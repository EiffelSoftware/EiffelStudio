note
	description: "Summary description for {EIFFEL_LANG_EMAIL_SERVICE_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_EMAIL_SERVICE_PARAMETERS

inherit
	EMAIL_SERVICE_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (a_cms_api: CMS_API)
		do
			if attached a_cms_api.setup.smtp as l_smtp then
				smtp_server := l_smtp
			else
				smtp_server := "localhost"
			end
			admin_email_address := a_cms_api.setup.site_email
		end

feature	-- Access

	smtp_server: IMMUTABLE_STRING_8

	admin_email_address: IMMUTABLE_STRING_8

end
