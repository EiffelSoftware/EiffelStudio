class

	TFTP_REQUEST_PACKET

inherit

	TFTP_PACKET
		redefine
			make_from_managed_pointer
		end

create

	make_from_managed_pointer, make_from_host_port_managed_pointer

feature -- Constants

	mode_octet: INTEGER is 0

	mode_netascii: INTEGER is 1

	mode_mail: INTEGER is 2

feature -- Initialisation

	make_from_managed_pointer (an_opcode: NATURAL_16; a_data_pointer: MANAGED_POINTER) is
		do
			Precursor (an_opcode, a_data_pointer)
			read_filename_and_mode
		end

feature

	mode: INTEGER

	filename: STRING

feature {NONE} -- Implementation

	read_filename_and_mode is
			--
		local
			done: BOOLEAN
			i: INTEGER
			ch: CHARACTER
			m: STRING
		do
			from
				done := False
				i := filename_offset
				create filename.make_empty
			until
				done or else i > data_pointer.count
			loop
				ch := data_pointer.read_character (i)
				if ch.code = 0 then
					done := True
				else
					filename.append_character(ch)
				end
				i := i + 1
			end

			from
				done := False
				create m.make_empty
			until
				done or else i > data_pointer.count
			loop
				ch := data_pointer.read_character (i)
				if ch.code = 0 then
					done := True
				else
					m.append_character(ch)
				end
				i := i + 1
			end

				-- Default mode is octet
			if m.is_case_insensitive_equal ("netascii") then
				mode := mode_netascii
			elseif m.is_case_insensitive_equal ("octet") then
				mode := mode_octet
			elseif m.is_case_insensitive_equal ("mail") then
				mode := mode_mail
			end
		end
end
