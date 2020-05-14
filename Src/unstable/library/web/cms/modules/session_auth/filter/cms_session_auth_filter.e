note
	description: "[
		Processes a HTTP request's checking Session cookies, putting the result into the execution variable user.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_AUTH_FILTER

inherit
	CMS_AUTH_STRATEGY_FILTER
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

	auth_strategy: STRING
		do
			Result := {CMS_SESSION_AUTH_MODULE}.logout_location
		end

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>.
		do
			if
				attached {WSF_STRING} req.cookie (session_api.session_token) as l_roc_auth_session_token
			then
				if attached session_api.user_by_session_token (l_roc_auth_session_token.value) as l_user then
					set_current_user (l_user)
				else
					api.logger.put_error (generator + ".execute login_valid failed for: " + l_roc_auth_session_token.url_encoded_value , Void)
				end
			end
			execute_next (req, res)
		end

end
