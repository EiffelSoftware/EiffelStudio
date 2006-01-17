indexing
	description: "Small structure that holds entry point of current CLI image"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_ENTRY
	
inherit
	WEL_STRUCTURE
		rename
			structure_size as count
		redefine
			make
		end
		
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Allocated `item'.
		do
			Precursor {WEL_STRUCTURE}
			c_set_jump_inst_high (item, 0xFF)
			c_set_jump_inst_low (item, 0x25)
		end
		
feature -- Measurement

	count: INTEGER is
			-- Size of current.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of `CLI_ENTRY' structure.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_ENTRY)"
		end

	start_position: INTEGER is 2
			-- Actual position where `jump' info and `rva'
			-- are located.
			
	jump_size: INTEGER is 4
			-- Size taken by padding + `jump' instruction.

feature -- Settings

	set_iat_rva (rva: INTEGER) is
			-- Set `iat_rva' to `rva'.
		do
			c_set_iat_rva (item, rva + 0x400000)
		end
		
feature {NONE} -- Initialization

	c_set_jump_inst_high (an_item: POINTER; i: INTEGER_8) is
			-- Set `JumpInstH' to `i'.
		external
			"C struct CLI_ENTRY access JumpInstH type BYTE use %"cli_writer.h%""
		end
			
	c_set_jump_inst_low (an_item: POINTER; i: INTEGER_8) is
			-- Set `JumpInstL' to `i'.
		external
			"C struct CLI_ENTRY access JumpInstL type BYTE use %"cli_writer.h%""
		end
	
	c_set_iat_rva (an_item: POINTER; i: INTEGER) is
			-- Set `IAT_RVA' to `i'.
		external
			"C struct CLI_ENTRY access IAT_RVA type DWORD use %"cli_writer.h%""
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLI_ENTRY
