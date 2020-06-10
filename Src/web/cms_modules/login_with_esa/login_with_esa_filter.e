note
	description: "Summary description for {LOGIN_WITH_ESA_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_FILTER

inherit
	CMS_AUTH_FILTER
		rename
			make as make_filter
		end

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_esa_api: LOGIN_WITH_ESA_API)
			-- Initialize Current handler with `a_esa_api'.
		do
			make_filter (a_api)
			login_with_esa_api := a_esa_api
		end

feature -- API Service

	login_with_esa_api: LOGIN_WITH_ESA_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			l_auth: HTTP_AUTHORIZATION
			l_user: detachable CMS_USER
		do
			create l_auth.make (req.http_authorization)
			if
				l_auth.is_basic and then
				attached l_auth.login as l_auth_login and then
				attached l_auth.password as l_auth_password and then
				attached login_with_esa_api as l_login_w_esa_api and then
				l_login_w_esa_api.is_valid_credential (l_auth_login, l_auth_password)
			then
				l_user := l_login_w_esa_api.associated_cms_user (l_auth_login, l_auth_password, True)
				if
					l_user /= Void and then
					l_user.is_active and then
					api.user_has_permission (l_user, {LOGIN_WITH_ESA_MODULE}.perm_use_login_with_esa)
				then
					api.set_user (l_user)
				end
			end
			execute_next (req, res)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
