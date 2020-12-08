note
	description: "Summary description for {JWT_AUTH_TOKEN_WEBAPI_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_TOKEN_WEBAPI_FILTER

inherit
	CMS_WEBAPI_AUTH_FILTER
		rename
			make as make_filter
		end

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_jwt_auth_api: JWT_AUTH_API)
			-- Initialize Current handler with `a_api'.
		do
			make_filter (a_api)
			jwt_auth_api := a_jwt_auth_api
		end

feature -- API Service

	jwt_auth_api: JWT_AUTH_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			tok: READABLE_STRING_8
		do
			if
				attached req.http_authorization as l_auth and then
				l_auth.starts_with_general ("Bearer ")
			then
				tok := l_auth.substring (8, l_auth.count)
				if attached jwt_auth_api.user_for_token (tok) as l_user and then l_user.is_active then
					if api.user_has_permission (l_user, {JWT_AUTH_MODULE_WEBAPI}.perm_use_jwt_auth) then
						api.set_user (l_user)
					end
				end
			end
			execute_next (req, res)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
