note
	description: "Data regarding debugger info in PE file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DEBUG_DIRECTORY

inherit
	CLI_DEBUG_DIRECTORY_I
		undefine
			is_equal, copy
		end

	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

create
	make,
	make_codeview,
	make_pdbchecksum

feature {NONE} -- Initialization

	make
			-- Allocate `item'
		do
			managed_pointer_make (structure_size)
			c_set_characteristics (item, 0)
			c_set_date_stamp (item, {CLI_TIME}.time (default_pointer))
			c_set_major_version (item, 0)
			c_set_minor_version (item, 0)
			c_set_type (item, {CLI_DEBUG_CONSTANTS}.type_unknown)
		end

	make_codeview
		do
			make
			c_set_type (item, {CLI_DEBUG_CONSTANTS}.Type_codeview)
		end

	make_pdbchecksum
		do
			make
			c_set_type (item, {CLI_DEBUG_CONSTANTS}.type_pdbchecksum)
			c_set_major_version (item, 1)
		end

feature -- Settings

	set_time_date_stamp (a_time_date_stamp: INTEGER)
		do
			c_set_date_stamp (item, a_time_date_stamp)
		end

	set_size (a_size: INTEGER)
			--
		require
			valid_size: a_size >= 0
		do
			c_set_size (item, a_size)
		end

	set_address_of_data (a_rva: INTEGER)
			-- Set RVA of debug info into PE file.
		require
			valid_rva: a_rva /= 0
		do
			c_set_address_of_raw_data (item, a_rva)
		end

	set_pointer_to_data (a_pos: INTEGER)
			-- Set position of debug info in PE file.
		require
			valid_rva: a_pos /= 0
		do
			c_set_pointer_to_raw_data (item, a_pos)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of IMAGE_DATA_DIRECTORY.
		external
			"C macro use <windows.h>"
		alias
			"sizeof(IMAGE_DEBUG_DIRECTORY)"
		end

feature {NONE} -- Implementation

	c_set_characteristics (an_item: POINTER; i: INTEGER)
			-- Set `Characteristics' to `i'.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access Characteristics type DWORD use <windows.h>"
		end

	c_set_date_stamp (an_item: POINTER; t: INTEGER)
			-- Set `TimeDataStamp' to `t'.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access TimeDateStamp type DWORD use <windows.h>"
		end

	c_set_major_version (an_item: POINTER; v: INTEGER_16)
			-- Set `MajorVersion' to `v'.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access MajorVersion type WORD use <windows.h>"
		end

	c_set_minor_version (an_item: POINTER; v: INTEGER_16)
			-- Set `MinorVersion' to `v'.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access MinorVersion type WORD use <windows.h>"
		end

	c_set_type (an_item: POINTER; t: INTEGER)
			-- Set `Type' to `t'.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access @Type type DWORD use <windows.h>"
		end

	c_set_size (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfData' to `i'.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access SizeOfData type DWORD use <windows.h>"
		end

	c_set_address_of_raw_data (an_item: POINTER; i: INTEGER)
			-- Set `AddressOfRawData' to i.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access AddressOfRawData type DWORD use <windows.h>"
		end

	c_set_pointer_to_raw_data (an_item: POINTER; i: INTEGER)
			-- Set `PointerToRawData' to i.
		external
			"C struct IMAGE_DEBUG_DIRECTORY access PointerToRawData type DWORD use <windows.h>"
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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

end -- class CLI_DEBUG_DIRECTORY
