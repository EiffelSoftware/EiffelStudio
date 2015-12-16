note
	description: "[
		Processes a HTTP request's checking Session cookies, putting the result into the execution variable user.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_FILTER

inherit
	WSF_URI_TEMPLATE_HANDLER

	CMS_HANDLER
		rename
			make as make_handler
		end

	WSF_FILTER

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_session_oauth_api: CMS_SESSION_API)
		do
			make_handler (a_api)
			session_oauth_api := a_session_oauth_api
		end

	session_oauth_api: CMS_SESSION_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			api.logger.put_debug (generator + ".execute ", Void)
				-- A valid user
			if
				attached {WSF_STRING} req.cookie ({CMS_SESSION_CONSTANTS}.session_auth_token) as l_roc_auth_session_token
			then
				if attached session_oauth_api.user_by_session_token (l_roc_auth_session_token.value) as l_user then
					set_current_user (req, l_user)
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_roc_auth_session_token.value , Void)
				end
			else
				api.logger.put_debug (generator + ".execute without authentication", Void)
			end
			execute_next (req, res)
		end

end
