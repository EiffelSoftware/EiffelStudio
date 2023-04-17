note
	description: "Small structure that holds entry point of current CLI image"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_ENTRY

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Allocated `item'.
		do
			managed_pointer_make (structure_size)
			c_set_jump_inst_high (item, 0xFF)
			c_set_jump_inst_low (item, 0x25)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of `CLI_ENTRY' structure.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_ENTRY)"
		end

	start_position: INTEGER = 2
			-- Actual position where `jump' info and `rva'
			-- are located.

	jump_size: INTEGER = 4
			-- Size taken by padding + `jump' instruction.

feature -- Settings

	set_iat_rva (rva: INTEGER)
			-- Set `iat_rva' to `rva'.
		do
			c_set_iat_rva (item, rva + 0x400000)
		end

feature  -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (Current, 0, count)
			l_file.close
		end


feature {NONE} -- Initialization

	c_set_jump_inst_high (an_item: POINTER; i: INTEGER_8)
			-- Set `JumpInstH' to `i'.
		external
			"C struct CLI_ENTRY access JumpInstH type BYTE use %"cli_writer.h%""
		end

	c_set_jump_inst_low (an_item: POINTER; i: INTEGER_8)
			-- Set `JumpInstL' to `i'.
		external
			"C struct CLI_ENTRY access JumpInstL type BYTE use %"cli_writer.h%""
		end

	c_set_iat_rva (an_item: POINTER; i: INTEGER)
			-- Set `IAT_RVA' to `i'.
		external
			"C struct CLI_ENTRY access IAT_RVA type DWORD use %"cli_writer.h%""
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CLI_ENTRY
