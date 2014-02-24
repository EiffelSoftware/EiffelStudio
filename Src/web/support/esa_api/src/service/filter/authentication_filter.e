note
	description: "Authentication filter."
	author: "Olivier Ligot"
	date: "$Date$"
	revision: "$Revision$"

class
	AUTHENTICATION_FILTER

inherit

	WSF_FILTER

	WSF_URI_TEMPLATE_HANDLER

	SHARED_API_SERVICE

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			l_auth: HTTP_AUTHORIZATION
		do
			create l_auth.make (req.http_authorization)
				-- A valid user
			if (attached l_auth.type as l_auth_type and then l_auth_type.is_case_insensitive_equal ("basic")) and then
				attached l_auth.login as l_auth_login and then attached l_auth.password as l_auth_password then

				if api_service.login_valid (l_auth_login, l_auth_password) then
					req.set_execution_variable ("user", l_auth_login)
					execute_next (req, res)
				else
					req.set_execution_variable ("user", "Guest")
					execute_next (req, res)
				end
			else
				req.set_execution_variable ("user", "Guest")
				execute_next (req, res)
			end
		end

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
