note
	description: "Small structure that holds entry point of current CLI image"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_ENTRY

create
	make

feature {NONE} -- Initialization

	make
		do
			set_jump_inst_high (0xFF)
			set_jump_inst_low (0x25)
		end

feature -- Access

	jump_inst_h: INTEGER_8

	jump_inst_l: INTEGER_8

	iat_rva: INTEGER_32

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (item, 0, count)
			l_file.close
		end

feature -- Element Change

	set_jump_inst_high (a_jump_inst_h: INTEGER_8)
			-- Set `jump_inst_h` with `a_jump_inst_h`.
		do
			jump_inst_h := a_jump_inst_h
		ensure
			jump_inst_h_set: jump_inst_h = a_jump_inst_h
		end

	set_jump_inst_low (a_jump_inst_l: INTEGER_8)
			-- Set `jump_inst_l` with `a_jump_inst_l`.
		do
			jump_inst_l := a_jump_inst_l
		ensure
			jump_inst_l_set: jump_inst_l = a_jump_inst_l
		end

	set_iat_rva (rva: INTEGER)
			-- Set `iat_rva' to `rva'.
		do
			iat_rva := rva + 0x400000
		ensure
			iat_rva_set: iat_rva = rva + 0x400000
		end

feature -- Managed Pointer

	item: CLI_MANAGED_POINTER
			-- write the items to the buffer in  little-endian format.
		do
			create Result.make (size_of)

				-- padding
			Result.put_padding (2, 0)

				-- jump_inst_h
			Result.put_integer_8 (jump_inst_h)

				-- jump_inst_l
			Result.put_integer_8 (jump_inst_l)

				-- iat_rva
			Result.put_integer_32 (iat_rva)
		ensure
			item.position = size_of
		end

feature -- Measurement

	size_of: INTEGER
			-- Size of `CLI_ENTRY' structure.
		local
			s: CLI_MANAGED_POINTER_SIZE
		do
			create s.make

				-- padding
			s.put_padding (2)

				-- jump_inst_h
			s.put_integer_8

				-- jump_inst_l
			s.put_integer_8

				-- iat_rva
			s.put_integer_32
			Result := s
		ensure
			is_class: class
		end

	start_position: INTEGER = 2
			-- Actual position where `jump' info and `rva'
			-- are located.

	jump_size: INTEGER = 4
			-- Size taken by padding + `jump' instruction.

end -- class CLI_ENTRY
