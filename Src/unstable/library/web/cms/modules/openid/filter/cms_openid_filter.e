note
	description: "[
		Extracts an Openid token from the incoming request (cookie) and uses it to populate the user (or cms user context)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_FILTER

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

	make (a_api: CMS_API; a_user_openid_api: CMS_OPENID_API)
		do
			make_handler (a_api)
			user_openid_api := a_user_openid_api
		end

	user_openid_api: CMS_OPENID_API

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		local
			o: OPENID_CONSUMER
			v: OPENID_CONSUMER_VALIDATION

		do
			api.logger.put_debug (generator + ".execute ", Void)
				-- A valid user
			if
				attached {WSF_STRING} req.cookie ({CMS_OPENID_CONSTANTS}.openid_session) as l_roc_openid_session_token
			then
				if attached user_openid_api.user_openid_by_identity (l_roc_openid_session_token.value) as l_user then
					set_current_user (req, l_user)
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_roc_openid_session_token.value , Void)
				end
			else
				api.logger.put_debug (generator + ".execute without authentication", Void)
			end
			execute_next (req, res)
		end

end
