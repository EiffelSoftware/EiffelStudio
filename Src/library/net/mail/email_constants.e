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

	Data: STRING is "DATA "

	Mail_from: STRING is "MAIL FROM "

	Mail_to: STRING is "MAIL TO "

	ack_begin_connection: INTEGER is 220

	ok: INTEGER is 250

	ack_end_connection: INTEGER is 221

	remote_error: INTEGER is 550

	data_error: INTEGER is 354



end -- class EMAIL_CONSTANTS
