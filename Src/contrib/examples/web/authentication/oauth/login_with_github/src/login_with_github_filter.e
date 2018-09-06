note
	description: "Summary description for {LOGIN_WITH_GITHUB_FILTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_GITHUB_FILTER

inherit
	WSF_FILTER
	
	LOGIN_WITH_GITHUB_CONSTANTS

feature --

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>.
		do
			if
				attached {WSF_STRING} req.cookie (oauth_session_token) as l_roc_auth_session_token and then
				attached {WSF_STRING} req.cookie (oauth_user_login) as l_user
			then
				req.set_execution_variable ("user", l_user.value)
			else
				-- Set error.
			end
			execute_next (req, res)
		end

end
