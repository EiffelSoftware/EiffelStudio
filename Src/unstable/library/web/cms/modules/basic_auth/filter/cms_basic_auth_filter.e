note
	description: "[
		Processes a HTTP request's BASIC authorization headers, putting the result into the execution variable user.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BASIC_AUTH_FILTER

inherit
	CMS_AUTH_FILTER_I

	REFACTORING_HELPER

create
	make

feature -- Basic operations

	auth_strategy: STRING
		do
			Result := {CMS_BASIC_AUTH_MODULE}.logout_location
		end

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
					debug ("refactor_fixme")
						fixme ("Maybe we need to store in the credentials in a shared context SECURITY_CONTEXT")
						-- req.set_execution_variable ("security_content", create SECURITY_CONTEXT.make (l_user))
						-- other authentication filters (OpenID, etc) should implement the same approach.
					end
					set_current_user (l_user)
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_auth_login, Void)
				end
			end
			execute_next (req, res)
		end

end
