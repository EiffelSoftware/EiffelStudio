note
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

	make (host:STRING; user: STRING)
			-- Create an smtp protocol with 'host, 'user' and default port.
		require
			host_not_void: host /= Void
			user_not_void: user /= Void
		do
			hostname:= host
			username:= user
			port:= default_port
			create sub_header.make_empty
			create headers.make (4)
			create {EMAIL} memory_resource.make
		ensure
			hostname_set: hostname = host
			username_set: username = user
			port_set: port = default_port
		end

feature -- Access

	smtp_reply: detachable STRING
		-- Replied message from SMTP protocol

	pipelining: BOOLEAN
		-- Does the connection use pipeline?

feature -- Setting

	enable_pipelining
			-- Set pipelining.
		do
			pipelining:= True
		ensure
			pipelining_set: pipelining
		end

	disable_pipelining
			-- Unset pipelining.
		do
			pipelining:= False
		ensure
			pipelining_set: not pipelining
		end

feature -- Access EMAIL_PROTOCOL

	default_port: INTEGER = 25
		-- Smtp default port

feature -- Implementation (EMAIL_RESOURCE).

	transfer (resource: MEMORY_RESOURCE)
			-- Send the email and add a %R%N. at the end of the message.
		do
			if not error then
				memory_resource := resource
				recipients := Void
				send_mail
			end
		end

feature -- Basic operations.

	initiate_protocol
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

	close_protocol
			-- Terminate the connection.
		require else
			connection_exists: is_connected
		local
			l_socket: like socket
		do
			l_socket := socket
			check l_socket_attached: l_socket /= Void end
			send_command (Quit, Ack_end_connection)
			l_socket.cleanup
			disable_initiated
			disable_connected
			disable_transfer_error
			set_transfer_error_message ("")
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_receive: BOOLEAN = False
		-- Can the Smtp protocolreceive?

	initialize
			-- Initialize the protocol to send a new email.
		do

		end

feature {NONE} -- Implementation

	username: STRING
		-- Smtp user name (Needed to initiate the connection).


feature {NONE} -- Basic operations

	decode (a_socket: attached like socket)
			-- Retrieve response from server and set `smtp_code_number'.
		local
			response: STRING
		do
			from
				a_socket.read_line
				response:= a_socket.last_string
			until
				response.count < 4 or else response.item (4) /= '-'
			loop
					-- We are getting a multiline error code, we read
					-- until the error code is not followed by the hyphen
					-- sign.
				a_socket.read_line
				response := a_socket.last_string
					-- Per postcondition of `socket.read_line'.
				check response_attached: response /= Void end
			end
			response := response.substring (1, 3)
			smtp_code_number := response.to_integer
			smtp_reply := response
		ensure then
			smtp_reply_set: smtp_reply /= Void
		end

	send_command (s: STRING; expected_code: INTEGER)
			-- Send a string 's' to the server and result the code response.
		require
			s_not_void: s /= Void
			socket_not_void: socket /= Void
		local
			l_smtp_reply: like smtp_reply
			l_socket: like socket
		do
			l_socket := socket
			check l_socket_attached: l_socket /= Void end
			l_socket.put_string (s + "%R%N")
			decode (l_socket)
			if (smtp_code_number /= expected_code) then
				enable_transfer_error
				l_smtp_reply := smtp_reply
					-- Per postcondition of `decode'.
				check l_smtp_reply_attached: l_smtp_reply /= Void end
				set_transfer_error_message (l_smtp_reply)
			end
		end

feature {NONE} -- Basic operations

	send_mail
			-- Send mail using smtp protocol.
		do
			send_mails
			if memory_resource.headers.has (H_bcc) then
				enable_bcc_mode
				send_mails
				disable_bcc_mode
			end
		end

	send_mails
		local
			l_header: detachable HEADER
			l_header_from: STRING
		do
			l_header := memory_resource.header (H_from)
			check l_header_attached: l_header /= Void end
			l_header_from:= extracted_email (l_header.unique_entry)
			sub_header.wipe_out
			set_recipients
			build_sub_header
			send_all (l_header_from)
		end

	set_recipients
			-- Fill 'recipients' to know who will receive the resource,
			-- and fill 'header_from'
		require
			header_to_exists: memory_resource.headers.has (H_to)
		local
			a_header: detachable HEADER
			l_recipients: like recipients
		do
			if not bcc_mode then
				a_header:= memory_resource.header (H_to)
					-- Per precondition of `set_recipients'
				check a_header_attached: a_header /= Void  end
				create l_recipients.make (a_header.entries.count)
				from
					a_header.entries.start
				until
					a_header.entries.after
				loop
					l_recipients.extend (extracted_email (a_header.entries.item))
					a_header.entries.forth
				end
				a_header:= memory_resource.header (H_cc)
			else
				a_header := memory_resource.header (H_bcc)
					-- Per flow `bcc_mode' is True iff we have a bcc header.
				check a_header_attached: a_header /= Void  end
				create l_recipients.make (a_header.entries.count)
			end
			if a_header /= Void then
				from
					a_header.entries.start
				until
					a_header.entries.after
				loop
					l_recipients.extend (extracted_email (a_header.entries.item))
					a_header.entries.forth
				end
			end
			recipients := l_recipients
		end

	build_sub_header
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

	add_sub_header (sub_header_key: STRING)
			-- Add new header line 'sub_header_key',
			-- A distinction is done in case the mail is bcc or not.
		require
			sub_header_exists: sub_header /= Void
			sub_header_key_not_void: sub_header_key /= Void
			key_exists: memory_resource.headers.has (sub_header_key)
		local
			a_header: detachable HEADER
		do
			a_header:= memory_resource.header (sub_header_key)
			check a_header_attached: a_header /= Void end
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

	send_all (a_header_from: STRING)
			-- Send the mail considering the correct information to `a_header_from'
		require
			a_header_from_attached: a_header_from /= Void
			a_header_from_not_empty: not a_header_from.is_empty
			recipients_attached: recipients /= Void
		local
			l_recipients: like recipients
			l_mail_message: STRING
			l_mail_signature: STRING
		do
			l_mail_message := memory_resource.mail_message.twin
			l_mail_signature := memory_resource.mail_signature

			send_command (Mail_from + "<" + a_header_from + ">", Ok)
			if not error then
				l_recipients := recipients
				check l_recipients_attached: l_recipients /= Void end
				from
					l_recipients.start
				until
					l_recipients.after
				loop
					if not error then
						send_command (Mail_to + "<" + l_recipients.item + ">", Ok)
					end
					l_recipients.forth
				end

				if not error then
					send_command (Data, Data_code)
					l_mail_message.prepend (sub_header)
					if l_mail_signature /= Void then
						l_mail_message.append ("%R%N" + l_mail_signature)
					end
					l_mail_message.replace_substring_all ("%N.", "%N..")
					l_mail_message.append ("%R%N.")
					if not error then
						send_command (l_mail_message, Ok)
					end
				end
			end
		end


feature {NONE} -- Access

	recipients: detachable ARRAYED_LIST [STRING]
		-- Header to use with the command 'Mail_to'

	sub_header: STRING
		-- Sub_header: data before the message.

	bcc_mode: BOOLEAN
		-- Is bcc mode activated?

feature {NONE} -- Implementation

	enable_bcc_mode
		do
			bcc_mode:= True
		end

	disable_bcc_mode
		do
			bcc_mode:= False
		end

	extracted_email (a_text: STRING): STRING
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

note
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

