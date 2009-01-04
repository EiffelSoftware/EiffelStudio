class

	TFTP_ACK_PACKET

inherit

	TFTP_PACKET
		redefine
			make_from_managed_pointer
		end

create

	make_from_managed_pointer, make_from_host_port_managed_pointer, make_from_address_block

feature -- Initialisation

	make_from_managed_pointer (an_opcode: NATURAL_16; a_data_pointer: MANAGED_POINTER) is
		do
			Precursor (an_opcode, a_data_pointer)
			block_number := read_block_number
		end

feature

	block_number: INTEGER

	make_from_address_block (an_address: INET_ADDRESS; a_port: INTEGER; a_block_number: INTEGER) is
			--
		require
			address_non_void: an_address /= Void
		do
			block_number := a_block_number
			make_from_host_port_size (an_address, a_port, ack, 4)
			write_opcode (ack)
			write_block_number (a_block_number)
		end

end
