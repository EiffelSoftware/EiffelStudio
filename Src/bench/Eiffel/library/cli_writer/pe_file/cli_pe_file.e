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
			
			create dos_header

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
		
feature -- Saving

	save is
			-- 
		local
			l_pe_file: RAW_FILE
			l_padding: MANAGED_POINTER
		do
				-- First compute size of PE file headers and sections.
			compute_sizes

				-- Let's update PE data structures with proper RVAs
			update_rvas

				-- Write to file now.
			create l_pe_file.make_open_write (file_name)
			
				-- First the headers
			l_pe_file.put_data (dos_header.item, dos_header.size)
			l_pe_file.put_data (pe_header.item, pe_header.size)
			l_pe_file.put_data (optional_header.item, optional_header.size)
			l_pe_file.put_data (text_section_header.item, text_section_header.size)
			l_pe_file.put_data (reloc_section_header.item, reloc_section_header.size)

				-- Add padding to .text section
			create l_padding.make (padding (headers_size, file_alignment))
			l_pe_file.put_data (l_padding.item, l_padding.size)
			
				-- Store .text section
			l_pe_file.put_data (iat.item, iat.size)
			l_pe_file.put_data (cli_header.item, cli_header.size)
			if method_writer /= Void then
					-- No need for padding as it is correctly aligned of 4 bytes
				check
					correctly_aligned: (iat.size + cli_header.size) \\ 4 = 0
				end
				l_pe_file.put_data (method_writer.item, code_size)
			end
			l_pe_file.put_data (emitter.assembly_memory.item, meta_data_size)
			
			if import_table_padding > 0 then
				create l_padding.make (import_table_padding)
				l_pe_file.put_data (l_padding.item, l_padding.size)
			end
			l_pe_file.put_data (import_table.item, import_table.size)
			l_pe_file.put_data (entry_data.item, entry_data.size)
			
				-- Add padding to .text section
			create l_padding.make (padding (text_size, file_alignment))
			l_pe_file.put_data (l_padding.item, l_padding.size)
			
				-- Store .reloc section
			l_pe_file.put_data (reloc_section.item, reloc_section.size)
			
				-- Add padding to end of file/
			create l_padding.make (padding (reloc_size, file_alignment))
			l_pe_file.put_data (l_padding.item, l_padding.size)
			
			l_pe_file.close
			is_valid := False
		ensure
			not_is_valid: not is_valid
		end

feature {NONE} -- Saving

	compute_sizes is
			-- Compute sizes and basic locations of headers and sections,
			-- both real, on disk and in memory.
		do
				-- Size of meta data and code.
			meta_data_size := emitter.save_size

			if method_writer /= Void then
				code_size := method_writer.size
			end

				-- Real size of all components
			headers_size := dos_header.size + pe_header.size +
				optional_header.size + text_section_header.size +
				reloc_section_header.size
			
			import_table_padding := pad_up (iat.size + cli_header.size + code_size + meta_data_size, 16) - 
				(iat.size + cli_header.size + code_size + meta_data_size)
			text_size := iat.size + cli_header.size + code_size + meta_data_size + import_table_padding +
				import_table.size + entry_data.size
				
			reloc_size := reloc_section.size
			
				-- Size of `.text' and `.reloc' section on disk.
			headers_size_on_disk := pad_up (headers_size, file_alignment)
			text_size_on_disk := pad_up (text_size, file_alignment)
			reloc_size_on_disk := pad_up (reloc_size, file_alignment)

				-- RVA of `.text' and `.reloc'.
			text_rva := pad_up (headers_size, Section_alignment)
			reloc_rva := pad_up (text_rva + text_size_on_disk, Section_alignment)
			code_rva := text_rva + iat.size + cli_header.size

			import_directory_rva := text_rva + iat.size + cli_header.size + code_size + 
				meta_data_size + import_table_padding
		end

	update_rvas is
			-- Update all PE files data structures with correct RVAs.
		local
			import_directory, reloc_directory,
			iat_directory, cli_directory: CLI_DIRECTORY
		do
				-- Update optional header section.
			optional_header.set_code_size (text_size_on_disk)
			optional_header.set_reloc_size (reloc_size_on_disk)
			optional_header.set_entry_point_rva (text_rva + iat.size +
				cli_header.size + code_size + meta_data_size + import_table_padding + import_table.size +
				entry_data.start_position)
			optional_header.set_base_of_code (text_rva)
			optional_header.set_base_of_reloc (reloc_rva)
			optional_header.set_image_size (reloc_rva + pad_up (reloc_size, Section_alignment))
			optional_header.set_headers_size (pad_up (headers_size, file_alignment))
			
			import_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_import)
			import_directory.set_rva (import_directory_rva)
			import_directory.set_data_size (import_table.size - 1)
			
			reloc_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_basereloc)
			reloc_directory.set_rva (reloc_rva)
			reloc_directory.set_data_size (reloc_size)
			
			iat_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_iat)
			iat_directory.set_rva (text_rva)
			iat_directory.set_data_size (iat.size)
			
			cli_directory := optional_header.directory (
				feature {CLI_DIRECTORY_CONSTANTS}.Image_directory_entry_cli_descriptor)
			cli_directory.set_rva (text_rva + iat.size)
			cli_directory.set_data_size (cli_header.size)
			
				-- Update section headers
			text_section_header.set_virtual_size (pad_up (text_size, 4))
			text_section_header.set_virtual_address (text_rva)
			text_section_header.set_raw_data_size (text_size_on_disk)
			text_section_header.set_pointer_to_raw_data (headers_size_on_disk)
			text_section_header.set_characteristics (
				feature {CLI_PE_FILE_CONSTANTS}.Image_section_code |
				feature {CLI_PE_FILE_CONSTANTS}.Image_section_mem_execute |
				feature {CLI_PE_FILE_CONSTANTS}.Image_section_mem_read)

			reloc_section_header.set_virtual_size (pad_up (reloc_size, 4))
			reloc_section_header.set_virtual_address (reloc_rva)
			reloc_section_header.set_raw_data_size (reloc_size_on_disk)
			reloc_section_header.set_pointer_to_raw_data (headers_size_on_disk + text_size_on_disk)
			reloc_section_header.set_characteristics (
				feature {CLI_PE_FILE_CONSTANTS}.Image_section_initialized_data |
				feature {CLI_PE_FILE_CONSTANTS}.Image_section_mem_discardable |
				feature {CLI_PE_FILE_CONSTANTS}.Image_section_mem_read)
			
				-- CLI header.
			cli_header.meta_data_directory.set_rva_and_size (text_rva + iat.size + cli_header.size +
				code_size, meta_data_size)
			
				-- Setting of import table.
			iat.set_import_by_name_rva (text_rva + iat.size + cli_header.size + code_size +
				meta_data_size + import_table_padding + import_table.Size_to_import_by_name)
			import_table.set_rvas (text_rva, text_rva + iat.size + cli_header.size + code_size + meta_data_size
				+ import_table_padding)
			
				-- Entry point setting
			entry_data.set_iat_rva (text_rva)
			
				-- Reloc section
			reloc_section.set_data (text_rva + iat.size + cli_header.size + code_size +
				meta_data_size + import_table_padding + import_table.size + entry_data.jump_size)
				
				-- Set method RVAs now.
			method_writer.update_rvas (emitter, code_rva)
		end
		
feature {NONE} -- Implementation

	dos_header: CLI_DOS_HEADER
			-- DOS header.

	headers_size, text_size, reloc_size: INTEGER
	headers_size_on_disk, text_size_on_disk, reloc_size_on_disk: INTEGER
	text_rva, code_rva, reloc_rva: INTEGER
			-- Size information about current PE.

	meta_data_size, code_size: INTEGER

	import_table_padding: INTEGER
			-- Padding added before `import_table' so that it is aligned on 16 bytes boundaries.
	
	import_directory_rva: INTEGER
			-- RVA of import table.
		
invariant
	file_name_not_void: is_valid implies file_name /= Void
	file_name_not_empty: is_valid implies not file_name.is_empty
	dos_header_not_void: is_valid implies dos_header /= Void
	
end -- class CLI_PE_FILE
