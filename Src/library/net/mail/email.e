indexing
	description: "Email Object"
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL

create
	make_with_one_recipient, make_with_recipients

feature -- Initialization

	make_with_one_recipient (a_sender: STRING; a_recipient: STRING; a_subject: STRING; a_message: STRING) is
		require
			needed_info: a_sender /= Void
						 and then a_recipient /= Void 
						 and then a_subject /= Void
						 and then a_message /= Void
		do
			set_mail_from (a_sender)
			create mail_to.make
			add_mail_to (a_recipient)
			set_subject (a_subject)
			set_signature ("")
			set_message (a_message)
		end

	make_with_recipients (a_sender: STRING; some_recipients: LINKED_LIST [STRING]; a_message: STRING) is
		do
			set_mail_from (a_sender)
			set_mail_to (some_recipients)
			set_signature ("")
			set_message (a_message)
		end

feature -- Tool

	add_mail_to (new_to: STRING) is
		do
			mail_to.extend (new_to)
		end

feature -- Settings

	set_mail_from (s: STRING) is
		do
			mail_from:= s
		end

	set_mail_to (l: LINKED_LIST [STRING]) is
		do
			mail_to:= l
		end

	set_mail_cc (l: LINKED_LIST [STRING]) is
		do
			mail_cc:= l
		end

	set_mail_bcc (l: LINKED_LIST [STRING]) is
		do
			mail_bcc:= l
		end

	set_subject (s: STRING) is
		do
			subject:= s
		end

	set_message (s: STRING) is
			-- Set the email message 's' and end it with a . at the end of the line
		do
			message:= s
			message.append (signature)
		end

	set_signature (s: STRING) is
		do
			signature:= s
		end

feature -- Access

	subject: STRING
		-- Email subject

	mail_from: STRING
		-- From (sender)

	mail_to: LINKED_LIST [STRING]
		-- To (recipients)

	mail_cc: LINKED_LIST [STRING]
		-- Cc (recipients)

	mail_bcc: LINKED_LIST [STRING]
		-- Bcc (recipients)

	message: STRING
		-- Email message

	signature: STRING
		-- Email signature

	mailer: MAILER

end -- class EMAIL
