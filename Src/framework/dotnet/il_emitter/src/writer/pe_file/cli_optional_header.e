note
	description: "Representation of PE optional header for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=_IMAGE_OPTIONAL_HEADER ", "src=https://learn.microsoft.com/en-us/windows/win32/api/winnt/ns-winnt-image_optional_header32", "protocol=uri"
	Ecma_section: "II.25.2.3 PE optional header"

class
	CLI_OPTIONAL_HEADER

inherit

	CLI_UTILITIES
		export
			{NONE} all
			{ANY} file_alignment
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Allocate `item' and initialize default values for CLI.
		do
			set_magic (0x10B)
			set_major_linker_version (6)
			set_minor_linker_version (0)
			set_image_base (0x400000)
			set_section_alignment (section_alignment)
			set_file_alignment (file_alignment)
			set_major_operating_system_version (4)
			set_minor_operating_system_version (0)
			set_major_image_version (0)
			set_minor_image_version (0)
			set_major_subsystem_version (4)
			set_minor_subsystem_version (0)
			set_win32_version_value (0)
			set_check_sum (0)
			set_dll_characteristics (0)
			set_size_of_stack_reserve (0x500000)
			set_size_of_stack_commit (0x1000)
			set_size_of_heap_reserve (0x100000)
			set_size_of_heap_commit (0x1000)
			set_loader_flags (0)
			set_number_of_rva_and_sizes ({CLI_DIRECTORY_CONSTANTS}.Image_number_of_directory_entries)
			initialize_directories
		end

feature -- Access

	directory (i: INTEGER): CLI_DIRECTORY
			-- Retrieve `i-th' directory from current structure.
		do
			Result := data_directory [i]
		end

	magic: INTEGER_16
			-- The state of the image file.

	major_linker_version: INTEGER_8
			-- The major version number of the linker.

	minor_linker_version: INTEGER_8
			-- The minor version number of the linker.

	size_of_code: INTEGER
			-- The size of the code section, in bytes, or the sum of all such sections if there are multiple code sections.

	size_of_initialized_data: INTEGER
			-- The size of the initialized data section, in bytes, or the sum of all such sections if there are multiple initialized data sections.

	size_of_uninitialized_data: INTEGER
			-- The size of the uninitialized data section, in bytes, or the sum of all such sections if there are multiple uninitialized data sections.

	address_of_entry_point: INTEGER
			-- A pointer to the entry point function, relative to the image base address.
			-- For executable files, this is the starting address.
			-- For device drivers, this is the address of the initialization function. The entry point function is optional for DLLs. When no entry point is present, this member is zero.

	base_of_code: INTEGER
			-- A pointer to the beginning of the code section, relative to the image base.

	base_of_data: INTEGER
			-- A pointer to the beginning of the data section, relative to the image base.

	image_base: INTEGER
			-- The preferred address of the first byte of the image when it is loaded in memory.
			-- This value is a multiple of 64K bytes. The default value for DLLs is 0x10000000.
			-- The default value for applications is 0x00400000, except on Windows CE where it is 0x00010000.

	section_alignment_elem: INTEGER
			-- The alignment of sections loaded in memory, in bytes.
			-- This value must be greater than or equal to the FileAlignment member.
			-- The default value is the page size for the system.

	file_alignment_elem: INTEGER
			-- The alignment of the raw data of sections in the image file, in bytes. T
			-- The value should be a power of 2 between 512 and 64K (inclusive).
			-- The default is 512. If the SectionAlignment member is less than the system page size,
			-- this member must be the same as SectionAlignment.

	major_operating_system_version: INTEGER_16
			-- The major version number of the required operating system.

	minor_operating_system_version: INTEGER_16

	major_image_version: INTEGER_16

	minor_image_version: INTEGER_16

	major_subsystem_version: INTEGER_16

	minor_subsystem_version: INTEGER_16

	win32_version_value: INTEGER

	size_of_image: INTEGER
			-- The size of the image, in bytes, including all headers. Must be a multiple of SectionAlignment.

	size_of_headers: INTEGER
			-- The combined size of the following items, rounded to a multiple of the value specified in the FileAlignment member.

	check_sum: INTEGER

	subsystem: INTEGER_16
			-- The subsystem required to run this image.

	dll_characteristics: INTEGER_16

	size_of_stack_reserve: INTEGER

	size_of_stack_commit: INTEGER

	size_of_heap_reserve: INTEGER

	size_of_heap_commit: INTEGER

	loader_flags: INTEGER

	number_of_rva_and_sizes: INTEGER

	data_directory: ARRAYED_LIST [CLI_DIRECTORY]

feature -- Status Report

	count: INTEGER
			--  Number of elements that Current can hold.
		do
			Result := size_of
		end

feature -- Debug

	debug_header (a_name: STRING_32)
		local
			l_file: RAW_FILE
		do
			create l_file.make_create_read_write (a_name + ".bin")
			l_file.put_managed_pointer (item, 0, count)
			l_file.close
		end

feature -- Settings

	set_code_size (i: INTEGER)
			-- Set `code_size' to `i'.
		require
			valid_i: i > 0
			file_alignment_related: i \\ file_alignment = 0
		do
			size_of_code := i
		end

	set_reloc_size (i: INTEGER)
			-- Set `reloc_size' to `i'.
		require
			valid_i: i > 0
			file_alignment_related: i \\ file_alignment = 0
		do
			size_of_initialized_data := i
		end

	set_subsystem (i: INTEGER_16)
			-- Set `subsystem' to `i'.
		require
			valid_i: i = {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_console
				or i = {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_gui
		do
			subsystem := i
		end

	set_entry_point_rva (i: INTEGER)
			-- Set `entry_point_rva' to `i'.
		do
			address_of_entry_point := i
		end

	set_base_of_code (i: INTEGER)
			-- Set `base_of_code' to `i'
		do
			base_of_code := i
		end

	set_base_of_reloc (i: INTEGER)
			-- Set `base_of_reloc' to `i'
		do
			base_of_data := i
		end

	set_image_size (i: INTEGER)
			-- Set `image_size' to `i'.
		do
			size_of_image := i
		end

	set_headers_size (i: INTEGER)
			-- Set `headers_size' to `i'.
		do
			size_of_headers := i
		end

feature {NONE} -- Settings: standard fields

	set_magic (i: INTEGER_16)
			-- Set `magic' to `i'.
		do
			magic := i
		end

	set_major_linker_version (i: INTEGER_8)
			-- Set `major_linker_version' to `i'.
		do
			major_linker_version := i
		end

	set_minor_linker_version (i: INTEGER_8)
			-- Set `minor_linker_version' to `i'.
		do
			minor_linker_version := i
		end

	set_size_of_uninitialized_data (i: INTEGER)
			-- Set `size_of_uninitialized_data' to `i'.
		do
			size_of_uninitialized_data := i
		end

	c_set_address_of_entry_point (i: INTEGER)
			-- Set `address_of_entry_point' to `i'.
		do
			address_of_entry_point := i
		end

	c_set_base_of_code (i: INTEGER)
			-- Set `base_of_code' to `i'.
		do
			base_of_code := i
		end

	c_set_base_of_data (i: INTEGER)
			-- Set `base_of_data' to `i'.
		do
			base_of_data := i
		end

feature {NONE} -- Settings: NT additional fields

	set_image_base (i: INTEGER)
			-- Set `image_base' to `i'.
		do
			image_base := i
		end

	set_section_alignment (i: INTEGER)
			-- Set `section_alignment_elem' to `i'.
		do
			section_alignment_elem := i
		end

	set_file_alignment (i: INTEGER)
			-- Set `file_alignment_elem' to `i'.
		do
			file_alignment_elem := i
		end

	set_major_operating_system_version (i: INTEGER_16)
			-- Set `major_operating_system_version' to `i'.
		do
			major_operating_system_version := i
		end

	set_minor_operating_system_version (i: INTEGER_16)
			-- Set `minor_operating_system_version' to `i'.
		do
			minor_operating_system_version := i
		end

	set_major_image_version (i: INTEGER_16)
			-- Set `major_image_version' to `i'.
		do
			major_image_version := i
		end

	set_minor_image_version (i: INTEGER_16)
			-- Set `minor_image_version' to `i'.
		do
			minor_image_version := i
		end

	set_major_subsystem_version (i: INTEGER_16)
			-- Set `major_subsystem_version' to `i'.
		do
			major_subsystem_version := i
		end

	set_minor_subsystem_version (i: INTEGER_16)
			-- Set `minor_subsystem_version' to `i'.
		do
			minor_subsystem_version := i
		end

	set_win32_version_value (i: INTEGER)
			-- Set `win32_version_value' to `i'.
		do
			win32_version_value := i
		end

	set_size_of_image (i: INTEGER)
			-- Set `SizeOfImage' to `i'.
		do
			size_of_image := i
		end

	set_size_of_headers (i: INTEGER)
			-- Set `size_of_headers' to `i'.
		do
			size_of_headers := i
		end

	set_check_sum (i: INTEGER)
			-- Set `check_sum' to `i'.
		do
			check_sum := i
		end

	set_dll_characteristics (i: INTEGER_16)
			-- Set `dll_characteristics' to `i'.
		do
			dll_characteristics := i
		end

	set_size_of_stack_reserve (i: INTEGER)
			-- Set `size_of_stack_reserve' to `i'.
		do
			size_of_stack_reserve := i
		end

	set_size_of_stack_commit (i: INTEGER)
			-- Set `size_of_stack_commit' to `i'.
		do
			size_of_stack_commit := i
		end

	set_size_of_heap_reserve (i: INTEGER)
			-- Set `size_of_stack_commit' to `i'.
		do
			size_of_heap_reserve := i
		end

	set_size_of_heap_commit (i: INTEGER)
			-- Set `size_of_heap_commit' to `i'.
		do
			size_of_heap_commit := i
		end

	set_loader_flags (i: INTEGER)
			-- Set `loader_flags' to `i'.
		do
			loader_flags := i
		end

	set_number_of_rva_and_sizes (i: INTEGER)
			-- Set `number_of_rva_and_sizes' to `i'.
		do
			number_of_rva_and_sizes := i
		end

feature {NONE} -- Initialize Directory

	initialize_directories
		do
			create data_directory.make ({CLI_DIRECTORY_CONSTANTS}.Image_number_of_directory_entries)
			across 1 |..| {CLI_DIRECTORY_CONSTANTS}.Image_number_of_directory_entries as i loop
				data_directory.force (create {CLI_DIRECTORY}.make)
			end
		end

feature -- Managed Pointer

	item: MANAGED_POINTER
			-- write the items to the buffer in little-endian format.
		local
			l_pos: INTEGER
		do
			create Result.make (size_of)
			l_pos := 0

				-- magic
			Result.put_integer_16_le (magic, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- major_linker_version
			Result.put_integer_8_le (major_linker_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_8_bytes

				-- minor_linker_version
			Result.put_integer_8_le (minor_linker_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_8_bytes

				-- size_of_code
			Result.put_integer_32_le (size_of_code, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_initialized_data
			Result.put_integer_32_le (size_of_initialized_data, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_uninitialized_data
			Result.put_integer_32_le (size_of_uninitialized_data, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- address_of_entry_point
			Result.put_integer_32_le (address_of_entry_point, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- base_of_code
			Result.put_integer_32_le (base_of_code, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- base_of_data
			Result.put_integer_32_le (base_of_data, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- image_base
			Result.put_integer_32_le (image_base, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- section_alignment
			Result.put_integer_32_le (section_alignment, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- file_alignment_elem
			Result.put_integer_32_le (file_alignment_elem, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- major_operating_system_version
			Result.put_integer_16_le (major_operating_system_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- minor_operating_system_version
			Result.put_integer_16_le (minor_operating_system_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- major_image_version
			Result.put_integer_16_le (major_image_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- minor_image_version
			Result.put_integer_16_le (minor_image_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- major_subsystem_version
			Result.put_integer_16_le (major_subsystem_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- minor_subsystem_version
			Result.put_integer_16_le (minor_subsystem_version, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- win32_version_value
			Result.put_integer_32_le (win32_version_value, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_image
			Result.put_integer_32_le (size_of_image, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_headers
			Result.put_integer_32_le (size_of_headers, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- check_sum
			Result.put_integer_32_le (check_sum, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- subsystem
			Result.put_integer_16_le (subsystem, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- dll_characteristics
			Result.put_integer_16_le (dll_characteristics, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_16_bytes

				-- size_of_stack_reserve
			Result.put_integer_32_le (size_of_stack_reserve, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_stack_commit
			Result.put_integer_32_le (size_of_stack_commit, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_heap_reserve
			Result.put_integer_32_le (size_of_heap_reserve, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- size_of_heap_commit
			Result.put_integer_32_le (size_of_heap_commit, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- loader_flags
			Result.put_integer_32_le (loader_flags, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- number_of_rva_and_sizes
			Result.put_integer_32_le (number_of_rva_and_sizes, l_pos)
			l_pos := l_pos + {PLATFORM}.integer_32_bytes

				-- Write the Array of data directory as pointers.
			across data_directory as i loop
				Result.put_array (i.item.read_array (0, {CLI_DIRECTORY}.size_of), l_pos)
				l_pos := l_pos + {CLI_DIRECTORY}.size_of
			end
		end

feature -- Size

	size_of: INTEGER_32
			-- Size of the structure.
		do
				-- magic
			Result := {PLATFORM}.integer_16_bytes

				-- major_linker_version
			Result := Result + {PLATFORM}.integer_8_bytes

				-- minor_linker_version
			Result := Result + {PLATFORM}.integer_8_bytes

				-- size_of_code
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_initialized_data
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_uninitialized_data
			Result := Result + {PLATFORM}.integer_32_bytes

				-- address_of_entry_point
			Result := Result + {PLATFORM}.integer_32_bytes

				-- base_of_code
			Result := Result + {PLATFORM}.integer_32_bytes

				-- base_of_data
			Result := Result + {PLATFORM}.integer_32_bytes

				-- image_base
			Result := Result + {PLATFORM}.integer_32_bytes

				-- section_alignment
			Result := Result + {PLATFORM}.integer_32_bytes

				-- file_alignment_elem
			Result := Result + {PLATFORM}.integer_32_bytes

				-- major_operating_system_version
			Result := Result + {PLATFORM}.integer_16_bytes

				-- minor_operating_system_version
			Result := Result + {PLATFORM}.integer_16_bytes

				-- major_image_version
			Result := Result + {PLATFORM}.integer_16_bytes

				-- minor_image_version
			Result := Result + {PLATFORM}.integer_16_bytes

				-- major_subsystem_version
			Result := Result + {PLATFORM}.integer_16_bytes

				-- minor_subsystem_version
			Result := Result + {PLATFORM}.integer_16_bytes

				-- win32_version_value
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_image
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_headers
			Result := Result + {PLATFORM}.integer_32_bytes

				-- check_sum
			Result := Result + {PLATFORM}.integer_32_bytes

				-- subsystem
			Result := Result + {PLATFORM}.integer_16_bytes

				-- dll_characteristics
			Result := Result + {PLATFORM}.integer_16_bytes

				-- size_of_stack_reserve
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_stack_commit
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_heap_reserve
			Result := Result + {PLATFORM}.integer_32_bytes

				-- size_of_heap_commit
			Result := Result + {PLATFORM}.integer_32_bytes

				-- loader_flags
			Result := Result + {PLATFORM}.integer_32_bytes

				-- number_of_rva_and_sizes
			Result := Result + {PLATFORM}.integer_32_bytes

				-- data_directory
			Result := Result + {CLI_DIRECTORY_CONSTANTS}.Image_number_of_directory_entries * {CLI_DIRECTORY}.size_of

		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class CLI_OPTIONAL_HEADER
