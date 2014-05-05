note
	description: "Provides email access"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_EMAIL_SERVICE

inherit

	ESA_API_ERROR

create

	make_with_mailer

feature {NONE} -- Initialization

	make_with_mailer (a_mailer: NOTIFICATION_MAILER; )
		do
			mailer := a_mailer
			admin_email := "noreplies@eiffel.com"
			credentials
			set_successful
		ensure
			mailer_set: mailer = a_mailer
		end

	mailer: NOTIFICATION_MAILER
			-- notification

	admin_email: READABLE_STRING_8
			-- Administrator email

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
 			m: NOTIFICATION_EMAIL
			l_path: PATH
			l_error : detachable STRING
			l_html: HTML_ENCODER
		do
			if successful then
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
				create l_error.make_empty
				if mailer.is_available then
					create l_error.make_empty
					create m.make (admin_email, a_to, "Eiffel.com Registration Activation", l_content)
					if {PLATFORM}.is_windows and then attached {WS_NOTIFICATION_SENDMAIL_MAILER} mailer as l_mailer then
						l_error := l_mailer.process_mail_command (build_mailsend_command (a_to,l_content),l_path.name.out, True, Void)
						if attached  l_error and then l_error.has_substring ("Error") then
							set_last_error (l_error, generator + ".send_post_registration_email")
						else
							set_successful
						end
					else
						mailer.process_email (m)
					end
				end
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


feature {NONE} -- Implementation


	build_mailsend_command (a_to: STRING; a_content: STRING): STRING
			-- Workaround for windows.
			-- Using mailsend.
			-- "mailsend -to user@gmail.com -from user@gmail.com  -ssl -port 465 -auth -smtp smtp.gmail.com -sub test -v -user user@gmail.com -pass password -M message"
		do
			create Result.make_from_string ("mailsend")
			Result.append (" ")
			Result.append ("-to")
			Result.append (" ")
			Result.append (a_to)
			Result.append (" ")
			Result.append ("-from")
			Result.append (" ")
			Result.append ("%""+ admin_email+ "%"")
			Result.append (" ")
			Result.append ("-ssl -port 465 -auth -smtp smtp.gmail.com ")
			Result.append (" -sub ")
			Result.append ("EiffelSupport")
			Result.append (" ")
			Result.append (" -user ")
			if attached gmail_account as l_gmail then
				Result.append (l_gmail)
			else
				Result.append ("invalidemail")
			end
			Result.append (" -pass ")
			if attached password as l_password then
				Result.append (l_password)
			else
				Result.append ("nopassword")
			end
			Result.append (" -M ")
			Result.append ("%""+ a_content +"%"")

		end

	credentials
 			-- Retrieve a email and password from a file
 			-- firsline email
 			-- secondline password
 		local
 			f: RAW_FILE
 			p: PATH
 			l_retry: BOOLEAN
 			l_exceptions: EXCEPTIONS
 		do
 			if not l_retry then
	 			create p.make_current
	 			p := p.extended("src").extended ("esa_template").extended ("bin").extended ("email_credentials.txt")
	 			create f.make_with_path (p)
	 			if f.exists and then f.is_access_readable then
	 					f.open_read
	 				if not f.end_of_file then
	 					f.read_line
		 				create gmail_account.make_from_string (f.last_string)
		 				if attached gmail_account as l_gmail_account then
							l_gmail_account.left_adjust
		 					l_gmail_account.right_adjust
		 				end
		 				if not f.end_of_file then
			 				f.read_line
			 				create password.make_from_string (f.last_string)
			 				if attached password as l_password then
				 				l_password.left_adjust
			 					l_password.right_adjust
			 				end
			 			end
			 		end
	 				f.close
	 			end
	 		end
		rescue
			create l_exceptions
			if attached l_exceptions.exception_trace as l_trace  then
				debug
					io.error.put_string (l_trace)
				end
			end
			l_retry := True
			retry
		end


	gmail_account: detachable STRING
		-- Gmail account to send SMTP

	password: detachable STRING
		-- Account password

	Disclaimer: STRING = "This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using %"reply%", you will not receive an answer."
		-- Email not monitored disclaimer

end
