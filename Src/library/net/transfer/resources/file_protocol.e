indexing
	description:
		"The FILE protocol"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class FILE_PROTOCOL inherit

	RESOURCE
		redefine
			address
		end

create

	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize file protocol.
		do
			create file.make (address.name)
			create buffer.make_area (Default_buffer_size)
			read_buffer_size := Default_buffer_size
			set_overwrite_mode
		end
		 
feature {NONE} -- Constants

	Read_mode_id, Write_mode_id, Append_mode_id: INTEGER is unique
			-- File mode IDs

	Default_buffer_size: INTEGER is 65535
			-- Default read buffer size
			
feature -- Access

	address: FILE_URL
			-- Associated address
			
feature -- Measurement

	read_buffer_size: INTEGER
			-- Size of read buffer

	last_packet_size: INTEGER
			-- Size of last packet
	 
	count: INTEGER is
			-- Size of data resource
		do
			Result := file.count
		end
		 
	 bytes_transferred: INTEGER
	 		-- Number of transferred bytes
	 
feature -- Status report

	is_open: BOOLEAN is
			-- Is resource open?
		do
			Result := file.is_open_read or file.is_open_write or
				file.is_open_append
		end

	is_readable: BOOLEAN is
			-- Is it possible to open in read mode currently?
		do
			Result := file.is_open_read or else 
				(file.exists and then file.is_readable)
		end
	
	is_writable: BOOLEAN is
			-- Is it possible to open in write mode currently?
		do
			if file.is_open_write then
				Result := True
			elseif overwrite_mode then
				Result := file.is_creatable
			else
				Result := not file.exists
			end
		end
	
	address_exists: BOOLEAN is
			-- Does address exist?
		do
			Result := is_readable or is_writable
		end

	Is_local: BOOLEAN is True
			-- Is protocol not networked? (Answer: yes)
	
	valid_mode (n: INTEGER): BOOLEAN is
			-- Is mode `n' valid?
		do
			Result := Read_mode_id <= n and n <= Append_mode_id
		end
	 
	is_packet_pending: BOOLEAN is
			-- Can another packet currently be read out?
		do
			Result := not error and then file.is_open_read and then
				not file.after
		end
	
	read_mode: BOOLEAN is
			-- Is read mode set?
		do
			Result := (mode = Read_mode_id)
		end

	write_mode: BOOLEAN is
			-- Is write mode set?
		do
			Result := (mode = Write_mode_id) or (mode = Append_mode_id)
		end

	Is_count_valid: BOOLEAN is True
			-- Is value in `count' valid? (Answer: yes)

	Supports_multiple_transactions: BOOLEAN is False
			-- Does resource support multiple tranactions per connection?
			-- (Answer: no)

feature -- Status setting

	open is
			-- Open file resource.
		do
			if not is_open then
				inspect
					mode
				when Read_mode_id then
					file.open_read
				when Write_mode_id then
					file.open_write
				when Append_mode_id then
					file.open_append
				end
				bytes_transferred := 0
			end
		ensure then
			counter_reset: bytes_transferred = 0
		end

	close is
			-- Close.
		do
			file.close
			transfer_initiated := False
		end
	
	initiate_transfer is
			-- Initiate transfer.
		do
			transfer_initiated := True
		end
	
	set_read_buffer_size (n: INTEGER) is
			-- Set size of read buffer.
		do
			read_buffer_size := n
			create buffer.make_area (read_buffer_size)
		ensure then
			buffer_size_correct: buffer.area.count = read_buffer_size
		end
		
	set_overwrite_mode is
			-- Switch on file overwrite mode on.
		do
			overwrite_mode := True
		end

	reset_overwrite_mode is
			-- Switch on file overwrite mode on.
		do
			overwrite_mode := False
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
		
	reuse_connection (other: RESOURCE) is
			-- Reuse connection of `other'.
		do
		end

feature -- Output

	put (other: RESOURCE) is
			-- Write out resource `other'.
		do
			from until not other.is_packet_pending loop
				other.read
				file.put_string (other.last_packet)
				last_packet_size := other.last_packet.count
				bytes_transferred := bytes_transferred + last_packet_size
				if last_packet_size /= other.last_packet_size then
					error_code := Write_error
				end
			end
		end

feature -- Input

	read is
			-- Read packet.
		do
			file.read_stream (read_buffer_size)
			last_packet := file.last_string
			last_packet_size := last_packet.count
			bytes_transferred := bytes_transferred + last_packet_size
		end

feature {NONE} -- Implementation

	file: RAW_FILE

	buffer: TO_SPECIAL[CHARACTER]

	overwrite_mode: BOOLEAN

end -- class FILE_PROTOCOL

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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


