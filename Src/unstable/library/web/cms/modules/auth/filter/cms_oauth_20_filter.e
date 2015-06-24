note
	description: "Summary description for {CMS_OAUTH_20_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_FILTER

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

	make (a_api: CMS_API; a_user_oauth_api: CMS_OAUTH_20_API)
		do
			make_handler (a_api)
			user_oauth_api := a_user_oauth_api
		end

	user_oauth_api: CMS_OAUTH_20_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			api.logger.put_debug (generator + ".execute ", Void)
				-- A valid user
			if
				attached {WSF_STRING} req.cookie ({CMS_AUTHENTICATION_CONSTANTS}.oauth_session) as l_roc_auth_session_token
			then
				if attached user_oauth_api.user_oauth2_without_consumer_by_token (l_roc_auth_session_token.value) as l_user then
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
