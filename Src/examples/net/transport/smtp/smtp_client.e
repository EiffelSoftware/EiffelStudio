indexing
	description: "Simple way of sending an email."
	date: "$Date$"
	revision: "$Revision$"

class
	SMTP_CLIENT
	
create
	make

feature -- Initialization

	make is
			-- Initialize
		local
			l_smtp_protocol: SMTP_PROTOCOL
			l_host: HOST_ADDRESS
			l_email: EMAIL
			l_smtp_server, l_sender, l_recipient, l_message: STRING
		do
				-- Get smtp server.
			io.put_string ("Enter your SMTP server address: ")
			io.read_line
			l_smtp_server := io.last_string.twin

				-- Get sender email.
			io.put_string ("Enter your email address: ")
			io.read_line
			l_sender := io.last_string.twin
			
				-- Get recipient email.
			io.put_string ("Enter your recipient email address: ")
			io.read_line
			l_recipient := io.last_string.twin
			
				-- Get one line message.
			io.put_string ("Enter your one line message: ")
			io.read_line
			l_message := io.last_string.twin

				-- To get local host name needed in creation of SMTP_PROTOCOL.
			create l_host.make_local

				-- Create our message.
			create l_email.make_with_entry (l_sender, l_recipient)
			l_email.set_message (l_message)
			
				-- Send it.
			create l_smtp_protocol.make (l_smtp_server, l_host.local_host_name)
			l_smtp_protocol.initiate_protocol
			l_smtp_protocol.transfer (l_email)
			l_smtp_protocol.close_protocol
		end

end -- class SMTP_CLIENT
