note
	description: "Provides email access"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_EMAIL_SERVICE

inherit

	SHARED_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_smtp_server: READABLE_STRING_32)
			-- Create an instance of {ESA_EMAIL_SERVICE} with an smtp_server `a_smtp_server'.
			-- Using "noreplies@eiffel.com" as admin email.
		local
		do
					-- Get local host name needed in creation of SMTP_PROTOCOL.
			create smtp_protocol.make (a_smtp_server, (create {INET_ADDRESS_FACTORY}).create_localhost.host_name)
			set_successful
		end

	admin_email: IMMUTABLE_STRING_8
			-- Administrator email.
		once
			Result := "noreplies@eiffel.com"
		end

	webmaster_email: IMMUTABLE_STRING_8
			-- Webmaster email.
		once
			Result := "webmaster@eiffel.com"
		end

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
				l_content.append ("/activation?code=")
				l_content.append (l_url.encoded_string (a_token))
				l_content.append ("&email=")
				l_content.append (l_url.encoded_string (a_to))
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
				l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Eiffel Support Site: Account Activation")
				send_email (l_email)
			end
		end

	send_email_change_email (a_new_email, a_token, a_host: STRING)
			-- Send confirmation email for email address change.
		require
			attached_new_email: a_new_email /= Void
			attached_token: a_token /= Void
		local
			l_message: STRING
			l_url: URL_ENCODER
			l_email: EMAIL
		do
			create l_url
			create l_message.make (1024)
			l_message.append ("Please confirm your new email address by clicking on the link below:%N%N")
			l_message.append (a_host)
			l_message.append ("/confirm_email?token=")
			l_message.append (l_url.encoded_string (a_token))
			l_message.append ("%N%NIf you are unable to click on the above link, please type the address into your Web browser:%N%N")
			l_message.append ("Once there, please enter the following information and then click the %"Confirm Email%" button.%N%N")
			l_message.append ("%NYour confirmation code: ")
			l_message.append (a_token)
			l_message.append ("%N%NThank you for using eiffel.com.%N%NEiffel Software.")
			l_message.append (Disclaimer)

				-- Create our message.
			create l_email.make_with_entry (admin_email, a_new_email)
			l_email.set_message (l_message)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Eiffel Support Site: Email Activation")
			send_email (l_email)
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
			l_path: PATH
			l_email: EMAIL
		do
			if successful then
				log.write_information (generator + ".send_password_reset to [" + a_to + "]" )
				create l_path.make_current
				create l_email.make_with_entry (admin_email, a_to)
				l_email.set_message (a_message)
				l_email.set_signature (disclaimer)
				l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "Eiffel Support Site: Password Reset")
				send_email (l_email)
			end
		end

	send_new_report_email (a_name: STRING; a_report: REPORT; a_email: STRING; a_subscribers: LIST [STRING]; a_url: STRING)
			-- Send report creation confirmation email to interested parties.
		local
			l_email: EMAIL
			l_etable: STRING_TABLE [STRING]
		do
			if successful then
				create l_email.make_with_entry (user_mail (a_name), a_email)
				l_email.set_message (new_report_email_message (a_report, a_url))
				l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, report_email_subject (a_report, 0))
				if not a_subscribers.is_empty then
					create l_etable.make_caseless (1)
					l_etable.force ("", a_email)
					l_email.add_header_entries ({EMAIL_CONSTANTS}.h_bcc, recipients_to_array (a_subscribers, l_etable))
				end
				l_email.add_header_entry ("MIME-Version:", "1.0")
				l_email.add_header_entry ("Content-Type", "text/plain; charset=UTF-8")

				send_email (l_email)
			else
				log.write_error (generator + ".send_new_report_email " + a_report.number.out + " " + last_error_message)
			end
		end

	send_new_interaction_email (a_user: USER_INFORMATION; a_report: REPORT; a_subscribers: LIST [STRING]; a_old_report: REPORT; a_url: STRING; a_user_role: USER_ROLE; a_submitter_email: STRING)
			-- Send report creation confirmation email to interested parties.
		local
			l_email: EMAIL
			l_message: STRING
			l_etable: STRING_TABLE [STRING]
			l_array: ARRAY [STRING]
		do
			if
				attached a_report.interactions as l_interactions and then
				attached l_interactions.first as l_report_interaction
			then
				if successful and then
				   attached a_user.email as ll_email
				then
					if a_user_role.is_administrator or else a_user_role.is_responsible then
						create l_email.make_with_entry (user_mail ("Eiffel Software Customer Support"), ll_email)
					else
						create l_email.make_with_entry (user_mail (a_user.displayed_name), ll_email)
					end
					create l_message.make_empty
					l_message.append (new_interaction_email_message(a_user,l_report_interaction, a_report, a_old_report,a_url))
					l_email.set_message (l_message)
					l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, report_email_subject (a_report, l_interactions.count))
					if not a_subscribers.is_empty then
						create  l_etable.make_caseless (2)
						l_etable.force ("", a_submitter_email)
						l_etable.force ("", ll_email )
						l_array := recipients_to_array (a_subscribers, l_etable)
						l_array.force (a_submitter_email, l_array.count + 1)
						l_email.add_header_entries ({EMAIL_CONSTANTS}.h_bcc, l_array )
					end
					send_email (l_email)
				else
					log.write_error (generator + ".send_new_interaction_email " + a_report.number.out + " " + last_error_message)
				end
			else
				log.write_error (generator + ".send_new_interaction_email " + a_report.number.out + " " + last_error_message)
			end
		end


	send_responsible_change_email (a_user_name: READABLE_STRING_32; a_report: REPORT; a_user: USER_INFORMATION; a_url: STRING)
			-- Send email to new problem report responsible.
		local
			l_email: EMAIL
			l_content: STRING
		do
			if successful and then
				attached a_user.email as ll_email
			then
				create l_email.make_with_entry (user_mail (a_user.displayed_name), ll_email)
				create l_content.make (2048)
				l_content.append (a_user_name)
				l_content.append (" has made you the responsible for problem report '")
				l_content.append (a_report.synopsis)
				l_content.append ("'.%N%N")
				l_content.append ( report_email_links (a_url + "/report_detail", a_report.number))
				l_email.set_message (l_content)
				l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, report_email_subject (a_report, 0))
				send_email (l_email)
			else
				log.write_error (generator + ".send_responsible_change_email " + a_report.number.out + " " + last_error_message)
			end
		end

	send_shutdown_email (a_message: READABLE_STRING_GENERAL)
			-- Send email shutdown cause by an unexpected condition.
		local
			l_email: EMAIL
			l_content: STRING
		do
			create l_email.make_with_entry (admin_email, webmaster_email)
			create l_content.make (2048)
			l_content.append (a_message.as_string_32)
			l_email.set_message (l_content)
			l_email.add_header_entry ({EMAIL_CONSTANTS}.H_subject, "ESA API exception")
			send_email (l_email)
		end

feature {NONE} -- Implementation

	user_mail (a_name: STRING): STRING
			-- Construct the from email of a user `a_name' as "a_name <admin_mail>".
		do
			create Result.make (a_name.count + 3 + admin_email.count)
			Result.append (a_name)
			Result.append_character ('<')
			Result.append (admin_email)
			Result.append_character ('>')
		end

	report_email_subject (a_report: REPORT; a_interactions_count: INTEGER): STRING
			-- Subject of email related to report `a_report'
		do
			create Result.make (1024)
			Result.append_character ('[')
			if attached a_report.category as l_category then
				Result.append (l_category.synopsis)
			end
			Result.append (" #")
			Result.append_integer (a_report.number)
			if a_interactions_count > 0 then
				Result.append (" - ")
				Result.append_integer (a_interactions_count)
			end
			Result.append ("] ")
			Result.append (a_report.synopsis)
		end

	recipients_to_array (a_recipients: LIST [STRING]; a_emails: STRING_TABLE[STRING]): ARRAY [STRING]
			-- Convert list of recipients to 'To' array of strings.
		require
			valid_recipients: not a_recipients.is_empty
		local
			i: INTEGER
		do
			a_emails.compare_objects
			from
				create Result.make_empty
				a_recipients.start
				i := 1
				if not a_emails.has (a_recipients.item) then
					Result.force (a_recipients.item, i)
					i := 2
				end
				a_recipients.forth
			until
				a_recipients.after
			loop
				if not a_emails.has (a_recipients.item) then
					Result.force (a_recipients.item, i)
					i := i + 1
				end
				a_recipients.forth
			end
		ensure
			attached_string: Result /= Void
		end

	report_email_links (a_url:STRING; a_report_number: INTEGER): STRING
			-- Links to report with number `a_report_number'
		do
			create Result.make (1024)
			Result.append ("%N%NAdditional information available at:%N")
			Result.append (a_url)
			Result.append ("/")
			Result.append_integer (a_report_number)
			Result.append ("%N%NAdd a new interaction to problem report at:%N")
			Result.append (a_url)
			Result.append ("/")
			Result.append_integer (a_report_number)
			Result.append ("/interaction_form")
		end


	new_report_email_message (a_report: REPORT; a_url: STRING): STRING
			-- New report message
		local
			utf: UTF_CONVERTER
		do
			create Result.make (4096)
			Result.append (report_email_subject (a_report, 0))
			Result.append (":%N%NSubmitter: ")
			if
				attached a_report.contact as l_contact and then
				attached l_contact.name as l_name
			then
				Result.append (l_name)
			end
			Result.append ("%NClass: ")
			if attached a_report.report_class as l_class then
				Result.append (l_class.synopsis)
			end
			Result.append ("%NSeverity: ")
			if attached a_report.severity as l_severity then
				Result.append (l_severity.synopsis)
			end
			Result.append ("%NCategory: ")
			if
				attached a_report.category as l_category and then
				attached l_category.synopsis as l_synopsis
			then
				Result.append (l_synopsis)
			end
			Result.append ("%NRelease: ")
			if attached a_report.release as l_release then
				Result.append (l_release)
			end
			Result.append ("%NEnvironment: ")
			if attached a_report.environment as l_env then
				Result.append (l_env)
			end
			Result.append ("%N%NDescription:%N")
			if attached a_report.description as l_description  then
				utf.escaped_utf_32_string_into_utf_8_string_8 (l_description, Result)
				if attached a_report.to_reproduce as l_reproduce and then l_reproduce.count > 0 then
					Result.append ("%N%NTo reproduce:%N")
					utf.escaped_utf_32_string_into_utf_8_string_8 (l_reproduce, Result)
				end
			end

			if attached {LIST [REPORT_INTERACTION]} a_report.interactions as l_interactions then
				across l_interactions as  ic
				loop
					if attached ic.item.attachments as l_attachments then
					Result.append ("%NAttachments%N")
						across l_attachments as ic2
						loop
							Result.append (a_url)
							Result.append ("/report_interaction/")
							Result.append_integer (ic2.item.id)
							Result.append ("/")
							Result.append (ic2.item.name)
							Result.append ("%N")
						end
					end
				end
			end

			Result.append (report_email_links (a_url + "/report_detail", a_report.number))
			Result.append ("%N%N")
			Result.append (signature (Void))
		end

	new_interaction_email_message (a_user: USER_INFORMATION; a_report_interaction: REPORT_INTERACTION; a_report: REPORT; a_old_report: REPORT; a_url: STRING): STRING
			-- New interaction message.
		do
			create Result.make (4096)

			if
				attached a_old_report.category as l_old_category and then
				attached a_old_report.status as l_old_status and then
				attached a_report.category as l_category and then
				attached a_report.status as l_status
			then
				Result.append ("%N")
				if not l_old_status.synopsis.is_case_insensitive_equal_general (l_status.synopsis) then
					Result.append ("Status changed to '" + l_status.synopsis)

					if not l_old_category.synopsis.is_case_insensitive_equal_general (l_category.synopsis) then
						Result.append ("', category changed to '" + l_category.synopsis + "'")
					else
						Result.append ("'")
					end
				else
					if not l_old_category.synopsis.is_case_insensitive_equal_general (l_category.synopsis) then
						Result.append ("Category changed to '" + l_category.synopsis + "'")
					end
				end
				Result.append ("%N%N")
			end

			if attached a_report_interaction.content as l_content then
				Result.append ((create{UTF8_ENCODER}).decoded_string (l_content))
				Result.append ("%N%N")
			end

			if
				attached a_report_interaction.attachments as l_attachments 	and then
				not l_attachments.is_empty
			then
				Result.append (attachments_text (l_attachments, a_url))
			end

			Result.append (report_email_links (a_url + "/report_detail", a_report.number))
			Result.append ("%N%N")
			Result.append (signature (a_user))
		end

	attachments_text (a_attachments: LIST [REPORT_ATTACHMENT]; a_url: READABLE_STRING_8): STRING
			-- Text for downloading attachments `a_attachments'.
		require
			not_empty: not a_attachments.is_empty
		do
			create Result.make (512)
			Result.append ("Attachments:%N%N")
			from
				a_attachments.start
				Result.append (attachment_text (a_attachments.item, a_url))
				a_attachments.forth
			until
				a_attachments.after
			loop
				Result.append ("%N%N")
				Result.append (attachment_text (a_attachments.item, a_url))
				a_attachments.forth
			end
		ensure
			attached_text: Result /= Void
		end

	attachment_text (a_attachment: REPORT_ATTACHMENT; a_url: READABLE_STRING_8): STRING
			-- Text for downloading `a_attachment'.
		local
			u: UTF_CONVERTER
		do
			create Result.make (512)
			u.utf_32_string_into_utf_8_string_8 (a_attachment.name, Result)
			Result.append (" (")
			Result.append_integer (a_attachment.bytes_count)
			Result.append (" bytes):%N")
			Result.append (a_url)
			Result.append ("/report_interaction/")
			Result.append_integer (a_attachment.id)
			Result.append ("/")
			u.utf_32_string_into_utf_8_string_8 (a_attachment.name, Result)
		end


	signature (a_user: detachable USER_INFORMATION): STRING
			-- Email signature for user `a_user'.
		do
			create Result.make (256)
			Result.append ("--%NWith best regards,%NThe Customer Support Team.%N")
			if a_user /= Void then
				Result.append ("%N------------------------------------------------------------%N")
				Result.append ("Message prepared by: ")
				Result.append (a_user.displayed_name)
				Result.append ("%N%N")
				Result.append (Disclaimer)
			end
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
