note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_STORAGE_SQL

inherit
	JWT_AUTH_STORAGE_I

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

create
	make

feature -- Access/token

	token (a_token: READABLE_STRING_GENERAL): detachable JWT_AUTH_TOKEN
			-- Token record for token `a_token`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_uid: INTEGER_64
			l_token, l_secret: READABLE_STRING_8
			l_apps_string, l_refresh_token: detachable READABLE_STRING_8
		do
			reset_error
			create l_parameters.make (1)
			l_parameters.put (a_token, "token")
			sql_query (sql_select_user_for_token, l_parameters)
			sql_start
			if not has_error  and not sql_after then
				l_token := sql_read_string (2)
				l_uid := sql_read_integer_64 (1)
				l_secret := sql_read_string (3)
				l_apps_string := sql_read_string (4)
				l_refresh_token := sql_read_string (5)
				sql_finalize_query (sql_select_user_for_token)
				if
					not has_error and
					attached api as l_cms_api and then
					l_uid > 0 and then
					l_token /= Void and then
					l_token.is_case_insensitive_equal_general (a_token) and then
					l_refresh_token /= Void
				then
					if attached l_cms_api.user_api.user_by_id (l_uid) as u then
						create Result.make (u, l_token, l_refresh_token)
						Result.set_secret (l_secret)
						if l_apps_string /= Void and then not l_apps_string.is_empty then
							across
								l_apps_string.split (',') as ic
							loop
								Result.set_application (ic.item)
							end
						end
					else
						check known_user: False end
							-- Clean invalid entry!
						discard_uid_token (l_uid, a_token)
					end
				end
			else
				sql_finalize_query (sql_select_user_for_token)
			end
		end

	user_tokens (a_user: CMS_USER): detachable LIST [JWT_AUTH_TOKEN]
			-- Tokens associated with `a_user`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			l_tokens: ARRAYED_LIST [JWT_AUTH_TOKEN]
			tok: JWT_AUTH_TOKEN
		do
			reset_error
			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")
			sql_query (sql_select_user_tokens, l_parameters)
			if not has_error then
				create l_tokens.make (0)
				from
					sql_start
				until
					sql_after or has_error
				loop
					if
						attached sql_read_string (2) as l_tok and then
						not l_tok.is_whitespace and then
						attached sql_read_string (5) as l_ref_tok
					then
						create tok.make (a_user, l_tok, l_ref_tok)
						l_tokens.force (tok)
						if attached sql_read_string (3) as sec then
							tok.set_secret (sec)
						end
						if attached sql_read_string (4) as s_app then
							across
								s_app.split (',') as ic
							loop
								tok.set_application (ic.item)
							end
						end
					end
					sql_forth
				end
			end
			sql_finalize_query (sql_select_user_tokens)
			if
				not has_error and
				l_tokens /= Void
			then
				Result := l_tokens
			end
		end

feature -- Change/token

	record_user_token (a_token: JWT_AUTH_TOKEN)
			-- Record `a_token`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
			s: STRING_32
		do
			create l_parameters.make (5)
			l_parameters.put (a_token.user.id, "uid")
			l_parameters.put (a_token.token, "token")
			l_parameters.put (a_token.secret, "secret")
			if attached a_token.applications as apps and then not apps.is_empty then
				create s.make_empty
				across
					apps as ic
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append_string_general (ic.item)
				end
			end
			l_parameters.put (s, "apps")
			l_parameters.put (a_token.refresh_key, "refresh")

			reset_error
			sql_insert (sql_insert_user_token, l_parameters)
			sql_finalize_insert (sql_insert_user_token)
		end

	discard_user_token (a_user: CMS_USER; a_token: READABLE_STRING_GENERAL)
			-- Discard `a_token` from `a_user`.
		do
			discard_uid_token (a_user.id, a_token)
		end

	discard_all_user_tokens (a_user: CMS_USER)
			-- Discard all tokens for `a_user`.
			-- Discard `a_token` from `a_uid`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (1)
			l_parameters.put (a_user.id, "uid")

			reset_error
			sql_delete (sql_delete_all_user_tokens, l_parameters)
			sql_finalize_delete (sql_delete_all_user_tokens)
		end

	discard_uid_token (a_uid: INTEGER_64; a_token: READABLE_STRING_GENERAL)
			-- Discard `a_token` from `a_uid`.
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (2)
			l_parameters.put (a_uid, "uid")
			l_parameters.put (a_token, "token")

			reset_error
			sql_delete (sql_delete_user_token, l_parameters)
			sql_finalize_delete (sql_delete_user_token)
		end

feature {NONE} -- Queries/token

	sql_select_user_for_token: STRING = "SELECT uid, token, secret, apps, refresh FROM jwt_auth WHERE token=:token;"

	sql_select_user_tokens: STRING = "SELECT uid, token, secret, apps, refresh FROM jwt_auth WHERE uid=:uid;"

	sql_insert_user_token: STRING = "INSERT INTO jwt_auth (uid, token, secret, apps, refresh) VALUES (:uid, :token, :secret, :apps, :refresh);"

	sql_delete_user_token: STRING = "DELETE FROM jwt_auth WHERE uid=:uid AND token=:token;"

	sql_delete_all_user_tokens: STRING = "DELETE FROM jwt_auth WHERE uid=:uid;"

feature -- Access/challenge

	sign_in_challenge (ch: READABLE_STRING_GENERAL): detachable JWT_AUTH_SIGN_IN_CHALLENGE
		local
			l_parameters: STRING_TABLE [detachable ANY]
			dt: DATE_TIME
			cl, l_ch, s_apps, s_info: READABLE_STRING_GENERAL
			l_apps: LIST [READABLE_STRING_GENERAL]
			l_status: INTEGER_32
			l_uid: like {CMS_USER}.id
		do
			create l_parameters.make (1)
			l_parameters.put (ch, "challenge")
			reset_error
			sql_query (sql_select_sign_in_challenge, l_parameters)
			sql_start
			if not has_error  and not sql_after then
				l_ch := sql_read_string_32 (1)
				cl := sql_read_string_32 (2)
				s_info := sql_read_string_32 (3)
				dt := sql_read_date_time (4)
				s_apps := sql_read_string_32 (5)
				if s_apps /= Void then
					l_apps := s_apps.split (',')
				end
				l_status := sql_read_integer_32 (6)
				l_uid := sql_read_integer_64 (7)
				sql_finalize_query (sql_select_sign_in_challenge)
				if cl = Void or l_ch = Void or dt = Void then
					error_handler.add_custom_error (0, "DB", "unexpected db value in jwt_auth_challenge")
				else
					check same_challenge: l_ch /= Void and then l_ch.same_string (ch) end
					create Result.make (cl, l_apps, l_ch, dt)
					if s_info /= Void and then not s_info.is_whitespace then
						Result.set_information (s_info)
					end
					Result.set_status (l_status)
					Result.set_user_id (l_uid)
				end
			else
				sql_finalize_query (sql_select_sign_in_challenge)
			end
		end

feature -- Change/challenge

	record_sign_in_challenge (ch: JWT_AUTH_SIGN_IN_CHALLENGE)
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			if ch.status = ch.status_normal then
				create l_parameters.make (7)
				l_parameters.put (ch.challenge, "challenge")
				l_parameters.put (ch.client, "client")
				l_parameters.put (ch.information, "info")
				l_parameters.put (ch.expiration_date, "expiration")
				if attached ch.applications_as_csv as apps then
					l_parameters.put (apps, "apps")
				else
					l_parameters.put ("", "apps")
				end
				l_parameters.put (ch.status, "status")
				l_parameters.put (ch.user_id, "uid")
				reset_error
				sql_insert (sql_insert_sign_in_challenge, l_parameters)
				sql_finalize_insert (sql_insert_sign_in_challenge)
			else
				create l_parameters.make (4)
				l_parameters.put (ch.challenge, "challenge")
				l_parameters.put (ch.client, "client")
				l_parameters.put (ch.status, "status")
				l_parameters.put (ch.user_id, "uid")
				reset_error
				sql_modify (sql_update_sign_in_challenge, l_parameters)
				sql_finalize_modify (sql_update_sign_in_challenge)
			end
		end

	discard_sign_in_challenge (ch: READABLE_STRING_GENERAL)
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (1)
			l_parameters.put (ch, "challenge")

			reset_error
			sql_delete (sql_delete_sign_in_challenge, l_parameters)
			sql_finalize_delete (sql_delete_sign_in_challenge)
		end

	clean_sign_in_challenges
		local
			l_parameters: STRING_TABLE [detachable ANY]
		do
			create l_parameters.make (2)
			l_parameters.put ({JWT_AUTH_SIGN_IN_CHALLENGE}.status_expired, "status")
			l_parameters.put (create {DATE_TIME}.make_now_utc, "date")

			reset_error
			sql_delete (sql_delete_expired_sign_in_challenges, l_parameters)
			sql_finalize_delete (sql_delete_expired_sign_in_challenges)
		end

feature {NONE} -- Queries/token

	sql_insert_sign_in_challenge: STRING = "INSERT INTO jwt_auth_challenges (challenge, client, info, expiration, apps, status, uid) VALUES (:challenge, :client, :info, :expiration, :apps, :status, :uid);"

	sql_update_sign_in_challenge: STRING = "UPDATE jwt_auth_challenges SET status=:status, uid=:uid WHERE challenge=:challenge AND client=:client;"

	sql_delete_sign_in_challenge: STRING = "DELETE FROM jwt_auth_challenges WHERE challenge=:challenge;"

	sql_delete_expired_sign_in_challenges: STRING = "DELETE FROM jwt_auth_challenges WHERE status=:status OR expiration < :date ;"

	sql_select_sign_in_challenge: STRING = "SELECT challenge, client, info, expiration, apps, status, uid FROM jwt_auth_challenges WHERE challenge=:challenge ;"

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
