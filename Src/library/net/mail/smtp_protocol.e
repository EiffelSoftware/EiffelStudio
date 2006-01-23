indexing
	description: "Implementation of SMTP protocol."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SMTP_PROTOCOL

inherit
	SENDING_PROTOCOL
		rename
			code_number as smtp_code_number
		end

create
	make

feature -- Initialization

	make (host:STRING; user: STRING) is
			-- Create an smtp protocol with 'host, 'user' and default port.
		require
			host_not_void: host /= Void
			user_not_void: user /= Void
		do
			hostname:= host
			username:= user
			port:= default_port
		ensure
			hostname_set: hostname = host
			username_set: username = user
			port_set: port = default_port
		end

feature -- Access

	smtp_reply: STRING
		-- Replied message from SMTP protocol

	pipelining: BOOLEAN
		-- Does the connection use pipeline?

feature -- Setting

	enable_pipelining is
			-- Set pipelining.
		do
			pipelining:= True
		ensure
			pipelining_set: pipelining
		end

	disable_pipelining is
			-- Unset pipelining.
		do
			pipelining:= False
		ensure
			pipelining_set: not pipelining
		end

feature -- Access EMAIL_PROTOCOL

	default_port: INTEGER is 25
		-- Smtp default port

feature -- Implementation (EMAIL_RESOURCE).

	transfer (resource: MEMORY_RESOURCE) is
			-- Send the email and add a %R%N. at the end of the message.
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

	decode is
			-- Retrieve response from server and set `smtp_code_number'.
		local
			response: STRING
		do
			from
				socket.read_line
				response:= socket.last_string
			until
				response.item (4) /= '-'
			loop
					-- We are getting a multiline error code, we read
					-- until the error code is not followed by the hyphen
					-- sign.
				socket.read_line
				response := socket.last_string
			end
			response:= response.substring (1, 3)
			smtp_code_number := response.to_integer
			smtp_reply := response
		end

	send_command (s: STRING; expected_code: INTEGER) is
			-- Send a string 's' to the server and result the code response.
		require
			s_not_void: s /= Void
		do
			socket.put_string (s + "%R%N")
			decode
			if (smtp_code_number /= expected_code) then
				enable_transfer_error
				set_transfer_error_message (smtp_reply)
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
			header_from:= extracted_email (memory_resource.header (H_from).unique_entry)
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
				create recipients.make (a_header.entries.count)
				if a_header /= Void then
					from
						a_header.entries.start
					until
						a_header.entries.after
					loop
						recipients.extend (extracted_email (a_header.entries.item))
						a_header.entries.forth
					end
				end
				a_header:= memory_resource.header (H_cc)
			else
				a_header := memory_resource.header (H_bcc)
				create recipients.make (a_header.entries.count)
			end
			if a_header /= Void then
				from
					a_header.entries.start
				until
					a_header.entries.after
				loop
					recipients.extend (extracted_email (a_header.entries.item))
					a_header.entries.forth
				end
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
			sub_header.append ("%R%N")
		end

	add_sub_header (sub_header_key: STRING) is
			-- Add new header line 'sub_header_key',
			-- A distinction is done in case the mail is bcc or not.
		require
			sub_header_exists: sub_header /= Void
			sub_header_key_not_void: sub_header_key /= Void
			key_exists: memory_resource.headers.has (sub_header_key)
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
						sub_header.append (H_to + ":" + a_header.entries.item + "%R%N")
					end
					if not (sub_header_key.is_equal (H_to) or sub_header_key.is_equal (H_cc)) then
						sub_header.append (sub_header_key + ":" + a_header.entries.item + "%R%N")
					end
				else
					sub_header.append (sub_header_key + ":" + a_header.entries.item + "%R%N")
				end
				a_header.entries.forth
			end
		end

	send_all is
		-- Send the mail considering the correct information.
		do
			mail_message := memory_resource.mail_message.twin
			mail_signature := memory_resource.mail_signature

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
						mail_message.append ("%R%N" + mail_signature)
					end
					mail_message.replace_substring_all ("%N.", "%N..")
					mail_message.append ("%R%N.")
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

	extracted_email (a_text: STRING): STRING is
			-- Extract email address from `a_text'.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			l_pos1, l_pos2: INTEGER
		do
			Result := a_text
			l_pos1 := a_text.index_of ('<', 1)
			if l_pos1 > 1 then
				l_pos2 := a_text.index_of ('>', l_pos1)
				if l_pos2 > l_pos1 then
					Result := a_text.substring (l_pos1 + 1,  l_pos2 - 1)
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SMTP_PROTOCOL

