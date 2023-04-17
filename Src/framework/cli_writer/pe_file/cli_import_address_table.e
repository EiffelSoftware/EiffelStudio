note
	description: "Representation of both an Import Lookup table and an Import Address Table (IAT) in a PE File for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMPORT_ADDRESS_TABLE

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- New instance of CLI_IMPORT_ADDRESS_TABLE.
		do
			managed_pointer_make (structure_size)
		end

feature -- Settings

	set_import_by_name_rva (rva: INTEGER)
			-- Set `import_by_name_rva' to `rva'.
		do
			c_set_import_by_name_rva (item, rva)
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


feature -- Measurement

	structure_size: INTEGER
			-- Size of CLI_IMPORT_ADDRESS_TABLE.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMPORT_ADDRESS_TABLE)"
		end

feature {NONE} -- Implementation

	c_set_import_by_name_rva (an_item: POINTER; i: INTEGER)
			-- Set `ImportByNameRVA' to `i'.
		external
			"C struct CLI_IMPORT_ADDRESS_TABLE access ImportByNameRVA type DWORD use %"cli_writer.h%""
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

end -- class CLI_IMPORT_ADDRESS_TABLE
