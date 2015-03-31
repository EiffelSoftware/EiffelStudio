note
	description: "Summary description for {EMAIL_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_SERVICE

inherit

	SHARED_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_smtp_server: READABLE_STRING_32)
			-- Create an instance of {EMAIL_SERVICE} with an smtp_server `a_smtp_server'.
			-- Using "noreplies@eiffel.com" as admin email.
		local
			l_address_factory: INET_ADDRESS_FACTORY
		do
					-- Get local host name needed in creation of SMTP_PROTOCOL.
			create l_address_factory
			create smtp_protocol.make (a_smtp_server, l_address_factory.create_localhost.host_name)
			set_successful
		end

	admin_email: IMMUTABLE_STRING_8
			-- Administrator email.
		once
			Result := "Eiffel Software Evaluation <noreplies@eiffel.com>"
		end

	webmaster_email: IMMUTABLE_STRING_8
			-- WebMaster email.
		once
			Result := "Eiffel Software Web Master <webmaster@eiffel.com>"
		end

	download_email: IMMUTABLE_STRING_8
			-- Administrator email.
		once
			Result := "Eiffel Software Evaluation <download@eiffel.com>"
		end

	smtp_protocol: SMTP_PROTOCOL
			-- SMTP protocol.

feature -- Basic Operations

	send_download_email (a_to, a_content, a_host: STRING)
			-- Send successful download message containing token code (use to validate the download and give it an expiration of 30 days) `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
			attached_host: a_host /= Void
		local
			l_email: EMAIL
		do
				-- Create our message.
			create l_email.make_with_entry (admin_email, a_to)
			l_email.set_message (a_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Your EiffelStudio Download")
			l_email.add_header_entry ("MIME-Version:", "1.0")
			l_email.add_header_entry ("Content-Type", "text/html; charset=ISO-8859-1")
			send_email (l_email)
		end

	send_email_resources (a_to, a_content: READABLE_STRING_8)
			-- Send message containing video resources.
		require
			attached_to: a_to /= Void
		local
			l_email: EMAIL
		do
				-- Create our message.
			create l_email.make_with_entry (admin_email, a_to)
			l_email.set_message (a_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Video resources for a smooth EiffelStudio installation")
			l_email.add_header_entry ("MIME-Version:", "1.0")
			l_email.add_header_entry ("Content-Type", "text/html; charset=ISO-8859-1")
			send_email (l_email)
		end

	send_email_download_notification (a_content: READABLE_STRING_32)
		do
			send_download_notification (a_content,"Notification EiffelStudio Download")
		end

	send_email_internal_server_error (a_content: READABLE_STRING_32)
		local
			l_email: EMAIL
		do
				-- Create our message.
			create l_email.make_with_entry (admin_email, webmaster_email)
			l_email.set_message (a_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Internal Server Error")
			send_email (l_email)
		end

	send_email_bad_request_error (a_content: READABLE_STRING_32)
		local
				l_email: EMAIL
		do
				-- Create our message.
			create l_email.make_with_entry (admin_email, webmaster_email)
			l_email.set_message (a_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Bad request")
			send_email (l_email)
		end

	send_email (a_email: EMAIL)
			-- Send the email represented by `a_email'.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				log.write_information (generator + ".send_email Process send email.")
				smtp_protocol.initiate_protocol
				smtp_protocol.transfer (a_email)
				smtp_protocol.close_protocol
				log.write_information (generator + ".send_email Email sent.")
				set_successful
			else
				log.write_error (generator + ".send_email Email not send: " + last_error_message )
			end
		rescue
			set_last_error_from_exception (generator + ".send_email")
			l_retried := True
			retry
		end

	Disclaimer: STRING = "This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using %"reply%", you will not receive an answer."
		-- Email not monitored disclaimer.

feature {NONE} -- Implemenation

	send_download_notification (a_content: READABLE_STRING_32; a_subject: READABLE_STRING_32)
				-- Send a notification email with content `a_content' with subject `a_subject'.
		local
			l_email: EMAIL
		do
				-- Create our message.
			create l_email.make_with_entry (admin_email, download_email)
			l_email.set_message (a_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, a_subject)
			send_email (l_email)
		end

end
