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
	make_smtp, make_smtp_and_connect

feature -- Initialization

	make_smtp (a_hostname:STRING; a_username: STRING) is
			-- Create an smtp protocol with 'a_hostname, 'a_port' and 'a_username'.
		do
			username:= a_username
			make (a_hostname, default_port)
		end

	make_smtp_and_connect (a_hostname:STRING; a_username: STRING) is
			-- Create an smtp protocol with 'a_hostname, 'a_port' and 'a_username'.
		do
			username:= a_username
			make (a_hostname, default_port)
			connect
		end


feature -- Access

	smtp_code_number: INTEGER
		-- Code number of the reply.

	smtp_reply: STRING
		-- Replied message from SMTP protocol.

	smtp_error: BOOLEAN is
			-- Protocol error.
		do
			Result:= smtp_code_number /= ack_begin_connection and 
					 smtp_code_number /= ack_end_connection and
					 smtp_code_number /= 0
		end

feature -- Access EMAIL_PROTOCOL

	default_port: INTEGER is 25

feature -- Status setting

	pipelining: BOOLEAN
		-- Does the connection will use pipeline?

feature -- Status setting. (EMAIL_RESOURCE)

	is_sender: BOOLEAN is True

	is_receiver: BOOLEAN is True

feature -- Setting

	enable_pipelining is
			-- Set pipelining.
		do
			pipelining:= True
		end

	disable_pipelining is
			-- Unset pipelining.
		do
			pipelining:= False
		end

feature {NONE} -- Implementation (EMAIL_PROTOCOL).

	initiate is
			-- Initiate the smtp connection.
			-- It can be an helo or an ehlo connection.
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
			-- Send the email and add a %N. at the end of the message.
		do

		end

	terminate is
			-- Terminate the connection.
		do
			socket.cleanup
		end

feature {NONE} -- Implementation

	username: STRING
		-- Smtp user name (Needed to initiate the connection).


feature {NONE} -- Miscellaneous

	decode (s: STRING): INTEGER is
			-- Retrieve the number corresponding to the message sent by the smtp server.
		local
			s_int: STRING
		do
			smtp_reply:= s
			s_int:= s.substring (1, 4)
			Result:= s_int.to_integer
		end

	send (s: STRING) is
			-- send a string 's' to the server and result the code response.
		local
			response: STRING
		do
			socket.put_string (s)
			socket.read_line
			response:= socket.last_string
			smtp_code_number:= decode (response)
		end

end -- class SMTP_PROTOCOL
