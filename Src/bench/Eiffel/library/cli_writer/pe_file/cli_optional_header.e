indexing
	description: "Representation of PE optional header for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_OPTIONAL_HEADER

inherit
	WEL_STRUCTURE
		rename
			structure_size as count
		redefine
			make
		end

	CLI_UTILITIES
		export
			{NONE} all
			{ANY} file_alignment
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Allocate `item' and initialize default values for CLI.
		do
			Precursor {WEL_STRUCTURE}
			c_set_magic (item, 0x10B)
			c_set_major_linker_version (item, 6)
			c_set_minor_linker_version (item, 0)
			c_set_image_base (item, 0x400000)
			c_set_section_alignment (item, section_alignment)
			c_set_file_alignment (item, file_alignment)
			c_set_major_operating_system_version (item, 4)
			c_set_minor_operating_system_version (item, 0)
			c_set_major_image_version (item, 0)
			c_set_minor_image_version (item, 0)
			c_set_major_subsystem_version (item, 4)
			c_set_minor_subsystem_version (item, 0)
			c_set_win32_version_value (item, 0)
			c_set_check_sum (item, 0)
			c_set_dll_characteristics (item, 0)
			c_set_size_of_stack_reserve (item, 0x100000)
			c_set_size_of_stack_commit (item, 0x1000)
			c_set_size_of_heap_reserve (item, 0x100000)
			c_set_size_of_heap_commit (item, 0x1000)
			c_set_loader_flags (item, 0)
			c_set_number_of_rva_and_sizes (item, feature {CLI_DIRECTORY_CONSTANTS}.Image_number_of_directory_entries)
		end

feature -- Access

	directory (i: INTEGER): CLI_DIRECTORY is
			-- Retrieve `i-th' directory from current structure.
		local
			p: POINTER
		do
			p := c_directories (item)
			create Result.make_by_pointer (p + i * feature {CLI_DIRECTORY}.structure_size)
		end
		
feature -- Measurement

	count: INTEGER is
			-- Size of Current C structure.
		do
			Result := structure_size
		end
		
feature -- Settings

	set_code_size (i: INTEGER) is
			-- Set `code_size' to `i'.
		require
			valid_i: i > 0
			file_alignment_related: i \\ file_alignment = 0
		do
			c_set_size_of_code (item, i)
		end
		
	set_reloc_size (i: INTEGER) is
			-- Set `reloc_size' to `i'.
		require
			valid_i: i > 0
			file_alignment_related: i \\ file_alignment = 0
		do
			c_set_size_of_initialized_data (item, i)
		end

	set_subsystem (i: INTEGER_16) is
			-- Set `subsystem' to `i'.
		require
			valid_i: i = feature {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_console 
				or i = feature {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_gui
		do
			c_set_subsystem (item, i)
		end

	set_entry_point_rva (i: INTEGER) is
			-- Set `entry_point_rva' to `i'.
		do
			c_set_address_of_entry_point (item, i)
		end
		
	set_base_of_code (i: INTEGER) is
			-- Set `base_of_code' to `i'
		do
			c_set_base_of_code (item, i)
		end

	set_base_of_reloc (i: INTEGER) is
			-- Set `base_of_reloc' to `i'
		do
			c_set_base_of_data (item, i)
		end
		
	set_image_size (i: INTEGER) is
			-- Set `image_size' to `i'.
		do
			c_set_size_of_image (item, i)
		end
		
	set_headers_size (i: INTEGER) is
			-- Set `headers_size' to `i'.
		do
			c_set_size_of_headers (item, i)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER is
			-- Size of IMAGE_OPTIONAL_HEADER structure.
		external
			"C macro use <windows.h>"
		alias
			"sizeof(IMAGE_OPTIONAL_HEADER)"
		end

feature {NONE} -- Access

	c_directories (an_item: POINTER): POINTER is
			-- 
		external
			"C struct IMAGE_OPTIONAL_HEADER access &DataDirectory use <windows.h>"
		end
		
feature {NONE} -- Settings: standard fields

	c_set_magic (an_item: POINTER; i: INTEGER_16) is
			-- Set `Magic' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access Magic type WORD use <windows.h>"
		end

	c_set_major_linker_version (an_item: POINTER; i: INTEGER_8) is
			-- Set `MajorLinkerVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MajorLinkerVersion type BYTE use <windows.h>"
		end

	c_set_minor_linker_version (an_item: POINTER; i: INTEGER_8) is
			-- Set `MinorLinkerVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MinorLinkerVersion type BYTE use <windows.h>"
		end

	c_set_size_of_code (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfCode' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfCode type DWORD use <windows.h>"
		end

	c_set_size_of_initialized_data (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfInitializedData' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfInitializedData type DWORD use <windows.h>"
		end

	c_set_size_of_uninitialized_data (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfUninitializedData' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfUninitializedData type DWORD use <windows.h>"
		end

	c_set_address_of_entry_point (an_item: POINTER; i: INTEGER) is
			-- Set `AddressOfEntryPoint' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access AddressOfEntryPoint type DWORD use <windows.h>"
		end

	c_set_base_of_code (an_item: POINTER; i: INTEGER) is
			-- Set `BaseOfCode' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access BaseOfCode type DWORD use <windows.h>"
		end

	c_set_base_of_data (an_item: POINTER; i: INTEGER) is
			-- Set `BaseOfData' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access BaseOfData type DWORD use <windows.h>"
		end

feature {NONE} -- Settings: NT additional fields

	c_set_image_base (an_item: POINTER; i: INTEGER) is
			-- Set `ImageBase' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access ImageBase type DWORD use <windows.h>"
		end

	c_set_section_alignment (an_item: POINTER; i: INTEGER) is
			-- Set `SectionAlignment' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SectionAlignment type DWORD use <windows.h>"
		end

	c_set_file_alignment (an_item: POINTER; i: INTEGER) is
			-- Set `FileAlignment' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access FileAlignment type DWORD use <windows.h>"
		end

	c_set_major_operating_system_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MajorOperatingSystemVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MajorOperatingSystemVersion type WORD use <windows.h>"
		end

	c_set_minor_operating_system_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MinorOperatingSystemVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MinorOperatingSystemVersion type WORD use <windows.h>"
		end

	c_set_major_image_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MajorImageVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MajorImageVersion type WORD use <windows.h>"
		end

	c_set_minor_image_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MinorImageVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MinorImageVersion type WORD use <windows.h>"
		end

	c_set_major_subsystem_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MajorSubsystemVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MajorSubsystemVersion type WORD use <windows.h>"
		end

	c_set_minor_subsystem_version (an_item: POINTER; i: INTEGER_16) is
			-- Set `MinorSubsystemVersion' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access MinorSubsystemVersion type WORD use <windows.h>"
		end

	c_set_win32_version_value (an_item: POINTER; i: INTEGER) is
			-- Set `Win32VersionValue' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access Win32VersionValue type DWORD use <windows.h>"
		end

	c_set_size_of_image (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfImage' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfImage type DWORD use <windows.h>"
		end

	c_set_size_of_headers (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfHeaders' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfHeaders type DWORD use <windows.h>"
		end

	c_set_check_sum (an_item: POINTER; i: INTEGER) is
			-- Set `CheckSum' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access CheckSum type DWORD use <windows.h>"
		end

	c_set_subsystem (an_item: POINTER; i: INTEGER_16) is
			-- Set `Subsystem' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access Subsystem type WORD use <windows.h>"
		end

	c_set_dll_characteristics (an_item: POINTER; i: INTEGER_16) is
			-- Set `DllCharacteristics' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access DllCharacteristics type WORD use <windows.h>"
		end

	c_set_size_of_stack_reserve (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfStackReserve' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfStackReserve type DWORD use <windows.h>"
		end

	c_set_size_of_stack_commit (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfStackCommit' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfStackCommit type DWORD use <windows.h>"
		end

	c_set_size_of_heap_reserve (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfHeapReserve' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfHeapReserve type DWORD use <windows.h>"
		end

	c_set_size_of_heap_commit (an_item: POINTER; i: INTEGER) is
			-- Set `SizeOfHeapCommit' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access SizeOfHeapCommit type DWORD use <windows.h>"
		end

	c_set_loader_flags (an_item: POINTER; i: INTEGER) is
			-- Set `LoaderFlags' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access LoaderFlags type DWORD use <windows.h>"
		end

	c_set_number_of_rva_and_sizes (an_item: POINTER; i: INTEGER) is
			-- Set `NumberOfRvaAndSizes' to `i'.
		external
			"C struct IMAGE_OPTIONAL_HEADER access NumberOfRvaAndSizes type DWORD use <windows.h>"
		end

end -- class CLI_OPTIONAL_HEADER
