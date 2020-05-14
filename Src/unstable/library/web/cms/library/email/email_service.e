note
	description: "Basic Email Service"
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_SERVICE

inherit
	SHARED_ERROR

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make (a_params: like parameters)
			-- Create instance of {EMAIL_SERVICE} with smtp_server `a_params.smtp_server'.
			-- Using `a_params.admin_email' as admin email.
		do
			parameters := a_params
			initialize
		end

	initialize
			-- Initialize service.
		do
			admin_email := parameters.admin_email
			create {NOTIFICATION_SMTP_MAILER} mailer.make (parameters.smtp_server)
			set_successful
		end

	parameters: EMAIL_SERVICE_PARAMETERS
			-- Associated parameters.

	mailer: NOTIFICATION_MAILER
			-- SMTP protocol.

feature -- Access

	admin_email: IMMUTABLE_STRING_8
			-- Site admin's email.

feature -- Basic Operations

	send_internal_email (a_content: READABLE_STRING_GENERAL)
		do
			send_message (admin_email, admin_email, "Notification Contact", a_content)
		end

	send_email_internal_server_error (a_content: READABLE_STRING_GENERAL)
		do
			send_message (admin_email, admin_email, "Internal Server Error", a_content)
		end

	send_message (a_from_address, a_to_address: READABLE_STRING_8; a_subjet: READABLE_STRING_GENERAL; a_content: READABLE_STRING_GENERAL)
		local
			l_email: NOTIFICATION_EMAIL
			utf: UTF_CONVERTER
		do
			write_debug_log (generator + ".send_message: [from:" + a_from_address + ", to:" + a_to_address + ", subject:" + utf.escaped_utf_32_string_to_utf_8_string_8 (a_subjet) + ", content:" + utf.escaped_utf_32_string_to_utf_8_string_8 (a_content))
			create l_email.make (a_from_address, a_to_address, utf.escaped_utf_32_string_to_utf_8_string_8 (a_subjet) , utf.escaped_utf_32_string_to_utf_8_string_8 (a_content))
			l_email.add_header_line ("MIME-Version:1.0")
			l_email.add_header_line ("Content-Type: text/html; charset=utf-8")
			send_email (l_email)
		end

feature {NONE} -- Implementation

	send_email (a_email: NOTIFICATION_EMAIL)
			-- Send the email represented by `a_email'.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				write_information_log (generator + ".send_email Process send email.")
				mailer.process_email (a_email)
				write_information_log (generator + ".send_email Email sent.")
				if mailer.has_error then
					set_last_error ("smtp_protocol reported an error", generator + ".send_email")
				else
					set_successful
				end
			else
				write_error_log (generator + ".send_email Email not send " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (last_error_message))
			end
		rescue
			set_last_error_from_exception (generator + ".send_email")
			l_retried := True
			retry
		end

end
