indexing
	description: "Representation of both an Import Lookup table and an Import Address Table (IAT) in a PE File for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMPORT_ADDRESS_TABLE

inherit
	WEL_STRUCTURE
		rename
			structure_size as size
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

	size: INTEGER is
			-- Size of Current structure.
		do
			Result := structure_size
		end
	
	structure_size: INTEGER is
			-- Size of CLI_IMPORT_ADDRESS_TABLE.
		external
			"C macro use %"pe_writer.h%""
		alias
			"sizeof(CLI_IMPORT_ADDRESS_TABLE)"
		end
	
feature {NONE} -- Implementation

	c_set_import_by_name_rva (an_item: POINTER; i: INTEGER) is
			-- Set `ImportByNameRVA' to `i'.
		external
			"C struct CLI_IMPORT_ADDRESS_TABLE access ImportByNameRVA type DWORD use %"pe_writer.h%""
		end
		
end -- class CLI_IMPORT_ADDRESS_TABLE
