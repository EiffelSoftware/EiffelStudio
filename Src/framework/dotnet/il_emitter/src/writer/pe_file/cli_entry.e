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
			create padding.make_filled({NATURAL_8} 0, 1, 2)
			set_jump_inst_high (0xFF)
			set_jump_inst_low (0x25)
		end

feature -- Access

	padding: ARRAY [NATURAL_8]

	jump_inst_h: INTEGER_8

	jump_inst_l: INTEGER_8

	iat_rva: INTEGER_32

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Element Change

   set_jump_inst_high (a_jump_inst_h: INTEGER_8)
   		-- Set `jump_inst_h` with `a_jump_inst_h`.
      do
        jump_inst_h := a_jump_inst_h
      end

    set_jump_inst_low (a_jump_inst_l: INTEGER_8)
     	 -- Set `jump_inst_l` with `a_jump_inst_l`.
      do
        jump_inst_l := a_jump_inst_l
      end


	set_iat_rva (rva: INTEGER)
			-- Set `iat_rva' to `rva'.
		do
			iat_rva :=  rva + 0x400000
		end

feature -- Managed Pointer

	item: MANAGED_POINTER
			-- write the items to the buffer in  little-endian format.
		local
			l_pos: INTEGER
		do
			create Result.make (size_of)
			l_pos := 0

				-- padding
			Result.put_array (padding, l_pos)
			l_pos := 2 * {PLATFORM}.natural_8_bytes

				-- jump_inst_h
			Result.put_integer_8_le(jump_inst_h, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_8_bytes

				-- jump_inst_l
			Result.put_integer_8_le(jump_inst_l, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_8_bytes

				-- iat_rva
			Result.put_integer_32_le(iat_rva, l_pos)
		end

feature -- Measurement

	size_of: INTEGER
			-- Size of `CLI_ENTRY' structure.
		do
				-- padding
			Result := 2 * {PLATFORM}.natural_8_bytes

				-- jump_inst_h
			Result := Result + {PLATFORM}.integer_8_bytes

				-- jump_inst_l
			Result := Result + {PLATFORM}.integer_8_bytes

				-- iat_rva
			Result := Result + {PLATFORM}.integer_32_bytes
		ensure
			is_class: class
		end

	start_position: INTEGER = 2
			-- Actual position where `jump' info and `rva'
			-- are located.

	jump_size: INTEGER = 4
			-- Size taken by padding + `jump' instruction.

end -- class CLI_ENTRY
