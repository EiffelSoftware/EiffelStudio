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
	make

feature -- Initialization

	make (host:STRING; user: STRING) is
			-- Create an smtp protocol with 'host, 'user' and default port.
		do
			hostname:= host
			username:= user
			port:= default_port
		end

feature -- Access

	smtp_code_number: INTEGER
		-- Code number of the reply

	smtp_reply: STRING
		-- Replied message from SMTP protocol

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
		-- Smtp default port

feature -- Implementation (EMAIL_RESOURCE).

	transfer (resource: MEMORY_RESOURCE) is
			-- Send the email and add a %N. at the end of the message.
		do
			if not error then
				memory_resource := resource
				recipients:= Void
				send_mail
			end
--			disable_transfer_error
		end

feature -- Basic operations.

	initiate_protocol is
			-- Initiate the smtp connection
			-- It can be a helo or a ehlo connection.
		do
			connect
			if pipelining then
				send_command (ehlo + username, Ok)
			else
				send_command (helo + username, Ok)
			end
			if not error then
				enable_initiated
			end
		end

	close_protocol is
			-- Terminate the connection.
		require else
			connection_exists: is_connected
		do
			send_command (Quit, Ack_end_connection)
--			if not error then
				socket.cleanup
				disable_initiated
				disable_connected
				disable_transfer_error
				set_transfer_error_message ("")
--			end
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_receive: BOOLEAN is False
		-- Can the Smtp protocolreceive?

	initialize is
			-- Initialize the protocol to send a new email.
		do

		end

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
			socket.put_string (s + "%R%N")
			if not socket.interface_error then
				socket.read_line
				if not socket.interface_error then
					response:= socket.last_string
					smtp_code_number := decode (response)
					if (smtp_code_number /= expected_code) then
						enable_transfer_error
						set_transfer_error_message (smtp_reply)
					end
				end
			end
			if socket.interface_error then
				enable_transfer_error
				set_transfer_error_message ("Interface error")
			end
		end

feature {NONE} -- Basic operations

	send_mail is
			-- Send mail using smtp protocol.
		do
			send_mails
			if memory_resource.headers.has (H_bcc) then
				enable_bcc_mode
				send_mails
				disable_bcc_mode
			end
		end

	send_mails	is
		do
				header_from:= memory_resource.header (H_from).unique_entry
				sub_header:= ""
				set_recipients
				build_sub_header
				send_all
		end

	set_recipients is
			-- Fill 'recipients' to know who will receive the resource,
			-- and fill 'header_from'
		require
			header_to_exists: memory_resource.headers.has (H_to)
		local
			a_header: HEADER
		do
			if not bcc_mode then
				a_header:= memory_resource.header (H_to)
				recipients:= clone (a_header.entries)
				a_header:= memory_resource.header (H_cc)
				if a_header /= Void then
					from 
						a_header.entries.start
					until
						a_header.entries.after
					loop
						recipients.extend (a_header.entries.item)
						a_header.entries.forth
					end
				end
			else
				recipients:= memory_resource.header (H_bcc).entries
			end
		end

	build_sub_header is
			-- Build the header of the message in 'sub_header'.
		do
			from 
				memory_resource.headers.start
			until
				memory_resource.headers.after
			loop
				add_sub_header (memory_resource.headers.key_for_iteration)
				memory_resource.headers.forth
			end
		end

	add_sub_header (sub_header_key: STRING) is
			-- Add new header line 'sub_header_key',
			-- A distinction is done in case the mail is bcc or not.
		require
			key_exists: memory_resource.headers.has (sub_header_key)
			sub_header_exists: sub_header /= Void
		local
			a_header: HEADER
		do
			a_header:= memory_resource.header (sub_header_key)
			from 
				a_header.entries.start
			until
				a_header.entries.after
			loop
				if bcc_mode then
					if sub_header_key.is_equal (H_bcc) then
						sub_header.append (H_to + ":" +a_header.entries.item + "%N")
					end
					if not (sub_header_key.is_equal (H_to) or sub_header_key.is_equal (H_cc)) then
						sub_header.append (sub_header_key + ":" + a_header.entries.item + "%N")
					end
				else
					sub_header.append (sub_header_key + ":" + a_header.entries.item + "%N")
				end
				a_header.entries.forth
			end
		end

	send_all is
		-- Send the mail considering the correct information.
		do
			mail_message:= clone (memory_resource.mail_message)
			mail_signature:= memory_resource.mail_signature

			send_command (Mail_from + "<" + header_from + ">", Ok)
			if not error then
				from 
					recipients.start
				until
					recipients.after
				loop
					if not error then
						send_command (Mail_to + "<" + recipients.item + ">", Ok)
					end
					recipients.forth
				end

				if not error then
					send_command (Data, Data_code)
					mail_message.prepend (sub_header)
					if mail_signature /= Void then
						mail_message.append ("%N" + mail_signature)
					end
					mail_message.replace_substring_all ("%N.", "%N..")
					mail_message.append ("%N.%N")
					if not error then
						send_command (mail_message, Ok)
					end
				end
			end
		end


feature {NONE} -- Access

	recipients: ARRAYED_LIST [STRING]
		-- Header to use with the command 'Mail_to'

	header_from: STRING
		-- Header to use with the command 'Mail_from'.

	sub_header: STRING
		-- Sub_header: data before the message.

	mail_message: STRING
		-- Message.

	mail_signature: STRING
		-- Signature.

	bcc_mode: BOOLEAN
		-- Is bcc mode activated?

feature {NONE} -- Implementation

	enable_bcc_mode is
		do
			bcc_mode:= True
		end

	disable_bcc_mode is
		do
			bcc_mode:= False
		end

end -- class SMTP_PROTOCOL
