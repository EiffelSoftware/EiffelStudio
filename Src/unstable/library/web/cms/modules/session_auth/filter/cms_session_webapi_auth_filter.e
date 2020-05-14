note
	description: "Summary description for {CMS_SESSION_WEBAPI_AUTH_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_WEBAPI_AUTH_FILTER

inherit
	CMS_WEBAPI_AUTH_FILTER
		rename
			make as make_filter
		end

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_session_api: CMS_SESSION_API)
		do
			make_filter (a_api)
			session_api := a_session_api
		end

	session_api: CMS_SESSION_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			if
				attached {WSF_STRING} req.cookie (session_api.session_token) as l_roc_auth_session_token
			then
				if attached session_api.user_by_session_token (l_roc_auth_session_token.value) as l_user then
					if api.user_has_permission (l_user, {CMS_SESSION_AUTH_MODULE_WEBAPI}.perm_use_webapi_session_auth) then
						set_current_user (l_user)
					end
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_roc_auth_session_token.url_encoded_value , Void)
				end
			end
			execute_next (req, res)
		end

end
