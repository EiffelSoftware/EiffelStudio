indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SMTP_PROTOCOL

inherit
	SENDING_PROTOCOL

create
	make_smtp

feature -- Initialization

	make_smtp (a_hostname:STRING; a_port: INTEGER; a_username: STRING) is
			-- Create an smtp protocol with 'a_hostname, 'a_port' and 'a_username'
		do
			username:= a_username
			make (a_hostname, a_port)
		end

feature -- Options

	pipelining: BOOLEAN
		-- Is the connection will use pipeline ?

feature -- Access

	smtp_code_number: INTEGER

	smtp_reply: STRING

	smtp_error: BOOLEAN is
		do
			Result:= smtp_code_number /= ack_begin_connection and 
					 smtp_code_number /= ack_end_connection and
					 smtp_code_number /= 0
		end

feature -- Setting

	enable_pipelining is
		do
			pipelining:= True
		end

	disable_pipelining is
		do
			pipelining:= False
		end

feature {NONE} -- {EMAIL_PROTOCOL}

	initiate is
		do
			if pipelining then
				send (ehlo + username)
			else
				send (helo + username)
			end
			if not smtp_error then
				enable_initiated
			end
		end

	transfer is
			-- Send the email and add a %N. at the end of the message
		do

		end

	quit is
		do
			socket.cleanup
		end

feature {NONE} -- Access

	username: STRING


feature {NONE} -- Tools

	decode (s: STRING): INTEGER is
			-- Retrieve the number corresponding to the message sent by the smtp server
		local
			s_int: STRING
		do
			smtp_reply:= s
			s_int:= s.substring (1, 4)
			Result:= s_int.to_integer
		end

	send (s: STRING) is
			-- send a string 's' to the server and result the code response
		local
			response: STRING
		do
			socket.put_string (s)
			socket.read_line
			response:= socket.last_string
			smtp_code_number:= decode (response)
		end

end -- class SMTP_PROTOCOL
