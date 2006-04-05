indexing
	description: "Representation of an IMAGE_DATA_DIRECTORY for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DIRECTORY

inherit
	MEMORY_STRUCTURE
		rename
			structure_size as count
		end
		
create
	make,
	make_by_pointer
	
feature -- Access

	rva: INTEGER is
			-- Relative virtual address for current directory.
		do
			Result := c_virtual_address (item)
		end
		
	data_size: INTEGER is
			-- Size of data pointer by `relative_virtual_address'.
		do
			Result := c_size (item)
		end
		
feature -- Settings

	set_rva (i: INTEGER) is
			-- Set `rva' to `i'.
		do
			c_set_virtual_address (item, i)
		ensure
			rva_set: rva = i
		end

	set_data_size (i: INTEGER) is
			-- Set `data_size' to `i'.
		do
			c_set_size (item, i)
		ensure
			data_size_set: data_size = i
		end
		
	set_rva_and_size (a_rva, a_size: INTEGER) is
			-- Set `rva' and `data_size' to `a_rva' and `a_size'.
		do
			c_set_virtual_address (item, a_rva)
			c_set_size (item, a_size)
		ensure
			rva_set: rva = a_rva
			data_size_set: data_size = a_size
		end

feature -- Measurement

	count: INTEGER is
			-- Size of current structure.
		do
			Result := structure_size
		end

	frozen structure_size: INTEGER is
			-- Size of IMAGE_DATA_DIRECTORY.
		external
			"C macro use <windows.h>"
		alias
			"sizeof(IMAGE_DATA_DIRECTORY)"
		end

feature {NONE} -- Implementation

	c_virtual_address (an_item: POINTER): INTEGER is
			-- Access to `VirtualAddress'.
		external
			"C struct IMAGE_DATA_DIRECTORY access VirtualAddress use <windows.h>"
		end

	c_size (an_item: POINTER): INTEGER is
			-- Access to `Size'.
		external
			"C struct IMAGE_DATA_DIRECTORY access Size use <windows.h>"
		end		

	c_set_virtual_address (an_item: POINTER; i: INTEGER) is
			-- Access to `VirtualAddress'.
		external
			"C struct IMAGE_DATA_DIRECTORY access VirtualAddress type DWORD use <windows.h>"
		end

	c_set_size (an_item: POINTER; i: INTEGER) is
			-- Access to `Size'.
		external
			"C struct IMAGE_DATA_DIRECTORY access Size type DWORD use <windows.h>"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class CLI_DIRECTORY
