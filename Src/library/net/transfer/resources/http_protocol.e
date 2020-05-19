note
	description:
		"Files accessed via HTTP"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class HTTP_PROTOCOL

inherit
	NETWORK_RESOURCE
		redefine
			is_writable, location
		end

create

	make

feature {NONE} -- Initialization

	initialize
			-- Initialize protocol.
		do
			set_read_buffer_size (Default_buffer_size)
			create headers.make
		end

feature {NONE} -- Constants

	Read_mode_id: INTEGER = unique

feature -- Access

	location: STRING_8
			-- Resource location
		do
			Result := address.location
		end

feature -- Measurement

	count: INTEGER
			-- Size of data resource
		do
			if is_count_valid then Result := content_length end
		end

	Default_buffer_size: INTEGER = 16384
			-- Default size of read buffer.

feature -- Status report

	read_mode: BOOLEAN
			-- Is read mode set?
		do
			Result := (mode = Read_mode_id)
		end

	Write_mode: BOOLEAN = False
			-- Is write mode set? (Answer: no)

	Is_writable: BOOLEAN = False
			-- Is it possible to open in write mode currently? (Answer: no)
			-- (HTTP resources are read-only.)

	valid_mode (n: INTEGER): BOOLEAN
			-- Is mode `n' valid?
		do
			Result := n = Read_mode_id
		end

	Supports_multiple_transactions: BOOLEAN = False
			-- Does resource support multiple tranactions per connection?
			-- (Answer: no)

feature -- Status setting

	open
			-- Open resource.
		local
			l_main_socket: like main_socket
		do
			if not is_open then
				if address.is_proxy_used then
					create l_main_socket.make_client_by_port
						(address.proxy_port, address.proxy_host)
				else
					create l_main_socket.make_client_by_port
							(address.port, address.host)
				end
				main_socket := l_main_socket
				l_main_socket.set_timeout_ns (timeout_ns)
				l_main_socket.set_connect_timeout (connect_timeout)
				l_main_socket.connect
			end
			if not is_open then
				error_code := Connection_refused
			else
				bytes_transferred := 0
				transfer_initiated := False
				is_packet_pending := False
				content_length := 0
			end
		rescue
			error_code := Connection_refused
		end

	close
			-- Close.
		do
			if attached main_socket as l_socket then
				l_socket.close
				main_socket := Void
			end
			if is_packet_pending then is_count_valid := False end
			last_packet := Void
			is_packet_pending := False
		rescue
			error_code := Transmission_error
		end

	initiate_transfer
			-- Initiate transfer.
		local
			str: STRING_8
		do
			str := Http_get_command.twin
			str.extend (' ')
			if address.is_proxy_used then
				str.append (location)
			else
				str.extend ('/')
				str.append (address.path)
			end
			str.extend (' ')
			str.append (Http_version)
			str.append (Http_end_of_header_line)

			str.append (Http_host_header + ": " + address.host)
			if address.port /= address.default_port then
				str.append (":")
				str.append_integer (address.port)
			end
			if not address.username.is_empty then
				str.append (Http_end_of_header_line)
				str.append (Http_authorization_header + ": Basic "
						+ base64_encoded (address.username + ":" + address.password))
			end
			str.append (Http_end_of_command)
			if not error then
				check main_socket_attached: attached main_socket as l_socket then
					l_socket.put_string (str)
					debug ("eiffelnet")
						Io.error.put_string (str)
					end
					get_headers
					transfer_initiated := True
					is_packet_pending := True
				end
			end
		rescue
			error_code := Transfer_failed
		end

	set_read_mode
			-- Set read mode.
		do
			mode := Read_mode_id
		end

	 set_write_mode
	 		-- Set write mode.
		do
		end

feature {NONE} -- Status setting

	open_connection
			-- Open the connection.
		do
			open
		end

feature {NONE} -- Implementation

	headers: LINKED_LIST[STRING]
			-- HTTP headers

	content_length: INTEGER
			-- Cached value of 'Content-Length:'

	get_headers
			-- Get HTTP headers
		require
			open: is_open
		local
			str: detachable STRING
		do
			headers.wipe_out
			check attached main_socket as l_socket then
				from
				until
					error or else (str /= Void and then str.is_equal ("%R"))
				loop
					check_socket (l_socket, Read_only)
					if not error then
						l_socket.read_line
						str := l_socket.last_string
						if not str.is_empty then
							headers.extend (str.twin)
						end
					end
				end
				check_error
				if not error then get_content_length end
			end
		end

	get_content_length
			-- Get content length from HTTP headers
		require
			non_empty_headers: not headers.is_empty
			no_error: not error
		local
			str: STRING
			pos: INTEGER
		do
			from
				headers.start
			until
				headers.after or else
					headers.item.substring_index ("Content-Length:", 1) > 0
			loop
				headers.forth
			end
			if not headers.after then
				str := headers.item.twin
				pos := str.index_of (' ', 1)
				str.remove_head (pos)
					-- Remove trailing and heading white spaces.
				str.right_adjust
				str.left_adjust
				content_length := str.to_integer
				is_count_valid := True
			else
				content_length := 0
				is_count_valid := False
			end
		end

	check_error
			-- Check for error.
		do
			if is_open and headers.count > 0 then
				from
					headers.start
				until
					(error_code /= 0) or headers.after
				loop
					if headers.item.count >= 5 and then
						equal (headers.item.substring (1, 5), "HTTP/") and then
						headers.item.substring_index ("OK", 6) = 0 then
						error_code := File_not_found
					end
					headers.forth
				end
			end
		end

feature {NONE} -- Encoder Implementation

	base64_encoded (s: STRING): STRING_8
			-- base64 encoded value of `s'.
		require
			s_not_void: s /= Void
		local
			i,n: INTEGER
			c: INTEGER
			f: SPECIAL [BOOLEAN]
			base64chars: STRING_8
		do
			base64chars := once "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
			from
				n := s.count
				i := (8 * n) \\ 6
				if i > 0 then
					create f.make_filled (False, 8 * n + (6 - i))
				else
					create f.make_filled (False, 8 * n)
				end
				i := 0
			until
				i > n - 1
			loop
				c := s.item (i + 1).code
				f[8 * i + 0] := c.bit_test(7)
				f[8 * i + 1] := c.bit_test(6)
				f[8 * i + 2] := c.bit_test(5)
				f[8 * i + 3] := c.bit_test(4)
				f[8 * i + 4] := c.bit_test(3)
				f[8 * i + 5] := c.bit_test(2)
				f[8 * i + 6] := c.bit_test(1)
				f[8 * i + 7] := c.bit_test(0)
				i := i + 1
			end
			from
				i := 0
				n := f.count
				create Result.make (n // 6)
			until
				i > n - 1
			loop
				c := 0
				if f[i + 0] then c := c + 0x20 end
				if f[i + 1] then c := c + 0x10 end
				if f[i + 2] then c := c + 0x8 end
				if f[i + 3] then c := c + 0x4 end
				if f[i + 4] then c := c + 0x2 end
				if f[i + 5] then c := c + 0x1 end
				Result.extend (base64chars.item (c + 1))
				i := i + 6
			end

			i := s.count \\ 3
			if i > 0 then
				from until i > 2 loop
					Result.extend ('=')
					i := i + 1
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

invariant

	headers_list_exists: headers /= Void
	count_constraint: (is_count_valid and count > 0) implies
				(is_packet_pending = (bytes_transferred < count))

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class HTTP_PROTOCOL

