note
	description: "[
		Extracts an Openid token from the incoming request (cookie) and uses it to populate the user (or cms user context)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_FILTER

inherit
	CMS_AUTH_STRATEGY_FILTER
		rename
			make as make_filter
		end

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_openid_api: CMS_OPENID_API)
		do
			make_filter (a_api)
			openid_api := a_openid_api
		end

	openid_api: CMS_OPENID_API

feature -- Basic operations

	auth_strategy: STRING
		do
			Result := {CMS_OPENID_MODULE}.logout_location
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>.
		do
			if
				attached {WSF_STRING} req.cookie (openid_api.session_token) as l_roc_openid_session_token
			then
				if attached openid_api.user_openid_by_identity (l_roc_openid_session_token.value) as l_user then
					set_current_user (l_user)
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_roc_openid_session_token.value , Void)
				end
			end
			execute_next (req, res)
		end

end
