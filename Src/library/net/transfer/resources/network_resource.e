note
	description:
		"Resources accessed over a network"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class NETWORK_RESOURCE inherit

	DATA_RESOURCE
		redefine
			address
		end

	TRANSFER_COMMAND_CONSTANTS
		undefine
			is_equal
		end

	EXCEPTIONS
		undefine
			is_equal
		end

feature -- Access

	last_packet_size: INTEGER
			-- Size of last packet

	bytes_transferred: INTEGER
	 		-- Number of transferred bytes

	read_buffer_size: INTEGER
	 		-- Size of read buffer

	address: NETWORK_RESOURCE_URL
			-- Address of URL

feature -- Status report

	is_open: BOOLEAN
			-- Is resource open?
		local
			l_socket: like main_socket
		do
			l_socket := main_socket
			Result := l_socket /= Void and then (l_socket.is_open_read or l_socket.is_open_write)
		end

	is_readable: BOOLEAN
			-- Is it possible to open in read mode currently?
		local
			opened: BOOLEAN
			failed: BOOLEAN
			m: INTEGER
		do
			m := mode
			if not failed then
				if readable_cached then
					Result := readable
				else
					if not is_open then
						set_read_mode
						open_connection
						opened := is_open
					end
					if main_socket /= Void then
						readable := is_open
						readable_cached := True
						if opened then close end
						Result := readable
					end
				end
			end
			mode := m
		rescue
			if not assertion_violation then
				mode := m
				failed := True
				retry
			end
		end

	is_writable: BOOLEAN
			-- Is it possible to open in write mode currently?
		local
			opened: BOOLEAN
			failed: BOOLEAN
			m: INTEGER
		do
			m := mode
			if not failed then
				if writable_cached then
					Result := writable
				else
					if not is_open then
						set_write_mode
						open_connection
						opened := is_open
					end
					if main_socket /= Void then
						writable := is_open
						writable_cached := True
						if opened then close end
						Result := writable
					end
				end
			end
			mode := m
		rescue
			if not assertion_violation then
				mode := m
				failed := True
				retry
			end
		end

	is_packet_pending: BOOLEAN
			-- Can another packet currently be read out?

	is_count_valid: BOOLEAN
			-- Is value in `count' valid?

	address_exists: BOOLEAN
			-- Does address exists?
		do
			Result := address.is_correct
		end

	is_proxy_used: BOOLEAN
			-- Is a proxy used?
		do
			Result := address.is_proxy_used and is_readable
		end

feature -- Status setting

	set_read_buffer_size (n: INTEGER)
			-- Set size of read buffer.
		do
			read_buffer_size := n
		end

	reuse_connection (other: NETWORK_RESOURCE)
			-- Reuse connection of `other'.
		do
			main_socket := other.main_socket
		end

feature {NONE} -- Status setting

	open_connection
			-- Open the connection.
		require
			closed: not is_open
		deferred
		end

feature -- Output

	put (other: DATA_RESOURCE)
			-- Write out resource `other'.
		local
			l_main_socket: like main_socket
			l_packet: like last_packet
		do
			l_main_socket := main_socket
			check l_main_socket_attached: l_main_socket /= Void end
			from until error or else not other.is_packet_pending loop
				check_socket (l_main_socket, Write_only)
				if not error then
					other.read
					l_packet := other.last_packet
					check l_packet_attached: l_packet /= Void end
					l_main_socket.put_string (l_packet)
					last_packet := l_packet
					last_packet_size := l_packet.count
					if last_packet_size /= other.last_packet_size then
						error_code := Write_error
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
			l_main_socket: like main_socket
			l_packet: like last_packet
		do
			l_main_socket := main_socket
			check l_main_socket: l_main_socket /= Void end
			check_socket (l_main_socket, Read_only)
			if not error then
				l_main_socket.read_stream (read_buffer_size)
				l_packet := l_main_socket.last_string
				last_packet := l_packet
				last_packet_size := l_packet.count
				bytes_transferred := bytes_transferred + last_packet_size
				if last_packet_size = 0 or (is_count_valid and bytes_transferred = count) then
					is_packet_pending := False
				end
			end
		rescue
			error_code := Transfer_failed
			last_packet := Void
			last_packet_size := 0
		end

feature -- Constants

	Read_only: INTEGER = 1
	Write_only: INTEGER = 2
			-- Constants determining the transfer direction for `check_socket'

feature {DATA_RESOURCE} -- Implementation

	main_socket: detachable NETWORK_STREAM_SOCKET

feature {NONE} -- Implementation

	readable: BOOLEAN
			-- Cached value of `is_readable'

	writable: BOOLEAN
			-- Cached value of `is_writable'

	readable_cached: BOOLEAN
			-- Has a value f�r `is_readable' been cached?

	writable_cached: BOOLEAN
			-- Has a value f�r `is_writable' been cached?

	check_socket (s: NETWORK_SOCKET; transfer_mode: INTEGER)
			-- Check, if it is possible to read from/write to `s' (depending on
			-- `transfer_mode' within `timeout' seconds. If not, set an error.
		require
			no_error: not error
			socket_exists: s /= Void
			defined_mode: Read_only = transfer_mode or transfer_mode = Write_only
		do
			if transfer_mode = read_only then
				if not s.ready_for_reading then
					error_code := Connection_timeout
				end
			elseif not s.ready_for_writing then
				error_code := Connection_timeout
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

end -- class NETWORK_RESOURCE
