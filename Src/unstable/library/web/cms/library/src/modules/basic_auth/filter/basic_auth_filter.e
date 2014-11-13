note
	description: "Processes a HTTP request's BASIC authorization headers, putting the result into the execution variable user."
	date: "$Date$"
	revision: "$Revision$"

class
	BASIC_AUTH_FILTER

inherit

	WSF_URI_TEMPLATE_HANDLER
	CMS_HANDLER
	WSF_FILTER

create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			l_auth: HTTP_AUTHORIZATION
		do
			log.write_debug (generator + ".execute " )
			create l_auth.make (req.http_authorization)
			if attached req.raw_header_data as l_raw_data then
			   log.write_debug (generator + ".execute " + l_raw_data )
			end
				-- A valid user
			if (attached l_auth.type as l_auth_type and then l_auth_type.is_case_insensitive_equal_general ("basic")) and then
				attached l_auth.login as l_auth_login and then attached l_auth.password as l_auth_password then
				if api.is_valid_credential (l_auth_login, l_auth_password) then
					if attached api.user_by_name (l_auth_login) as l_user then
						debug ("refactor_fixme")
							fixme ("Maybe we need to store in the credentials in a shared context SECURITY_CONTEXT")
							-- req.set_execution_variable ("security_content", create SECURITY_CONTEXT.make (l_user))
							-- other authentication filters (OpenID, etc) should implement the same approach.
						end
						req.set_execution_variable ("user", l_user)
						execute_next (req, res)
					else
						debug ("refactor_fixme")
							to_implement ("Internal server error")
						end
					end
				else
					log.write_error (generator + ".execute login_valid failed for: " + l_auth_login )
					execute_next (req, res)
				end
			else
				log.write_error (generator + ".execute Not valid")
				execute_next (req, res)
			end
		end

end
