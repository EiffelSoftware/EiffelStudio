indexing
	description: "Representation of both an Import Lookup table and an Import Address Table (IAT) in a PE File for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMPORT_ADDRESS_TABLE

inherit
	WEL_STRUCTURE
		rename
			structure_size as count
		end
		
create
	make

feature -- Settings

	set_import_by_name_rva (rva: INTEGER) is
			-- Set `import_by_name_rva' to `rva'.
		do
			c_set_import_by_name_rva (item, rva)
		end
		
feature -- Measurement

	count: INTEGER is
			-- Size of Current structure.
		do
			Result := structure_size
		end
	
	structure_size: INTEGER is
			-- Size of CLI_IMPORT_ADDRESS_TABLE.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMPORT_ADDRESS_TABLE)"
		end
	
feature {NONE} -- Implementation

	c_set_import_by_name_rva (an_item: POINTER; i: INTEGER) is
			-- Set `ImportByNameRVA' to `i'.
		external
			"C struct CLI_IMPORT_ADDRESS_TABLE access ImportByNameRVA type DWORD use %"cli_writer.h%""
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

end -- class CLI_IMPORT_ADDRESS_TABLE
