note
	description: "Representation of PE optional header for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_OPTIONAL_HEADER

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

	CLI_UTILITIES
		export
			{NONE} all
			{ANY} file_alignment
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Allocate `item' and initialize default values for CLI.
		do
			managed_pointer_make (structure_size)
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
			c_set_size_of_stack_reserve (item, 0x500000)
			c_set_size_of_stack_commit (item, 0x1000)
			c_set_size_of_heap_reserve (item, 0x100000)
			c_set_size_of_heap_commit (item, 0x1000)
			c_set_loader_flags (item, 0)
			c_set_number_of_rva_and_sizes (item, {CLI_DIRECTORY_CONSTANTS}.Image_number_of_directory_entries)
		end

feature -- Access

	directory (i: INTEGER): CLI_DIRECTORY
			-- Retrieve `i-th' directory from current structure.
		local
			p: POINTER
		do
			p := c_directories (item)
			create Result.make_by_pointer (p + i * {CLI_DIRECTORY}.structure_size)
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


feature -- Settings

	set_code_size (i: INTEGER)
			-- Set `code_size' to `i'.
		require
			valid_i: i > 0
			file_alignment_related: i \\ file_alignment = 0
		do
			c_set_size_of_code (item, i)
		end

	set_reloc_size (i: INTEGER)
			-- Set `reloc_size' to `i'.
		require
			valid_i: i > 0
			file_alignment_related: i \\ file_alignment = 0
		do
			c_set_size_of_initialized_data (item, i)
		end

	set_subsystem (i: INTEGER_16)
			-- Set `subsystem' to `i'.
		require
			valid_i: i = {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_console
				or i = {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_gui
		do
			c_set_subsystem (item, i)
		end

	set_entry_point_rva (i: INTEGER)
			-- Set `entry_point_rva' to `i'.
		do
			c_set_address_of_entry_point (item, i)
		end

	set_base_of_code (i: INTEGER)
			-- Set `base_of_code' to `i'
		do
			c_set_base_of_code (item, i)
		end

	set_base_of_reloc (i: INTEGER)
			-- Set `base_of_reloc' to `i'
		do
			c_set_base_of_data (item, i)
		end

	set_image_size (i: INTEGER)
			-- Set `image_size' to `i'.
		do
			c_set_size_of_image (item, i)
		end

	set_headers_size (i: INTEGER)
			-- Set `headers_size' to `i'.
		do
			c_set_size_of_headers (item, i)
		end

feature {NONE} -- Implementation

	structure_size: INTEGER
			-- Size of CLI_IMAGE_OPTIONAL_HEADER structure.
		external
			"C macro use %"cli_writer.h%""
		alias
			"sizeof(CLI_IMAGE_OPTIONAL_HEADER)"
		end

feature {NONE} -- Access

	c_directories (an_item: POINTER): POINTER
			--
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access &DataDirectory use %"cli_writer.h%""
		end

feature {NONE} -- Settings: standard fields

	c_set_magic (an_item: POINTER; i: INTEGER_16)
			-- Set `Magic' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access Magic type WORD use %"cli_writer.h%""
		end

	c_set_major_linker_version (an_item: POINTER; i: INTEGER_8)
			-- Set `MajorLinkerVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MajorLinkerVersion type BYTE use %"cli_writer.h%""
		end

	c_set_minor_linker_version (an_item: POINTER; i: INTEGER_8)
			-- Set `MinorLinkerVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MinorLinkerVersion type BYTE use %"cli_writer.h%""
		end

	c_set_size_of_code (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfCode' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfCode type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_initialized_data (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfInitializedData' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfInitializedData type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_uninitialized_data (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfUninitializedData' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfUninitializedData type DWORD use %"cli_writer.h%""
		end

	c_set_address_of_entry_point (an_item: POINTER; i: INTEGER)
			-- Set `AddressOfEntryPoint' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access AddressOfEntryPoint type DWORD use %"cli_writer.h%""
		end

	c_set_base_of_code (an_item: POINTER; i: INTEGER)
			-- Set `BaseOfCode' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access BaseOfCode type DWORD use %"cli_writer.h%""
		end

	c_set_base_of_data (an_item: POINTER; i: INTEGER)
			-- Set `BaseOfData' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access BaseOfData type DWORD use %"cli_writer.h%""
		end

feature {NONE} -- Settings: NT additional fields

	c_set_image_base (an_item: POINTER; i: INTEGER)
			-- Set `ImageBase' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access ImageBase type DWORD use %"cli_writer.h%""
		end

	c_set_section_alignment (an_item: POINTER; i: INTEGER)
			-- Set `SectionAlignment' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SectionAlignment type DWORD use %"cli_writer.h%""
		end

	c_set_file_alignment (an_item: POINTER; i: INTEGER)
			-- Set `FileAlignment' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access FileAlignment type DWORD use %"cli_writer.h%""
		end

	c_set_major_operating_system_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MajorOperatingSystemVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MajorOperatingSystemVersion type WORD use %"cli_writer.h%""
		end

	c_set_minor_operating_system_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MinorOperatingSystemVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MinorOperatingSystemVersion type WORD use %"cli_writer.h%""
		end

	c_set_major_image_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MajorImageVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MajorImageVersion type WORD use %"cli_writer.h%""
		end

	c_set_minor_image_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MinorImageVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MinorImageVersion type WORD use %"cli_writer.h%""
		end

	c_set_major_subsystem_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MajorSubsystemVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MajorSubsystemVersion type WORD use %"cli_writer.h%""
		end

	c_set_minor_subsystem_version (an_item: POINTER; i: INTEGER_16)
			-- Set `MinorSubsystemVersion' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access MinorSubsystemVersion type WORD use %"cli_writer.h%""
		end

	c_set_win32_version_value (an_item: POINTER; i: INTEGER)
			-- Set `Win32VersionValue' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access Win32VersionValue type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_image (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfImage' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfImage type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_headers (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfHeaders' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfHeaders type DWORD use %"cli_writer.h%""
		end

	c_set_check_sum (an_item: POINTER; i: INTEGER)
			-- Set `CheckSum' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access CheckSum type DWORD use %"cli_writer.h%""
		end

	c_set_subsystem (an_item: POINTER; i: INTEGER_16)
			-- Set `Subsystem' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access Subsystem type WORD use %"cli_writer.h%""
		end

	c_set_dll_characteristics (an_item: POINTER; i: INTEGER_16)
			-- Set `DllCharacteristics' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access DllCharacteristics type WORD use %"cli_writer.h%""
		end

	c_set_size_of_stack_reserve (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfStackReserve' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfStackReserve type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_stack_commit (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfStackCommit' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfStackCommit type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_heap_reserve (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfHeapReserve' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfHeapReserve type DWORD use %"cli_writer.h%""
		end

	c_set_size_of_heap_commit (an_item: POINTER; i: INTEGER)
			-- Set `SizeOfHeapCommit' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access SizeOfHeapCommit type DWORD use %"cli_writer.h%""
		end

	c_set_loader_flags (an_item: POINTER; i: INTEGER)
			-- Set `LoaderFlags' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access LoaderFlags type DWORD use %"cli_writer.h%""
		end

	c_set_number_of_rva_and_sizes (an_item: POINTER; i: INTEGER)
			-- Set `NumberOfRvaAndSizes' to `i'.
		external
			"C struct CLI_IMAGE_OPTIONAL_HEADER access NumberOfRvaAndSizes type DWORD use %"cli_writer.h%""
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

end -- class CLI_OPTIONAL_HEADER
