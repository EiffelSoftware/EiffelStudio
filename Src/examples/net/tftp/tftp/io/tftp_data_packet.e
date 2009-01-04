class

	TFTP_DATA_PACKET

inherit

	TFTP_ACK_PACKET

create

	make_from_managed_pointer, make_from_host_port_managed_pointer, make_from_address_code_data

feature

	data_offset: INTEGER = 4

feature

	block_size: INTEGER = 512

feature -- Initialization

	make_from_address_code_data (an_address: INET_ADDRESS; a_port: INTEGER; a_block_number: INTEGER; a_data_pointer: MANAGED_POINTER; a_data_length: INTEGER) is
			--
		require
			address_non_void: an_address /= Void
		local
			i: INTEGER
		do
			make_from_host_port_size (an_address, a_port, data, 4 + a_data_length)
			write_opcode (data)
			write_block_number (a_block_number)
			from
				i := 0
			until
				i >= a_data_length
			loop
				data_pointer.put_natural_8 (a_data_pointer.read_natural_8 (i), data_offset + i)
				i := i + 1
			end
		end

feature

	data_length: INTEGER is
			--
		do
			Result := data_pointer.count - data_offset
		end

end
