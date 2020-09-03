note
	description: "Summary description for {EMAIL_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_SERVICE

inherit

	SHARED_ERROR

create
	make,
	make_sendmail

feature {NONE} -- Initialization

	make (a_smtp_server: READABLE_STRING_8)
			-- Create an instance of {EMAIL_SERVICE} with an smtp_server `a_smtp_server'.
			-- Using "noreplies@eiffel.com" as admin email.
		do
			create {NOTIFICATION_SMTP_MAILER} mailer.make (a_smtp_server)
			set_successful
		end

	make_sendmail
		do
			create {NOTIFICATION_SENDMAIL_MAILER} mailer
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

	mailer: NOTIFICATION_MAILER
			-- SMTP protocol.

feature -- Basic Operations

	send_download_email (a_to: READABLE_STRING_8; a_content, a_host, a_release: READABLE_STRING_8)
			-- Send successful download message containing token code (use to validate the download and give it an expiration of 30 days) `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
			attached_host: a_host /= Void
		local
			l_email: NOTIFICATION_EMAIL
		do
			create l_email.make (admin_email, a_to, "Your EiffelStudio "+ a_release +" Download", a_content)
			l_email.add_header_line ("MIME-Version: 1.0")
			l_email.add_header_line ("Content-Type: text/html; charset=ISO-8859-1")
			send_email (l_email)
		end

	send_email_resources (a_to: READABLE_STRING_8; a_content: READABLE_STRING_8)
			-- Send message containing video resources.
		require
			attached_to: a_to /= Void
		local
			l_email: NOTIFICATION_EMAIL
		do
			create l_email.make (admin_email, a_to, "Video resources for a smooth EiffelStudio installation", a_content)
			l_email.add_header_line ("MIME-Version: 1.0")
			l_email.add_header_line ("Content-Type: text/html; charset=ISO-8859-1")
			send_email (l_email)
		end

	send_email_download_notification (a_content: READABLE_STRING_8)
				-- Send a notification email with content `a_content'.
		local
			l_email: NOTIFICATION_EMAIL
		do
			create l_email.make (admin_email, download_email, a_content, "Notification EiffelStudio Download")
			l_email.add_header_line ("MIME-Version: 1.0")
			l_email.add_header_line ("Content-Type: text/html; charset=ISO-8859-1")

			send_email (l_email)
		end

	send_email_internal_server_error (a_content: READABLE_STRING_8)
		local
			l_email: NOTIFICATION_EMAIL
		do
			create l_email.make (admin_email, webmaster_email, "Internal Server Error", a_content)
			l_email.add_header_line ("MIME-Version: 1.0")
			l_email.add_header_line ("Content-Type: text/html; charset=ISO-8859-1")
			send_email (l_email)
		end

	send_email_bad_request_error (a_content: READABLE_STRING_8)
		local
			l_email: NOTIFICATION_EMAIL
		do
			create l_email.make (admin_email, webmaster_email, "Bad request", a_content)
			l_email.add_header_line ("MIME-Version: 1.0")
			l_email.add_header_line ("Content-Type: text/html; charset=ISO-8859-1")
			send_email (l_email)
		end

	send_email (a_email: NOTIFICATION_EMAIL)
			-- Send the email represented by `a_email'.
		local
			l_retried: BOOLEAN
			utf: UTF_CONVERTER
		do
			if not l_retried then
				log.write_information (generator + ".send_email Process send email.")
				mailer.safe_process_email (a_email)
				log.write_information (generator + ".send_email Email sent.")
				set_successful
			else
				log.write_error (generator + ".send_email Email not send: " + utf.utf_32_string_to_utf_8_string_8 (last_error_message))
			end
		rescue
			set_last_error_from_exception (generator + ".send_email")
			l_retried := True
			retry
		end

	Disclaimer: STRING = "This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using %"reply%", you will not receive an answer."
		-- Email not monitored disclaimer.


end
