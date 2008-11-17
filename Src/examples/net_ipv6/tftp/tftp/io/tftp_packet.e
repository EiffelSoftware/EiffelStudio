deferred class

	TFTP_PACKET

feature -- Contants

	max_packet_length: INTEGER = 516
	max_data_length: INTEGER = 512

feature -- TFTP opcodes (RFC 1350)

	RRQ: NATURAL_16 = 1
	WRQ: NATURAL_16 = 2
	DATA: NATURAL_16 =3
	ACK: NATURAL_16 = 4
	ERROR: NATURAL_16 = 5

feature

	opcode: NATURAL_16

	host: INET_ADDRESS

	port: INTEGER

	data_pointer: MANAGED_POINTER

feature {NONE} -- Initialization

	make_from_host_port_size (a_host: INET_ADDRESS; a_port: INTEGER; an_opcode: INTEGER; size: INTEGER) is
		do
			opcode := an_opcode.as_natural_16
			host := a_host
			port := a_port
			create data_pointer.make (size)
		end

	make_from_host_port_managed_pointer (a_host: INET_ADDRESS; a_port: INTEGER; an_opcode: NATURAL_16; a_data_pointer: MANAGED_POINTER) is
			--
		require
			valid_host: a_host /= Void
			valod_opcode: an_opcode >= rrq and then an_opcode <= error
			data_non_void: a_data_pointer /= Void
		do
			make_from_managed_pointer (an_opcode, a_data_pointer)
			host := a_host
			port := a_port
		end

	make_from_managed_pointer (an_opcode: NATURAL_16; a_data_pointer: MANAGED_POINTER) is
			--
		require
			valod_opcode: an_opcode >= rrq and then an_opcode <= error
			data_non_void: a_data_pointer /= Void
		do
			opcode := an_opcode
			data_pointer := a_data_pointer
		end

feature {NONE} -- Implementation

	opcode_offset: INTEGER is
		do
			Result := 0
		end

	filename_offset: INTEGER is
		do
			Result := 2
		end

	block_number_offset: INTEGER is
		do
			Result := 2
		end

	error_code_offset: INTEGER is
		do
			Result := 2
		end

	error_message_offset: INTEGER is
		do
			Result := 4
		end

	read_block_number: INTEGER is
			--
		do
			Result := data_pointer.read_natural_16_be (block_number_offset)
		end

	write_opcode (an_opcode:INTEGER) is
			--
		do
			data_pointer.put_natural_16_be (an_opcode.as_natural_16, opcode_offset)
		end

	write_block_number (block_number: INTEGER) is
			--
		do
			data_pointer.put_natural_16_be (block_number.as_natural_16, block_number_offset)
		end

	write_error_code (error_code: INTEGER) is
			--
		do
			data_pointer.put_natural_16_be (error_code.as_natural_16, error_code_offset)
		end

	write_string (s: STRING; offset: INTEGER) is
			--
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count
			loop
				data_pointer.put_character (s.item (i), offset+i-1)
				i := i + 1
			end
			data_pointer.put_natural_8 (0, offset+i-1)
		end

	write_error (error_code: INTEGER; message: STRING) is
			--
		do
			write_error_code (error_code)
			write_string (message, error_message_offset)
		end

	write_filename_and_mode (file_name: STRING; mode: STRING) is
			--
		local
			i: INTEGER
			offset: INTEGER
		do
			from
				offset := filename_offset
				i := 1
			until
				i > file_name.count
			loop
				data_pointer.put_character (file_name.item (i), offset+i-1)
				i := i + 1
			end
			data_pointer.put_natural_8 (0, offset+i-1)

			from
				i := 1
			until
				i > mode.count
			loop
				data_pointer.put_character (mode.item (i), offset+i-1)
				i := i + 1
			end
			data_pointer.put_natural_8 (0, offset+i-1)
		end

	read_error_code: INTEGER is
			--
		do
			Result := data_pointer.read_natural_16_be (error_code_offset)
		end

	read_string (offset: INTEGER): STRING is
			--
		require
			data_pointer /= Void
		local
			i: INTEGER
			ch: CHARACTER
		do
			create Result.make_empty
			from
				i := offset
			until
				i > data_pointer.count
			loop
				ch := data_pointer.read_character (i)
				if  ch.code = 0 then
					i := data_pointer.count
				else
					Result.append_character(ch)
				end
				i := i + 1
			end
		end

end
