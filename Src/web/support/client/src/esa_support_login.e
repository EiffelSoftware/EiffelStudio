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

	last_username: STRING_GENERAL
			-- Last logged in user's user name

	last_password: STRING_GENERAL
			-- Last logged in user's password

feature -- Status report

	is_logged_in: BOOLEAN
			-- Indicates if a user has been logged in

	is_bad_request: BOOLEAN
			-- Set by `attempt_logon' to indicate if there was network problem during last login

feature -- Basic operations

	attempt_logon (a_user, a_pass: STRING_GENERAL; a_remember: BOOLEAN)
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
				if attached basic_auth (a_user, a_pass) as l_auth then
					ctx.add_header ("Authorization", l_auth)
				end
				l_resp := get (logon_url, ctx)
				if l_resp.status = 200 then
					is_logged_in := True
				end
				if is_logged_in then
					last_username := a_user
					last_password := a_pass
				end
			end
		ensure
			last_username_set: (is_logged_in and last_username = a_user) or (not is_logged_in and last_username = Void)
			last_password_set: (is_logged_in and last_password = a_pass) or (not is_logged_in and last_password = Void)
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
			last_username := Void
			last_password := Void
			if not retried then
				if attached basic_auth (last_username, last_password) as l_auth then
					ctx.add_header ("Authorization", l_auth)
				end
				l_resp := get (logoff_url, ctx)
			end
		ensure
			not_is_logged_in: not is_logged_in
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	basic_auth (a_user, a_pass: STRING_GENERAL): detachable READABLE_STRING_8
			-- Create a basic auth password with `a_user' and `a_pass'.
		local
			h: HTTP_AUTHORIZATION
		do
			create h.make_basic_auth (a_user, a_pass)
			if attached h.http_authorization as s then
				Result := s
			end
		end

feature {NONE} -- Constants

	logon_url: STRING
				-- Retrieve Login url from CJ response.
		local
			l_resp: ESA_SUPPORT_RESPONSE
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_found: BOOLEAN
		do
			create ctx.make
			l_resp := get (config.service_root, ctx)
			if l_resp.status /= 200 then
				(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
			else
				if attached l_resp.collection as l_col then
					across
						l_col.links as ic
					until
						l_found
					loop
						if ic.item.rel.same_string ("login") and then ic.item.prompt.same_string ("Login") then
							l_found := True
							create {STRING} Result.make_from_string (ic.item.href)
						end
					end
					if Result = Void then
						create {STRING} Result.make_empty
					end
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
				end
			end
		end

	logoff_url: STRING
			-- Retrieve Logoff url from CJ response.
		local
			l_resp: ESA_SUPPORT_RESPONSE
			ctx: HTTP_CLIENT_REQUEST_CONTEXT
			l_found: BOOLEAN
		do
			create ctx.make
			if attached basic_auth (last_username, last_password) as l_auth then
				ctx.add_header ("Authorization", l_auth)
			end
			l_resp := get (config.service_root, ctx)
			if l_resp.status /= 200 then
				(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
			else
				if attached l_resp.collection as l_col then
					across
						l_col.links as ic
					until
						l_found
					loop
						if ic.item.rel.same_string ("logoff") and then ic.item.prompt.same_string ("Logoff") then
							l_found := True
							create {STRING} Result.make_from_string (ic.item.href)
						end
					end
					if Result = Void then
						create {STRING} Result.make_empty
					end
				else
					(create {EXCEPTIONS}).raise ("Connection error: HTTP Status " + l_resp.status.out)
				end
			end
		end

invariant
	last_username_attached: is_logged_in implies last_username /= Void
	not_last_username_is_empty: is_logged_in implies not last_username.is_empty
	last_password_attached: is_logged_in implies last_password /= Void
	not_last_password_is_empty: is_logged_in implies not last_password.is_empty

end
