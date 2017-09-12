note
	description: "Summary description for {CMS_CORE_ACCESS_TOKEN_WEBAPI_AUTH_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ACCESS_TOKEN_WEBAPI_AUTH_FILTER

inherit
	CMS_WEBAPI_AUTH_FILTER

create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			tok: READABLE_STRING_GENERAL
			u: CMS_USER
		do
			if
				attached req.http_authorization as l_auth and then
				l_auth.starts_with_general ("Bearer ")
			then
				tok := l_auth.substring (8, l_auth.count)
				if attached api.user_api.users_with_profile_item ("access_token", tok) as lst then
					if lst.count = 1 then
						u := lst.first
						if api.user_has_permission (u, "use access_token") then
							api.set_user (u)
						end
					end
				end
			end
			execute_next (req, res)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
