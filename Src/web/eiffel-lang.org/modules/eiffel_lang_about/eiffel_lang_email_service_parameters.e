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
			admin_email := a_cms_api.setup.site_email
			if not admin_email.has ('<') then
				admin_email := "Eiffel Lang Notification Contact <" + admin_email +">"
			end
		end

feature	-- Access

	smtp_server: IMMUTABLE_STRING_8

	admin_email: IMMUTABLE_STRING_8

	contact_email: IMMUTABLE_STRING_8
			-- Contact email.
		once
			Result := "Eiffel-Lang Community <contact@eiffel-lang.org>"
		end

	contact_subject_text: IMMUTABLE_STRING_8
		once
			Result := "Thank you for contacting us"
		end

end
