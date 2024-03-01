﻿note
	description: "In memory representation of a PE file for CLI."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PE_FILE

inherit
	CLI_PE_FILE_I

	MD_UTILITIES
		export
			{NONE} padding, file_alignment
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like file_name; console_app, dll_app, is_32bits_app: BOOLEAN; e: like emitter)
			-- Create new PE file with name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			valid_app_type: dll_app implies console_app
			emitter_attached: attached e
		local
			l_characteristics: INTEGER_16
		do
			is_valid := True
			file_name := a_name
			is_dll := dll_app
			is_console := console_app
			is_32bits := is_32bits_app
			emitter := e

				-- PE file header basic initialization.
			create pe_header.make
			pe_header.set_number_of_sections (2)
			l_characteristics := {CLI_PE_FILE_CONSTANTS}.Image_file_32bit_machine |
				{CLI_PE_FILE_CONSTANTS}.Image_file_executable_image |
				{CLI_PE_FILE_CONSTANTS}.Image_file_line_nums_stripped |
				{CLI_PE_FILE_CONSTANTS}.Image_file_local_syms_stripped
			if is_dll then
				l_characteristics := l_characteristics | {CLI_PE_FILE_CONSTANTS}.Image_file_dll
			end
			pe_header.set_characteristics (l_characteristics)

				-- PE optional header basic initialization.
			create optional_header.make
			if is_console then
				optional_header.set_subsystem (
					{CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_console)
			else
				optional_header.set_subsystem (
					{CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_gui)
			end

			create text_section_header.make (".text")
			create reloc_section_header.make (".reloc")

			create iat.make

			create import_table.make (is_dll)

			create cli_header.make (is_32bits)

			create entry_data.make

			create reloc_section.make

			debug ("cli_writer_dbg")
				write_debug
			end
		ensure
			file_name_set: file_name = a_name
			is_valid_set: is_valid
			is_console_set: is_console = console_app
			is_dll_set: is_dll = dll_app
		end

	write_debug
		do
			pe_header.debug_header ("pe_header_com")
			optional_header.debug_header ("optional_header_com")
			text_section_header.debug_header ("text_section_header_com")
			reloc_section_header.debug_header ("reloc_section_header_com")
			iat.debug_header ("iat_com")
			import_table.debug_header("import_table_com")
			cli_header.debug_header ("cli_header_com")
			entry_data.debug_header ("entry_data_com")
			reloc_section.debug_header ("reloc_section_com")
		end

feature -- Status

	is_valid: BOOLEAN
			-- Is Current PE file still valid, i.e. not yet saved to disk?

	is_console: BOOLEAN
			-- Is current application a console one?

	is_dll: BOOLEAN
			-- Is current application a DLL?

	is_32bits: BOOLEAN
			-- Is current application a 32bit application?

	file_name: READABLE_STRING_32
			-- Name of current PE file on disk.

	has_strong_name: BOOLEAN
			-- Does current have a strong name signature?

	cli_header_has_flag_strong_name_signed: BOOLEAN
			-- Has CLI Header flag "strong_name_signed" ?
		do
			Result := (cli_header.flags & {CLI_HEADER}.strong_name_signed) = {CLI_HEADER}.strong_name_signed
		end

	has_resources: BOOLEAN
			-- Does current have some resources attached?
		do
			Result := resources /= Void
		end

feature -- Access

	pe_header: CLI_PE_FILE_HEADER
			-- PE File header.

	optional_header: CLI_OPTIONAL_HEADER
			-- PE optional header.

	text_section_header: CLI_SECTION_HEADER
	reloc_section_header: CLI_SECTION_HEADER
	iat: CLI_IMPORT_ADDRESS_TABLE

	code: detachable MANAGED_POINTER
			-- CLI code instruction stream.

	codeview_debug_directory: detachable CLI_DEBUG_DIRECTORY
	codeview_debug_info: detachable MANAGED_POINTER
			-- Data for storing codeview debug information in PE files.

	checksum_debug_directory: detachable CLI_DEBUG_DIRECTORY
	checksum_debug_info: detachable MANAGED_POINTER
	reproducible_debug_directory: detachable CLI_DEBUG_DIRECTORY
			-- Data for storing pdb checksum debug information in PE files.	

	strong_name_directory: detachable CLI_DIRECTORY
	strong_name_info: detachable MANAGED_POINTER
	public_key: detachable MD_PUBLIC_KEY
	signing: detachable MD_STRONG_NAME
			-- Hold data for strong name signature.

	resources: detachable CLI_RESOURCES
			-- Hold data for resources.

	cli_header: CLI_HEADER
			-- Header for `meta_data'.

	method_writer: detachable MD_METHOD_WRITER
			-- To hold IL code.

	emitter: MD_EMIT_I
			-- Meta data emitter, needed for RVA update.

	import_table: CLI_IMPORT_TABLE

	entry_data: CLI_ENTRY
			-- Data about entry point.

	reloc_section: CLI_IMAGE_RELOCATION
			-- Relocation section.

feature -- Settings

	set_method_writer (m: like method_writer)
			-- Set `method_writer' to `m'.
		do
			method_writer := m
		end

	set_entry_point_token (token: INTEGER)
			-- Set `token' as entry point of current CLI image.
		do
			cli_header.set_entry_point_token (token)
		end

	set_codeview_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY;
			a_debug_info: MANAGED_POINTER)

			-- Set `debug_directory' to `a_cli_debug_directory' and `debug_info'
			-- to `a_debug_info'.
		do
			codeview_debug_directory := a_cli_debug_directory
			codeview_debug_info := a_debug_info
		end

	set_checksum_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY;
			a_checksum_info: MANAGED_POINTER)

			-- Set `checksum_debug_directory' to `a_cli_debug_directory' and `checksum_info'
			-- to `a_checksum_info'.
		do
			if a_checksum_info.count = 0 then
				checksum_debug_directory := Void
				checksum_debug_info := Void
			else
				checksum_debug_directory := a_cli_debug_directory
				checksum_debug_info := a_checksum_info
			end
		end

	set_reproducible_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY)
				-- Set `reproducible_debug_information' to `a_cli_debug_directory'
		do
			reproducible_debug_directory := a_cli_debug_directory
		end

	set_public_key (a_key: like public_key; a_signing: like signing)
			-- Set `public_key' to `a_key'.
		do
			public_key := a_key
			has_strong_name := True
			cli_header.add_flags ({CLI_HEADER}.strong_name_signed)
			signing := a_signing
		end

	set_resources (r: like resources)
			-- Set `resources' with `r'
		do
			resources := r
		end

feature -- Saving

	save
			--
		local
			l_pe_file, l_meta_data_file: RAW_FILE
			l_padding, l_signature: MANAGED_POINTER
			l_strong_name_location, l_size: INTEGER
			l_uni_string: CLI_STRING
			l_meta_data_file_name: like file_name
		do
				-- First compute size of PE file headers and sections.
			compute_sizes

				-- Let's update PE data structures with proper RVAs
			update_rvas

				-- Write to file now.
			create l_pe_file.make_with_name (file_name)
			l_pe_file.open_write

				-- First the headers
			l_pe_file.put_managed_pointer (dos_header, 0, dos_header.count)
			l_pe_file.put_managed_pointer (pe_header, 0, pe_header.count)
			l_pe_file.put_managed_pointer (optional_header, 0, optional_header.count)
			l_pe_file.put_managed_pointer (text_section_header, 0, text_section_header.count)
			l_pe_file.put_managed_pointer (reloc_section_header, 0, reloc_section_header.count)

				-- Add padding to .text section
			create l_padding.make (padding (headers_size, file_alignment))
			l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)

				-- Store .text section
			l_pe_file.put_managed_pointer (iat, 0, iat.count)
			l_pe_file.put_managed_pointer (cli_header, 0, cli_header.count)
			if attached method_writer as l_method_writer then
					-- No need for padding as it is correctly aligned of 4 bytes
				check
					correctly_aligned: (iat.count + cli_header.count) \\ 4 = 0
				end
				l_pe_file.put_managed_pointer (l_method_writer.item, 0, code_size)
			end

			if
				attached codeview_debug_directory as d and then
				attached codeview_debug_info as i
			then
				l_pe_file.put_managed_pointer (d, 0, d.count)
				l_pe_file.put_managed_pointer (i, 0, i.count)
				l_size := padding (d.count + i.count, 16)
				if l_size > 0 then
					create l_padding.make (l_size)
					l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)
				end
			end

			if has_strong_name then
				l_strong_name_location := l_pe_file.count
				create l_padding.make (strong_name_size)
				l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)
			end

			if attached resources as r and then attached r.item as p then
					-- Store `resources.item' since otherwise no one will be referencing
					-- it and thus ready for GC.
				l_pe_file.put_managed_pointer (p, 0, resources_size)
			end

				-- Save the metadata to `l_pe_file'. We cannot use `MD_EMIT.assembly_memory'
				-- because on some platforms the amount of required memory cannot be allocated
				-- in one chunk.
				-- Instead we save it to disk and then copy it over. This is not efficient
				-- but we cannot use the stream version of the API since we do not have a way
				-- to make an IStream from an Eiffel FILE.
			l_meta_data_file_name := file_name + ".pe"
			emitter.save (create {CLI_STRING}.make (l_meta_data_file_name))
			create l_meta_data_file.make_with_name (l_meta_data_file_name)
			l_meta_data_file.open_read
			check valid_size: l_meta_data_file.count = meta_data_size end
			l_meta_data_file.copy_to (l_pe_file)
			l_meta_data_file.close
			l_meta_data_file.delete

			if import_table_padding > 0 then
				create l_padding.make (import_table_padding)
				l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)
			end
			l_pe_file.put_managed_pointer (import_table, 0, import_table.count)
			l_pe_file.put_managed_pointer (entry_data, 0, entry_data.count)

				-- Add padding to .text section
			create l_padding.make (padding (text_size, file_alignment))
			l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)

				-- Store .reloc section
			l_pe_file.put_managed_pointer (reloc_section, 0, reloc_section.count)

				-- Add padding to end of file
			create l_padding.make (padding (reloc_size, file_alignment))
			l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)

			l_pe_file.close
			is_valid := False

			if
				has_strong_name and
				attached signing as l_signing and
				attached public_key as l_public_key
			then
				create l_pe_file.make_with_name (file_name)
				l_pe_file.open_read
				create l_padding.make (l_pe_file.count)
				l_pe_file.read_to_managed_pointer (l_padding, 0, l_padding.count)
				l_pe_file.close

				create l_uni_string.make (file_name)
				l_signature := l_signing.assembly_signature (l_uni_string, l_public_key.key_pair)
				(l_padding.item + l_strong_name_location).memory_copy (l_signature.item,
					l_signature.count)

				create l_pe_file.make_with_name (file_name)
				l_pe_file.open_write
				l_pe_file.put_managed_pointer (l_padding, 0, l_padding.count)
				l_pe_file.close
			end
		end

feature {NONE} -- Saving

	compute_sizes
			-- Compute sizes and basic locations of headers and sections,
			-- both real, on disk and in memory.
		do
				-- Size of meta data and code.
			meta_data_size := emitter.save_size

			if attached method_writer as l_method_writer then
				code_size := l_method_writer.count
			else
				code_size := 0
			end

			if
				attached codeview_debug_directory as d and then
				attached codeview_debug_info as i
			then
				debug_size := pad_up (d.count + i.count, 16)
			else
				debug_size := 0
			end

			if
				has_strong_name and
				attached signing as l_signing and then
				attached public_key as l_public_key
			then
				strong_name_size := l_signing.assembly_signature_size (l_public_key.item)
			else
				strong_name_size := 0
			end

			if has_resources and attached resources as l_resources then
				resources_size := l_resources.count
			else
				resources_size := 0
			end

				-- Real size of all components
			headers_size := dos_header.count + pe_header.count +
				optional_header.count + text_section_header.count +
				reloc_section_header.count

			import_table_padding := pad_up (iat.count + cli_header.count + code_size +
					debug_size + strong_name_size + resources_size + meta_data_size, 16) -
				(iat.count + cli_header.count + code_size + debug_size +
					strong_name_size + resources_size + meta_data_size)

			text_size := iat.count + cli_header.count + code_size + debug_size +
				strong_name_size + resources_size + meta_data_size +
				import_table_padding + import_table.count + entry_data.count

			reloc_size := reloc_section.count

				-- Size of `.text' and `.reloc' section on disk.
			headers_size_on_disk := pad_up (headers_size, file_alignment)
			text_size_on_disk := pad_up (text_size, file_alignment)
			reloc_size_on_disk := pad_up (reloc_size, file_alignment)

				-- RVA of `.text' and `.reloc'.
			text_rva := pad_up (headers_size, Section_alignment)
			reloc_rva := pad_up (text_rva + text_size_on_disk, Section_alignment)
			code_rva := text_rva + iat.count + cli_header.count

			import_directory_rva := text_rva + iat.count + cli_header.count + code_size +
				debug_size + strong_name_size + resources_size + meta_data_size +
				import_table_padding
		end

	update_rvas
			-- Update all PE files data structures with correct RVAs.
		local
			import_directory, reloc_directory,
			iat_directory, cli_directory, l_debug_directory: CLI_DIRECTORY
		do
				-- Update optional header section.
			optional_header.set_code_size (text_size_on_disk)
			optional_header.set_reloc_size (reloc_size_on_disk)
			optional_header.set_entry_point_rva (text_rva + iat.count +
				cli_header.count + code_size + debug_size + strong_name_size + resources_size +
				meta_data_size + import_table_padding +
				import_table.count + entry_data.start_position)
			optional_header.set_base_of_code (text_rva)
			optional_header.set_base_of_reloc (reloc_rva)
			optional_header.set_image_size (reloc_rva + pad_up (reloc_size, Section_alignment))
			optional_header.set_headers_size (pad_up (headers_size, file_alignment))

			import_directory := optional_header.directory (
					{CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_import)
			import_directory.set_rva (import_directory_rva)
			import_directory.set_data_size (import_table.count - 1)

			reloc_directory := optional_header.directory (
					{CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_basereloc)
			reloc_directory.set_rva (reloc_rva)
			reloc_directory.set_data_size (reloc_size)

			if
				attached codeview_debug_directory as d and then
				attached codeview_debug_info as i
			then
				l_debug_directory := optional_header.directory (
						{CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_debug)
				l_debug_directory.set_rva (text_rva + iat.count + cli_header.count + code_size)
				l_debug_directory.set_data_size (d.count)

				d.set_address_of_data (text_rva + iat.count + cli_header.count +
					code_size + d.count)
				d.set_pointer_to_data (headers_size_on_disk + iat.count +
					cli_header.count + code_size + d.count)
				d.set_size (i.count)
			end

			iat_directory := optional_header.directory (
					{CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_iat)
			iat_directory.set_rva (text_rva)
			iat_directory.set_data_size (iat.count)

			cli_directory := optional_header.directory (
					{CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_cli_descriptor)
			cli_directory.set_rva (text_rva + iat.count)
			cli_directory.set_data_size (cli_header.count)

				-- Update section headers
			text_section_header.set_virtual_size (pad_up (text_size, 4))
			text_section_header.set_virtual_address (text_rva)
			text_section_header.set_raw_data_size (text_size_on_disk)
			text_section_header.set_pointer_to_raw_data (headers_size_on_disk)
			text_section_header.set_characteristics (
				{CLI_SECTION_CONSTANTS}.code |
				{CLI_SECTION_CONSTANTS}.execute |
				{CLI_SECTION_CONSTANTS}.read)

			reloc_section_header.set_virtual_size (pad_up (reloc_size, 4))
			reloc_section_header.set_virtual_address (reloc_rva)
			reloc_section_header.set_raw_data_size (reloc_size_on_disk)
			reloc_section_header.set_pointer_to_raw_data (headers_size_on_disk + text_size_on_disk)
			reloc_section_header.set_characteristics (
				{CLI_SECTION_CONSTANTS}.initialized_data |
				{CLI_SECTION_CONSTANTS}.discardable |
				{CLI_SECTION_CONSTANTS}.read)

				-- CLI header.
			if has_strong_name then
				cli_header.strong_name_directory.set_rva_and_size (text_rva + iat.count +
					cli_header.count + code_size + debug_size, strong_name_size)
			end

			if has_resources then
				cli_header.resources_directory.set_rva_and_size (text_rva + iat.count +
					cli_header.count + code_size + debug_size + strong_name_size, resources_size)
			end

			cli_header.meta_data_directory.set_rva_and_size (text_rva + iat.count +
				cli_header.count + code_size + debug_size + strong_name_size + resources_size,
				meta_data_size)

				-- Setting of import table.
			iat.set_import_by_name_rva (text_rva + iat.count + cli_header.count + code_size +
				+ debug_size + strong_name_size + resources_size + meta_data_size +
				import_table_padding + import_table.Size_to_import_by_name)
			import_table.set_rvas (text_rva, text_rva + iat.count + cli_header.count +
				code_size + debug_size + strong_name_size + resources_size + meta_data_size +
				import_table_padding)

				-- Entry point setting
			entry_data.set_iat_rva (text_rva)

				-- Reloc section
			reloc_section.set_data (text_rva + iat.count + cli_header.count + code_size +
				debug_size + strong_name_size + resources_size + meta_data_size +
				import_table_padding + import_table.count +
				entry_data.jump_size)

				-- Set method RVAs now.
			if attached method_writer as l_method_writer then
				l_method_writer.update_rvas (emitter, code_rva)
			end
		end

feature {NONE} -- Implementation

	dos_header: MANAGED_POINTER
			-- DOS header.
		once
			create Result.make_from_array ({ARRAY [NATURAL_8]} <<
					0x4D, 0x5A, 0x90, 0x00, 0x03, 0x00, 0x00, 0x00,
					0x04, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00,
					0xB8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00,
					0x0E, 0x1F, 0xBA, 0x0E, 0x00, 0xB4, 0x09, 0xCD,
					0x21, 0xB8, 0x01, 0x4C, 0xCD, 0x21, 0x54, 0x68,
					0x69, 0x73, 0x20, 0x70, 0x72, 0x6F, 0x67, 0x72,
					0x61, 0x6D, 0x20, 0x63, 0x61, 0x6E, 0x6E, 0x6F,
					0x74, 0x20, 0x62, 0x65, 0x20, 0x72, 0x75, 0x6E,
					0x20, 0x69, 0x6E, 0x20, 0x44, 0x4F, 0x53, 0x20,
					0x6D, 0x6F, 0x64, 0x65, 0x2E, 0x0D, 0x0D, 0x0A,
					0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x50, 0x45, 0x00, 0x00
				>>)
		ensure
			valid_size: dos_header.count = 132
		end

	headers_size, text_size, reloc_size: INTEGER
	headers_size_on_disk, text_size_on_disk, reloc_size_on_disk: INTEGER
	text_rva, code_rva, reloc_rva: INTEGER
			-- Size information about current PE.

	debug_size, strong_name_size, meta_data_size, code_size: INTEGER
	resources_size: INTEGER

	import_table_padding: INTEGER
			-- Padding added before `import_table' so that it is aligned on 16 bytes boundaries.

	import_directory_rva: INTEGER
			-- RVA of import table.

invariant
	file_name_not_void: is_valid implies file_name /= Void
	file_name_not_empty: is_valid implies not file_name.is_empty
	dos_header_not_void: is_valid implies dos_header /= Void
	public_key_not_void: (is_valid and has_strong_name) implies public_key /= Void

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

end
