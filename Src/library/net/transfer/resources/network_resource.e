indexing
	description:
		"Resources accessed over a network"

	status:	"See note at end of class"
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

	is_open: BOOLEAN is
			-- Is resource open?
		do
			Result := main_socket /= Void and then
				(main_socket.is_open_read or main_socket.is_open_write)
		end
	 
	is_readable: BOOLEAN is
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
	
	is_writable: BOOLEAN is
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

	address_exists: BOOLEAN is
			-- Does address exists?
		do
			Result := address.is_correct
		end
	 
	is_proxy_used: BOOLEAN is
			-- Is a proxy used?
		do
			Result := address.is_proxy_used and is_readable
		end

feature -- Status setting

	set_read_buffer_size (n: INTEGER) is
			-- Set size of read buffer.
		do
			read_buffer_size := n
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
				check
					shared: equal (main_socket, o.main_socket)
						-- Because of referential equality
				end
		end

feature {NONE} -- Status setting

	open_connection is
			-- Open the connection.
		require
			closed: not is_open
		deferred
		end
	 
feature -- Output

	put (other: DATA_RESOURCE) is
			-- Write out resource `other'.
		do
			from until error or else not other.is_packet_pending loop
				check_socket (main_socket, Write_only)
				if not error then
					other.read
					main_socket.put_string (other.last_packet)
					if main_socket.socket_ok then
						last_packet := other.last_packet
						last_packet_size := last_packet.count
					else
						last_packet := Void
						last_packet_size := 0
					end
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
			check_socket (main_socket, Read_only)
			if not error then
				main_socket.read_stream (read_buffer_size)
				if main_socket.socket_ok then
					last_packet := main_socket.last_string
					last_packet_size := last_packet.count
				else
					error_code := Transfer_failed
					last_packet := Void
					last_packet_size := 0
				end
				bytes_transferred := bytes_transferred + last_packet_size
				if not error and then last_packet_size = 0 or 
					(is_count_valid and bytes_transferred = count) then
					is_packet_pending := False 
				end
			end
		rescue
			error_code := Transfer_failed
		end

feature {NONE} -- Constants

	Read_only, Write_only: INTEGER is unique
			-- Constants determinint the transfer direction for `check_socket'
			
feature {DATA_RESOURCE} -- Implementation

	main_socket: NETWORK_STREAM_SOCKET
	
feature {NONE} -- Implementation

	readable: BOOLEAN
			-- Cached value of `is_readable'

	writable: BOOLEAN
			-- Cached value of `is_writable'

	readable_cached: BOOLEAN
			-- Has a value für `is_readable' been cached?

	writable_cached: BOOLEAN
			-- Has a value für `is_writable' been cached?

	check_socket (s: NETWORK_SOCKET; transfer_mode: INTEGER) is
			-- Check, if it is possible to read from/write to `s' (depending on
			-- `transfer_mode' within `timeout' seconds. If not, set an error.
		require
			no_error: not error
			socket_exists: s /= Void
			defined_mode: Read_only <= transfer_mode and
						transfer_mode <= Write_only
		local
			m: BOOLEAN
		do
			m := (transfer_mode = Read_only)
			if not s.ready_for_reading then
				error_code := Connection_timeout 
			end
		end

invariant

	main_socket_ok: (main_socket /= Void and not error) implies 
			main_socket.socket_ok

end -- class NETWORK_RESOURCE

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


