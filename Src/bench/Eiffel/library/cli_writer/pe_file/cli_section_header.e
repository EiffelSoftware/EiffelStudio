indexing
	description: "Representation of a CLI section header."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_SECTION_HEADER

inherit
	WEL_STRUCTURE
		rename
			structure_size as size,
			make as old_make
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Create new section with name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_valid: not a_name.is_empty and then a_name.count <= 8
		local
			l_wel_string: ASCII_STRING
			l_name_ptr: POINTER
		do
			old_make
			c_set_pointer_to_line_numbers (item, 0)
			c_set_number_of_line_numbers (item, 0)
			
			create l_wel_string.make (a_name)
			l_name_ptr := c_name (item)
			l_name_ptr.memory_copy (l_wel_string.item, a_name.count)
		end

feature -- Measurement

	size: INTEGER is
			-- Size of current structure.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of IMAGE_SECTION_HEADER.
		external
			"C macro use <windows.h>"
		alias
			"sizeof(IMAGE_SECTION_HEADER)"
		end

feature -- Settings

	set_virtual_size (i: INTEGER) is
			-- Set `virtual_size' to `i'.
		do
			c_set_virtual_size (item, i)
		end

	set_virtual_address (i: INTEGER) is
			-- Set `virtual_address' to `i'.
		do
			c_set_virtual_address (item, i)
		end

	set_raw_data_size (i: INTEGER) is
			-- Set `raw_data_size' to `i'.
		do
			c_set_size_of_raw_data (item, i)
		end

	set_pointer_to_raw_data (i: INTEGER) is
			-- Set `pointer_to_raw_data' to `i'.
		do
			c_set_pointer_to_raw_data (item, i)
		end
		
	set_characteristics (i: INTEGER) is
			-- Set `characteristics' to `i'.
		do
			c_set_characteristics (item, i)
		end
		
feature {NONE} -- Access

	c_name (an_item: POINTER): POINTER is
			-- Get `Name'.
		external
			"C struct IMAGE_SECTION_HEADER access &Name use <windows.h>"
		end

feature {NONE} -- Settings

	c_set_virtual_size (an_item: POINTER; i: INTEGER) is
			-- Set `VirtualSize' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access Misc.VirtualSize type DWORD use <windows.h>"
		end

	c_set_virtual_address (an_item: POINTER; i: INTEGER) is
			-- Set `VirtualAddress' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access VirtualAddress type DWORD use <windows.h>"
		end

	c_set_size_of_raw_data (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfRawData' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access SizeOfRawData type DWORD use <windows.h>"
		end

	c_set_pointer_to_raw_data (an_item: POINTER; i: INTEGER) is
			-- Set `PointerToRawData' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access PointerToRawData type DWORD use <windows.h>"
		end

	c_set_pointer_to_relocations (an_item: POINTER; i: INTEGER) is
			-- Set `PointerToRelocations' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access PointerToRelocations type DWORD use <windows.h>"
		end

	c_set_pointer_to_line_numbers (an_item: POINTER; i: INTEGER) is
			-- Set `PointerToLinenumbers' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access PointerToLinenumbers type DWORD use <windows.h>"
		end

	c_set_number_of_relocations (an_item: POINTER; i: INTEGER_16) is
			-- Set `NumberOfRelocations' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access NumberOfRelocations type DWORD use <windows.h>"
		end

	c_set_number_of_line_numbers (an_item: POINTER; i: INTEGER_16) is
			-- Set `NumberOfLinenumbers' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access NumberOfLinenumbers type DWORD use <windows.h>"
		end

	c_set_characteristics (an_item: POINTER; i: INTEGER) is
			-- Set `Characteristics' to `i'.
		external
			"C struct IMAGE_SECTION_HEADER access Characteristics type DWORD use <windows.h>"
		end

end -- class CLI_SECTION_HEADER
