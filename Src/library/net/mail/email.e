indexing
	description: "Email Object"
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL

inherit
	MEMORY_RESOURCE

create
	make_with_header, make_with_recipients

feature -- Initialization.

	make_with_header (header_from: STRING; header_to: STRING; header_subject: STRING; m_message: STRING) is
			-- Create an email for one recipient.
		require
			needed_info: header_from /= Void
						 and then header_to /= Void 
						 and then header_subject /= Void
						 and then m_message /= Void
		do
			create headers.make (3)
			headers.put (header_from, H_from)
			headers.put (header_to, H_to)
			headers.put (header_subject, H_subject)
			mail_message:= m_message
		end

	make_with_recipients (a_sender: STRING; some_recipients: LINKED_LIST [STRING]; a_message: STRING) is
			-- Create an email for multiple recipients.
		do
--			set_mail_from (a_sender)
--			set_mail_to (some_recipients)
--			set_signature ("")
--			set_message (a_message)
		end

feature -- Access

--	subject: STRING
		-- Email subject

--	mail_from: STRING
		-- From (sender)

--	mail_to: LINKED_LIST [STRING]
		-- To (recipients)

--	mail_cc: LINKED_LIST [STRING]
		-- Cc (recipients)

--	mail_bcc: LINKED_LIST [STRING]
		-- Bcc (recipients)


	signature: STRING
		-- Email signature

feature -- Settings

	set_headers (head: STRING; value: STRING) is
		require
			header_exists: valid_header (head)
		do
			headers.put (value, head)
		end

	set_signature (s: STRING) is
		do
			mail_signature:= s
		end

feature {NONE} -- Basic operations.

	transfer (resource: PROTOCOL_RESOURCE) is
			-- Used when the mailer will receive an email from 'resource'.
		do
			
		end

feature -- Basic operations

	send is
			-- Send email.
		do

		end

	receive is
			-- Receive email.
		do

		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_received: BOOLEAN is True
		-- An email can be received.

	can_be_sent: BOOLEAN is True
		-- An email can be send.

	valid_header (head: STRING): BOOLEAN is
		do
			Result:= (head.is_equal (H_to) or else head.is_equal (H_from) or else
						head.is_equal (H_cc) or else head.is_equal (H_bcc) or else
						head.is_equal (H_subject))
		end


end -- class EMAIL
