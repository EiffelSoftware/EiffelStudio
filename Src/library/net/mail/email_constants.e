indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL_CONSTANTS

feature -- Constants for SMTP Protocol

	Helo: STRING is "HELO "

	Ehlo: STRING is "EHLO "

	Data: STRING is "DATA"

	Mail_from: STRING is "MAIL FROM: "

	Mail_to: STRING is "RCPT TO: "

	Mail_cc: STRING is "RCPT CC:"

	Mail_bcc: STRING is "RCPT BCC:"

	Mail_reply_to: STRING is "RCPT REPLY TO:"

	Quit: STRING is "QUIT"

	Ack_begin_connection: INTEGER is 220

	Ok: INTEGER is 250

	Ack_end_connection: INTEGER is 221

	Remote_error: INTEGER is 550

	Data_code: INTEGER is 354

	Struct_error: INTEGER is 552

	Size_error: INTEGER is 500

	No_valid_recipient: INTEGER is 554

feature -- Constants for email headers (Authorized keys for the Hashtables)

	H_to: STRING is "To"

	H_from: STRING is "From"

	H_cc: STRING is "Cc"

	H_bcc: STRING is "Bcc"

	H_subject: STRING is "Subject"

	H_reply_to: STRING is "Reply-to"

	Default_headers: ARRAY [STRING] is 
		once
			create Result.make_from_array (<<H_to, H_from, H_cc, H_bcc, H_reply_to>>)
		end

end -- class EMAIL_CONSTANTS

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

