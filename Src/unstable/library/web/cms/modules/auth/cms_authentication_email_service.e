note
	description: "Summary description for {CMS_AUTHENTICATION_EMAIL_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_AUTHENTICATION_EMAIL_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_params: like parameters)
			-- Create instance of email service with `a_params' data.
		do
			parameters := a_params
			initialize
		end

	initialize
			-- Initialize service.
		do
			create error_handler.make
			reset_error
		end

feature -- Access

	parameters: CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS
			-- Associated parameters.

	cms_api: CMS_API
		do
			Result := parameters.cms_api
		end

	contact_email_address: IMMUTABLE_STRING_8
			-- contact email.
		do
			Result := parameters.contact_email_address
		end

	notif_email_address: IMMUTABLE_STRING_8
			-- Site admin's email.
		do
			Result := parameters.notif_email_address
		end

	sender_email_address: IMMUTABLE_STRING_8
			-- Site sender's email.
		do
			Result := parameters.sender_email_address
		end

feature -- Error

	error_handler: ERROR_HANDLER

	has_error: BOOLEAN
		do
			Result := error_handler.has_error
		end

	reset_error
		do
			error_handler.reset
		end

feature -- Basic Operations / Internal

	send_internal_email (a_content: READABLE_STRING_GENERAL)
		do
			send_message (sender_email_address, notif_email_address, "Notification Contact", a_content)
		end

	send_email_internal_server_error (a_content: READABLE_STRING_GENERAL)
		do
			send_message (sender_email_address, notif_email_address, "Internal Server Error", a_content)
		end

feature -- Basic Operations / Contact

	send_admin_account_evaluation (a_user: CMS_USER; a_application: READABLE_STRING_GENERAL; a_url_activate, a_url_reject, a_host: READABLE_STRING_8)
			-- Send new user register to webmaster to confirm or reject itt.
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.admin_account_evaluation)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$user", a_user.utf_8_name)
			if attached a_user.email as l_email then
				l_message.replace_substring_all ("$email", l_email)
			else
				l_message.replace_substring_all ("$email", "unknown email")
			end
			l_message.replace_substring_all ("$application", cms_api.utf_8_encoded (a_application))
			l_message.replace_substring_all ("$activation_url", a_url_activate)
			l_message.replace_substring_all ("$rejection_url", a_url_reject)
			send_message (contact_email_address, contact_email_address, parameters.contact_subject_account_evaluation, l_message)
		end

	send_contact_email (a_to: READABLE_STRING_8; a_user: CMS_USER; a_host: READABLE_STRING_8)
			-- Send successful contact message for user `a_user' to `a_to'.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_activation)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$user", a_user.utf_8_name)
			l_message.replace_substring_all ("$email", a_to)
			send_message (contact_email_address, a_to, parameters.contact_subject_register, l_message)
		end

	send_contact_activation_email (a_to: READABLE_STRING_8; a_user: CMS_USER; a_link, a_host: READABLE_STRING_8)
			-- Send successful message activation to `a_to'.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_re_activation)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$link", a_link)
			l_message.replace_substring_all ("$email", a_to)
			send_message (contact_email_address, a_to, parameters.contact_subject_activate, l_message)
		end

	send_contact_account_email_verification (a_to: READABLE_STRING_8; a_user: CMS_USER; a_activation_url: READABLE_STRING_8; a_host: READABLE_STRING_8)
			-- Send email validation message to a_to.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_email_verification)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$user", a_user.utf_8_name)
			l_message.replace_substring_all ("$email", a_to)
			l_message.replace_substring_all ("$activation_url", a_activation_url)
			send_message (contact_email_address, a_to, parameters.contact_subject_activated, l_message)
		end

	send_contact_activation_confirmation_email (a_to: READABLE_STRING_8; a_user: CMS_USER; a_host: READABLE_STRING_8)
			-- Send successful message activation to a_to.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_activation_confirmation)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$user", a_user.utf_8_name)
			l_message.replace_substring_all ("$email", a_to)
			send_message (contact_email_address, a_to, parameters.contact_subject_activated, l_message)
		end

	send_contact_activation_reject_email (a_to: READABLE_STRING_8; a_user: CMS_USER; a_host: READABLE_STRING_8; a_rejection_reason: detachable READABLE_STRING_GENERAL)
			-- Send successful contact activation reject message to `a_to'.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
			utf: UTF_CONVERTER
		do
			create l_message.make_from_string (parameters.account_rejected)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$email", a_to)
			l_message.replace_substring_all ("$user", a_user.utf_8_name)
			if a_rejection_reason /= Void and then not a_rejection_reason.is_whitespace then
				l_message.replace_substring_all ("$rejection_reason", utf.utf_32_string_to_utf_8_string_8 (a_rejection_reason))
			else
				l_message.replace_substring_all ("$rejection_reason", "it was not respecting the requirements.")
			end
			send_message (contact_email_address, a_to, parameters.contact_subject_rejected, l_message)
		end

	send_contact_password_email (a_to: READABLE_STRING_8; a_user: CMS_USER; a_link, a_host: READABLE_STRING_8)
			-- Send successful new account password message to `a_to'.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_password)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$link", a_link)
			send_message (contact_email_address, a_to, parameters.contact_subject_password, l_message)
		end

	send_contact_welcome_email (a_to: READABLE_STRING_8; a_user: CMS_USER; a_host: READABLE_STRING_8)
			-- Send successful welcome message to `a_to'.
		require
			attached_to: a_to /= Void
		local
			l_message: STRING
		do
			create l_message.make_from_string (parameters.account_welcome)
			l_message.replace_substring_all ("$host", a_host)
			l_message.replace_substring_all ("$sitename", parameters.utf_8_site_name)
			l_message.replace_substring_all ("$email", a_to)
			l_message.replace_substring_all ("$user", a_user.utf_8_name)
			send_message (contact_email_address, a_to, parameters.contact_subject_oauth, l_message)
		end

feature {NONE} -- Implementation

	send_message (a_from_address, a_to_address: READABLE_STRING_8; a_subjet: READABLE_STRING_GENERAL; a_content: READABLE_STRING_GENERAL)
		local
			l_email: CMS_EMAIL
			utf: UTF_CONVERTER
		do
			reset_error
			l_email := cms_api.new_html_email (a_to_address, utf.escaped_utf_32_string_to_utf_8_string_8 (a_subjet), utf.escaped_utf_32_string_to_utf_8_string_8 (a_content))
			l_email.set_from_address (a_from_address)
			cms_api.process_email (l_email)
			if cms_api.has_error then
				error_handler.add_custom_error (-1, generator + "send_message failed", cms_api.string_representation_of_errors)
			end
		end

end
