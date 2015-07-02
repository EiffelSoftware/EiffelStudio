note
	description: "Summary description for {CMS_OPENID_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_CONSTANTS

feature -- Access

	openid_session: STRING = "EWF_ROC_OPENID_TOKEN_"
			-- Name of Cookie used to keep the session info.
			-- FIXME: make this configurable.

	consumer: STRING = "consumer"
end
