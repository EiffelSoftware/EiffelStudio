indexing
	description: "Representation of PE import table for CLI"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_IMPORT_TABLE

inherit
	WEL_STRUCTURE
		rename
			structure_size as size,
			make as old_make
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (is_dll: BOOLEAN) is
			-- Allocate `item'.
		local
			str: POINTER
			ascii_str: ASCII_STRING
		do
			old_make
			c_set_time_date_stamp (item, 0)
			c_set_forwarder_chain (item, 0)

				-- Set `entry_point_name'.
			str := c_entry_point_name (item)
			if is_dll then
				create ascii_str.make (dll_entry_point_name)
			else
				create ascii_str.make (exe_entry_point_name)
			end
			str.memory_copy (ascii_str.item, ascii_str.count)
			
				-- Set `library_name'.
			str := c_library_name (item)
			create ascii_str.make (library_name)
			str.memory_copy (ascii_str.item, ascii_str.count)
		end

feature -- Settings

	set_rvas (section_rva, current_location: INTEGER) is
			-- Knowing that current lies in a section at `section_rva'
			-- and that its current RVA is `current_location', updates
			-- attributes of current to match those.
		do
			c_set_import_lookup_table (item, current_location + 40)
			c_set_name_rva (item, current_location + 62)
			c_set_iat_rva (item, section_rva)
			c_set_import_by_name_rva (item, current_location + size_to_import_by_name)
		end
		
feature -- Measurement

	size: INTEGER is
			-- Size of Current.
		do
			Result := structure_size
		end
		
	structure_size: INTEGER is
			-- Size of CLI_IMPORT_TABLE.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMPORT_TABLE)"
		end

	size_to_import_by_name: INTEGER is 48
			-- Location of import by name table from top of structure.
			
feature -- Constants

	dll_entry_point_name: STRING is "_CorDllMain"
	exe_entry_point_name: STRING is "_CorExeMain"
			-- Entry point names for `dll' or `exe'.
			
	library_name: STRING is "mscoree.dll"
			-- Name of library containing above entry points.

feature {NONE} -- Settings

	c_set_import_lookup_table (an_item: POINTER; i: INTEGER) is
			-- Set `ImportLookupTable' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access ImportLookupTable type DWORD use %"cli_writer.h%""
		end
	
	c_set_time_date_stamp (an_item: POINTER; i: INTEGER) is
			-- Set `TimeDateStamp' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access TimeDateStamp type DWORD use %"cli_writer.h%""
		end

	c_set_forwarder_chain (an_item: POINTER; i: INTEGER) is
			-- Set `ForwarderChain' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access ForwarderChain type DWORD use %"cli_writer.h%""
		end

	c_set_name_rva (an_item: POINTER; i: INTEGER) is
			-- Set `NameRVA' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access NameRVA type DWORD use %"cli_writer.h%""
		end

	c_set_iat_rva (an_item: POINTER; i: INTEGER) is
			-- Set `IatRVA' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access IatRVA type DWORD use %"cli_writer.h%""
		end

	c_set_import_by_name_rva (an_item: POINTER; i: INTEGER) is
			-- Set `ImportByNameRVA' to `i'.
		external
			"C struct CLI_IMPORT_TABLE access ImportByNameRVA type DWORD use %"cli_writer.h%""
		end

	c_entry_point_name (an_item: POINTER): POINTER is
			-- Access `EntryPointName'.
		external
			"C struct CLI_IMPORT_TABLE access EntryPointName use %"cli_writer.h%""
		end

	c_library_name (an_item: POINTER): POINTER is
			-- Access `LibraryName'.
		external
			"C struct CLI_IMPORT_TABLE access LibraryName use %"cli_writer.h%""
		end

end -- class CLI_IMPORT_TABLE
