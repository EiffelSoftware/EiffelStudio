indexing
	description: "In memory representation of a PE file for CLI."
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_PE_FILE

inherit
	CLI_UTILITIES
		export
			{NONE} padding, file_alignment
		end
		
create
	make
	
feature {NONE} -- Initialization

	make (a_name: like file_name; console_app, dll_app: BOOLEAN) is
			-- Create new PE file with name `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			valid_app_type: dll_app implies console_app
		local
			l_characteristics: INTEGER_16
		do
			is_valid := True
			file_name := a_name
			is_dll := dll_app
			is_console := console_app
			
				-- PE file header basic initialization.
			create pe_header.make
			pe_header.set_number_of_sections (2)
			l_characteristics := feature {CLI_PE_FILE_CONSTANTS}.Image_file_32bit_machine |
				feature {CLI_PE_FILE_CONSTANTS}.Image_file_executable_image |		
				feature {CLI_PE_FILE_CONSTANTS}.Image_file_line_nums_stripped |
				feature {CLI_PE_FILE_CONSTANTS}.Image_file_local_syms_stripped
			if is_dll then
				l_characteristics := l_characteristics | feature {CLI_PE_FILE_CONSTANTS}.Image_file_dll
			end
			pe_header.set_characteristics (l_characteristics)

				-- PE optional header basic initialization.
			create optional_header.make
			if is_console then
				optional_header.set_subsystem (
					feature {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_console)
			else
				optional_header.set_subsystem (
					feature {CLI_PE_FILE_CONSTANTS}.Image_subsystem_windows_gui)
			end
				
			create text_section_header.make (".text")
			create reloc_section_header.make (".reloc")
			
			create iat.make
			
			create import_table.make (is_dll)
			
			create cli_header.make
			
			create entry_data.make
			
			create reloc_section.make
		ensure
			file_name_set: file_name = a_name
			is_valid_set: is_valid
			is_console_set: is_console = console_app
			is_dll_set: is_dll = dll_app
		end

feature -- Status

	is_valid: BOOLEAN
			-- Is Current PE file still valid, i.e. not yet saved to disk?
			
	is_console: BOOLEAN
			-- Is current application a console one?
			
	is_dll: BOOLEAN
			-- Is current application a DLL?

	file_name: STRING
			-- Name of current PE file on disk.

	has_debug_info: BOOLEAN
			-- Does current have some debug info?

	has_strong_name: BOOLEAN
			-- Does current have a strong name signature?

feature -- Access

	pe_header: CLI_PE_FILE_HEADER
			-- PE File header.
			
	optional_header: CLI_OPTIONAL_HEADER
			-- PE optional header.

	text_section_header: CLI_SECTION_HEADER
	reloc_section_header: CLI_SECTION_HEADER
	iat: CLI_IMPORT_ADDRESS_TABLE

	code: MANAGED_POINTER
			-- CLI code instruction stream.

	debug_directory: CLI_DEBUG_DIRECTORY
	debug_info: MANAGED_POINTER
			-- Data for storing debug information in PE files.

	strong_name_directory: CLI_DIRECTORY
	strong_name_info: MANAGED_POINTER
	public_key: MD_PUBLIC_KEY
			-- Hold data for strong name signature.

	cli_header: CLI_HEADER
			-- Header for `meta_data'.
			
	method_writer: MD_METHOD_WRITER
			-- To hold IL code.

	emitter: MD_EMIT
			-- Meta data emitter, needed for RVA update.
	
	import_table: CLI_IMPORT_TABLE
	
	entry_data: CLI_ENTRY
			-- Data about entry point.
			
	reloc_section: CLI_IMAGE_RELOCATION
			-- Relocation section.
			
feature -- Settings
		
	set_method_writer (m: like method_writer) is
			-- Set `method_writer' to `m'.
		require
			m_not_void: m /= Void
		do
			method_writer := m
		ensure
			method_writer_set: method_writer = m
		end
		
	set_emitter (e: like emitter) is
			-- Set `emitter' to `e'.
		require
			e_not_void: e /= Void
		do
			emitter := e
		ensure
			emitter_set: emitter = e
		end
		
	set_entry_point_token (token: INTEGER) is
			-- Set `token' as entry point of current CLI image.
		require
			token_not_null: token /= 0
		do
			cli_header.set_entry_point_token (token)
		end

	set_debug_information (a_cli_debug_directory: CLI_DEBUG_DIRECTORY;
			a_debug_info: MANAGED_POINTER)
		is
			-- Set `debug_directory' to `a_cli_debug_directory' and `debug_info'
			-- to `a_debug_info'.
		require
			a_cli_debug_directory_not_void: a_cli_debug_directory /= Void
			a_debug_info_not_void: a_debug_info /= Void
		do
			debug_directory := a_cli_debug_directory
			debug_info := a_debug_info
			has_debug_info := True
		ensure
			debug_directory_set: debug_directory = a_cli_debug_directory
			debug_info_set: debug_info = a_debug_info
		end
	
	set_public_key (a_key: like public_key) is
			-- Set `public_key' to `a_key'.
		require
			key_not_void: a_key /= Void
			key_valid: a_key.item.count > 0
		do
			public_key := a_key
			has_strong_name := True
			cli_header.set_flags (feature {CLI_HEADER}.il_only |
				feature {CLI_HEADER}.strong_name_signed)
		ensure
			public_key_set: public_key = a_key
			has_strong_name_set: has_strong_name
			cli_header_flags_set: cli_header.flags = 
				feature {CLI_HEADER}.il_only | feature {CLI_HEADER}.strong_name_signed
		end

feature -- Saving

	save is
			-- 
		local
			l_pe_file: RAW_FILE
			l_padding: MANAGED_POINTER
			l_ptr: POINTER
			l_strong_name_location, l_result, l_size: INTEGER
			l_uni_string: UNI_STRING
		do
				-- First compute size of PE file headers and sections.
			compute_sizes

				-- Let's update PE data structures with proper RVAs
			update_rvas

				-- Write to file now.
			create l_pe_file.make_open_write (file_name)
			
				-- First the headers
			l_pe_file.put_data (dos_header.item, dos_header.count)
			l_pe_file.put_data (pe_header.item, pe_header.count)
			l_pe_file.put_data (optional_header.item, optional_header.count)
			l_pe_file.put_data (text_section_header.item, text_section_header.count)
			l_pe_file.put_data (reloc_section_header.item, reloc_section_header.count)

				-- Add padding to .text section
			create l_padding.make (padding (headers_size, file_alignment))
			l_pe_file.put_data (l_padding.item, l_padding.count)
			
				-- Store .text section
			l_pe_file.put_data (iat.item, iat.count)
			l_pe_file.put_data (cli_header.item, cli_header.count)
			if method_writer /= Void then
					-- No need for padding as it is correctly aligned of 4 bytes
				check
					correctly_aligned: (iat.count + cli_header.count) \\ 4 = 0
				end
				l_pe_file.put_data (method_writer.item, code_size)
			end
			
			if has_debug_info then
				l_pe_file.put_data (debug_directory.item, debug_directory.count)
				l_pe_file.put_data (debug_info.item, debug_info.count)
				create l_padding.make (padding (debug_directory.count + debug_info.count, 16))
				l_pe_file.put_data (l_padding.item, l_padding.count)
			end

			if has_strong_name then
				l_strong_name_location := l_pe_file.count
				create l_padding.make (strong_name_size)
				l_pe_file.put_data (l_padding.item, l_padding.count)
			end
			
			l_pe_file.put_data (emitter.assembly_memory.item, meta_data_size)
			
			if import_table_padding > 0 then
				create l_padding.make (import_table_padding)
				l_pe_file.put_data (l_padding.item, l_padding.count)
			end
			l_pe_file.put_data (import_table.item, import_table.count)
			l_pe_file.put_data (entry_data.item, entry_data.count)
			
				-- Add padding to .text section
			create l_padding.make (padding (text_size, file_alignment))
			l_pe_file.put_data (l_padding.item, l_padding.count)
			
				-- Store .reloc section
			l_pe_file.put_data (reloc_section.item, reloc_section.count)
			
				-- Add padding to end of file
			create l_padding.make (padding (reloc_size, file_alignment))
			l_pe_file.put_data (l_padding.item, l_padding.count)
			
			l_pe_file.close
			is_valid := False
			
			if has_strong_name then
				create l_pe_file.make_open_read (file_name)
				create l_padding.make (l_pe_file.count)
				l_pe_file.read_data (l_padding.item, l_padding.count)
				l_pe_file.close
				
				create l_uni_string.make (file_name)
				l_result := feature {MD_STRONG_NAME}.strong_name_signature_generation (
					l_uni_string.item, default_pointer, public_key.key_pair.item,
					public_key.key_pair.count, $l_ptr, $l_size)
					
				(l_padding.item + l_strong_name_location).memory_copy (l_ptr, l_size)
				
				create l_pe_file.make_open_write (file_name)
				l_pe_file.put_data (l_padding.item, l_padding.count)
				l_pe_file.close

				feature {MD_STRONG_NAME}.strong_name_free_buffer (l_ptr)
			end
			
		ensure
			not_is_valid: not is_valid
		end

feature {NONE} -- Saving

	compute_sizes is
			-- Compute sizes and basic locations of headers and sections,
			-- both real, on disk and in memory.
		local
			l_size: INTEGER
			l_result: INTEGER
		do
				-- Size of meta data and code.
			meta_data_size := emitter.save_size

			if method_writer /= Void then
				code_size := method_writer.count
			else
				code_size := 0
			end

			if has_debug_info then
				debug_size := pad_up (debug_directory.count + debug_info.count, 16)
			else
				debug_size := 0
			end

			if has_strong_name then
				l_result := feature {MD_STRONG_NAME}.strong_name_signature_size (
					public_key.item.item, public_key.item.count, $l_size)
				strong_name_size := l_size
			else
				strong_name_size := 0
			end

				-- Real size of all components
			headers_size := dos_header.count + pe_header.count +
				optional_header.count + text_section_header.count +
				reloc_section_header.count
			
			import_table_padding := pad_up (iat.count + cli_header.count + code_size +
				debug_size + strong_name_size + meta_data_size, 16) -
				(iat.count + cli_header.count + code_size + debug_size +
				strong_name_size + meta_data_size)

			text_size := iat.count + cli_header.count + code_size + debug_size +
				strong_name_size + meta_data_size +
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
				debug_size + strong_name_size + meta_data_size + import_table_padding
		end

	update_rvas is
			-- Update all PE files data structures with correct RVAs.
		local
			import_directory, reloc_directory,
			iat_directory, cli_directory, l_debug_directory: CLI_DIRECTORY
		do
				-- Update optional header section.
			optional_header.set_code_size (text_size_on_disk)
			optional_header.set_reloc_size (reloc_size_on_disk)
			optional_header.set_entry_point_rva (text_rva + iat.count +
				cli_header.count + code_size + debug_size + strong_name_size +
				meta_data_size + import_table_padding +
				import_table.count + entry_data.start_position)
			optional_header.set_base_of_code (text_rva)
			optional_header.set_base_of_reloc (reloc_rva)
			optional_header.set_image_size (reloc_rva + pad_up (reloc_size, Section_alignment))
			optional_header.set_headers_size (pad_up (headers_size, file_alignment))
			
			import_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_import)
			import_directory.set_rva (import_directory_rva)
			import_directory.set_data_size (import_table.count - 1)
			
			reloc_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_basereloc)
			reloc_directory.set_rva (reloc_rva)
			reloc_directory.set_data_size (reloc_size)

			if has_debug_info then
				l_debug_directory := optional_header.directory (
					feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_debug)
				l_debug_directory.set_rva (text_rva + iat.count + cli_header.count + code_size)
				l_debug_directory.set_data_size (debug_directory.count)
				
				debug_directory.set_address_of_data (text_rva + iat.count + cli_header.count +
					code_size + debug_directory.count)
				debug_directory.set_pointer_to_data (headers_size_on_disk + iat.count +
					cli_header.count + code_size + debug_directory.count)
				debug_directory.set_size (debug_info.count)
			end
			
			iat_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_iat)
			iat_directory.set_rva (text_rva)
			iat_directory.set_data_size (iat.count)
			
			cli_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_cli_descriptor)
			cli_directory.set_rva (text_rva + iat.count)
			cli_directory.set_data_size (cli_header.count)
			
				-- Update section headers
			text_section_header.set_virtual_size (pad_up (text_size, 4))
			text_section_header.set_virtual_address (text_rva)
			text_section_header.set_raw_data_size (text_size_on_disk)
			text_section_header.set_pointer_to_raw_data (headers_size_on_disk)
			text_section_header.set_characteristics (
				feature {CLI_SECTION_CONSTANTS}.code |
				feature {CLI_SECTION_CONSTANTS}.execute |
				feature {CLI_SECTION_CONSTANTS}.read)

			reloc_section_header.set_virtual_size (pad_up (reloc_size, 4))
			reloc_section_header.set_virtual_address (reloc_rva)
			reloc_section_header.set_raw_data_size (reloc_size_on_disk)
			reloc_section_header.set_pointer_to_raw_data (headers_size_on_disk + text_size_on_disk)
			reloc_section_header.set_characteristics (
				feature {CLI_SECTION_CONSTANTS}.initialized_data |
				feature {CLI_SECTION_CONSTANTS}.discardable |
				feature {CLI_SECTION_CONSTANTS}.read)
			
				-- CLI header.
			if has_strong_name then
				cli_header.strong_name_directory.set_rva_and_size (text_rva + iat.count +
					cli_header.count + code_size + debug_size, strong_name_size)
			end
			cli_header.meta_data_directory.set_rva_and_size (text_rva + iat.count +
				cli_header.count + code_size + debug_size + strong_name_size, meta_data_size)
			
				-- Setting of import table.
			iat.set_import_by_name_rva (text_rva + iat.count + cli_header.count + code_size +
				+ debug_size + strong_name_size + meta_data_size + import_table_padding +
				import_table.Size_to_import_by_name)
			import_table.set_rvas (text_rva, text_rva + iat.count + cli_header.count +
				code_size + debug_size + strong_name_size + meta_data_size + import_table_padding)
			
				-- Entry point setting
			entry_data.set_iat_rva (text_rva)
			
				-- Reloc section
			reloc_section.set_data (text_rva + iat.count + cli_header.count + code_size +
				debug_size + strong_name_size + meta_data_size +
				import_table_padding + import_table.count +
				entry_data.jump_size)
				
				-- Set method RVAs now.
			method_writer.update_rvas (emitter, code_rva)
		end
		
feature {NONE} -- Implementation

	dos_header: MANAGED_POINTER is
			-- DOS header.
		once
			create Result.make_from_array ( <<
				0x4D, 0x5A, 0x90, 0x0, 0x3, 0x0, 0x0, 0x0,
				0x4, 0x0, 0x0, 0x0, 0xFF, 0xFF, 0x0, 0x0,
				0xB8, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
				0x40, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
				0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
				0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
				0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
				0x0, 0x0, 0x0, 0x0, 0x80, 0x0, 0x0, 0x0,
				0xE, 0x1F, 0xBA, 0xE, 0x0, 0xB4, 0x9, 0xCD,
				0x21, 0xB8, 0x1, 0x4C, 0xCD, 0x21, 0x54, 0x68,
				0x69, 0x73, 0x20, 0x70, 0x72, 0x6F, 0x67, 0x72,
				0x61, 0x6D, 0x20, 0x63, 0x61, 0x6E, 0x6E, 0x6F,
				0x74, 0x20, 0x62, 0x65, 0x20, 0x72, 0x75, 0x6E,
				0x20, 0x69, 0x6E, 0x20, 0x44, 0x4F, 0x53, 0x20,
				0x6D, 0x6F, 0x64, 0x65, 0x2E, 0xD, 0xD, 0xA,
				0x24, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
				0x50, 0x45, 0x0, 0x0
			>>)
		ensure
			valid_size: dos_header.count = 132
		end

	headers_size, text_size, reloc_size: INTEGER
	headers_size_on_disk, text_size_on_disk, reloc_size_on_disk: INTEGER
	text_rva, code_rva, reloc_rva: INTEGER
			-- Size information about current PE.

	debug_size, strong_name_size, meta_data_size, code_size: INTEGER

	import_table_padding: INTEGER
			-- Padding added before `import_table' so that it is aligned on 16 bytes boundaries.
	
	import_directory_rva: INTEGER
			-- RVA of import table.
		
invariant
	file_name_not_void: is_valid implies file_name /= Void
	file_name_not_empty: is_valid implies not file_name.is_empty
	dos_header_not_void: is_valid implies dos_header /= Void
	public_key_not_void: (is_valid and has_strong_name) implies public_key /= Void
	
end -- class CLI_PE_FILE
