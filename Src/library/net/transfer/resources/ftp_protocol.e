indexing
	description:
		"FTP protocol"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class FTP_PROTOCOL inherit

	NETWORK_RESOURCE
		redefine
			address, is_open, put, read, reuse_connection
		end

create

	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize protocol.
		do
			set_read_buffer_size (Default_buffer_size)
		end

feature {NONE} -- Constants

	Read_mode_id, Write_mode_id: INTEGER is unique
	
feature -- Access

	address: FTP_URL
			-- Associated address
			
feature -- Measurement

	count: INTEGER is
			-- Size of data resource
		do
			if is_count_valid then Result := resource_size end
		end
				
	Default_buffer_size: INTEGER is 16384
			-- Default size of read buffer

feature -- Status report

	is_open: BOOLEAN is
			-- Is resource open?
		do
			if is_proxy_used then
				Result := proxy_connection.is_open
			else
				Result := (main_socket /= Void) and then not 
					main_socket.is_closed
			end
		end
	 
	is_logged_in: BOOLEAN
			-- Logged in to a server?
			
	read_mode: BOOLEAN is
			-- Is read mode set?
		do
			Result := (mode = Read_mode_id)
		end

	write_mode: BOOLEAN is
			-- Is write mode set?
		do
			Result := (mode = Write_mode_id)
		end

	valid_mode (n: INTEGER): BOOLEAN is
			-- Is mode `n' valid?
		do
			Result := (Read_mode_id <= n) and (n <= Write_mode_id)
		end
	 
	is_binary_mode: BOOLEAN
			-- Is binary transfer mode selected?
			
	passive_mode: BOOLEAN
			-- Is passive mode used?
			
	Supports_multiple_transactions: BOOLEAN is True
			-- Does resource support multiple transactions per connection?
			-- (Answer: yes)

feature -- Status setting

	open is
			-- Open resource.
		do
			if not is_open then
				open_connection
				if not is_open then
					error_code := Connection_refused
				else
					receive (main_socket)
					login
				end
			end
		end

	close is
			-- Close.
		do
			if is_proxy_used then
				proxy_connection.close
			else
				main_socket.close
				main_socket := Void
				if accepted_socket /= Void and then 
					(accepted_socket.is_open_read or 
					accepted_socket.is_open_write) then
					accepted_socket.close
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
	
	initiate_transfer is
			-- Initiate transfer.
		do
			if is_proxy_used then
				proxy_connection.initiate_transfer
			else
				if not passive_mode then
					create data_socket.make_server_by_port (0)
					data_socket.listen (5)
				end
				if send_transfer_command then
					debug Io.error.put_string ("Accepting socket...%N") end
					if passive_mode then
						accepted_socket := data_socket
					else
						data_socket.accept
						accepted_socket ?= data_socket.accepted
					end
					debug Io.error.put_string ("Socket accepted%N") end
						check
							type_ok: accepted_socket /= Void
						end
					transfer_initiated := True
					is_packet_pending := True
				end
			end
		ensure then
			connection_established: data_socket.is_open_read or
				data_socket.is_open_write
		rescue
			error_code := Connection_refused
		end
	
	set_read_mode is
			-- Set read mode.
		do
			mode := Read_mode_id
		end
	 
	set_write_mode is
	 		-- Set write mode.
		do
			mode := Write_mode_id
		end
	
	set_text_mode is
			-- Set ASCII text transfer mode.
		do
			is_binary_mode := False
		ensure
			text_mode_set: not is_binary_mode
		end

	set_binary_mode is
			-- Set binary transfer mode.
		do
			is_binary_mode := True
		ensure
			binary_mode_set: is_binary_mode
		end
		
	set_active_mode is
			-- Switch FTP client to active mode.
		do
			passive_mode := False
		ensure
			active_mode_set: not passive_mode
		end

	set_passive_mode is
			-- Switch FTP client to passive mode.
		do
			passive_mode := True
		ensure
			passive_mode_set: passive_mode
		end

	reuse_connection (other: DATA_RESOURCE) is
			-- Reuse connection of `other'.
		local
			o: like Current
		do
			o ?= other
				check
					same_type: o /= Void
						-- Because of precondition
				end
			main_socket := o.main_socket
			data_socket := o.data_socket
			accepted_socket := o.accepted_socket
			proxy_connection := o.proxy_connection
		end

feature {NONE} -- Status setting

	open_connection is
			-- Open the connection.
		do
			if is_proxy_used then
				create proxy_connection.make (address)
			else
				create main_socket.make_client_by_port
					(address.port, address.host)
				main_socket.connect
			end
		rescue
			error_code := Connection_refused
		end

feature -- Output

	put (other: DATA_RESOURCE) is
			-- Write out resource `other'.
		do
			if is_proxy_used then
				proxy_connection.put (other)
			else
				from until not other.is_packet_pending loop
					other.read
					accepted_socket.put_string (other.last_packet)
					if accepted_socket.socket_ok then
						last_packet_size := other.last_packet.count
					else
						last_packet_size := 0
					end
					bytes_transferred := bytes_transferred + last_packet_size
					if last_packet_size /= other.last_packet_size then
						error_code := Write_error
					end
				end
			end
		rescue
			error_code := Write_error
		end

feature -- Input

	read is
			-- Read packet.
		do
			if is_proxy_used then
				proxy_connection.read
			else
				accepted_socket.read_stream (read_buffer_size)
				if accepted_socket.socket_ok then
					last_packet := accepted_socket.last_string
					last_packet_size := last_packet.count
				else
					error_code := Transfer_failed
					last_packet := Void
					last_packet_size := 0
				end
				bytes_transferred := bytes_transferred + last_packet_size
				if not error and last_packet_size = 0 then 
					is_packet_pending := False
					receive (main_socket)
					if not reply_code_ok (<<226>>) then
						error_code := Transfer_failed
					end
				end
			end
		rescue
			error_code := Transfer_failed
		end

feature {DATA_RESOURCE} -- Implementation

	data_socket: NETWORK_STREAM_SOCKET
			-- Socket for data connection

	accepted_socket: NETWORK_STREAM_SOCKET
			-- Handle to socket of incoming connection

	proxy_connection: HTTP_PROTOCOL
			-- Connection to http proxy

feature {NONE} -- Implementation

	resource_size: INTEGER
			-- Cached size of transferred file

	last_reply: STRING
			-- Last received server reply
			
	send (s: SOCKET; str: STRING) is
			-- Send string `str' to socket `s'.
		require
			socket_exists: s /= Void
			socket_writable: s.is_open_write
			non_empty_string: str /= Void and then not str.is_empty
		local
			packet: STRING
		do
			packet := clone (str)
			packet.append ("%N")
			debug Io.error.put_string (packet) end
			s.put_string (packet)
			receive (s)
		end

	receive (s: SOCKET) is
			-- Receive line.
		require
			socket_exists: s /= Void
			socket_readable: s.is_open_read
		local
			go_on: BOOLEAN
		do
			from 
				last_reply := Void
			until 
				last_reply /= Void and not go_on
			loop
				s.read_line
				last_reply := clone (s.last_string)
				last_reply.append ("%N")
				debug
					if not last_reply.is_empty then 
						Io.putstring (last_reply) 
					end
				end
				if has_num (last_reply) then
					if dash_check (last_reply) then
						go_on := True
					else
						go_on := False
					end
				end
			end
		end

	port_command (p: INTEGER): STRING is
			-- PORT command
		require
			port_positive: p > 0
		local
			str: STRING
			h_addr: HOST_ADDRESS
		do
			create h_addr.make
			h_addr.set_address_from_name (h_addr.local_host_name)
			Result := clone (Ftp_port_command)
			Result.extend (' ')
			str := byte_list (h_addr.host_number, 4, True)
			Result.append (str)
			Result.append (",")
			str := byte_list (p, 2, False)
			Result.append (str)
		end

	byte_list (n, num: INTEGER; low_first: BOOLEAN): STRING is
			-- A comma-separated representation of the `num' lowest bytes of
			-- `n'
		require
			positive_number_of_bytes: num > 0
		local
			divisor: INTEGER
			i: INTEGER
			number: INTEGER
			str: STRING
		do
			from
				divisor := (256 ^ (num - 1)).rounded
				create Result.make (20)
				number := n
			variant
				divisor
			until
				divisor = 0
			loop
				i := number // divisor
				number := number - i * divisor
				str := i.out
				if low_first then
					Result.prepend (str)
				else
					Result.append (str)
				end
				if divisor > 1 then 
					if low_first then 
						Result.prepend (",") 
					else
						Result.append (",") 
					end
				end
				divisor := divisor // 256
			end
		end
		
	has_num (str: STRING): BOOLEAN is
			-- Check for response code.
		require
			string_exists: str /= Void
		local
			s: STRING
			i: INTEGER
		do
			if str.count >= 3 then
				s := clone (str)
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

	dash_check (str: STRING): BOOLEAN is
			-- Check for dash
		require
			string_exists: str /= Void
		local
			s: STRING
		do
			if str.count >= 4 then
				s := clone (str)
				s.left_adjust
				if s.count >= 4 then Result := (s.item (4) = '-') end
			end
		end
	
	reply_code_ok (codes: ARRAY[INTEGER]): BOOLEAN is
			-- Is reply code in `codes`?
		require
			non_empty_reply: last_reply /= Void and then not last_reply.is_empty
			non_empty_array: codes /= Void and then not codes.is_empty
		local
			i: INTEGER
			code: INTEGER
			pos: INTEGER
			str: STRING
		do
			str := clone (last_reply)
			str.left_adjust
			pos := str.index_of (' ', 1)
			str.head (pos - 1)
			code := str.to_integer
			from 
				i := 1 
			until 
				Result or i = codes.count + 1 
			loop
				Result := (codes @ i = code)
				i := i + 1
			end
		end

	get_size (s: STRING) is
			-- Extract file size from `s'.
		require
			no_error_occurred: not error
			one_parenthesis_pair: (s.occurrences ('(') = 1) and
				(s.occurrences (')') = 1)
			parenthesis_match: s.index_of ('(', 1) < s.index_of (')', 1)
		local
			pos: INTEGER
			tail: STRING
		do
			pos := s.index_of ('(', 1)
			tail := clone (s)
			tail.tail (s.count - pos)
			pos := tail.index_of (' ', 1)
			tail.head (pos - 1)
			resource_size := tail.to_integer
			if resource_size > 0 then is_count_valid := True end
		end

	setup_passive_mode_socket (data: STRING): NETWORK_STREAM_SOCKET is
			-- Create a data socket specified by `data' for the use with
			-- passive mode.
		require
			passive_mode: passive_mode
			non_empty_data: data /= Void and then not data.is_empty
		local
			ip_address: STRING
			l_paren, r_paren: INTEGER
			comma: INTEGER
			port_str: STRING
			port_number: INTEGER
		do
			l_paren := last_reply.index_of ('(', 1)
			r_paren := last_reply.index_of (')', l_paren)
			ip_address := last_reply.substring (l_paren + 1, r_paren - 1)
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
			socket_created: Result /= Void
		end

	login is
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
		ensure
			logged_in: is_logged_in
		end
		
	send_username: BOOLEAN is
			-- Send username. Did it work?
		local
			cmd: STRING
		do
			cmd := clone (Ftp_user_command)
			cmd.extend (' ')
			cmd.append (address.username)
			send (main_socket, cmd)
			Result := reply_code_ok (<<230, 331>>)
			if not Result then
				error_code := No_such_user
			end
		end

	send_password: BOOLEAN is
			-- Send password. Did it work?
		local
			cmd: STRING
		do
			cmd := clone (Ftp_password_command)
			cmd.extend (' ')
			cmd.append (address.password)
			send (main_socket, cmd)
			Result := reply_code_ok (<<202, 230>>)
			if not Result then
				error_code := Access_denied
			end	
		end

	send_passive_mode_command: BOOLEAN is
			-- Send passive mode command. Did it work?
		do
			send (main_socket, Ftp_passive_mode_command)
			Result := reply_code_ok (<<227>>)
			if Result then
				data_socket := setup_passive_mode_socket (last_reply)
				data_socket.connect
			else
				error_code := Wrong_command
			end
		end

	send_text_mode_command: BOOLEAN is
			-- Send ASCII text transfer mode command. Did it work?
		do
			send (main_socket, Ftp_text_mode_command)
			Result := reply_code_ok (<<200>>)
			if not Result then
				error_code := Wrong_command
			end
		end

	send_binary_mode_command: BOOLEAN is
			-- Send binary transfer mode command. Did it work?
		do
			send (main_socket, Ftp_binary_mode_command)
			Result := reply_code_ok (<<200>>)
			if not Result then
				error_code := Wrong_command
			end
		end

	send_transfer_mode_command: BOOLEAN is
			-- Send transfer mode command. Did it work?
		do
			if is_binary_mode then
				Result := send_binary_mode_command
			else
				Result := send_text_mode_command
			end
		end
		
	send_port_command: BOOLEAN is
			-- Send PORT command. Did it work?
		require
			data_socket_exists: data_socket /= Void
		local
			port_str: STRING
		do
			port_str := port_command (data_socket.port)
			send (main_socket, port_str)
			Result := reply_code_ok (<<200>>)
			if not Result then
				error_code := Wrong_command
			end
		end

	send_transfer_command: BOOLEAN is
			-- Send transfer command. Did it work?
		local
			cmd: STRING
		do
			if passive_mode then
				Result := send_passive_mode_command
			else
				Result := send_port_command
			end

			if Result then
				if Read_mode then
					cmd := clone (Ftp_retrieve_command)
				elseif Write_mode then
					cmd := clone (Ftp_store_command)
				end
					check
						command_set: cmd /= Void
							-- Because there is only read and write mode
					end
				cmd.extend (' ')
				cmd.append (address.path)
				send (main_socket, cmd)
				Result := reply_code_ok (<<150>>)
				if not Result then
					error_code := Permission_denied
				elseif Read_mode then
					get_size (last_reply)
				end
			end
		end
		
invariant

	data_socket_ok: data_socket /= Void implies data_socket.socket_ok

end -- class FTP_PROTOCOL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


