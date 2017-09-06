note
	description: "Summary description for {CMS_BASIC_WEBAPI_AUTH_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BASIC_WEBAPI_AUTH_FILTER

inherit
	CMS_WEBAPI_AUTH_FILTER

create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			l_auth: HTTP_AUTHORIZATION
		do
			create l_auth.make (req.http_authorization)
			if
				l_auth.is_basic and then
				attached l_auth.login as l_auth_login and then
				attached l_auth.password as l_auth_password
			then
				if
					api.user_api.is_valid_credential (l_auth_login, l_auth_password) and then
					attached api.user_api.user_by_name (l_auth_login) as l_user
				then
					api.set_user (l_user)
				else
					-- not authenticated due to bad login or password.
				end
			end
			execute_next (req, res)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
