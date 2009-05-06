note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_CONSTANTS

feature -- Constants for SMTP Protocol

	Helo: STRING = "HELO "

	Ehlo: STRING = "EHLO "

	Data: STRING = "DATA"

	Mail_from: STRING = "MAIL FROM: "

	Mail_to: STRING = "RCPT TO: "

	Mail_cc: STRING = "RCPT CC:"

	Mail_bcc: STRING = "RCPT BCC:"

	Mail_reply_to: STRING = "RCPT REPLY TO:"

	Quit: STRING = "QUIT"

	Ack_begin_connection: INTEGER = 220

	Ok: INTEGER = 250

	Ack_end_connection: INTEGER = 221

	Remote_error: INTEGER = 550

	Data_code: INTEGER = 354

	Struct_error: INTEGER = 552

	Size_error: INTEGER = 500

	No_valid_recipient: INTEGER = 554

feature -- Constants for email headers (Authorized keys for the Hashtables)

	H_to: STRING = "To"

	H_from: STRING = "From"

	H_cc: STRING = "Cc"

	H_bcc: STRING = "Bcc"

	H_subject: STRING = "Subject"

	H_reply_to: STRING = "Reply-to"

	Default_headers: ARRAY [STRING]
		once
			create Result.make_from_array (<<H_to, H_from, H_cc, H_bcc, H_reply_to>>)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EMAIL_CONSTANTS

