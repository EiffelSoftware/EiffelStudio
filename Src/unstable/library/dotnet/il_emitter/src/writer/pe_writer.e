note
	description: "This is the main class for generating a PE file"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_WRITER

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

		--  the maximum number of PE objects we will generate
		--  this includes the following:
		--  	.text / cildata
		--   	.reloc (for the single necessary reloc entry)
		--    	.rsrc (not implemented yet, will hold version info record)

	make (is_exe: BOOLEAN; is_gui: BOOLEAN; a_snk_file: STRING_32)
			--
		do
			dll := not is_exe
			gui := is_gui
			file_align := 0x200
			object_align := 0x2000
			image_base := 0x400000
			language := 0x4b0
			create snk_file.make_from_string (a_snk_file)
			create meta_header.make_from_other (meta_header1)
			create string_map.make (0)
			create tables.make_filled (create {DNL_TABLE}.make, 1, {PE_TABLE_CONSTANTS}.max_tables)
			create {ARRAYED_LIST [PE_METHOD]} methods.make (0)
			create rva.make
			create guid.make
			create blob.make
			create us.make
			create strings.make
		ensure
			dll_set: dll = not is_exe
			gui_set: gui = is_gui
			object_base_zero: object_base = 0
			value_base_zero: value_base = 0
			enum_base_zero: enum_base = 0
			system_index_zero: system_index = 0
			entry_point_zero: entry_point = 0
			param_attribute_type_zero: param_attribute_type = 0
			param_attribute_data_zero: param_attribute_data = 0
			file_align_set: file_align = 0x200
			object_align_set: object_align = 0x2000
			image_base_set: image_base = 0x400000
			language_set: language = 0x4b0
			pe_header_void: pe_header = Void
			pe_object_void: pe_objects = Void
			cor20_header_void: cor20_header = Void
			tables_header_void: tables_header = Void
			snk_file_set: snk_file.same_string_general (a_snk_file)
			snk_len_zero: snk_len = 0
			output_file_vooid: output_file = Void
			pe_base_zero: pe_base = 0
			cor_base_zero: cor_base = 0
			snk_base = 0
			string_map_empty: string_map.is_empty
			methods_empty: methods.is_empty
		end

feature -- Access

	snk_base: NATURAL assign set_snk_base
			-- `snk_base'

	cor_base: NATURAL assign set_cor_base
			-- `cor_base'

	pe_base: NATURAL assign set_pe_base
			-- `pe_base'

	snk_len: NATURAL assign set_snk_len
			-- `snk_len'

	snk_file: STRING_32
			-- `snk_file'

	tables_header: detachable DOTNET_META_TABLES_HEADER
			-- `tables_header'

	cor20_header: detachable PE_DOTNET_COR20_HEADER
			-- `cor20_header'

	pe_objects: detachable LIST [PE_OBJECT]
			-- `pe_objects'

	pe_header: detachable PE_HEADER
			-- `pe_header'

	language: NATURAL_32
			-- `language'
			-- C++ defined as four bytes
			-- DWord language_;

	image_base: NATURAL assign set_image_base
			-- `image_base'

	object_align: NATURAL assign set_object_align
			-- `object_align'

	file_align: NATURAL assign set_file_align
			-- `file_align'

	param_attribute_data: NATURAL assign set_param_attribute_data
			-- `param_attribute_data'

	param_attribute_type: NATURAL assign set_param_attribute_type
			-- `param_attribute_type'

	entry_point: NATURAL assign set_entry_point
			-- `entry_point'

	system_index: NATURAL assign set_system_index
			-- `system_index'

	enum_base: NATURAL assign set_enum_base
			-- `enum_base'

	value_base: NATURAL assign set_value_base
			-- `value_base'

	object_base: NATURAL assign set_object_base
			-- `object_base'

	gui: BOOLEAN assign set_gui
			-- `gui'

	dll: BOOLEAN assign set_dll
			-- `dll'

	output_file: detachable FILE_STREAM

	assembly_version: detachable ARRAY [NATURAL_16]
			--| C++ defined as Word assemblyVersion_[4];
			--| Word is two bytes.

	file_version: detachable ARRAY [NATURAL_16]

	product_version: detachable ARRAY [NATURAL_16]

	stream_headers: detachable ARRAY2 [NATURAL]

	rsa_encoder: detachable CIL_RSA_ENCODER

	mzh_header: ARRAY [NATURAL_8]
			-- MS-DOS header
		do
			Result := <<
					0x4d, 0x5a, 0x90, 0x00, 0x03, 0x00, 0x00, 0x00,
					0x04, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00,
					0xb8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
					0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00,

					0x0e, 0x1f, 0xba, 0x0e, 0x00, 0xb4, 0x09, 0xcd,
					0x21, 0xb8, 0x01, 0x4c, 0xcd, 0x21, 0x54, 0x68,
					0x69, 0x73, 0x20, 0x70, 0x72, 0x6f, 0x67, 0x72,
					0x61, 0x6d, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f,
					0x74, 0x20, 0x62, 0x65, 0x20, 0x72, 0x75, 0x6e,
					0x20, 0x69, 0x6e, 0x20, 0x44, 0x4f, 0x53, 0x20,
					0x6d, 0x6f, 0x64, 0x65, 0x2e, 0x0d, 0x0d, 0x0a,
					0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00>>
		ensure
			instance_free: class
		end

	meta_header: DOTNET_META_HEADER

	stream_names: ARRAY [STRING_32]
		do
			Result := <<"#~", "#Strings", "#US", "#GUID", "#Blob">>
		ensure
			instance_free: class
		end

	default_us: ARRAY [NATURAL_8]
			-- defined as static Byte defaultUS_[];
			--| Byte defined as 1 byte.
		do
			Result := <<0, 3, 0x20, 0, 0>>
			Result.conservative_resize_with_default (0, 1, 8)
		end

	string_map: STRING_TABLE [NATURAL]
			-- reflection of the String stream so that we can keep from doing duplicates.
			-- right now we don't check duplicates on any of the other streams...

	tables: ARRAY [DNL_TABLE]
			-- tables that can appear in a PE file.

	methods: LIST [PE_METHOD]

	strings: PE_POOL

	us: PE_POOL

	blob: PE_POOL

	guid: PE_POOL

	rva: PE_POOL

feature {NONE} -- Implemenation

	meta_header1: DOTNET_META_HEADER
		do
			create Result
			Result.set_signature (1)
			Result.set_major (1)
			Result.set_minor (0)
		ensure
			instance_free: class
		end

feature -- Element change

	set_snk_base (a_snk_base: like snk_base)
			-- Assign `snk_base' with `a_snk_base'.
		do
			snk_base := a_snk_base
		ensure
			snk_base_assigned: snk_base = a_snk_base
		end

	set_cor_base (a_cor_base: like cor_base)
			-- Assign `cor_base' with `a_cor_base'.
		do
			cor_base := a_cor_base
		ensure
			cor_base_assigned: cor_base = a_cor_base
		end

	set_pe_base (a_pe_base: like pe_base)
			-- Assign `pe_base' with `a_pe_base'.
		do
			pe_base := a_pe_base
		ensure
			pe_base_assigned: pe_base = a_pe_base
		end

	set_snk_len (a_snk_len: like snk_len)
			-- Assign `snk_len' with `a_snk_len'.
		do
			snk_len := a_snk_len
		ensure
			snk_len_assigned: snk_len = a_snk_len
		end

	set_snk_file (a_snk_file: like snk_file)
			-- Assign `snk_file' with `a_snk_file'.
		do
			snk_file := a_snk_file
		ensure
			snk_file_assigned: snk_file = a_snk_file
		end

	set_tables_header (a_tables_header: like tables_header)
			-- Assign `tables_header' with `a_tables_header'.
		do
			tables_header := a_tables_header
		ensure
			tables_header_assigned: tables_header = a_tables_header
		end

	set_cor20_header (a_cor20_header: like cor20_header)
			-- Assign `cor20_header' with `a_cor20_header'.
		do
			cor20_header := a_cor20_header
		ensure
			cor20_header_assigned: cor20_header = a_cor20_header
		end

	set_pe_object (a_pe_object: like pe_objects)
			-- Assign `pe_objects' with `a_pe_object'.
		do
			pe_objects := a_pe_object
		ensure
			pe_object_assigned: pe_objects = a_pe_object
		end

	set_pe_header (a_pe_header: like pe_header)
			-- Assign `pe_header' with `a_pe_header'.
		do
			pe_header := a_pe_header
		ensure
			pe_header_assigned: pe_header = a_pe_header
		end

	set_language (a_language: like language)
			-- Assign `language' with `a_language'.
		do
			language := a_language
		ensure
			language_assigned: language = a_language
		end

	set_image_base (an_image_base: like image_base)
			-- Assign `image_base' with `an_image_base'.
		do
			image_base := an_image_base
		ensure
			image_base_assigned: image_base = an_image_base
		end

	set_object_align (an_object_align: like object_align)
			-- Assign `object_align' with `an_object_align'.
		do
			object_align := an_object_align
		ensure
			object_align_assigned: object_align = an_object_align
		end

	set_file_align (a_file_align: like file_align)
			-- Assign `file_align' with `a_file_align'.
		do
			file_align := a_file_align
		ensure
			file_align_assigned: file_align = a_file_align
		end

	set_param_attribute_data (a_param_attribute_data: like param_attribute_data)
			-- Assign `param_attribute_data' with `a_param_attribute_data'.
		do
			param_attribute_data := a_param_attribute_data
		ensure
			param_attribute_data_assigned: param_attribute_data = a_param_attribute_data
		end

	set_param_attribute_type (a_param_attribute_type: like param_attribute_type)
			-- Assign `param_attribute_type' with `a_param_attribute_type'.
		do
			param_attribute_type := a_param_attribute_type
		ensure
			param_attribute_type_assigned: param_attribute_type = a_param_attribute_type
		end

	set_entry_point (an_entry_point: like entry_point)
			-- Assign `entry_point' with `an_entry_point'.
		do
			entry_point := an_entry_point
		ensure
			entry_point_assigned: entry_point = an_entry_point
		end

	set_system_index (a_system_index: like system_index)
			-- Assign `system_index' with `a_system_index'.
		do
			system_index := a_system_index
		ensure
			system_index_assigned: system_index = a_system_index
		end

	set_enum_base (an_enum_base: like enum_base)
			-- Assign `enum_base' with `an_enum_base'.
		do
			enum_base := an_enum_base
		ensure
			enum_base_assigned: enum_base = an_enum_base
		end

	set_value_base (a_value_base: like value_base)
			-- Assign `value_base' with `a_value_base'.
		do
			value_base := a_value_base
		ensure
			value_base_assigned: value_base = a_value_base
		end

	set_object_base (an_object_base: like object_base)
			-- Assign `object_base' with `an_object_base'.
		do
			object_base := an_object_base
		ensure
			object_base_assigned: object_base = an_object_base
		end

	set_gui (a_gui: like gui)
			-- Assign `gui' with `a_gui'.
		do
			gui := a_gui
		ensure
			gui_assigned: gui = a_gui
		end

	set_dll (a_dll: like dll)
			-- Assign `dll' with `a_dll'.
		do
			dll := a_dll
		ensure
			dll_assigned: dll = a_dll
		end

feature -- Element Change

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		local
			n: INTEGER
		do
			n := a_entry.table_index
			tables [n].table.force (a_entry)
			debug ("pe_writer")
					-- Check C++ code  PEWriter::AddTableEntry
				to_implement ("Double check if its requried.")
			end
			Result := tables [n].table.count.to_natural_32
		end

	add_method (a_method: PE_METHOD)
			-- add a method entry to the output list.  Note that Index_(D methods won't be added here.
		do
			if a_method.flags & {PE_METHOD_CONSTANTS}.EntryPoint /= 0 then
				if entry_point /= 0 then
					{EXCEPTIONS}.raise (generator + "Multiple entry points")
				else
					entry_point := a_method.method_def | ({PE_TABLES}.tMethodDef.value |<< 24)
				end
			end
			methods.force (a_method)
		end

feature -- Status Report

	is_entry_point: BOOLEAN
		do
			Result := entry_point /= 0
		end

feature -- Stream functions

	hash_string (a_utf8: STRING_32): NATURAL
			-- return the stream index
			--| TODO add a precondition to verify a_utf8 is a valid UTF_8
		do
			if string_map.has (a_utf8) and then
				attached string_map.item (a_utf8) as l_val then
				Result := l_val
			else
				if strings.size = 0 then
					strings.increment_size
				end
					-- TODO check if we really need to do `+ 1`
				strings.confirm (strings.size + 1)
				Result := strings.size
				strings.increment_size_by ((a_utf8.count + 1).to_natural_32)
				string_map.force (Result, a_utf8)
			end
		end

	hash_us (a_str: STRING_32; a_len: INTEGER): NATURAL
			-- return the stream index
		do
			to_implement ("Add implementation")
		end

	hash_guid (a_guid: ARRAY [NATURAL_8]): NATURAL
			-- return the stream index
		do
			to_implement ("Add implementation")
		end

	Hash_Blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_8): NATURAL
			-- return the stream index
		do
			to_implement ("Add implementation")
		end

feature -- Various Operations

	RVA_bytes (a_bytes: ARRAY [NATURAL_8]; a_data: NATURAL): NATURAL
			--  this is the 'cildata' contents.   Again we emit into the cildata and it returns the offset in
			--  the cildata to use.  It does NOT return the rva immediately, that is calculated later
		do
			to_implement ("Add implementation")
		end

	set_base_classes (a_object_index: NATURAL; a_value_index: NATURAL; a_enum_index: NATURAL; a_system_index: NATURAL)
			--  Set the indexes of the various classes which can be extended to make new classes
			--  these are typically in the typeref table
			--  Also set the index of the System namespace entry which is t

		do
			to_implement ("Add implementation")
		end

	set_param_attribute (a_param_attribute_type: NATURAL; a_param_attribute_data: NATURAL)
			-- this sets the data for the paramater attribute we support
			-- we aren't generally supporting attributes in this version but we do need to be able to
			-- set a single attribute that means a function has a variable length argument list
		do
			param_attribute_data := a_param_attribute_data
			param_attribute_type := a_param_attribute_type
		ensure
			param_attribute_data_set: param_attribute_data = a_param_attribute_data
			param_attribute_type_set: param_attribute_type = a_param_attribute_type
		end

	create_guid (a_Guid: ARRAY [NATURAL_8])
		do
			to_implement ("Add implementation [instance_free]")
		end

	next_table_index (a_table: INTEGER): NATURAL
		do
			to_implement ("Add implementation")
		end

	write_file (a_corFlags: INTEGER; a_out: FILE_STREAM): BOOLEAN
		do
			output_file := a_out
			if not is_entry_point and not dll then
				{EXCEPTIONS}.raise (generator + " Missing Entry Point ")
			end
			calculate_objects (a_corflags)
		end

	hash_part_of_file (a_context: CIL_SHA1_CONTEXT; a_offset: NATURAL; a_len: NATURAL)
		do
			to_implement ("Add implementation")
		end

	cildata_rva: detachable ARRAY [NATURAL_8]
			-- TODO double check.
			-- another thing that makes this lib not thread safe, the RVA for
			-- the beginning of the .data section gets put here after it is calculated
			--| defined as
			--|  static DWord cildata_rva_;
			--|  DWord =:: four bytes

feature -- Operations

	calculate_objects (a_cor_flags: INTEGER)
			-- this calculates various addresses and offsets that will be used and referenced
			-- when we actually generate the data.   This must be kept in sync with the code to
			-- generate data
		require
			pe_header_void: pe_header = Void
		local
			l_pe_header: PE_HEADER
			l_pe_objects: like pe_objects
			l_n: INTEGER
			l_current_rva: NATURAL
		do
				-- pe_header setup.
			check pe_header = Void end
			create l_pe_header
			l_pe_header.signature := {PE_HEADER_CONSTANTS}.PESIG
			l_pe_header.cpu_type := {PE_HEADER_CONSTANTS}.pe_intel386.to_integer_16
			l_pe_header.magic := {PE_HEADER_CONSTANTS}.pe_magicnum.to_natural_8
			l_pe_header.nt_hdr_size := 0xe0
				-- optional header size
			l_pe_header.flags := ({PE_HEADER_CONSTANTS}.pe_file_executable + if dll then {PE_HEADER_CONSTANTS}.pe_file_library else 0 end).to_natural_8
			l_pe_header.linker_major_version := 6
			l_pe_header.object_align := object_align.to_integer_32
			l_pe_header.file_align := file_align.to_integer_32
			l_pe_header.image_base := image_base.to_integer_32
			l_pe_header.os_major_version := 4
			l_pe_header.subsys_major_version := 4
			l_pe_header.subsystem := (if gui then {PE_HEADER_CONSTANTS}.PE_SUBSYS_WINDOWS else {PE_HEADER_CONSTANTS}.PE_SUBSYS_CONSOLE end).to_integer_16
			l_pe_header.dll_flags := 0x8540
				-- magic!
			l_pe_header.stack_size := 0x100000
			l_pe_header.stack_commit := 0x1000
			l_pe_header.heap_size := 0x100000
			l_pe_header.heap_commit := 0x1000
			l_pe_header.num_rvas := 16

			l_pe_header.num_objects := 2
			l_pe_header.header_size := mzh_header.count + compute_pe_header_size + l_pe_header.num_objects * compute_pe_object_size

			if (l_pe_header.header_size \\ file_align.to_integer_32) /= 0 then
				l_pe_header.header_size := l_pe_header.header_size + (file_align.to_integer_32 - (l_pe_header.header_size \\ file_align.to_integer_32))
			end

			l_pe_header.time := number_of_seconds_since_epoch

			pe_header := l_pe_header

			check pe_objects = Void end

			create {ARRAYED_LIST [PE_OBJECT]}l_pe_objects.make_filled (max_pe_objects)

			l_n := 1
			l_pe_objects[l_n].name := ".text"
			l_pe_objects[l_n].flags := {PE_HEADER_CONSTANTS}.winf_execute | {PE_HEADER_CONSTANTS}.winf_code | {PE_HEADER_CONSTANTS}.winf_readable

			l_n := l_n + 1
			l_pe_objects[l_n].name := ".reloc"
			l_pe_objects[l_n].flags := {PE_HEADER_CONSTANTS}.WINF_INITDATA | {PE_HEADER_CONSTANTS}.WINF_READABLE | {PE_HEADER_CONSTANTS}.WINF_DISCARDABLE
			l_current_rva := mzh_header.count.to_natural_32 + compute_pe_header_size.to_natural_32 + l_pe_header.num_objects.to_natural_32 * compute_pe_object_size.to_natural_32
			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end

			l_pe_objects [1].virtual_addr := l_current_rva.to_integer_32
			l_pe_objects [1].raw_ptr := l_pe_header.header_size
			l_pe_header.code_base := l_current_rva.to_integer_32
			l_pe_header.iat_rva := l_current_rva.to_integer_32
			l_pe_header.iat_size := 8
			--l_pe_header.com_size =



			to_implement ("Work in progress")
		end

feature {NONE} -- Implementation

	number_of_seconds_since_epoch: INTEGER_32
			-- calculate the number of seconds since epoch in eiffel
		local
			l_date_epoch: DATE_TIME
			l_date_now: DATE_TIME
			l_diff: INTEGER_32
		do
			create l_date_epoch.make_from_epoch (0)
			create l_date_now.make_now_utc
			Result := l_date_now.definite_duration (l_date_epoch).seconds_count.to_integer
		ensure
			is_class: class
		end


	compute_pe_header_size: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_HEADER
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {INTEGER_16} l_field then
						Result := Result + {PLATFORM}.integer_16_bytes
					elseif attached {NATURAL_8} l_field then
						Result := Result + {PLATFORM}.natural_8_bytes
					end
				end
			end
		end

	compute_pe_object_size: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_OBJECT
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					elseif attached {STRING} l_field as l_str then
						Result := Result + l_str.capacity
					elseif attached {ARRAY [INTEGER]} l_field as l_arr then
						Result := Result + (l_arr.count * {PLATFORM}.integer_32_bytes)
					end
				end
			end
		end


	compute_pe_dotnet_core20_size: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_DOTNET_COR20_HEADER
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {NATURAL_16} l_field then
						Result := Result + {PLATFORM}.natural_16_bytes
					elseif attached {ARRAY [NATURAL]} l_field as l_arr then
						Result := Result + (l_arr.count * {PLATFORM}.natural_32_bytes)
					end
				end
			end
		end

feature -- Write operations

	write_mz_data: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_pe_header: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_pe_objects: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_iat: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_core_header: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_hash_data: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_static_data: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_methods: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_metadata_headers: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_tables: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_strings: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_us: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_guid: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_blob: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_imports: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_entry_point: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_version_info (a_file_name: STRING_32): BOOLEAN
		do
			to_implement ("Add implementation")
		end

	write_relocs: BOOLEAN
		do
			to_implement ("Add implementation")
		end

	version_string (a_name: STRING_32; a_value: STRING_32)
			-- a helper to put a string into the string area of the version information.
		do
			to_implement ("Add implementation")
		end

feature -- Output Helpers

	put (a_data: ANY; a_size: NATURAL)
		do
			if attached output_file as l_file then
					-- outputFile_->write((char *)data, size)
			end
		end

	offset: NATURAL_64
			-- the output position.
		do
			to_implement ("Add implementation")
		end

	seek (a_offset: NATURAL)
			-- Set the output position.
		do
			to_implement ("Add implementation")
		end

	align (a_offset: NATURAL)
		do
			to_implement ("Add implementation")
		end

feature -- Constants

	MAX_PE_OBJECTS: INTEGER = 4
			-- the maximum number of PE objects we will generate
			-- this includes the following:
			-- 	.text / cildata
			-- 	.reloc (for the single necessary reloc entry)
			-- 	.rsrc (not implemented yet, will hold version info record)

end
