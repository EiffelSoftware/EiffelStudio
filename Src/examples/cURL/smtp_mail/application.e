note
	description	: "[
			cURL https://curl.haxx.se/libcurl/c/smtp-mail.html
			For original C version, please see:
			https://curl.haxx.se/libcurl/c/smtp-mail.html
			This is a simple example showing how to send mail using libcurl's SMTP
			capabilities.
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=cURL smtp example", "src=https://curl.haxx.se/libcurl/c/smtp-mail.html", "protocol=uri"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_result: INTEGER
			l_from: STRING
			l_to: STRING
			l_cc: STRING
			recipients: POINTER
			curl_externals: CURL_EXTERNALS
			payload_data: CURL_PAYLOAD_DATA_FUNCTION
			l_message: STRING
		do
			io.put_string ("Eiffel cURL SMTP example showing how to send e-mails.")
			io.put_new_line
			print ("%NLibCurl Veriosn:" + (create {CURL_OPT_CONSTANTS}).libcurl_version.out)

				-- add the from email.
			l_from := "sender@example.org"
			l_to := "addressee@example.net"
			l_cc := "info@example.org"

			create l_message.make_from_string (message)
			l_message.replace_substring_all ("$TO", l_to)
			l_message.replace_substring_all ("$CC", l_cc)
			l_message.replace_substring_all ("$FROM", l_from)
			if curl_easy.is_dynamic_library_exists then
				curl_handle := curl_easy.init


					-- This is the URL for your mailserver "smtp://mail.example.com"
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "smtp://127.0.0.1")

					-- Note that this option isn't strictly required, omitting it will result
					-- in libcurl sending the MAIL FROM command with empty sender data. All
					-- autoresponses should have an empty reverse-path, and should be directed
					-- to the address in the reverse-path which triggered them. Otherwise,
					-- they could cause an endless loop. See RFC 5321 Section 4.5.5 for more
					-- details.
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_mail_from, l_from)

					-- Add two recipients, in this particular case they correspond to the
					-- To: and Cc: addressees in the header, but they could be any kind of
					-- * recipient.

				create curl_externals
				recipients := curl_externals.slist_append (recipients, l_to)
				recipients := curl_externals.slist_append (recipients, l_cc)
				curl_easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_mail_rcpt, recipients)

				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_upload, 1)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_infilesize, l_message.count)
				create payload_data.make
				payload_data.set_data_to_read (l_message)
				curl_easy.set_curl_function (payload_data)
				curl_easy.set_read_function (curl_handle)

				l_result := curl_easy.perform (curl_handle)

				if l_result = {CURL_CODES}.curle_ok then
					print ("%NSMTP sent ok")
				else
					print ("Error: cURL Error[" + l_result.out + "]")
				end
				curl_externals.slist_free_all (recipients)

					-- Always cleanup
				curl_easy.cleanup (curl_handle)
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

feature {NONE} -- Implementation

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals.
		once
			create Result
		end

	curl_handle: POINTER
			-- cURL handle.

	message: STRING  = "[
		Date: Mon, 29 Nov 2010 21:54:29 +1100
		To:  $TO
		From:  $FROM (Example User)
		Cc: $CC (Another example User)
		Subject: SMTP example message
		
		The body of the message starts here
		
		It could be a lot of lines, could be MIME encoded, whatever.
		Check RFC5322.
	]"

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
