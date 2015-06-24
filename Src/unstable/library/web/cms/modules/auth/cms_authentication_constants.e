note
	description: "Summary description for {CMS_AUTHENTICATION_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_CONSTANTS

feature -- Access

	oauth_session: STRING = "EWF_ROC_OAUTH_TOKEN_"
			-- Name of Cookie used to keep the session info.
			-- FIXME: make this configurable.

end
