class

	TFTP_ERROR_PACKET

inherit

	TFTP_PACKET
		redefine
			make_from_managed_pointer
		end

create
	make_from_host_port_managed_pointer, make_from_address_code_message

feature -- Initialisation

	make_from_managed_pointer (an_opcode: NATURAL_16; a_data_pointer: MANAGED_POINTER)
		do
			Precursor (an_opcode, a_data_pointer)
			code := read_error_code
			message := read_string (error_message_offset)
		end

	make_from_address_code_message (an_address: INET_ADDRESS; a_port: INTEGER; a_code: INTEGER; a_message: STRING)
			--
		require
			address_non_void: an_address /= Void
			a_message_not_void: a_message /= Void
		local
			size: INTEGER
		do
			size := 4
			message := a_message
			size := size + a_message.count + 1
			make_from_host_port_size (an_address, a_port, error, size)
			write_opcode (error)
			write_error (a_code, a_message)
		end

feature

	code: INTEGER

	message: STRING

end
