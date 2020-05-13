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

feature {NONE} -- Initialization

	make (host: READABLE_STRING_8; user: READABLE_STRING_8)
			-- Create an smtp protocol with 'host, 'user' and default port.
		require
			host_not_void: host /= Void
			host_not_empty: not host.is_empty
			user_not_void: user /= Void
			user_not_empty: not user.is_empty
		do
			hostname := host
			username := user
			port := default_port
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
		do
			if attached socket as l_socket then
				send_command (Quit, Ack_end_connection)
				l_socket.cleanup
				disable_initiated
				disable_connected
				disable_transfer_error
				set_transfer_error_message ("")
			end
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_receive: BOOLEAN = False
		-- Can the Smtp protocolreceive?

	initialize
			-- Initialize the protocol to send a new email.
		do
		end

feature {NONE} -- Connection

	username: READABLE_STRING_8
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
		do
			if attached socket as l_socket then
				l_socket.put_string (s + "%R%N")
				decode (l_socket)
				if smtp_code_number /= expected_code then
					enable_transfer_error
					if attached smtp_reply as l_smtp_reply then
						set_transfer_error_message (l_smtp_reply)
					else
							-- Per postcondition of `decode'.
						check has_reply: False end
					end
				end
			end
		end

	send_mail
			-- Send mail using smtp protocol.
		do
			send_mails
		end

	send_mails
		require
			can_be_sent: memory_resource.can_be_sent
		local
			l_header_from: READABLE_STRING_8
		do
			if attached memory_resource.header (H_from) as l_header then
				l_header_from := extracted_email (l_header.unique_entry)
				sub_header.wipe_out
				set_recipients
				build_sub_header
				send_all (l_header_from)
			else
				-- Implied by precondition.
				check has_from_header: False end
			end
		end

	set_recipients
			-- Fill 'recipients' to know who will receive the resource,
			-- and fill 'header_from'
		require
			has_header_to: memory_resource.headers.has (H_to)
		local
			l_recipients: like recipients
		do
			create l_recipients.make (5)
			recipients := l_recipients
			if attached memory_resource.header (H_to) as l_header then
				across l_header.entries as ic loop
					l_recipients.extend (extracted_email (ic.item))
				end
			else
				-- Per precondition of `set_recipients'
				check has_recipients: False end
			end
				-- CC
			if attached memory_resource.header (H_cc) as l_header then
				across l_header.entries as ic loop
					l_recipients.extend (extracted_email (ic.item))
				end
			end
				-- BCC
			if attached memory_resource.header (H_bcc) as l_header then
				across l_header.entries as ic loop
					l_recipients.extend (extracted_email (ic.item))
				end
			end
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

	add_sub_header (sub_header_key: READABLE_STRING_8)
			-- Add new header line 'sub_header_key',
		note
			EIS: "SMTP RFC5321", "src=https://tools.ietf.org/html/rfc5321#appendix-B", "protocol=uri"
		require
			sub_header_exists: sub_header /= Void
			sub_header_key_not_void: sub_header_key /= Void
			key_exists: memory_resource.headers.has (sub_header_key)
		local
			l_entries: like {HEADER}.entries
			l_entry: STRING
		do
				-- BCC email addresses must be listed in the RCPT TO command list,
				-- but the BCC header should not be printed under the DATA command.
				-- So we not append them into the sub_header string which will be
				-- used under the DATA command.
			if
				not sub_header_key.is_case_insensitive_equal_general (h_bcc) and then
				attached memory_resource.header (sub_header_key) as l_header
			then
				from
					l_entries := l_header.entries
					l_entries.start
					create l_entry.make_empty
				until
					l_entries.after
				loop
					l_entry.append (l_entries.item)
					l_entries.forth
					if not l_entries.after then
						l_entry.append_character (',')
					end
				end
				sub_header.append (sub_header_key + ": " + l_entry + "%R%N")
			end
		end

	send_all (a_header_from: READABLE_STRING_8)
			-- Send the mail considering the correct information to `a_header_from'
		require
			a_header_from_attached: a_header_from /= Void
			a_header_from_not_empty: not a_header_from.is_empty
			recipients_attached: recipients /= Void
		local
			l_mail_message: STRING_8
			l_mail_signature: READABLE_STRING_8
		do
			create l_mail_message.make_from_string (memory_resource.mail_message)
			l_mail_signature := memory_resource.mail_signature

			send_command (Mail_from + "<" + a_header_from + ">", Ok)
			if not error then
					-- TO
				if attached recipients as l_recipients then
					across l_recipients as ic loop
						if not error then
							send_command (Mail_to + "<" + ic.item + ">", Ok)
						end
					end
				else
					-- Per precondition `recipients_attached`
					check has_recipients: False end
				end

				if not error then
					send_command (Data, Data_code)
					l_mail_message.prepend (sub_header)
					if l_mail_signature /= Void then
						l_mail_message.append ("%R%N")
						l_mail_message.append (l_mail_signature)
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

	recipients: detachable ARRAYED_LIST [READABLE_STRING_8]
		-- Header to use with the command 'Mail_to', it contains the "TO", "CC" and "BCC" fields.

	sub_header: STRING
		-- Sub_header: data before the message.

feature {NONE} -- Implementation

	extracted_email (a_text: READABLE_STRING_8): READABLE_STRING_8
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
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
