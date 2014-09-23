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
			Result := "noreplies@eiffel.com"
		end

	smtp_protocol: SMTP_PROTOCOL
			-- SMTP protocol.

feature -- Basic Operations

	send_download_email (a_to, a_content, a_host: STRING)
			-- Send successful download message containing token code (use to validate the download and give it an expiration of 10 days) `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
			attached_host: a_host /= Void
		local
			l_content: STRING
			l_url: URL_ENCODER
 			l_path: PATH
			l_email: EMAIL
		do
			create l_path.make_current
			create l_content.make_from_string (a_content)
			l_content.append (Disclaimer)
				-- Create our message.
			create l_email.make_with_entry (admin_email, a_to)
			l_email.set_message (l_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Eiffel Site: EiffelStudio Download")
			l_email.add_header_entry ("MIME-Version:", "1.0")
			l_email.add_header_entry ("Content-Type", "text/html; charset=ISO-8859-1")
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
				log.write_error (generator + ".send_email Email not send" + last_error_message )
			end
		rescue
			set_last_error_from_exception (generator + ".send_email")
			l_retried := True
			retry
		end

	Disclaimer: STRING = "This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using %"reply%", you will not receive an answer."
		-- Email not monitored disclaimer.

end
