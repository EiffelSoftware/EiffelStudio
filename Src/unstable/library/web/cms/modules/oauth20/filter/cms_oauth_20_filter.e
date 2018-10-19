note
	description: "[
			Extracts an OAuth2 token from the incoming request (cookie) and 
			uses it to populate the user (or cms user context).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_FILTER

inherit
	CMS_AUTH_STRATEGY_FILTER
		rename
			make as make_filter
		end

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_user_oauth_api: CMS_OAUTH_20_API)
		do
			make_filter (a_api)
			oauth_api := a_user_oauth_api
		end

	oauth_api: CMS_OAUTH_20_API

feature -- Basic operations

	auth_strategy: STRING
		do
			Result := {CMS_OAUTH_20_MODULE}.logout_location
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>.
		do
			if
				attached {WSF_STRING} req.cookie (oauth_api.session_token) as l_roc_auth_session_token
			then
				if attached oauth_api.user_oauth2_without_consumer_by_token (l_roc_auth_session_token.value) as l_user then
					if api.has_permission ({CMS_OAUTH_20_MODULE}.perm_use_oauth2_auth) then
						set_current_user (l_user)
					end
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_roc_auth_session_token.value , Void)
				end
			end
			execute_next (req, res)
		end

end
