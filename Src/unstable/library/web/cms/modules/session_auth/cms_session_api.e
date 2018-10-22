note
	description: "API to manage CMS User session authentication"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_API

inherit
	CMS_AUTH_API_I

	REFACTORING_HELPER

create {CMS_SESSION_AUTH_MODULE}
	make_with_storage

feature {NONE} -- Initialization

	make_with_storage (a_api: CMS_API; a_session_auth_storage: CMS_SESSION_AUTH_STORAGE_I)
			-- Create an object with api `a_api' and storage `a_session_auth_storage'.
		local
			s: detachable READABLE_STRING_8
		do
			session_auth_storage := a_session_auth_storage
			make (a_api)

				-- Initialize session related settings.
			s := a_api.setup.site_auth_token ("session")
			if s = Void then
				s := a_api.setup.site_id + default_session_token_suffix
			end
			create session_token.make_from_string (s)

			session_max_age := a_api.setup.site_auth_max_age ("session")
		ensure
			session_auth_storage_set:  session_auth_storage = a_session_auth_storage
		end

feature {CMS_MODULE} -- Access: User session storage.

	session_auth_storage: CMS_SESSION_AUTH_STORAGE_I
			-- storage interface.

feature -- Settings

	default_session_token_suffix: STRING = "_SESSION_TOKEN_"
			-- Default value for `session_token'.

	session_token: IMMUTABLE_STRING_8
			-- Token used for the session related cookies.

	session_max_age: INTEGER
			-- Value of the Max-Age, before the cookie expires.

feature -- Status report

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
		do
			if
				a_response.is_authenticated and then
				attached a_response.request.cookie (session_token)
			then
				Result := True
			end
		end

feature -- Access

	user_by_session_token (a_token: READABLE_STRING_32): detachable CMS_USER
			-- Retrieve user by token `a_token', if any.
		do
			Result := session_auth_storage.user_by_session_token (a_token)
		end

	has_user_token (a_user: CMS_USER): BOOLEAN
			-- Has the user `a_user' and associated session token?
		do
			Result := session_auth_storage.has_user_token (a_user)
		end

feature -- Basic operation

	process_user_login (a_user: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_token: STRING
			l_cookie: WSF_COOKIE
			dt: DATE_TIME
		do
			l_token := new_session_token
			if has_user_token (a_user) then
				update_user_session_auth (l_token, a_user)
			else
				new_user_session_auth (l_token, a_user)
			end
			create l_cookie.make (session_token, l_token)
			l_cookie.set_max_age (session_max_age)
			if l_cookie.max_age < 0 then
				l_cookie.unset_expiration
			else
				if l_cookie.max_age = 0 then
					create dt.make_from_epoch (0)
				else
					create dt.make_now_utc
					dt.second_add (l_cookie.max_age)
				end
				l_cookie.set_expiration_date (dt)
			end
			l_cookie.set_path ("/")
			res.add_cookie (l_cookie)
			cms_api.set_user (a_user)
			cms_api.record_user_login (a_user)
		end

	process_user_logout (a_user: CMS_USER; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_cookie: WSF_COOKIE
		do
			if
				attached session_token as tok and then
				attached {WSF_STRING} req.cookie (tok) as l_cookie_token
			then
					 -- Logout Session
				create l_cookie.make (tok, "") -- l_cookie_token.value) -- FIXME: unicode issue?
				l_cookie.set_path ("/")
				l_cookie.unset_max_age
				l_cookie.set_expiration_date (create {DATE_TIME}.make_from_epoch (0))
				res.add_cookie (l_cookie)
			else
					-- it seems the user was not login, as there is no associated cookie!
			end
			cms_api.unset_user
		end

feature -- Change User session

	new_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER;)
			-- New user session for user `a_user' with token `a_token'.
		do
			session_auth_storage.new_user_session_auth (a_token, a_user)
		end


	update_user_session_auth (a_token: READABLE_STRING_GENERAL; a_user: CMS_USER )
			-- Update user session for user `a_user' with token `a_token'.
		do
			session_auth_storage.update_user_session_auth (a_token, a_user)
		end

feature -- Token

	new_session_token: STRING
			-- Generate token to use in a Session.
		local
			l_token: STRING
			l_security: CMS_TOKEN_GENERATOR
			l_encode: URL_ENCODER
		do
			create l_security
			l_token := l_security.token
			create l_encode
			from until l_token.same_string (l_encode.encoded_string (l_token)) loop
				-- Loop ensure that we have a security token that does not contain characters that need encoding.
			    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
				-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end
			Result := l_token
		end


end
