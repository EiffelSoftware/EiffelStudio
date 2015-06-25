note
	description: "Summary description for {CMS_OAUTH_20_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OAUTH_20_CONSTANTS

feature -- Access

	oauth_session: STRING = "EWF_ROC_OAUTH_TOKEN_"
			-- Name of Cookie used to keep the session info.
			-- FIXME: make this configurable.

	oauth_callback: STRING = "callback"
			-- Callback parameter.

	oauth_code: STRING = "code"
			-- Code query parameter.

end
