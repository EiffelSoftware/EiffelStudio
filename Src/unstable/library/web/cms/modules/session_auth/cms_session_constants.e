note
	description: "Summary description for {CMS_SESSION_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_CONSTANTS


feature
	session_auth_token: STRING = "EWF_ROC_SESSION_AUTH_TOKEN_"
			-- Name of Cookie used to keep the session info.
			-- TODO add a config file to be able to customize this value via coniguration file.

	session_max_age: INTEGER = 86400
			-- Value of the Max-Age, before the cookie expires.
			-- TODO add a config file to be able to customize this value via coniguration file.

end
