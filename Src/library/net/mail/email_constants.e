note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_CONSTANTS

feature -- Constants for SMTP Protocol

	Helo: STRING_8 = "HELO "

	Ehlo: STRING_8 = "EHLO "

	Data: STRING_8 = "DATA"

	Mail_from: STRING_8 = "MAIL FROM: "

	Mail_to: STRING_8 = "RCPT TO: "

	Mail_cc: STRING_8 = "RCPT CC:"

	Mail_bcc: STRING_8 = "RCPT BCC:"

	Mail_reply_to: STRING_8 = "RCPT REPLY TO:"

	Quit: STRING_8 = "QUIT"

	Ack_begin_connection: INTEGER = 220

	Ok: INTEGER = 250

	Ack_end_connection: INTEGER = 221

	Remote_error: INTEGER = 550

	Data_code: INTEGER = 354

	Struct_error: INTEGER = 552

	Size_error: INTEGER = 500

	No_valid_recipient: INTEGER = 554

feature -- Constants for email headers (Authorized keys for the Hashtables)

	H_to: STRING_8 = "To"

	H_from: STRING_8 = "From"

	H_cc: STRING_8 = "Cc"

	H_bcc: STRING_8 = "Bcc"

	H_subject: STRING_8 = "Subject"

	H_reply_to: STRING_8 = "Reply-to"

	H_date: STRING_8 = "Date"

	Default_headers: ARRAY [STRING_8]
		obsolete
			"Use one of the `H_xxx` constants instead [2017-05-31]."
		once
			create Result.make_from_array (<<H_to, H_from, H_cc, H_bcc, H_reply_to>>)
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EMAIL_CONSTANTS

