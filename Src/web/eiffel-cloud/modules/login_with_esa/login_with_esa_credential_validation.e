note
	description: "Summary description for {LOGIN_WITH_ESA_CREDENTIAL_VALIDATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_CREDENTIAL_VALIDATION

inherit
	CMS_USER_CREDENTIAL_VALIDATION

	CMS_API_ACCESS

create
	make

feature {NONE} -- Creation

	make (a_login_with_esa_api: LOGIN_WITH_ESA_API)
		do
			login_with_esa_api := a_login_with_esa_api
		end

	login_with_esa_api: LOGIN_WITH_ESA_API

feature -- Access

	id: STRING = "login-with-esa"

feature -- Status report

	user_with_credential (a_user_identifier: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL): detachable CMS_USER
				-- User validating credentials `a_user_identifier` and `a_password`, if any.
		do
			if login_with_esa_api.is_valid_credential (a_user_identifier, a_password) then
				Result := login_with_esa_api.associated_cms_user (a_user_identifier, a_password, True)
				if
					Result /= Void and then
					not login_with_esa_api.cms_api.user_has_permission (Result, {LOGIN_WITH_ESA_MODULE}.perm_use_login_with_esa)
				then
					Result := Void
				end
			end
		end

end
