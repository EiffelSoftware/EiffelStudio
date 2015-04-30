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
		local
			l_address_factory: INET_ADDRESS_FACTORY
		do
			admin_email := parameters.admin_email

				-- Get local host name needed in creation of SMTP_PROTOCOL.
			create l_address_factory
			create smtp_protocol.make (parameters.smtp_server, l_address_factory.create_localhost.host_name)
			set_successful
		end

	parameters: EMAIL_SERVICE_PARAMETERS
			-- Associated parameters.

	admin_email: IMMUTABLE_STRING_8
			-- Site admin's email.

	smtp_protocol: SMTP_PROTOCOL
			-- SMTP protocol.

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
			l_email: EMAIL
			utf: UTF_CONVERTER
		do
			write_debug_log (generator + ".send_contact_email: [from:" + a_from_address + ", to:" + a_to_address + ", subject:" + a_subjet + ", content:" + a_content)
			create l_email.make_with_entry (a_from_address, a_to_address)
			l_email.set_message (utf.escaped_utf_32_string_to_utf_8_string_8 (a_content))
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, utf.escaped_utf_32_string_to_utf_8_string_8 (a_subjet))
			l_email.add_header_entry ("MIME-Version:", "1.0")
			l_email.add_header_entry ("Content-Type", "text/html; charset=utf-8")
			send_email (l_email)
		end

feature {NONE} -- Implementation

	send_email (a_email: EMAIL)
			-- Send the email represented by `a_email'.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				write_information_log (generator + ".send_email Process send email.")
				smtp_protocol.initiate_protocol
				smtp_protocol.transfer (a_email)
				smtp_protocol.close_protocol
				write_information_log (generator + ".send_email Email sent.")
				if smtp_protocol.error then
					set_last_error ("smtp_protocol reported an error", generator + ".send_email")
				else
					set_successful
				end
			else
				write_error_log (generator + ".send_email Email not send " + last_error_message )
			end
		rescue
			set_last_error_from_exception (generator + ".send_email")
			l_retried := True
			retry
		end

end
