note
	description: "FTP protocol"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FTP_PROTOCOL inherit

	NETWORK_RESOURCE
		redefine
			address, is_open, put, read, reuse_connection, make
		end

create
	make

feature {NONE} -- Initialization

	make (addr: like address)
		do
			Precursor {NETWORK_RESOURCE} (addr)
			create last_reply.make_empty
		end

	initialize
			-- Initialize protocol.
		do
			set_read_buffer_size (Default_buffer_size)
		end

feature {NONE} -- Constants

	Read_mode_id, Write_mode_id: INTEGER = unique

feature -- Access

	address: FTP_URL
			-- Associated address

feature -- Measurement

	count: INTEGER
			-- Size of data resource
		do
			if is_count_valid then Result := resource_size end
		end

	Default_buffer_size: INTEGER = 16384
			-- Default size of read buffer

feature -- Status report

	is_open: BOOLEAN
			-- Is resource open?
		local
			l_socket: like main_socket
		do
			if is_proxy_used then
				check attached proxy_connection as l_proxy then
					Result := l_proxy.is_open
				end
			else
				l_socket := main_socket
				Result := (l_socket /= Void) and then not l_socket.is_closed
			end
		end

	is_logged_in: BOOLEAN
			-- Logged in to a server?

	read_mode: BOOLEAN
			-- Is read mode set?
		do
			Result := mode = Read_mode_id
		end

	write_mode: BOOLEAN
			-- Is write mode set?
		do
			Result := mode = Write_mode_id
		end

	valid_mode (n: INTEGER): BOOLEAN
			-- Is mode `n' valid?
		do
			Result := (Read_mode_id <= n) and (n <= Write_mode_id)
		end

	is_binary_mode: BOOLEAN
			-- Is binary transfer mode selected?

	passive_mode: BOOLEAN
			-- Is passive mode used?

	Supports_multiple_transactions: BOOLEAN = True
			-- Does resource support multiple transactions per connection?
			-- (Answer: yes)

feature -- Status setting

	open
			-- Open resource.
		do
			if not is_open then
				open_connection
				if not is_open then
					error_code := Connection_refused
				elseif attached main_socket as l_socket then
					receive (l_socket)
					if not error then login end
				else
					error_code := no_socket_to_connect
				end
			end
		rescue
			error_code := Connection_refused
		end

	close
			-- Close.
		do
			if is_proxy_used then
				check attached proxy_connection as l_proxy then
					l_proxy.close
				end
			elseif attached main_socket as l_socket then
				l_socket.close
				main_socket := Void
				if
					attached accepted_socket as l_accepted_socket and then
					(l_accepted_socket.is_open_read or l_accepted_socket.is_open_write)
				then
					l_accepted_socket.close
					accepted_socket := Void
					data_socket := Void
				end
			end
			last_packet := Void
			is_packet_pending := False
			readable_cached := False
			writable_cached := False
			is_logged_in := False
		ensure then
			not_logged_in: not is_logged_in
		rescue
			error_code := Transmission_error
		end

	initiate_transfer
			-- Initiate transfer.
		local
			l_socket: like accepted_socket
		do
			if is_proxy_used then
				check attached proxy_connection as l_proxy then
					l_proxy.initiate_transfer
				end
			else
				if not passive_mode then
					create l_socket.make_server_by_port (0)
					data_socket := l_socket
					l_socket.set_timeout_ns (timeout_ns)
					l_socket.listen (1)
				end
				if send_transfer_command then
					debug Io.error.put_string ("Accepting socket...%N") end
					if passive_mode then
						accepted_socket := data_socket
					elseif l_socket /= Void then
						l_socket.accept
						l_socket := l_socket.accepted
						check l_socket_attached: l_socket /= Void end
						accepted_socket := l_socket
					end
					if accepted_socket /= Void then
						debug Io.error.put_string ("Socket accepted%N") end
						transfer_initiated := True
						is_packet_pending := True
					else
						error_code := Connection_refused
					end
				end
			end
		ensure then
			connection_established: attached data_socket as l_data_socket and then
				(l_data_socket.is_open_read or l_data_socket.is_open_write)
		rescue
			error_code := Connection_refused
		end

	set_read_mode
			-- Set read mode.
		do
			mode := Read_mode_id
		end

	set_write_mode
	 		-- Set write mode.
		do
			mode := Write_mode_id
		end

	set_text_mode
			-- Set ASCII text transfer mode.
		do
			is_binary_mode := False
		ensure
			text_mode_set: not is_binary_mode
		end

	set_binary_mode
			-- Set binary transfer mode.
		do
			is_binary_mode := True
		ensure
			binary_mode_set: is_binary_mode
		end

	set_active_mode
			-- Switch FTP client to active mode.
		do
			passive_mode := False
		ensure
			active_mode_set: not passive_mode
		end

	set_passive_mode
			-- Switch FTP client to passive mode.
		do
			passive_mode := True
		ensure
			passive_mode_set: passive_mode
		end

	reuse_connection (other: FTP_PROTOCOL)
			-- Reuse connection of `other'.
		do
			main_socket := other.main_socket
			data_socket := other.data_socket
			accepted_socket := other.accepted_socket
			proxy_connection := other.proxy_connection
		end

feature {NONE} -- Status setting

	open_connection
			-- Open the connection.
		local
			l_socket: like main_socket
			l_proxy: like proxy_connection
		do
			if is_proxy_used then
				create l_proxy.make (address)
				proxy_connection := l_proxy
				l_proxy.set_timeout_ns (timeout_ns)
			else
				create l_socket.make_client_by_port (address.port, address.host)
				main_socket := l_socket
				l_socket.set_timeout_ns (timeout_ns)
				l_socket.connect
			end
		rescue
			error_code := Connection_refused
		end

feature -- Output

	put (other: DATA_RESOURCE)
			-- Write out resource `other'.
		do
			if is_proxy_used then
				check attached proxy_connection as l_proxy then
					l_proxy.put (other)
				end
			else
				from
				until
					error or else not other.is_packet_pending
				loop
					if attached accepted_socket as l_socket then
						check_socket (l_socket, Write_only)
						if not error then
							other.read
							if attached other.last_packet as l_packet then
								l_socket.put_string (l_packet)
								last_packet_size := l_packet.count
								bytes_transferred := bytes_transferred + last_packet_size
								if last_packet_size /= other.last_packet_size then
									error_code := Write_error
								end
							else
								error_code := read_error
							end
						end
					else
						error_code := no_socket_to_connect
					end
				end
			end
		rescue
			error_code := Write_error
		end

feature -- Input

	read
			-- Read packet.
		local
			l_packet: like last_packet
		do
			if is_proxy_used then
				check attached proxy_connection as l_proxy then
					l_proxy.read
				end
			elseif attached accepted_socket as l_socket then
				check_socket (l_socket, Read_only)
				if not error then
					l_socket.read_stream (read_buffer_size)
					l_packet := l_socket.last_string
					last_packet := l_packet
					last_packet_size := l_packet.count
					bytes_transferred := bytes_transferred + last_packet_size
					if last_packet_size = 0 then
						is_packet_pending := False
						if attached main_socket as l_main_socket then
							receive (l_socket)
							if not reply_code_ok (last_reply, <<226>>) then
								error_code := Transfer_failed
							end
						else
							error_code := no_socket_to_connect
						end
					end
				end
			else
				error_code := no_socket_to_connect
			end
		rescue
			error_code := Transfer_failed
			last_packet := Void
			last_packet_size := 0
		end

feature {DATA_RESOURCE} -- Implementation

	data_socket: detachable NETWORK_STREAM_SOCKET
			-- Socket for data connection

	accepted_socket: detachable NETWORK_STREAM_SOCKET
			-- Handle to socket of incoming connection

	proxy_connection: detachable HTTP_PROTOCOL
			-- Connection to http proxy

feature {NONE} -- Implementation

	resource_size: INTEGER
			-- Cached size of transferred file

	last_reply: STRING_8
			-- Last received server reply

	send (s: NETWORK_SOCKET; str: STRING_8)
			-- Send string `str' to socket `s'.
		require
			socket_exists: s /= Void
			socket_writable: s.is_open_write
			non_empty_string: str /= Void and then not str.is_empty
		local
			packet: STRING_8
		do
			packet := str.twin
			packet.append ("%N")
			debug Io.error.put_string (packet) end
			s.put_string (packet)
			receive (s)
		end

	receive (s: NETWORK_SOCKET)
			-- Receive line.
		require
			socket_exists: s /= Void
			socket_readable: s.is_open_read
		local
			l_reply: detachable STRING_8
			go_on: BOOLEAN
		do
			from
				l_reply := Void
			until
				error or else (l_reply /= Void and not go_on)
			loop
				check_socket (s, Read_only)
				if not error then
					s.read_line
					l_reply := s.last_string.twin
					l_reply.append ("%N")
					debug
						if not l_reply.is_empty then
							io.put_string (l_reply)
						end
					end
					if has_num (l_reply) then
						if dash_check (l_reply) then
							go_on := True
						else
							go_on := False
						end
					end
				end
			end
			if l_reply /= Void then
				last_reply := l_reply
			end
		end

	port_command (p: INTEGER): STRING_8
			-- PORT command
		require
			port_positive: p > 0
		local
			af: INET_ADDRESS_FACTORY
		do
			create af
			Result := Ftp_port_command.twin
			Result.extend (' ')
			Result.append (af.create_localhost.host_address)
			Result.append (",")
			Result.append (byte_list (p, 2, False))
		end

	byte_list (n, num: INTEGER; low_first: BOOLEAN): STRING_8
			-- A comma-separated representation of the `num' lowest bytes of
			-- `n'
		require
			positive_number_of_bytes: num > 0
		local
			divisor: INTEGER
			i: INTEGER
			number: INTEGER
		do
			from
				divisor := (256 ^ (num - 1)).rounded
				create Result.make (20)
				number := n
			until
				divisor = 0
			loop
				i := number // divisor
				number := number - i * divisor
				if low_first then
					Result.prepend_integer (i)
				else
					Result.append_integer (i)
				end
				if divisor > 1 then
					if low_first then
						Result.prepend (",")
					else
						Result.append (",")
					end
				end
				divisor := divisor // 256
			variant
				divisor
			end
		end

	has_num (str: STRING): BOOLEAN
			-- Check for response code.
		require
			string_exists: str /= Void
		local
			s: STRING
			i: INTEGER
		do
			if str.count >= 3 then
				s := str.twin
				s.left_adjust
				if s.count >=3 then
					Result := True
					from i := 1 until i = 4 or not Result loop
						if i <= s.count and then not s.item (i).is_digit then
							Result := False
						end
						i := i + 1
					end
				end
			end
		end

	dash_check (str: STRING): BOOLEAN
			-- Check for dash
		require
			string_exists: str /= Void
		local
			s: STRING
		do
			if str.count >= 4 then
				s := str.twin
				s.left_adjust
				if s.count >= 4 then Result := s [4] = '-' end
			end
		end

	reply_code_ok (a_reply: STRING; codes: ARRAY[INTEGER]): BOOLEAN
			-- Is reply code in `codes`?
		require
			non_empty_reply: a_reply /= Void and then not a_reply.is_empty
			non_empty_array: codes /= Void and then not codes.is_empty
		local
			i: INTEGER
			code: INTEGER
			str: STRING
		do
			str := a_reply.twin
			str.left_adjust
			str.keep_head (str.index_of (' ', 1) - 1)
			code := str.to_integer
			from
				i := 1
			until
				Result or i = codes.count + 1
			loop
				Result := codes [i] = code
				i := i + 1
			end
		end

	get_size (s: STRING)
			-- Extract file size from `s'.
		require
			no_error_occurred: not error
			s_attached: s /= Void
			one_parenthesis_pair: (s.occurrences ('(') = 1) and
				(s.occurrences (')') = 1)
			parenthesis_match: s.index_of ('(', 1) < s.index_of (')', 1)
		local
			pos: INTEGER
			tail: STRING
		do
			pos := s.index_of ('(', 1)
			tail := s.twin
			tail.remove_head (pos)
			pos := tail.index_of (' ', 1)
			tail.keep_head (pos - 1)
			resource_size := tail.to_integer
			if resource_size > 0 then is_count_valid := True end
		end

	setup_passive_mode_socket (a_reply: STRING_8): NETWORK_STREAM_SOCKET
			-- Create a data socket specified by `a_reply' for the use with
			-- passive mode.
		require
			passive_mode: passive_mode
			non_empty_data: a_reply /= Void and then not a_reply.is_empty
		local
			ip_address: STRING_8
			l_paren, r_paren: INTEGER
			comma: INTEGER
			port_str: STRING_8
			port_number: INTEGER
		do
			l_paren := a_reply.index_of ('(', 1)
			r_paren := a_reply.index_of (')', l_paren)
			ip_address := a_reply.substring (l_paren + 1, r_paren - 1)
			ip_address.replace_substring_all (",", ".")
			-- First occurrence
			comma := ip_address.index_of ('.', 1)
			-- Second occurrence
			comma := ip_address.index_of ('.', comma + 1)
			-- Third occurrence
			comma := ip_address.index_of ('.', comma + 1)
			-- Fourth occurrence
			comma := ip_address.index_of ('.', comma + 1)
			port_str := ip_address.substring (comma + 1, ip_address.count)
			ip_address := ip_address.substring (1, comma - 1)
			comma := port_str.index_of ('.', 1)
			port_number := 256 *
				port_str.substring (1, comma - 1).to_integer +
				port_str.substring (comma + 1, port_str.count).to_integer

			create Result.make_client_by_port (port_number, ip_address)
		ensure
			socket_created_if_no_error: not error implies Result /= Void
		rescue
			error_code := Connection_refused
		end

	login
			-- Log in to server.
		require
			opened: is_open
		do
			if send_username and then send_password and then
				send_transfer_mode_command then
				bytes_transferred := 0
				transfer_initiated := False
				is_count_valid := False
				is_logged_in := True
			else
				close
			end
		end

	send_username: BOOLEAN
			-- Send username. Did it work?
		local
			cmd: STRING_8
		do
			if attached main_socket as l_socket then
				cmd := Ftp_user_command.twin
				cmd.extend (' ')
				cmd.append (address.username)
				send (l_socket, cmd)
				Result := reply_code_ok (last_reply, <<230, 331>>)
				if not Result then
					error_code := No_such_user
				end
			else
				error_code := no_socket_to_connect
			end
		end

	send_password: BOOLEAN
			-- Send password. Did it work?
		local
			cmd: STRING_8
		do
			if attached main_socket as l_socket then
				cmd := Ftp_password_command.twin
				cmd.extend (' ')
				cmd.append (address.password)
				send (l_socket, cmd)
				Result := reply_code_ok (last_reply, <<202, 230>>)
				if not Result then
					error_code := Access_denied
				end
			else
				error_code := no_socket_to_connect
			end
		end

	send_passive_mode_command: BOOLEAN
			-- Send passive mode command. Did it work?
		local
			l_data_socket: like data_socket
		do
			if attached main_socket as l_socket then
				send (l_socket, Ftp_passive_mode_command)
				Result := reply_code_ok (last_reply, <<227>>)
				if Result then
					l_data_socket := setup_passive_mode_socket (last_reply)
					l_data_socket.connect
					data_socket := l_data_socket
				else
					error_code := Wrong_command
				end
			else
				error_code := no_socket_to_connect
			end
		end

	send_text_mode_command: BOOLEAN
			-- Send ASCII text transfer mode command. Did it work?
		do
			if attached main_socket as l_socket then
				send (l_socket, Ftp_text_mode_command)
				Result := reply_code_ok (last_reply, <<200>>)
				if not Result then
					error_code := Wrong_command
				end
			else
				error_code := no_socket_to_connect
			end
		end

	send_binary_mode_command: BOOLEAN
			-- Send binary transfer mode command. Did it work?
		do
			if attached main_socket as l_socket then
				send (l_socket, Ftp_binary_mode_command)
				Result := reply_code_ok (last_reply, <<200>>)
				if not Result then
					error_code := Wrong_command
				end
			else
				error_code := no_socket_to_connect
			end
		end

	send_transfer_mode_command: BOOLEAN
			-- Send transfer mode command. Did it work?
		do
			if is_binary_mode then
				Result := send_binary_mode_command
			else
				Result := send_text_mode_command
			end
		end

	send_port_command: BOOLEAN
			-- Send PORT command. Did it work?
		require
			data_socket_exists: data_socket /= Void
		local
			port_str: STRING_8
			l_data_socket: like data_socket
		do
			l_data_socket := data_socket
			check l_socket_attached: l_data_socket /= Void then
				port_str := port_command (l_data_socket.port)

				if attached main_socket as l_socket then
					send (l_socket, port_str)

					Result := reply_code_ok (last_reply, <<200>>)
					if not Result then
						error_code := Wrong_command
					end
				else
					error_code := no_socket_to_connect
				end
			end
		end

	send_transfer_command: BOOLEAN
			-- Send transfer command. Did it work?
		local
			cmd: STRING_8
		do
			if attached main_socket as l_socket then
				if passive_mode then
					Result := send_passive_mode_command
				else
					Result := send_port_command
				end

				if Result then
					if Read_mode then
						cmd := Ftp_retrieve_command.twin
					else
						check write_mode: write_mode end
						cmd := Ftp_store_command.twin
					end
					cmd.extend (' ')
					cmd.append (address.path)
					send (l_socket, cmd)
					Result := reply_code_ok (last_reply, <<150>>)
					if not Result then
						error_code := Permission_denied
					elseif Read_mode then
						get_size (last_reply)
					end
				end
			else
				error_code := no_socket_to_connect
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
