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
	make_with_header, make_with_recipient, make_with_recipients

feature -- Initialization.

	make_with_header (header_from: HEADER; header_to: HEADER) is
			-- Create an email for one recipient.
		require
			needed_info: header_from /= Void
						 and then header_to /= Void 
		do
			create headers.make (3)

			headers.put (header_from, H_from)
			headers.put (header_to, H_to)

			set_subject ("")
		end

	make_with_recipient (sender: STRING; recipient: STRING) is
			-- Create an email for multiple recipients
		local
			m_header: HEADER
		do
			create headers.make (3)

			create m_header.make_with_entry (sender)
			headers.put (m_header, H_from)
			create m_header.make_with_entry (recipient)
			headers.put (m_header, H_to)

			set_subject ("")
		end

	make_with_recipients (sender: STRING; recipients: ARRAY [STRING]) is
			-- Create an email for multiple recipients
		local
			m_header: HEADER
		do
			create headers.make (3)

			create m_header.make_with_entry (sender)
			headers.put (m_header, H_from)
			create m_header.make_with_entries (recipients)
			headers.put (m_header, H_to)
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

end -- class EMAIL
