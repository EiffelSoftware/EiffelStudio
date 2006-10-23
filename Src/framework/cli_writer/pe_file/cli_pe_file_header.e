indexing
	description: "[
		Representation of a PE file header through C structure IMAGE_FILE_HEADER
		for CLI.
		See Partition II, 24.2.2 for details on default values.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PE_FILE_HEADER

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
			-- Allocate `item' and initialize default values for CLI.
		do
			Precursor {WEL_STRUCTURE}
			c_set_machine (item, 0x14C)
			c_set_time_date_stamp (item, {CLI_TIME}.time (default_pointer))
			c_set_pointer_to_symbol_table (item, 0)
			c_set_size_of_optional_header (item, 0x00E0)
			c_set_number_of_symbols (item, 0)
		end
		
feature -- Settings

	set_number_of_sections (i: INTEGER) is
			-- Set `number_of_sections
		do
			c_set_number_of_sections (item, i.to_integer_16)
		end

	set_time_date_stamp (t: INTEGER) is
			-- Set `time_date_stamp' to `t'.
		do
			c_set_time_date_stamp (item, t)
		end
		
	set_size_of_optional_header_size (s: INTEGER_16) is
			-- Set `size_of_optional_header_size' to `s'.
		do
			c_set_size_of_optional_header (item, s)
		end
		
	set_characteristics (c: INTEGER_16) is
			-- Set `characteristics' to `c'.
			-- Loof in `CLI_PE_FILE_CONSTANTS' for possible constants.
		do
			c_set_characteristics (item, c)
		end

feature -- Measurement

	count: INTEGER is
			-- Size of Current C structure.
		do
			Result := structure_size
		end
		
feature {NONE} -- Implementation

	structure_size: INTEGER is
			-- Size of IMAGE_FILE_HEADER structure.
		external
			"C macro use <windows.h>"
		alias
			"sizeof(IMAGE_FILE_HEADER)"
		end

	c_set_machine (an_item: POINTER; i: INTEGER_16) is
			-- Set `Machine' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access Machine type WORD use <windows.h>"
		end

	c_set_number_of_sections (an_item: POINTER; i: INTEGER_16) is
			-- Set `NumberOfSections' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access NumberOfSections type WORD use <windows.h>"
		end
		
	c_set_time_date_stamp (an_item: POINTER; i: INTEGER) is
			-- Set `TimeDateStamp' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access TimeDateStamp type DWORD use <windows.h>"
		end

	c_set_pointer_to_symbol_table (an_item: POINTER; i: INTEGER) is
			-- Set `PointerToSymbolTable' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access PointerToSymbolTable type DWORD use <windows.h>"
		end

	c_set_number_of_symbols (an_item: POINTER; i: INTEGER) is
			-- Set `NumberOfSymbols' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access NumberOfSymbols type DWORD use <windows.h>"
		end
	
	c_set_size_of_optional_header (an_item: POINTER; i: INTEGER_16) is
			-- Set `SizeOfOptionalHeader' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access SizeOfOptionalHeader type WORD use <windows.h>"
		end
	
	c_set_characteristics (an_item: POINTER; i: INTEGER_16) is
			-- Set `Characteristics' to `i'.
		external
			"C struct IMAGE_FILE_HEADER access Characteristics type WORD use <windows.h>"
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

end -- class CLI_PE_FILE_HEADER
