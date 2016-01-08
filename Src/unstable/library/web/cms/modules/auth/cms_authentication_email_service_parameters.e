note
	description: "Summary description for {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS

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
			l_site_name := utf.escaped_utf_32_string_to_utf_8_string_8 (a_cms_api.setup.site_name)
			notif_email_address := a_cms_api.setup.site_notification_email
			sender_email_address := a_cms_api.setup.site_email

			if not notif_email_address.has ('<') then
				notif_email_address := l_site_name + " <" + notif_email_address + ">"
			end

			if attached a_cms_api.module_configuration_by_name ({CMS_AUTHENTICATION_MODULE}.name, Void) as cfg then
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
				contact_email_address := l_contact_email
			else
				contact_email_address := notif_email_address
			end
			if l_subject_register /= Void then
				contact_subject_register := l_subject_register
			else
				contact_subject_register := "Thank you for registering with us."
			end

			if l_subject_activate /= Void then
				contact_subject_activate := l_subject_activate
			else
				contact_subject_activate := "New account activation token."
			end
			if l_subject_password /= Void then
				contact_subject_password := l_subject_password
			else
				contact_subject_password := "Password Recovery."
			end
			if l_subject_oauth /= Void then
				contact_subject_oauth := l_subject_oauth
			else
				contact_subject_oauth := "Welcome."
			end
		end

feature	-- Access

	cms_api: CMS_API

	notif_email_address: IMMUTABLE_STRING_8

	sender_email_address: IMMUTABLE_STRING_8

	contact_email_address: IMMUTABLE_STRING_8
			-- Contact email.

	contact_subject_register: IMMUTABLE_STRING_8
	contact_subject_activate: IMMUTABLE_STRING_8
	contact_subject_password: IMMUTABLE_STRING_8
	contact_subject_oauth: IMMUTABLE_STRING_8

	account_activation: STRING
			-- Account activation template email message.
		do
			Result := template_string ("account_activation.html", default_template_account_activation)
		end

	account_re_activation: STRING
			-- Account re_activation template email message.
		do
			Result := template_string ("accunt_re_activation.html", default_template_account_re_activation)
		end

	account_password: STRING
			-- Account password template email message.
		do
			Result := template_string ("account_new_password.html", default_template_account_new_password)
		end

	account_welcome: STRING
			-- Account welcome template email message.
		do
			Result := template_string ("account_welcome.html", default_template_account_welcome)
		end

feature {NONE} -- Implementation: Template		

	template_path (a_name: READABLE_STRING_GENERAL): PATH
			-- Location of template named `a_name'.
		local
			p: PATH
		do
			create p.make_from_string (a_name)
			Result := cms_api.module_location_by_name ({CMS_AUTHENTICATION_MODULE}.name).extended ("mail_templates").extended (a_name)
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

	default_template_account_activation: STRING = "[
		<!doctype html>
		<html lang="en">
		<head>
		  <meta charset="utf-8">
		  <title>Activation</title>
		  <meta name="description" content="Activation">
		  <meta name="author" content="ROC CMS">
		</head>

		<body>
			<p>Thank you for registering at <a href="...">ROC CMS</a></p>

			<p>To complete your registration, please click on the following link to activate your account:<p>

			<p><a href="$link">$link</a></p>
			<p>Thank you for joining us.</p>
		</body>
		</html>
	]"


	default_template_account_re_activation: STRING = "[
		<!doctype html>
		<html lang="en">
		<head>
		  <meta charset="utf-8">
		  <title>New Activation</title>
		  <meta name="description" content="New Activation token">
		  <meta name="author" content="ROC CMS">
		</head>

		<body>
			<p>You have requested a new activation token at <a href="...">ROC CMS</a></p>

			<p>To complete your registration, please click on the following link to activate your account:<p>

			<p><a href="$link">$link</a></p>
			<p>Thank you for joining us.</p>
		</body>
		</html>
	]"



	default_template_account_new_password: STRING = "[
		<!doctype html>
		<html lang="en">
		<head>
		  <meta charset="utf-8">
		  <title>New Password</title>
		  <meta name="description" content="New Password">
		  <meta name="author" content="ROC CMS">
		</head>

		<body>
			<p>You have required a new password at <a href="...">ROC CMS</a></p>

			<p>To complete your request, please click on this link to generate a new password:<p>

			<p><a href="$link">$link</a></p>
		</body>
		</html>
	]"


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
