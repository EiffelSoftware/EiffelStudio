note
	description: "Provides email access"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_EMAIL_SERVICE

inherit

	ESA_API_ERROR

	ESA_SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make (a_smtp_server: READABLE_STRING_32)
			-- Create an instance of {ESA_EMAIL_SERVICE} with an smtp_server `a_smtp_server'.
			-- Using "noreplies@eiffel.com" as admin email.
		do

			admin_email := "noreplies@eiffel.com"
			smtp_server := a_smtp_server
					-- Get local host name needed in creation of SMTP_PROTOCOL.
			create host.make_local
			create smtp_protocol.make (a_smtp_server, host.local_host_name)
			set_successful
		ensure
			smtp_server_set: smtp_server = a_smtp_server
		end


	admin_email: READABLE_STRING_8
			-- Administrator email.

	host: HOST_ADDRESS
			--  host name of SMTP_PROTOCOL.

	smtp_server: READABLE_STRING_32
			-- SMTP server address.

	smtp_protocol: SMTP_PROTOCOL
			-- SMTP protocol.

feature -- Basic Operations

	send_post_registration_email (a_to, a_token, a_host: STRING)
			-- Send successful registration message containing activation code `a_token' to `a_to'.
		require
			attached_to: a_to /= Void
			attached_token: a_token /= Void
			attached_host: a_host /= Void
		local
			l_content: STRING
			l_url: URL_ENCODER
 			l_path: PATH
			l_html: HTML_ENCODER
			l_email: EMAIL
		do
			if successful then
				log.write_information (generator + ".send_post_registration_email to [" + a_to + "]" )
				create l_path.make_current
				create l_url
				create l_html
				create l_content.make (1024)
				l_content.append ("Thank you for registering at eiffel.com.%N%NTo complete your registration, please click on this link to activate your account:%N%N")
				l_content.append (a_host)
				l_content.append ("/activation")
				l_content.append ("%N%NOnce there, please enter the following information and then click the Activate Account, button.%N%N")
				l_content.append ("Your e-mail: ")
				l_content.append (l_html.encoded_string (a_to))
				l_content.append ("%N%NYour activation code: ")
				l_content.append (l_html.encoded_string(a_token))
				l_content.append ("%N%NThank you for joining us.%N%NEiffel Software.")
				l_content.append (Disclaimer)
					-- Create our message.
				create l_email.make_with_entry (admin_email, a_to)
				l_email.set_message (l_content)
				send_email (l_email)
			end
		end

	send_email_change_email (a_new_email, a_token: STRING)
			-- Send confirmation email for email address change.
		require
			attached_new_email: a_new_email /= Void
			attached_token: a_token /= Void
		local
			l_message: STRING
			l_url: URL_ENCODER
		do
			create l_url
			create l_message.make (1024)
			l_message.append ("Please confirm your new email address by clicking on the link below:%N%N")
--			l_message.append (login_root (True))
			l_message.append ("secure/protected/email_confirmation.aspx?token=")
			l_message.append (l_url.encoded_string (a_token))
			l_message.append ("&email=")
			l_message.append (l_url.encoded_string(a_new_email))
			l_message.append ("%N%NIf you are unable to click on the above link, please type the address below into your Web browser:%N%N")
--			l_message.append (application_root (True))
			l_message.append ("/secure/protected/email_confirmation.aspx%N%N")
			l_message.append ("Once there, please enter the following information and then click the %"Confirm Email%" button.%N%N")
			l_message.append ("Your new email address: ")
			l_message.append (a_new_email)
			l_message.append ("%NYour confirmation code: ")
			l_message.append (a_token)
			l_message.append ("%N%NThank you for using eiffel.com.%N%NEiffel Software.")
--			l_message.append (Disclaimer)
--			send_email (from_address (Void), a_new_email, Void, "Eiffel Software - Email Address Change Confirmation", l_message)
		end

	send_new_email_confirmed_email (a_old_email, a_new_email: STRING)
			-- Send email to old email address confirming address change.
		local
			l_message: STRING
		do
			create l_message.make (1024)
			l_message.append ("Your account information on eiffel.com has been updated and your new email address is now ")
			l_message.append (a_new_email)
			l_message.append (". Please contact us by phone 805-685-1006 or by fax 805-685-6869 as soon as possible if you haven't requested this change.%N%NThank you for using eiffel.com.%N%NEiffel Software.%N%N------------------------------------------------------------%N")
--			l_message.append (Disclaimer)
--			send_email (from_address (Void), a_old_email, Void, "Eiffel Software - Email Address Updated", l_message)
		end


	send_password_reset (a_to, a_message, a_host: STRING)
			-- Send password reset email `a_token' to `a_to'.
		local
			l_content: STRING
			l_url: URL_ENCODER
 			l_path: PATH
			l_html: HTML_ENCODER
			l_email: EMAIL
		do
			if successful then
				log.write_information (generator + ".send_password_reset to [" + a_to + "]" )
				create l_path.make_current
				create l_url
				create l_html
				create l_email.make_with_entry (admin_email, a_to)
				l_email.set_message (a_message)
				send_email (l_email)
			end
		end

feature {NONE} -- Implementation


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
			else
				log.write_error (generator + ".send_email Email not send" + last_error_message )
			end
		rescue
			set_last_error_from_exception (generator + ".send_email")
			l_retried := True
			retry
		end

	Disclaimer: STRING = "This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using %"reply%", you will not receive an answer."
		-- Email not monitored disclaimer

end
