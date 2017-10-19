note
	description: "[
		Communicates with the login site to permit logging in and out of the support system.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_SUPPORT_LOGIN

inherit

	ESA_SUPPORT_ACCESS

create
	make

feature {NONE} -- Access

	last_username: detachable IMMUTABLE_STRING_32
			-- Last logged in user's user name

	last_password: detachable IMMUTABLE_STRING_32
			-- Last logged in user's password

	cache_register_url: detachable STRING_8
			-- Cached register url.

	cache_logon_url: detachable STRING_8
			-- Cached logon url.				

	cache_logoff_url: detachable STRING_8
			-- Cached logoff url.

feature -- Status report

	is_logged_in: BOOLEAN
			-- Indicates if a user has been logged in

	is_bad_request: BOOLEAN
			-- Set by `attempt_logon' to indicate if there was network problem during last login

feature -- Basic operations

	attempt_logon (a_user, a_pass: READABLE_STRING_GENERAL; a_remember: BOOLEAN)
			-- Attemps to log a user in
		require
			is_support_accessible: is_support_accessible
		local
			retried: BOOLEAN
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_resp: ESA_SUPPORT_RESPONSE
		do
			is_logged_in := False
			if not retried then
				is_bad_request := False
				create ctx.make
				if a_user /= Void and a_pass /= Void then
					if attached basic_auth (a_user, a_pass) as l_auth then
						ctx.add_header ("Authorization", l_auth)
					end
				end

				if attached logon_url as l_logon_url then
					l_resp := get (l_logon_url, ctx)
					if l_resp.status = 200 then
						is_logged_in := True
					end
					if is_logged_in then
						create last_username.make_from_string_general (a_user)
						create last_password.make_from_string_general (a_pass)
					end
				end
			end
		ensure
			last_username_set: (is_logged_in and attached last_username as u and then a_user.same_string (u))
								or (not is_logged_in and last_username = Void)
			last_password_set: (is_logged_in and attached last_password as p and then a_pass.same_string (p))
								or (not is_logged_in and last_password = Void)
		rescue
			if l_resp /= Void and then l_resp.status /= 200 then
				is_bad_request := True
			end
			retried := True
			retry
		end

	force_logout
			-- Forces log out
		require
			is_support_accessible: is_support_accessible
		local
			retried: BOOLEAN
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_resp: ESA_SUPPORT_RESPONSE
		do
			is_logged_in := False
			if not retried then
				if
					attached logoff_url as l_url and
					attached last_username as u and
					attached last_password as p
				then
					create ctx.make
					if attached basic_auth (u, p) as l_auth then
						ctx.add_header ("Authorization", l_auth)
					end
					last_username := Void
					last_password := Void

					l_resp := get (l_url, ctx)
				end
			end
		ensure
			not_is_logged_in: not is_logged_in
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	basic_auth (a_user, a_pass: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- Create a basic auth password with `a_user' and `a_pass'.
		require
			user_not_void: a_user /= Void
			pass_not_void: a_pass /= Void
		local
			h: HTTP_AUTHORIZATION
		do
			create h.make_basic_auth (a_user, a_pass)
			if attached h.http_authorization as s then
				Result := s
			end
		end

feature -- Access

	logon_url: detachable STRING_8
				-- Retrieve Login url from CJ response.
		local
			retried: BOOLEAN
		do
			if not retried then
					-- Cache logon url
				if cache_logon_url = Void then
					cache_logon_url := retrieve_url ("login", "Login")
				end
				Result := cache_logon_url
			end
		rescue
			is_bad_request := True
			retried := True
			retry
		end

	logoff_url: detachable STRING_8
			-- Retrieve Logoff url from CJ response.
		local
			retried: BOOLEAN
		do
			if not retried then
				if cache_logoff_url = Void then
					cache_logoff_url := retrieve_url ("logoff", "Logoff")
				end
				Result := cache_logoff_url
			end
		rescue
			is_bad_request := True
			retried := True
			retry
		end

	register_url: detachable STRING_8
			-- Retrieve Register url from CJ response.
		local
			retried: BOOLEAN
		do
			if not retried then
					-- Cache Register page.
				if cache_register_url = Void then
					cache_register_url := retrieve_url ("register", "Register")
				end
				Result := cache_register_url
			end
		rescue
			is_bad_request := True
			retried := True
			retry
		end

feature {NONE} -- Retrieve URL

	retrieve_url (a_rel: STRING_8; a_prompt: STRING_8): detachable STRING_8
			-- Retrieve an Href value from CJ response if any, in other case
			-- and empty String.
		local
			l_resp: ESA_SUPPORT_RESPONSE
			lnk: CJ_LINK
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_found: BOOLEAN
		do
			create ctx.make
			if attached last_username as u and attached last_password as p then
				if attached basic_auth (u, p) as l_auth then
					ctx.add_header ("Authorization", l_auth)
				end
			end

			l_resp := get (config.service_root, ctx)
			if l_resp.status /= 200 then
				(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
			else
				if attached l_resp.collection as l_col and then attached l_col.links as l_links then
					across
						l_links as ic
					until
						l_found
					loop
						lnk := ic.item
						if lnk.rel.same_string (a_rel) then
							if
								a_prompt /= Void and then
							 	attached lnk.prompt as lnk_prompt and then
							 	lnk_prompt.same_string (a_prompt)
							then
								l_found := True
								create Result.make_from_string (lnk.href)
							end
						end
					end
					if Result = Void then
						create Result.make_empty
					end
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
				end
			end
		end

invariant
	not_last_username_is_empty: is_logged_in implies attached last_username as l_last_username and then not l_last_username.is_empty
	not_last_password_is_empty: is_logged_in implies attached last_password as l_last_password and then not l_last_password.is_empty

end
