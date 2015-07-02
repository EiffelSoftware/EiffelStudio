note
	description: "Summary description for {CMS_OPENID_EMAIL_SERVICE_PARAMETERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_EMAIL_SERVICE_PARAMETERS

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
			l_contact_email, l_subject_register, l_subject_activate, l_subject_password, l_subject_oauth: detachable READABLE_STRING_8
		do
			cms_api := a_cms_api
				-- Use global smtp setting if any, otherwise "localhost"
			smtp_server := utf.escaped_utf_32_string_to_utf_8_string_8 (a_cms_api.setup.text_item_or_default ("smtp", "localhost"))
			l_site_name := utf.escaped_utf_32_string_to_utf_8_string_8 (a_cms_api.setup.site_name)
			admin_email := a_cms_api.setup.site_email

			if not admin_email.has ('<') then
				admin_email := l_site_name + " <" + admin_email +">"
			end

			if attached {CONFIG_READER} a_cms_api.module_configuration_by_name ({CMS_AUTHENTICATION_MODULE}.name, Void) as cfg then
				if attached cfg.text_item ("smtp") as l_smtp then
						-- Overwrite global smtp setting if any.
					smtp_server := utf.utf_32_string_to_utf_8_string_8 (l_smtp)
				end
				s := cfg.text_item ("email")
				if s /= Void then
					l_contact_email := utf.utf_32_string_to_utf_8_string_8 (s)
				end
				s := cfg.text_item ("subject_register")
				if s /= Void then
					l_subject_register := utf.utf_32_string_to_utf_8_string_8 (s)
				end
				s := cfg.text_item ("subject_activate")
				if s /= Void then
					l_subject_register := utf.utf_32_string_to_utf_8_string_8 (s)
				end
				s := cfg.text_item ("subject_password")
				if s /= Void then
					l_subject_register := utf.utf_32_string_to_utf_8_string_8 (s)
				end
				s := cfg.text_item ("subject_oauth")
				if s /= Void then
					l_subject_oauth := utf.utf_32_string_to_utf_8_string_8 (s)
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
			if l_subject_register /= Void then
				contact_subject_register := l_subject_register
			else
				contact_subject_register := "Thank you for registering with us."
			end
		end

feature	-- Access

	smtp_server: IMMUTABLE_STRING_8

	admin_email: IMMUTABLE_STRING_8

	contact_email: IMMUTABLE_STRING_8
			-- Contact email.

	contact_subject_register: IMMUTABLE_STRING_8

	account_welcome: STRING
			-- Account welcome template email message.
		do
			Result := template_string ("account_welcome.html", default_template_account_welcome)
		end

feature {NONE} -- Implementation: Template		

	template_path (a_name: READABLE_STRING_GENERAL): PATH
			-- Location of template named `a_name'.
		do
			Result := cms_api.module_location_by_name ({CMS_AUTHENTICATION_MODULE}.name).extended (a_name)
		end

	template_string (a_name: READABLE_STRING_GENERAL; a_default: STRING): STRING
			-- Content of template named `a_name', or `a_default' if template is not found.
		local
			p: PATH
		do
			p := template_path ("account_activation.html")
			if attached read_template_file (p) as l_content then
				Result := l_content
			else
				create Result.make_from_string (a_default)
			end
		end

feature {NONE} -- Implementation

	cms_api: CMS_API

	read_template_file (a_path: PATH): detachable STRING
			-- Read the content of the file at path `a_path'.
		local
			l_file: FILE
			n: INTEGER
		do
			create {PLAIN_TEXT_FILE} l_file.make_with_path (a_path)
			if l_file.exists and then l_file.is_readable then
				n := l_file.count
				l_file.open_read
				l_file.read_stream (n)
				Result := l_file.last_string
				l_file.close
			else
				-- Error	
			end
		end


feature {NONE} -- Message email

	default_template_account_welcome: STRING = "[
		<!doctype html>
		<html lang="en">
		<head>
		  <meta charset="utf-8">
		  <title>Welcome</title>
		  <meta name="description" content="Welcome">
		  <meta name="author" content="ROC CMS">
		</head>

		<body>
			<p>Welcome to<a href="...">ROC CMS</a></p>
			<p>Thank you for joining us.</p>
		</body>
		</html>
	]"

end
