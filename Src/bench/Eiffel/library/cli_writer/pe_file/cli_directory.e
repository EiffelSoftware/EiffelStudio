indexing
	description: "Representation of an IMAGE_DATA_DIRECTORY for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_DIRECTORY

inherit
	WEL_STRUCTURE
		rename
			structure_size as size
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

	size: INTEGER is
			-- Size of current structure.
		do
			Result := structure_size
		end

	structure_size: INTEGER is
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

end -- class CLI_DIRECTORY
