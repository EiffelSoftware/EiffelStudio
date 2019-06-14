note
	description: "The FILE protocol."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FILE_PROTOCOL inherit

	DATA_RESOURCE
		redefine
			address
		end

create

	make

feature {NONE} -- Initialization

	initialize
			-- Initialize file protocol.
		do
			create file.make_with_path (address.path)
			create buffer.make_filled ('%/000/', Default_buffer_size)
			read_buffer_size := Default_buffer_size
			set_overwrite_mode
		end

feature {NONE} -- Constants

	Read_mode_id, Write_mode_id, Append_mode_id: INTEGER = unique
			-- File mode IDs

	Default_buffer_size: INTEGER = 65535
			-- Default read buffer size

feature -- Access

	address: FILE_URL
			-- Associated address

feature -- Measurement

	read_buffer_size: INTEGER
			-- Size of read buffer

	last_packet_size: INTEGER
			-- Size of last packet

	count: INTEGER
			-- Size of data resource
		do
			Result := file.count
		end

	bytes_transferred: INTEGER
	 		-- Number of transferred bytes

feature -- Status report

	is_open: BOOLEAN
			-- Is resource open?
		do
			Result := file.is_open_read or file.is_open_write or
				file.is_open_append
		end

	is_readable: BOOLEAN
			-- Is it possible to open in read mode currently?
		do
			Result := file.is_open_read or else
				(file.exists and then file.is_readable)
		end

	is_writable: BOOLEAN
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

	address_exists: BOOLEAN
			-- Does address exist?
		do
			Result := is_readable or is_writable
		end

	Is_local: BOOLEAN = True
			-- Is protocol not networked? (Answer: yes)

	is_proxy_used: BOOLEAN = False
			-- Does resource use a proxy? (Answer: no)

	valid_mode (n: INTEGER): BOOLEAN
			-- Is mode `n' valid?
		do
			Result := Read_mode_id <= n and n <= Append_mode_id
		end

	is_packet_pending: BOOLEAN
			-- Can another packet currently be read out?
		do
			Result := not error and then file.is_open_read and then
				not file.after
		end

	read_mode: BOOLEAN
			-- Is read mode set?
		do
			Result := mode = Read_mode_id
		end

	write_mode: BOOLEAN
			-- Is write mode set?
		do
			Result := (mode = Write_mode_id) or (mode = Append_mode_id)
		end

	Is_count_valid: BOOLEAN = True
			-- Is value in `count' valid? (Answer: yes)

	Supports_multiple_transactions: BOOLEAN = False
			-- Does resource support multiple tranactions per connection?
			-- (Answer: no)

feature -- Status setting

	open
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

	close
			-- Close.
		do
			file.close
			transfer_initiated := False
		end

	initiate_transfer
			-- Initiate transfer.
		do
			transfer_initiated := True
		end

	set_read_buffer_size (n: INTEGER)
			-- Set size of read buffer.
		do
			read_buffer_size := n
			create buffer.make_filled ('%/000/', read_buffer_size)
		ensure then
			buffer_size_correct: buffer.count = read_buffer_size
		end

	set_overwrite_mode
			-- Switch on file overwrite mode on.
		do
			overwrite_mode := True
		end

	reset_overwrite_mode
			-- Switch on file overwrite mode on.
		do
			overwrite_mode := False
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

	reuse_connection (other: DATA_RESOURCE)
			-- Reuse connection of `other'.
		do
		end

feature -- Output

	put (other: DATA_RESOURCE)
			-- Write out resource `other'.
		local
			l_other_packet: like last_packet
		do
			from until not other.is_packet_pending loop
				other.read
				l_other_packet := other.last_packet
				if l_other_packet /= Void then
					file.put_string (l_other_packet)
					last_packet_size := l_other_packet.count
					bytes_transferred := bytes_transferred + last_packet_size
				end
				if last_packet_size /= other.last_packet_size then
					error_code := Write_error
				end
			end
		end

feature -- Input

	read
			-- Read packet.
		local
			l_packet: like last_packet
		do
			file.read_stream (read_buffer_size)
			l_packet := file.last_string
			last_packet := l_packet
			last_packet_size := l_packet.count
			bytes_transferred := bytes_transferred + last_packet_size
		rescue
			error_code := transfer_failed
			last_packet := Void
			last_packet_size := 0
		end

feature {NONE} -- Implementation

	file: RAW_FILE

	buffer: SPECIAL[CHARACTER]

	overwrite_mode: BOOLEAN;

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
