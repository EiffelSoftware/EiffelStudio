note
	description: "Summary description for {CONTACT_EMAIL_SERVICE_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONTACT_EMAIL_SERVICE_PARAMETERS

inherit
	EMAIL_SERVICE_PARAMETERS

create
	make

feature {NONE} -- Initialization

	make (a_cms_api: CMS_API)
		local
			utf: UTF_CONVERTER
			l_site_name: READABLE_STRING_8
			s: detachable READABLE_STRING_32
			l_contact_email, l_contact_subject: detachable READABLE_STRING_8
		do
				-- Use global smtp setting if any, otherwise "localhost"
			smtp_server := utf.escaped_utf_32_string_to_utf_8_string_8 (a_cms_api.setup.text_item_or_default ("smtp", "localhost"))
			l_site_name := utf.escaped_utf_32_string_to_utf_8_string_8 (a_cms_api.setup.site_name)
			admin_email := a_cms_api.setup.site_email

			if not admin_email.has ('<') then
				admin_email := l_site_name + " <" + admin_email +">"
			end

			if attached {CONFIG_READER} a_cms_api.module_configuration_by_name ("contact", Void) as cfg then
				if attached cfg.text_item ("smtp") as l_smtp then
						-- Overwrite global smtp setting if any.
					smtp_server := utf.utf_32_string_to_utf_8_string_8 (l_smtp)
				end
				s := cfg.text_item ("email")
				if s /= Void then
					l_contact_email := utf.utf_32_string_to_utf_8_string_8 (s)
				end
				s := cfg.text_item ("subject")
				if s /= Void then
					l_contact_subject := utf.utf_32_string_to_utf_8_string_8 (s)
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

	smtp_server: IMMUTABLE_STRING_8

	admin_email: IMMUTABLE_STRING_8

	contact_email: IMMUTABLE_STRING_8
			-- Contact email.

	contact_subject_text: IMMUTABLE_STRING_8

end
