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
	make_smtp, make_smtp_connect_and_initiate

feature -- Initialization

	make_smtp (a_hostname:STRING; a_username: STRING) is
			-- Create an smtp protocol with 'a_hostname, 'a_port' and 'a_username'.
		do
			username:= a_username
			make (a_hostname, default_port)
		end

	make_smtp_connect_and_initiate (a_hostname:STRING; a_username: STRING) is
			-- Create an smtp protocol with 'a_hostname, 'a_port' and 'a_username'.
		do
			username:= a_username
			make (a_hostname, default_port)
			connect
			initiate_protocol
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
			if Result then
				enable_transfer_error
			end
		end

	pipelining: BOOLEAN
		-- Does the connection use pipeline?

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

feature -- Access EMAIL_PROTOCOL

	default_port: INTEGER is 25
		-- Smtp default port.

	memory_resource: MEMORY_RESOURCE
		-- Memory resource to be send.

feature -- Implementation (EMAIL_PROTOCOL).

	transfer (resource: MEMORY_RESOURCE) is
			-- Send the email and add a %N. at the end of the message.
		require else
			connection_exists: is_connected
			connection_initiated: is_initiated
		do
			memory_resource := resource
			send_mail
		end

feature -- Basic operations.

	initiate_protocol is
			-- Initiate the smtp connection
			-- It can be a helo or a ehlo connection.
		local
			stop_waiting: BOOLEAN
		do
			if pipelining then
				send_command (ehlo + username, Ok)
			else
				send_command (helo + username, Ok)
			end
			if not transfer_error then
				enable_initiated
			end
		end

	close_protocol is
			-- Terminate the connection.
		require else
			connection_exists: is_connected
		do
			send_command (Quit, Ack_end_connection)
			if not transfer_error then
				socket.cleanup
				disable_connected
			end
		ensure then
			disconnected: not is_connected
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_receive: BOOLEAN is False
		-- Smtp protocol can not receive.

feature {NONE} -- Implementation

	username: STRING
		-- Smtp user name (Needed to initiate the connection).


feature {NONE} -- Basic operations

	decode (s: STRING): INTEGER is
			-- Retrieve the number corresponding to the message receive from the smtp server.
		local
			s_int: STRING
		do
			smtp_reply:= s
			s_int:= s.substring (1, 4)
			Result:= s_int.to_integer
		end

	send_command (s: STRING; expected_code: INTEGER) is
			-- send a string 's' to the server and result the code response.
		local
			response: STRING
		do
			socket.put_string (s + "%N")
			socket.read_line
			response:= socket.last_string
			smtp_code_number := decode (response)
			if (smtp_code_number /= expected_code) then
				enable_transfer_error
			end
		end

feature {NONE} -- Basic operations

	send_mail is
			-- Send mail using smtp protocol.
		require else
			connection_exists: is_connected
			connection_initiated: is_initiated		
		do
			retrieve_header_and_message
			set_from
			set_to
			set_cc
			set_bcc
			set_subject
			set_message
			set_signature
			send_all
		end

	retrieve_header_and_message is
		do
			header_to:= memory_resource.header (H_to)
			header_from:= memory_resource.header (H_from)
			header_cc:= memory_resource.header (H_cc)
			header_bcc:= memory_resource.header (H_bcc)
			header_subject:= memory_resource.header (H_subject)
			mail_message:= memory_resource.mail_message
			mail_signature:= memory_resource.mail_signature
		ensure
			valid_email: mail_to /= Void and then mail_message /= Void
		end

	decompose (addresses: STRING): LINKED_LIST [STRING] is
			-- Create a linked list of addresses from 'addresses'
		do
			create Result.make
			if addresses /= Void then
				Result.extend (addresses)
			end
		end

	set_from is
		do
			if not transfer_error then
				send_command (Mail_from + header_from, Ok)
			end
		end

	set_to is
		do
			list_of_addresses:= decompose (header_to)
			from
				list_of_addresses.start
			until
				list_of_addresses.after
			loop
				send_command (Mail_to + list_of_addresses.item, Ok)
				list_of_addresses.forth
			end
		end

	set_cc is
		do
			if not transfer_error then
				list_of_addresses:= decompose (header_cc)
				if list_of_addresses /= Void then
					from
						list_of_addresses.start
					until
						list_of_addresses.after
					loop
						send_command (Mail_cc + list_of_addresses.item, Ok)
						list_of_addresses.forth
					end
				end
			end
		end

	set_bcc is
		do
			if not transfer_error then
				list_of_addresses:= decompose (header_bcc)
				if list_of_addresses /= Void then
					from
						list_of_addresses.start
					until
						list_of_addresses.after
					loop
						send_command (Mail_bcc + list_of_addresses.item, Ok)
						list_of_addresses.forth
					end
				end
			end
		end

	set_subject is
		do
			if not transfer_error then
				mail_message.prepend (Mail_subject + header_subject + "%N")
			end
		end

	set_message is
		do
			if not transfer_error then
				send_command (Data, Data_code)
				mail_message.replace_substring_all ("%N.", ".%N")
			end
		end

	set_signature is
		do
			if not transfer_error then
				if mail_signature /= Void then
					mail_message.append ("%N" + mail_signature)
				end
			end
		end

	send_all is
		do
			if not transfer_error then
				mail_message.append ("%N.")
				send_command (mail_message, Ok)
			end
		end

feature {NONE} -- Access

	header_to: STRING
		-- To.

	header_from: STRING
		-- From.

	header_cc: STRING
		-- Cc.

	header_bcc: STRING
		-- Bcc.

	header_subject: STRING
		-- Subject.

	mail_message: STRING
		-- Message.

	mail_signature: STRING
		-- Signature.

	list_of_addresses: LINKED_LIST [STRING]

end -- class SMTP_PROTOCOL
