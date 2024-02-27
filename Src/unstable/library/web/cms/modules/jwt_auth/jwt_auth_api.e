note
	description: "API to handle JWT auth control."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
					-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {JWT_AUTH_STORAGE_SQL} jwt_auth_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {JWT_AUTH_STORAGE_NULL} jwt_auth_storage
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	jwt_auth_storage: JWT_AUTH_STORAGE_I

feature -- Factory

	new_token (a_user: CMS_USER; apps: detachable ITERABLE [READABLE_STRING_GENERAL]): detachable JWT_AUTH_TOKEN
			-- New JWT token for user `a_user` and `apps` scopes.
		do
			Result := new_token_with_expiration (a_user, apps, 0)
		end

	new_token_with_expiration (a_user: CMS_USER; apps: detachable ITERABLE [READABLE_STRING_GENERAL]; a_expiration_in_seconds: NATURAL_32): detachable JWT_AUTH_TOKEN
			-- New JWT token for user `a_user` and `apps` scopes.
			-- If `a_expiration_in_seconds` is positive, use it as the token expiration value.
			-- (Note: if it is over the expiration value from the configuration, use the one from the configuration).
		require
			a_expiration_in_seconds > 0
		local
			jws: JWS
			sec: like new_secret_key
			dt: DATE_TIME
			nb: INTEGER
		do
			create jws
			jws.set_algorithm_to_hs256
			sec := new_secret_key (40, 0)
			jws.claimset.set_subject (a_user.name)
			create dt.make_now_utc
			jws.claimset.set_issued_at (dt)
			create dt.make_now_utc
			if
				attached cms_api.module_configuration_by_name ({JWT_AUTH_MODULE}.name, "config") as cfg
			then
				nb := cfg.integer_item ("jwt.expiration") -- In Seconds
			end
			if a_expiration_in_seconds > 0 then
				if nb <= 0 or else a_expiration_in_seconds.to_integer_32 <= nb then
					nb := a_expiration_in_seconds.to_integer_32
				end
			end
			if nb < 0 then
					-- Never expires ...
			else
				if nb = 0 then
					dt.day_add (30) -- 30 days
				elseif nb > 0 then
					dt.second_add (nb)
				end
				jws.claimset.set_expiration_time (dt)
			end

			jws.claimset.set_claim ("uid", a_user.id.out)
			create Result.make (a_user, jws.encoded_string (sec), new_secret_key (40, 2))
			Result.set_secret (sec)
			if apps /= Void then
				across
					apps as ic
				loop
					Result.set_application (ic.item)
				end
			end
			record_user_token (Result)
			if has_error then
				Result := Void
			end
		end

	refresh_token (a_user: CMS_USER; a_token: READABLE_STRING_GENERAL; a_refresh_key: READABLE_STRING_GENERAL): detachable JWT_AUTH_TOKEN
		local
			tok: detachable JWT_AUTH_TOKEN
		do
			tok := jwt_auth_storage.token (a_token)
			if
				tok /= Void and then
				not tok.is_expired (Void) and then
				tok.refresh_key.is_case_insensitive_equal_general (a_refresh_key)
			then
				check same_user: tok.user.same_as (a_user) end
				discard_user_token (a_user, a_token)
				check no_error: not has_error end
				Result := new_token (a_user, tok.applications)
			else
					-- Either no token, or invalid refresh key.
			end
		end

	new_magic_login_link (a_user: CMS_USER; a_expiration_in_seconds: NATURAL_32): detachable STRING_8
		do
			if attached {JWT_AUTH_TOKEN} new_token_with_expiration (a_user, <<"magic-login">>, a_expiration_in_seconds) as l_magic_token then
				Result := cms_api.absolute_url ("/user/" + a_user.id.out + "/magic-login/" + url_encoded (l_magic_token.token), Void)
			end
		end

	new_sign_in_challenge_with_expiration (cl: READABLE_STRING_GENERAL; info: detachable READABLE_STRING_GENERAL; apps: detachable LIST [READABLE_STRING_GENERAL]; a_expiration_in_seconds: NATURAL_32): detachable JWT_AUTH_SIGN_IN_CHALLENGE
		local
			nb: INTEGER
		do
				-- TODO: find better way to "clean" the challenge table
				-- probably a web cron solution at CMS api level.
			clean_sign_in_challenges

			if
				attached cms_api.module_configuration_by_name ({JWT_AUTH_MODULE}.name, "config") as cfg and then
				cfg.has_item ("challenge.expiration")
			then
				nb := cfg.integer_item ("challenge.expiration") -- In Seconds
			else
				nb := 1800 -- = 30 * 60 s = 30 minutes
			end
			if a_expiration_in_seconds > 0 then
				if nb <= 0 or else a_expiration_in_seconds.to_integer_32 <= nb then
					nb := a_expiration_in_seconds.to_integer_32
				end
			end
			create Result.make_with_expiration (cl, apps, cms_api.new_random_identifier (24, Void), nb)
			Result.set_information (info)
			record_sign_in_challenge (Result)
		end

	client_sign_in_link (a_challenge: JWT_AUTH_SIGN_IN_CHALLENGE): STRING_8
		do
			Result := cms_api.absolute_url ("/auth/client-sign-in/" + url_encoded (a_challenge.challenge), Void)
		end

	sign_in_challenge (a_challenge: READABLE_STRING_GENERAL): detachable JWT_AUTH_SIGN_IN_CHALLENGE
		do
			Result := jwt_auth_storage.sign_in_challenge (a_challenge)
		end

	approve_sign_in_challenge (ch: JWT_AUTH_SIGN_IN_CHALLENGE; u: CMS_USER)
		do
			cms_api.log ("auth", "approve sign-in challenge", 0, cms_api.user_local_link (u, Void))
			ch.approve (u)
			record_sign_in_challenge (ch)
		end

	is_valid_sign_in_challenge (a_challenge: JWT_AUTH_SIGN_IN_CHALLENGE; a_date: DATE_TIME): BOOLEAN
		do
			Result := a_challenge.is_valid (a_date)
		end

feature -- Access

	user_for_token (a_token: READABLE_STRING_GENERAL): detachable CMS_USER
			-- User for token `a_token`.
		require
			not_blank: not a_token.is_whitespace
		do
			if attached jwt_auth_storage.token (a_token) as l_record then
				if
					not l_record.is_expired (Void)
				then
					Result := l_record.user
				else
						-- Remove expired or bad token ...
					discard_user_token (l_record.user, a_token)
				end
			end
		end

	user_tokens (a_user: CMS_USER; a_app: detachable READABLE_STRING_GENERAL): detachable LIST [JWT_AUTH_TOKEN]
			-- Tokens associated with `a_user`, and if `a_app` is provided, filter for this application.
		require
			valid_user: a_user.has_id
		local
			tok: JWT_AUTH_TOKEN
		do
			Result := jwt_auth_storage.user_tokens (a_user)
			if Result /= Void and a_app /= Void then
				from
					Result.start
				until
					Result.off
				loop
					tok := Result.item
					if attached tok.applications as lst and then across lst as ic some a_app.is_case_insensitive_equal (ic.item) end then
							-- Keep
						Result.forth
					else
						Result.remove
					end
				end
			end
		end

feature -- Change

	record_sign_in_challenge (ch: JWT_AUTH_SIGN_IN_CHALLENGE)
		do
			jwt_auth_storage.record_sign_in_challenge (ch)
		end

	discard_sign_in_challenge (ch: JWT_AUTH_SIGN_IN_CHALLENGE)
		do
			ch.discard
			jwt_auth_storage.discard_sign_in_challenge (ch.challenge)
		end

	clean_sign_in_challenges
		do
			jwt_auth_storage.clean_sign_in_challenges
		end

	record_user_token (a_info: JWT_AUTH_TOKEN)
			-- Record `a_info`.
		require
			user_has_id: a_info.user.has_id
			valid_token: not a_info.token.is_whitespace
		do
			jwt_auth_storage.record_user_token (a_info)
		end

	discard_user_token (a_user: CMS_USER; a_token: READABLE_STRING_GENERAL)
			-- Discard `a_token` from `a_user`.
		require
			user_has_id: a_user.has_id
			valid_token: not a_token.is_whitespace
		do
			jwt_auth_storage.discard_user_token (a_user, a_token)
		end

	discard_all_user_tokens (a_user: CMS_USER)
			-- Discard all tokens from `a_user`.
		require
			user_has_id: a_user.has_id
		do
			jwt_auth_storage.discard_all_user_tokens (a_user)
		end

	discard_expired_tokens (a_date: DATE_TIME; a_discarded_count: detachable CELL [INTEGER])
			-- Discard expired tokens at date `dt`.
		local
			dt: DATE_TIME
		do
			dt := a_date
			if dt = Void then
				create dt.make_now_utc
			end
			jwt_auth_storage.discard_expired_tokens (dt, a_discarded_count)
		end

feature {NONE} -- Implementation

	new_secret_key (len, off: INTEGER): STRING_8
		local
			rand: RANDOM
			n: INTEGER
			v: NATURAL_32
		do
			rand := cms_api.random_generator
			create Result.make (len)
			from
				n := off
			until
				n = 0
			loop
				n := n - 1
				rand.forth
			end
			from
				n := 1
			until
				n = len
			loop
				rand.forth
				v := (rand.item \\ 16).to_natural_32
				check 0 <= v and v <= 15 end
				if v < 9 then
					Result.append_code (48 + v) -- 48 '0'
				else
					Result.append_code (97 + v - 9) -- 97 'a'
				end
				n := n + 1
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

