note
	description: "Summary description for {CONTACT_EMAIL_SERVICE_PARAMETERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_EMAIL_SERVICE_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (a_cms_api: CMS_API; a_contact_module: CMS_CONTACT_MODULE)
		local
			l_site_name: READABLE_STRING_8
			s: detachable READABLE_STRING_32
			l_contact_email, l_contact_subject: detachable READABLE_STRING_8
		do
				-- Use global smtp setting if any, otherwise "localhost"
			l_site_name := a_cms_api.utf_8_encoded (a_cms_api.setup.site_name)
			admin_email := a_cms_api.setup.site_email

			if not admin_email.has ('<') then
				admin_email := l_site_name + " <" + admin_email + ">"
			end

			if attached {CONFIG_READER} a_cms_api.module_configuration (a_contact_module, Void) as cfg then
				s := cfg.text_item ("email")
				if s /= Void then
					l_contact_email := a_cms_api.utf_8_encoded (s)
				end
				s := cfg.text_item ("subject")
				if s /= Void then
					l_contact_subject := a_cms_api.utf_8_encoded (s)
				end
			end
			if l_contact_email /= Void then
				if not l_contact_email.has ('<') then
					l_contact_email := l_site_name + " <" + l_contact_email + ">"
				end
				contact_email := l_contact_email
			else
				contact_email := admin_email
			end
			if l_contact_subject /= Void then
				contact_subject_text := l_contact_subject
			else
				contact_subject_text := "Thank you for contacting us"
			end
		end

feature	-- Access

	admin_email: IMMUTABLE_STRING_8

	contact_email: IMMUTABLE_STRING_8
			-- Contact email.

	contact_subject_text: IMMUTABLE_STRING_8

end
