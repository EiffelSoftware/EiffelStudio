indexing
	description:
		"Files accessed via HTTP"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class HTTP_PROTOCOL inherit

	NETWORK_RESOURCE
		redefine
			is_writable, location
		end

create 

	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize protocol.
		do
			set_read_buffer_size (Default_buffer_size)
			create headers.make
		end

feature {NONE} -- Constants

	Read_mode_id: INTEGER is unique
	
feature -- Access

	location: STRING is
			-- Resource location
		do
			Result := address.location
		end

feature -- Measurement

	count: INTEGER is
			-- Size of data resource
		do
			if is_count_valid then Result := content_length end
		end
		 
	Default_buffer_size: INTEGER is 16384
			-- Default size of read buffer.
			
feature -- Status report

	read_mode: BOOLEAN is
			-- Is read mode set?
		do
			Result := (mode = Read_mode_id)
		end

	Write_mode: BOOLEAN is False
			-- Is write mode set? (Answer: no)

	Is_writable: BOOLEAN is False
			-- Is it possible to open in write mode currently? (Answer: no)
			-- (HTTP resources are read-only.)
	
	valid_mode (n: INTEGER): BOOLEAN is
			-- Is mode `n' valid?
		do
			Result := n = Read_mode_id
		end
	 
	Supports_multiple_transactions: BOOLEAN is False
			-- Does resource support multiple tranactions per connection?
			-- (Answer: no)

feature -- Status setting

	open is
			-- Open resource.
		do
			if not is_open then
				if address.is_proxy_used then
					create main_socket.make_client_by_port 
						(address.proxy_port, address.proxy_host)
				else
					create main_socket.make_client_by_port 
							(address.port, address.host)
				end
				main_socket.connect
			end
			bytes_transferred := 0
			transfer_initiated := False
			is_packet_pending := False
			content_length := 0
		end

	close is
			-- Close.
		do
			main_socket.close
			if is_packet_pending then is_count_valid := False end
			main_socket := Void
			last_packet := Void
			is_packet_pending := False
		end
	
	initiate_transfer is
			-- Initiate transfer.
		local
			str: STRING
		do
			str := clone (Http_get_command)
			str.extend (' ')
			if address.is_proxy_used then
				str.append (location)
			else
				str.extend ('/')
				str.append (address.path)
			end
			str.extend (' ')
			str.append (Http_version)
			str.append (Http_end_of_command)
			main_socket.put_string (str)
				debug
					Io.error.put_string (str)
				end
			get_headers
			transfer_initiated := True
			is_packet_pending := True
		rescue
			error_code := Transfer_failed
		end
	
	set_read_mode is
			-- Set read mode.
		do
			mode := Read_mode_id
		end
	 
	 set_write_mode is
	 		-- Set write mode.
		do
		end
	
feature {NONE} -- Status setting

	open_connection is
			-- Open the connection.
		do
			open
		end
	 
feature {NONE} -- Implementation

	headers: LINKED_LIST[STRING]
			-- HTTP headers
	
	content_length: INTEGER
			-- Cached value of 'Content-Length:'

	get_headers is
			-- Get HTTP headers
		require
			open: is_open
		local
			str: STRING
		do
			headers.wipe_out
			from
			until
				str /= Void and str.is_equal ("%R")
			loop
				main_socket.read_line
				str := clone (main_socket.last_string)
					debug
						Io.error.put_string (str)
						Io.error.put_new_line
					end
				if not str.is_empty then headers.extend (str) end
			end
			check_error
			if not error then get_content_length end
		end

	get_content_length is
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
				str := clone (headers.item)
				pos := str.index_of (' ', 1)
				str.tail (str.count - pos)
				content_length := str.to_integer
				is_count_valid := True
			else
				content_length := 0
				is_count_valid := False
			end
		end
		
	check_error is
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
						headers.item.substring_index ("404", 6) > 0 then
						error_code := File_not_found
					end
					headers.forth
				end
			end
		end

invariant

	headers_list_exists: headers /= Void
	count_constraint: is_count_valid implies
				(is_packet_pending = (bytes_transferred < count))
	
end -- class HTTP_PROTOCOL


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


