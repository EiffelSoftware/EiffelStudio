note
	description: "This is the main class for generating a PE file"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_WRITER

inherit

	PE_TABLE_CONSTANTS

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (is_exe: BOOLEAN; is_gui: BOOLEAN; a_snk_file: STRING_32)
			-- Creation procedure to instance a new object.
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
			initialize_dnl_tables
			create {ARRAYED_LIST [PE_METHOD]} methods.make (0)
			create rva.make
			create guid.make
			create blob.make
			create us.make
			create strings.make
			create rsa_encoder.make
			create stream_headers.make_filled (0, 5, 2)
			create assembly_version.make_filled (0, 1, 4)
			create file_version.make_filled (0, 1, 4)
			create product_version.make_filled (0, 1, 4)
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

	initialize_dnl_tables
		do
			create {ARRAYED_LIST [DNL_TABLE]} tables.make ({PE_TABLE_CONSTANTS}.max_tables)
			across 1 |..| {PE_TABLE_CONSTANTS}.max_tables as i loop
				tables.force ((create {DNL_TABLE}.make))
			end
		end

feature -- Constant

	RTV_STRING: STRING = "v4.0.30319"
			--this is a CUSTOM version string for microsoft.
			--standard CIL differs

feature -- Access

	snk_base: NATURAL assign set_snk_base
			-- `snk_base'

	cor_base: NATURAL assign set_cor_base
			-- `cor_base'

	pe_base: NATURAL assign set_pe_base
			-- `pe_base'

	snk_len: NATURAL_64 assign set_snk_len
			-- `snk_len'

	snk_file: STRING_32
			-- `snk_file'

	tables_header: detachable PE_DOTNET_META_TABLES_HEADER
			-- `tables_header'

	cor20_header: detachable PE_DOTNET_COR20_HEADER
			-- `cor20_header'

	pe_objects: detachable LIST [PE_OBJECT]
			-- `pe_objects'

	pe_header: detachable PE_HEADER
			-- `pe_header'
			-- TODO double check if we need a list of headers.

	language: NATURAL_32
			-- `language'
			-- C++ defined as four bytes
			-- DWord language_;

	image_base: NATURAL_64 assign set_image_base
			-- `image_base'

	object_align: NATURAL_64 assign set_object_align
			-- `object_align'

	file_align: NATURAL_64 assign set_file_align
			-- `file_align'

	param_attribute_data: NATURAL_64 assign set_param_attribute_data
			-- `param_attribute_data'

	param_attribute_type: NATURAL_64 assign set_param_attribute_type
			-- `param_attribute_type'

	entry_point: NATURAL_64 assign set_entry_point
			-- `entry_point'

	system_index: NATURAL_64 assign set_system_index
			-- `system_index'

	enum_base: NATURAL_64 assign set_enum_base
			-- `enum_base'

	value_base: NATURAL_64 assign set_value_base
			-- `value_base'

	object_base: NATURAL_64 assign set_object_base
			-- `object_base'

	gui: BOOLEAN assign set_gui
			-- `gui'

	dll: BOOLEAN assign set_dll
			-- `dll'

	output_file: detachable FILE_STREAM

	assembly_version: ARRAY [NATURAL_16]
			--| C++ defined as Word assemblyVersion_[4];
			--| Word is two bytes.

	file_version: ARRAY [NATURAL_16]

	product_version: ARRAY [NATURAL_16]

	stream_headers: ARRAY2 [NATURAL_64]
			-- defined as streamHeaders_[5][2];

	rsa_encoder: CIL_RSA_ENCODER

	mzh_header: ARRAY [NATURAL_8]
			-- MS-DOS header
		do
			Result := {ARRAY [NATURAL_8]} <<
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

	meta_header: PE_DOTNET_META_HEADER

	stream_names: ARRAY [STRING_32]
		do
			Result := {ARRAY [STRING_32]} <<"#~", "#Strings", "#US", "#GUID", "#Blob">>
		ensure
			instance_free: class
		end

	default_us: ARRAY [NATURAL_8]
			-- defined as static Byte defaultUS_[];
			--| Byte defined as 1 byte.
		do
			Result := {ARRAY [NATURAL_8]} <<0, 3, 0x20, 0, 0>>
			Result.conservative_resize_with_default (0, 1, 8)
		end

	string_map: STRING_TABLE [NATURAL_64]
			-- reflection of the String stream so that we can keep from doing duplicates.
			-- right now we don't check duplicates on any of the other streams...

	tables: LIST [DNL_TABLE]
			-- tables that can appear in a PE file.

	methods: LIST [PE_METHOD]

	strings: PE_POOL

	us: PE_POOL

	blob: PE_POOL

	guid: PE_POOL

	rva: PE_POOL

feature {NONE} -- Implemenation

	meta_header1: PE_DOTNET_META_HEADER
		do
			create Result
			Result.set_signature ({PE_DOTNET_META_HEADER}.meta_sig)
			Result.set_major (1)
			Result.set_minor (1)
			Result.set_reserved (0)
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

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_64
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
--					#if 0
--					    // seems to alway apply
--					    if( n == tMethodDef )
--					    { {}
--					        MethodDefTableEntry* e = (MethodDefTableEntry*)entry;
--					        const int id = tables_[n].size();
--					        Q_ASSERT( id == e->method_->methodDef_ );
--					    }
--					#endif
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

	hash_string (a_utf8: STRING_32): NATURAL_64
			-- return the stream index
			--| TODO add a precondition to verify a_utf8 is a valid UTF_8
		local
			l_str: STRING_8
			l_converter: BYTE_ARRAY_CONVERTER
		do
			if string_map.has (a_utf8) and then
				attached string_map.item (a_utf8) as l_val then
				Result := l_val
			else
				if strings.size = 0 then
					strings.increment_size
				end
				strings.confirm (strings.size + 1)
				Result := strings.size
				l_str := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_utf8)
				create l_converter.make_from_bin_string (l_str)

				strings.copy_data (strings.size.to_integer_32, l_converter.to_natural_8_array, (l_str.count + 1).to_natural_64)
				strings.increment_size_by ((a_utf8.count + 1).to_natural_32)
				string_map.force (Result, a_utf8)
			end
		end

	hash_us (a_str: STRING_32; a_len: INTEGER): NATURAL_64
			-- return the stream index
		local
			l_flag: INTEGER
			l_blob_len: INTEGER
			n: INTEGER
		do
			if us.size = 0 then
				us.increment_size
			end
			us.confirm ((a_len * 2 + 5).to_natural_32)
			Result := us.size
			l_blob_len := a_len * 2 + 1
			if l_blob_len < 0x80 then
				us.base [us.size.to_integer_32] := l_blob_len.to_natural_8
				us.increment_size
			elseif l_blob_len <= 0x3fff then
				us.base [us.size.to_integer_32] := ((l_blob_len |>> 8) | 0x80).to_natural_8
				us.increment_size
				us.base [us.size.to_integer_32] := l_blob_len.to_natural_8
				us.increment_size
			else
				l_blob_len := l_blob_len & 0x1fffffff
				us.base [us.size.to_integer_32] := ((l_blob_len |>> 24) | 0xc0).to_natural_8
				us.increment_size
				us.base [us.size.to_integer_32] := (l_blob_len |>> 16).to_natural_8
				us.increment_size
				us.base [us.size.to_integer_32] := (l_blob_len |>> 8).to_natural_8
				us.increment_size
				us.base [us.size.to_integer_32] := (l_blob_len |>> 0).to_natural_8
				us.increment_size
			end

			across a_str as i loop
				n := i.code
				if (n & 0xff00) /= 0 then
					l_flag := 1
				elseif (n <= 8 or else (n >= 0x0e and then n < 0x20) or else n = 0x27 or else n = 0x2d or else n = 0x7f) then
					l_flag := 1
				end
				us.base [us.size.to_integer_32] := (n & 0xff).to_natural_8
				us.increment_size
				us.base [us.size.to_integer_32] := (n |>> 8).to_natural_8
				us.increment_size
			end
			us.base [us.size.to_integer_32] := l_flag.to_natural_8
			us.increment_size
		end

	hash_guid (a_guid: ARRAY [NATURAL_8]): NATURAL_64
			-- return the stream index
		do
			guid.confirm (16) -- 128 // 8
			Result := guid.size
			guid.copy_data (Result.to_integer_32, a_guid, 16)
			guid.increment_size_by (16)
			Result := Result // 16 + 1
		end

	hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_64): NATURAL_64
			-- return the stream index.
		local
			l_rv: NATURAL_64
			l_blob_len: NATURAL_64
		do
			l_blob_len := a_blob_len
			if blob.size = 0 then
				blob.increment_size
			end
			blob.confirm (a_blob_len + 4)
			l_rv := blob.size
			if a_blob_len < 0x80 then
				blob.base [blob.size.to_integer_32] := l_blob_len.to_natural_8
				blob.increment_size
			elseif a_blob_len <= 0x3fff then
				blob.base [blob.size.to_integer_32] := ((l_blob_len |>> 8) | 0x80).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := l_blob_len.to_natural_8
				blob.increment_size
			else
				l_blob_len := (l_blob_len & 0x1fffffff).to_natural_8
				blob.base [blob.size.to_integer_32] := ((l_blob_len |>> 24) | 0xc0).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := (l_blob_len |>> 16).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := (l_blob_len |>> 8).to_natural_8
				blob.increment_size
				blob.base [blob.size.to_integer_32] := (l_blob_len |>> 0).to_natural_8
				blob.increment_size
			end
			blob.copy_data ((blob.size).to_integer_32, a_blob_data, l_blob_len)
			blob.increment_size_by (l_blob_len.to_natural_8)
			Result := l_rv
		end

feature -- Various Operations

	RVA_bytes (a_bytes: ARRAY [NATURAL_8]; a_data_len: NATURAL_64): NATURAL_64
			--  this is the 'cildata' contents.   Again we emit into the cildata and it returns the offset in
			--  the cildata to use.  It does NOT return the rva immediately, that is calculated later.
		local
			l_pos: INTEGER
			l_rv: NATURAL_64
		do
			l_pos := rva.size.to_integer_32
			rva.confirm (a_data_len + l_pos.to_natural_64 - rva.size)
			l_rv := rva.size
			rva.increment_size_by (l_pos.to_natural_64 - rva.size + a_data_len)
			a_bytes.make_from_special (rva.base)
			Result := l_rv
		end

	set_base_classes (a_object_index: NATURAL_64; a_value_index: NATURAL_64; a_enum_index: NATURAL_64; a_system_index: NATURAL_64)
			--  Set the indexes of the various classes which can be extended to make new classes
			--  these are typically in the typeref table
			--  Also set the index of the System namespace entry which is t

		do
			{PE_SIGNATURE_GENERATOR_HELPER}.set_object_type (a_object_index)
			object_base := a_object_index
			value_base := a_value_index
			enum_base := a_enum_index
			system_index := a_system_index
		ensure
			object_base_set: object_base = a_object_index
			value_index_set: value_base = a_value_index
			enum_base_set: enum_base = a_enum_index
			system_index_set: system_index = a_system_index
		end

	set_param_attribute (a_param_attribute_type: NATURAL_64; a_param_attribute_data: NATURAL_64)
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

	create_guid (a_guid: ARRAY [NATURAL_8])
		local
			l_mp: MANAGED_POINTER
		do
				-- At the moment this code uses a C++ wrapper.
				-- double check how to use UUID.
			create l_mp.make (16)
			c_create_guid (l_mp.item)
			a_guid.make_from_array (l_mp.read_array (0, 16))
		end

	next_table_index (a_table: INTEGER): NATURAL
		do
				-- TODO double check if we need the + 1.
			Result := (tables [a_table].size + 1).to_natural_32
		end

	write_file (a_corFlags: INTEGER; a_out: FILE_STREAM): BOOLEAN
		local
			l_rv: BOOLEAN
			l_context: CIL_SHA1_CONTEXT
			l_off: INTEGER
			l_sz: INTEGER
			l_dis: INTEGER
			l_sig_hash: ARRAY [NATURAL_8]
			l_sig_len: CELL [NATURAL_64]
			l_output_file: like output_file
		do
			l_output_file := a_out
			if not is_entry_point and not dll then
				{EXCEPTIONS}.raise (generator + " Missing Entry Point ")
			end
			calculate_objects (a_corflags)

			l_rv := write_mz_data and then write_pe_header and then write_pe_objects and then write_iat and then write_core_header and then
				write_static_data and then write_methods and then write_metadata_headers and then write_tables and then write_strings and then
				write_us and then write_guid and then write_blob and then write_imports and then write_entry_point and then write_hash_data and then
					--write_version_info (a_file_name: STRING_32)
				write_relocs

			if l_rv and then snk_len /= 0 then
				create l_context.make
				l_context.sha1_reset
				hash_part_of_file (l_context, 0, 0x80)
					-- if there was something between here and the PE header we would hash it now

					-- well we are supposed to zero the pe header checksum and the
					-- authenticode signature pointer, but, since we don't set them nonzero anyway
					-- this is fine.
				hash_part_of_file (l_context, 0x80, 0xf8)

				fixme ("Double check this call to hash_part_of_file")
				hash_part_of_file (l_context, (0x80 + 0xf8).to_natural_64, ({PE_OBJECT}.size_of * if attached pe_header as l_header then l_header.num_objects else {INTEGER_16} 0 end).to_natural_64)

					-- yes we do NOT hash the gap between the objects table and the first section.
				if attached pe_header as l_header and then attached pe_objects as l_objects and then
					attached cor20_header as l_cor20_header then
					across 0 |..| (l_header.num_objects - 1) as i loop
						if l_objects [i + 1].virtual_addr > l_cor20_header.strong_name_signature [1].to_integer_32 and then
							l_cor20_header.strong_name_signature [1].to_integer_32 < l_objects [i + 1].virtual_addr + l_objects [i + 1].virtual_size
						then
							l_off := l_cor20_header.strong_name_signature [1].to_integer_32 - l_objects [i].virtual_addr
							l_sz := l_cor20_header.strong_name_signature [2].to_integer_32
							hash_part_of_file (l_context, l_objects [i + 1].raw_ptr.to_natural_64, l_off.to_natural_64)
							hash_part_of_file (l_context, (l_objects [i + 1].raw_ptr + l_off + l_sz).to_natural_64, (l_objects [i + 1].raw_size - l_off - l_sz).to_natural_64)
						else
							hash_part_of_file (l_context, l_objects [i + 1].raw_ptr.to_natural_64, l_objects [i + 1].raw_size.to_natural_64)
						end
					end
				end

				l_dis := l_context.sha1_result
				create l_sig_hash.make_filled (0, 1, 16384)
				l_sig_hash.area.fill_with (0xfe, 1, 128)
				create l_sig_len.put (0)
				rsa_encoder.get_strong_name_signature (l_sig_hash, l_sig_len, l_context.message_digest_byte, 20)

					-- TODO review
				l_output_file.go (snk_base.to_integer_32)
				l_output_file.put_string (byte_array_to_string (l_sig_hash, l_sig_len.item.to_integer_32))
			end

			Result := l_rv
		end

	hash_part_of_file (a_context: CIL_SHA1_CONTEXT; a_offset: NATURAL_64; a_len: NATURAL_64)
		local
			l_buf: ARRAY [NATURAL_8]
			l_sz: INTEGER
			l_len: INTEGER
		do
			if attached output_file as l_stream then
				l_stream.go (a_offset.to_integer_32)
				create l_buf.make_filled (0, 1, 8192)
				from
					l_sz := 0x0
				until
					l_sz >= a_len.to_integer_32
				loop
					l_len := if a_len.to_integer_32 - l_sz > 8192 then 8192 else a_len.to_integer_32 - l_sz end
					l_stream.read_stream (l_buf, l_len)
					l_sz := l_sz + l_len
				end
			end
		end

	cildata_rva: PE_CILDATA_RVA
		do
			create Result
		ensure
			instance_free: class
		end
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
			l_current_rva: NATURAL_64
			l_core_20_header: PE_DOTNET_COR20_HEADER
			l_last_rva: NATURAL_64
			l_end: INTEGER
			l_data: CIL_SEH_DATA
			l_edata: CIL_SEH_DATA
			l_exit: BOOLEAN
			l_etiny: BOOLEAN
			l_tables_header: PE_DOTNET_META_TABLES_HEADER
			l_counts: ARRAY [NATURAL_64]
			l_buffer: ARRAY [NATURAL_8]
			l_buf: ARRAY [NATURAL_8]
			l_len: CELL [NATURAL_64]
			l_sect: INTEGER
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
			l_pe_header.header_size := mzh_header.count + {PE_HEADER}.size_of + l_pe_header.num_objects * {PE_OBJECT}.size_of

			if (l_pe_header.header_size \\ file_align.to_integer_32) /= 0 then
				l_pe_header.header_size := l_pe_header.header_size + (file_align.to_integer_32 - (l_pe_header.header_size \\ file_align.to_integer_32))
			end

			l_pe_header.time := number_of_seconds_since_epoch

				-- pe_objects setup
			check pe_objects = Void end

			create {ARRAYED_LIST [PE_OBJECT]} l_pe_objects.make_filled (max_pe_objects)

			l_n := 1
			l_pe_objects [l_n].name := ".text"
			l_pe_objects [l_n].flags := {PE_HEADER_CONSTANTS}.winf_execute | {PE_HEADER_CONSTANTS}.winf_code | {PE_HEADER_CONSTANTS}.winf_readable

			l_n := l_n + 1
			l_pe_objects [l_n].name := ".reloc"
			l_pe_objects [l_n].flags := {PE_HEADER_CONSTANTS}.WINF_INITDATA | {PE_HEADER_CONSTANTS}.WINF_READABLE | {PE_HEADER_CONSTANTS}.WINF_DISCARDABLE
			l_current_rva := mzh_header.count.to_natural_32 + {PE_HEADER}.size_of.to_natural_32 + l_pe_header.num_objects.to_natural_32 * {PE_OBJECT}.size_of.to_natural_32
			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end

			l_pe_objects [1].virtual_addr := l_current_rva.to_integer_32
			l_pe_objects [1].raw_ptr := l_pe_header.header_size
			l_pe_header.code_base := l_current_rva.to_integer_32
			l_pe_header.iat_rva := l_current_rva.to_integer_32
			l_pe_header.iat_size := 8
			l_pe_header.com_size := {PE_DOTNET_COR20_HEADER}.size_of
			l_current_rva := l_current_rva + l_pe_header.com_size.to_natural_32

				-- cor20_header setup
			check cor20_header = Void end
			create l_core_20_header
			l_core_20_header.cb := {PE_DOTNET_COR20_HEADER}.size_of.to_natural_32
			l_core_20_header.major_runtime_version := 2
			l_core_20_header.minor_runtime_version := 5

				-- standard CIL expects ONLY bit 0, we are using bit 1 as well
				-- for interoperability with the microsoft runtimes.

			l_core_20_header.flags := a_cor_flags.to_natural_32
			l_core_20_header.entry_point_token := entry_point.to_natural_32

			if not snk_file.is_empty then

				snk_len := rsa_encoder.load_strong_name_keys (snk_file)
				if snk_len /= 0 then
					create l_buf.make_filled (0, 1, 16384)
					create l_len.put (0)
					rsa_encoder.get_public_key_data (l_buf, l_len)

					if attached {PE_ASSEMBLY_DEF_TABLE_ENTRY} tables [{PE_TABLES}.index_of ({PE_TABLES}.tassemblydef).to_integer_32].table[1] as l_table then
						l_table.public_key_index := (create {PE_BLOB}.make_with_index (hash_blob (l_buf, l_len.item)))
					end
					if attached {PE_ASSEMBLY_DEF_TABLE_ENTRY} tables [{PE_TABLES}.index_of ({PE_TABLES}.tassemblydef).to_integer_32].table[1] as l_table then
						l_table.flags := l_table.flags | {PE_ASSEMBLY_FLAGS}.publickey
					end
					l_core_20_header.flags := l_core_20_header.flags | 8
						-- Strong name signed.
					if snk_len = 0 then
						print ("%NWarning: key file not found or invalid.   Assembly will not be signed")
						io.put_new_line
					end

				end
			end

			cildata_rva.value := l_current_rva.to_natural_32
			if rva.size /= 0 then
				l_current_rva := l_current_rva + rva.size
				if l_current_rva \\ 8 /= 0 then
					l_current_rva := l_current_rva + 8 - (l_current_rva \\ 8)
				end
			end

			l_last_rva := l_current_rva

			across methods as method loop
				if method.flags & {PE_METHOD_CONSTANTS}.cil /= 0 then
					if (method.flags & 3) = {PE_METHOD_CONSTANTS}.tinyformat then
						method.set_rva (l_current_rva)
						l_last_rva := l_current_rva
						l_current_rva := l_current_rva + 1
					else
						if (l_current_rva \\ 4) /= 0 then
							l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
						end
						method.set_rva (l_current_rva)
						l_last_rva := l_current_rva
						l_current_rva := l_current_rva + 12
					end
					l_current_rva := l_current_rva + method.code_size
					if not method.seh_data.is_empty then
						if (l_current_rva \\ 4) /= 0 then
							l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
						end
						l_end := 1
						l_data := method.seh_data [l_end]
						from
						until
							l_end > method.seh_data.count or else L_exit
						loop
							l_edata := method.seh_data [l_end]

							l_etiny := l_edata.try_offset < 65536 and then l_edata.try_length < 256 and then
								l_edata.handler_offset < 65536 and then l_edata.handler_length < 256

							if not l_etiny then
								l_exit := true
							else
								l_end := l_end + 1
							end
						end
						if l_end > method.seh_data.count and then method.seh_data.count < 21 then
							l_current_rva := l_current_rva + 4 + (method.seh_data.count * 12).to_natural_32
						else
							l_current_rva := l_current_rva + 4 + (method.seh_data.count * 24).to_natural_32
						end
					end
				else
					method.set_rva (0)
				end
			end

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_core_20_header.metadata [1] := l_current_rva.to_natural_32
				-- metadata root

			l_current_rva := l_current_rva + 12
				-- metadata header

			l_current_rva := l_current_rva + 4
				-- version size

			l_current_rva := l_current_rva + compute_rtv_string_size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_current_rva := l_current_rva + 2
				-- flags

			l_current_rva := l_current_rva + 2
				-- streams, will be 5 in our implementation
				-- check stream_names feature.

			across stream_names as elem loop
				l_current_rva := l_current_rva + (elem.count + 1).to_natural_32
				if (l_current_rva \\ 4) /= 0 then
					l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
				end
			end

			stream_headers [1, 1] := l_current_rva - l_core_20_header.metadata [1]

				-- tables_header set_up
			check tables_header = Void end
			create l_tables_header
			l_tables_header.major_version := 2
			l_tables_header.minor_version := 1
			l_tables_header.mask_sorted := ({INTEGER_64} 0x1600 |<< 32) + 0x3325FA00
			if strings.size >= 65536 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 1
			end
			if guid.size >= 65536 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 2
			end
			if blob.size >= 65536 then
				l_tables_header.heap_offset_sizes := l_tables_header.heap_offset_sizes | 4
			end

			l_n := 0
			create l_counts.make_filled (0, 1, Max_tables + Extra_indexes)
			l_counts [t_string + 1] := strings.size
			l_counts [t_us + 1] := us.size
			l_counts [t_guid + 1] := guid.size
			l_counts [t_blob + 1] := blob.size

			across 0 |..| (max_tables - 1) as ic loop
				if not tables [ic + 1].is_empty then
					l_counts [ic + 1] := tables [ic + 1].size.to_natural_32
					l_tables_header.mask_valid := l_tables_header.mask_valid | ({INTEGER_64} 1 |<< ic)
					l_n := l_n + 1
				end
			end
			l_current_rva := l_current_rva + {PE_DOTNET_META_TABLES_HEADER}.size_of.to_natural_32
				-- tables header
			l_current_rva := l_current_rva + (l_n * {PLATFORM}.natural_32_bytes).to_natural_32
				--table counts
				-- Dword is 4 bytes.

			across 0 |..| (max_tables - 1) as ic loop
				if l_counts [ic + 1] /= 0 then
					create l_buffer.make_filled (0, 1, 512)
					l_n := tables [ic + 1].table [1].render (l_counts, l_buffer).to_integer_32
					l_n := l_n * (l_counts [ic + 1]).to_integer_32
					l_current_rva := l_current_rva + l_n.to_natural_32
				end
			end

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [1, 2] := l_current_rva - stream_headers [1, 1] - l_core_20_header.metadata [1]
			stream_headers [2, 1] := l_current_rva - l_core_20_header.metadata [1]
			l_current_rva := l_current_rva + strings.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [2, 2] := l_current_rva - stream_headers [2, 1] - l_core_20_header.metadata [1]
			stream_headers [3, 1] := l_current_rva - l_core_20_header.metadata [1]
			if us.size = 0 then
				l_current_rva := l_current_rva + default_us.count.to_natural_32
					-- US May be empty in our implementation we put an empty string there
			else
				l_current_rva := l_current_rva + us.size
			end

				-- TODO refactor this code into a feature.
			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [3, 2] := l_current_rva - stream_headers [3, 1] - l_core_20_header.metadata [1]
			stream_headers [4, 1] := l_current_rva - l_core_20_header.metadata [1]
			l_current_rva := l_current_rva + guid.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [4, 2] := l_current_rva - stream_headers [4, 1] - l_core_20_header.metadata [1]
			stream_headers [5, 1] := l_current_rva - l_core_20_header.metadata [1]
			l_current_rva := l_current_rva + blob.size

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [5, 2] := l_current_rva - stream_headers [5, 1] - l_core_20_header.metadata [1]
			l_core_20_header.metadata [2] := l_current_rva.to_natural_32 - l_core_20_header.metadata [1]
			l_pe_header.import_rva := l_current_rva.to_integer_32
			l_current_rva := l_current_rva + ({PE_IMPORT_DIR}.size_of * 2).to_natural_32 + 8

			if (l_current_rva \\ 16) /= 0 then
				l_current_rva := l_current_rva + 16 - (l_current_rva \\ 16).to_natural_32
			end

			l_current_rva := l_current_rva + 2 +
				c_sizeof ((create {C_STRING}.make ("_CorXXXMain")).item).to_natural_32 +
				c_sizeof ((create {C_STRING}.make ("mscoree.dll")).item).to_natural_32 + 1

			l_pe_header.import_size := l_current_rva.to_integer_32 - l_pe_header.import_rva

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			l_current_rva := l_current_rva + 2
			l_pe_header.entry_point := l_current_rva.to_integer_32
			l_current_rva := l_current_rva + 6
			if snk_len /= 0 then
				l_core_20_header.strong_name_signature [1] := l_current_rva.to_natural_32
				l_core_20_header.strong_name_signature [2] := snk_len.to_natural_32
				l_current_rva := l_current_rva + snk_len
			end

			l_sect := 1
			l_pe_objects [l_sect].virtual_size := l_current_rva.to_integer_32 - l_pe_objects [l_sect].virtual_addr
			l_n := l_pe_objects [l_sect].virtual_size

			if ((l_n \\ file_align.to_integer_32) /= 0) then
				l_n := l_n + file_align.to_integer_32 - (l_n \\ file_align.to_integer_32)
			end
			l_pe_objects [l_sect].raw_size := l_n
			l_pe_header.code_size := l_n

			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end
			l_pe_objects [l_sect + 1].raw_ptr := l_pe_objects [l_sect].raw_ptr + l_pe_objects [l_sect].raw_size
			l_pe_objects [l_sect + 1].virtual_addr := l_current_rva.to_integer_32
			l_pe_header.data_base := l_current_rva.to_integer_32
			l_sect := l_sect + 1

--#if 0
--        peHeader_->resource_rva = currentRVA;
--        currentRVA += (sizeof(PEResourceDirTable) + sizeof(PEResourceDirEntry)) * 3; /* resource dirs */
--        currentRVA += sizeof(PEResourceDataEntry);

--        currentRVA += 2; /* size of version info */
--        currentRVA += 48; /* fixed info */
--        currentRVA += 68; /* VarFileInfo */
--        currentRVA += 368 - 72; /* String file info base */
--        std::string nn = peLib.FileName();
--        n = nn.find_last_of("\\");
--        if (n != std::string::npos)
--            n = nn.size() - n;
--        else
--            n = nn.size();
--        if (n % 4)
--            n += 4 - (n % 4);
--        currentRVA += n * 2;

--        char temp[256];
--        sprintf(temp, "%d.%d.%d.%d", fileVersion[0], fileVersion[1], fileVersion[2], fileVersion[3]);
--        n = strlen(temp);
--        if (n % 4)
--            n += 4 - (n % 4);
--        n *= 2;
--        currentRVA += n;
--        sprintf(temp, "%d.%d.%d.%d", productVersion[0], productVersion[1], productVersion[2], productVersion[3]);
--        n = strlen(temp);
--        if (n % 4)
--            n += 4 - (n % 4);
--        n *= 2;
--        currentRVA += n;
--        sprintf(temp, "%d.%d.%d.%d", assemblyVersion[0], assemblyVersion[1], assemblyVersion[2], assemblyVersion[3]);
--        n = strlen(temp);
--        if (n % 4)
--            n += 4 - (n % 4);
--        n *= 2;
--        currentRVA += n;

--        peObjects_[sect].virtual_size = currentRVA - peObjects_[sect].virtual_addr;
--        peHeader_->resource_size = peObjects_[sect].virtual_size;
--        n = peObjects_[sect].virtual_size;
--        if (n % fileAlign);
--        n += fileAlign - n % fileAlign;
--        peObjects_[sect].raw_size = n;
--        peHeader_->data_size += n;

--        if (currentRVA %objectAlign)
--            currentRVA += objectAlign - currentRVA % objectAlign;
--        peObjects_[sect + 1].raw_ptr = peObjects_[sect].raw_ptr + peObjects_[sect].raw_size;
--        peObjects_[sect + 1].virtual_addr = currentRVA;
--        sect++;
--#endif

			l_pe_header.fixup_rva := l_current_rva.to_integer_32
			l_current_rva := l_current_rva + 12
				-- sizeof relocs

			l_pe_objects [l_sect].virtual_size := l_current_rva.to_integer_32 - l_pe_objects [l_sect].virtual_addr
			l_pe_header.fixup_size := l_pe_objects [l_sect].virtual_size
			l_n := l_pe_objects [l_sect].virtual_size
			if (l_n \\ file_align.to_integer_32) /= 0 then
				l_n := l_n + file_align.to_integer_32 - (l_n \\ file_align.to_integer_32)
			end
			l_pe_objects [l_sect].raw_size := l_n
			l_pe_header.data_size := l_pe_header.data_size + l_n

			if (l_current_rva \\ object_align) /= 0 then
				l_current_rva := l_current_rva + object_align - (l_current_rva \\ object_align)
			end
			l_pe_objects [l_sect + 1].raw_ptr := l_pe_objects [l_sect].raw_ptr + l_pe_objects [l_sect].raw_size
			l_pe_objects [l_sect + 1].virtual_addr := l_current_rva.to_integer_32
			l_pe_header.image_size := l_current_rva.to_integer_32

			pe_header := l_pe_header
			pe_objects := l_pe_objects
			cor20_header := l_core_20_header
			tables_header := l_tables_header
		end

feature {NONE} -- Implementation

	number_of_seconds_since_epoch: INTEGER_32
			-- calculate the number of seconds since epoch in eiffel
		local
			l_date_epoch: DATE_TIME
			l_date_now: DATE_TIME
		do
			create l_date_epoch.make_from_epoch (0)
			create l_date_now.make_now_utc
			Result := l_date_now.definite_duration (l_date_epoch).seconds_count.to_integer
		ensure
			is_class: class
		end

	c_sizeof (a_str: POINTER): INTEGER
		external "C inline"
		alias
			"return (EIF_INTEGER)sizeof($a_str);"
		end

	compute_rtv_string_size: NATURAL
		do
			fixme ("To double check this works as expected")
			Result := (rtv_string.count + 1).to_natural_32
		end

feature -- Write operations

	write_mz_data: BOOLEAN
		do
			put_mz_header (mzh_header)
			Result := True
		end

	write_pe_header: BOOLEAN
		do
			if attached output_file as l_stream and then
				attached pe_header as l_pe_header
			then
				pe_base := l_stream.count.to_natural_32
				put_pe_header (l_pe_header)
			end
			Result := True
		end

	write_pe_objects: BOOLEAN
		do
			if attached output_file as l_stream and then
				attached pe_objects as l_objects
			then
				put_pe_objects (l_objects)
			end
			Result := True
		end

	write_iat: BOOLEAN
		local
			l_import_rva: NATURAL_32
			l_n: NATURAL_32
		do
			if attached pe_header as l_pe_header
			then
				align (file_align)
				l_import_rva := l_pe_header.import_rva.to_natural_32
				l_n := l_import_rva + ({PE_IMPORT_DIR}.size_of * 2 + 4).to_natural_32
				if (l_n \\ 16) /= 0 then
					l_n := l_n + 16 - (l_n \\ 16)
				end
				put_natural_32 (l_n)
				l_n := 0
				put_natural_32 (l_n)
			end
			Result := True
		end

	write_core_header: BOOLEAN
		do
			if attached output_file as l_stream and then
				attached cor20_header as l_cor20_header
			then
				cor_base := l_stream.count.to_natural_32
				put_core20_header (l_cor20_header)
			end
			Result := True
		end

	write_hash_data: BOOLEAN
		local
			l_buf: ARRAY [NATURAL_8]
		do
			if attached output_file as l_stream then
				snk_base := l_stream.count.to_natural_32
				if snk_base /= 0 then
						-- the original code does the following
						-- Byte buf[2048]
						-- memset(buf, 0, snkLen_)
						-- put(buf, snkLen_)
						-- but if snkLen_ is greater than 2048, the buffer
						-- will not be large enough.
					create l_buf.make_filled (0, 1, snk_base.to_integer_32)
					fixme ("To improve performance we can create a put_ntimes_natural_8 (0, snk_base")
					put_array (l_buf)
				end
			end
			Result := True
		end

	write_static_data: BOOLEAN
		do
			if attached output_file as l_stream and then
				rva.size /= 0
			then
					-- To double check if the rva.base size is the
					-- same as rva.size.
				put_array (rva.base.to_array)
				align (8)
			end
			Result := True
		end

	write_methods: BOOLEAN
		local
			l_counts: ARRAY [NATURAL_64]
			l_dis: NATURAL_64
		do
			if attached output_file as l_stream then
				create l_counts.make_filled (0, 1, max_tables + extra_indexes)
				l_counts [t_string + 1] := strings.size
				l_counts [t_us + 1] := us.size
				l_counts [t_guid + 1] := guid.size
				l_counts [t_blob + 1] := blob.size

				across 0 |..| (max_tables - 1) as i loop
					l_counts [i + 1] := tables [i + 1].size.to_natural_64
				end

				across methods as m loop
					if m.flags & {PE_METHOD}.cil /= 0 then
						if m.flags & 3 = {PE_METHOD}.fatformat then
							align (3)
						end
						l_dis := m.write (l_counts, l_stream)
					end
				end
			end
			Result := True
		end

	write_metadata_headers: BOOLEAN
		local
			n: INTEGER
			l_flags: NATURAL_16
			l_data: NATURAL_16
			l_names: STRING_32
		do
			align (4)
			put_metadata_headers (meta_header1)
			n := rtv_string.count
			if n \\ 4 /= 0 then
				n := n + 4 - (n \\ 4)
			end
			put_integer_32 (n)
			put_string (rtv_string)
			align (4)
			l_flags := 0
			put_natural_16 (0)
			l_data := 5
			put_natural_16 (l_data)
			across 1 |..| 5 as i loop

					-- TODO double check
					-- C++ code uses put(&streamHeaders_[i][0], 4);
				put_natural_32 (stream_headers [i, 1].to_natural_32)
				put_natural_32 (stream_headers [i, 2].to_natural_32)

					-- Adding a null character a the end of the string
					-- C++ code uses put(streamNames_[i], strlen(streamNames_[i]) + 1);
				l_names := stream_names [i].twin
				l_names.append_character ('%U')
				put_string (l_names)
				align (4)
			end
			Result := True
		end

	write_tables: BOOLEAN
		local
			l_counts: ARRAY [NATURAL_64]
			l_item: NATURAL_32
			l_buffer: ARRAY [NATURAL_8]
			l_sz: NATURAL_32
		do
			if attached tables_header as l_tables_header
			then
				create l_counts.make_filled (0, 1, max_tables + extra_indexes)
				l_counts [t_string + 1] := strings.size
				l_counts [t_us + 1] := us.size
				l_counts [t_guid + 1] := guid.size
				l_counts [t_blob + 1] := blob.size

				put_tables_header (l_tables_header)

				across 0 |..| (max_tables - 1) as i loop
					l_counts [i + 1] := tables [i + 1].size.to_natural_64
					l_item := l_counts [i + 1].to_natural_32
					if l_item /= 0 then
						put_natural_32 (l_item)
					end
				end

				across 0 |..| (max_tables - 1) as i loop
					l_item := tables [i + 1].size.to_natural_32
					across 0 |..| (l_item - 1).to_integer_32 as j loop
						create l_buffer.make_filled (0, 1, 512)
						l_sz := tables [i + 1].table [j + 1].render (l_counts, l_buffer).to_natural_32
							-- TODO double check
							-- this is not efficient.
						put_array (l_buffer.subarray (1, l_sz.as_integer_32))
					end
				end
				align (4)
					-- Commented code in C++ implementation to be double check.
					-- Dword n = 0
					-- put(&n, sizeof(n));
			end
			Result := True
		end

	write_strings: BOOLEAN
		do
			put_array_with_size (strings.base.to_array, strings.size.to_integer_32)
			align (4)
			Result := True
		end

	write_us: BOOLEAN
		do
			if us.size = 0 then
				put_array (default_us)
			else
				put_array_with_size (us.base.to_array, us.size.to_integer_32)
			end
			align (4)
			Result := True
		end

	write_guid: BOOLEAN
		do
			put_array_with_size (guid.base.to_array, guid.size.to_integer_32)
			align (4)
			Result := True
		end

	write_blob: BOOLEAN
		do
			put_array_with_size (blob.base.to_array, blob.size.to_integer_32)
			align (4)
			Result := True
		end

	write_imports: BOOLEAN
		local
			l_dir: ARRAY [PE_IMPORT_DIR]
			l_item: NATURAL_32
			l_main_name: NATURAL_32
		do
			if attached pe_header as l_pe_header
			then
				create l_dir.make_filled (create {PE_IMPORT_DIR}, 1, 2)
				l_dir [1] := (create {PE_IMPORT_DIR})
				l_dir [1].thunk_pos2 := l_pe_header.import_rva + 2 * {PE_IMPORT_DIR}.size_of
				l_item := (l_dir [1].thunk_pos2 + 8).to_natural_32
				if l_item \\ 16 /= 0 then
					l_item := l_item + 16 - (l_item \\ 16)
				end
				l_main_name := l_item
				l_item := l_item + 2
				l_item := l_item + 12 -- in C++ sizeof("_CorXXXMain");
				l_dir [1].dll_name := l_item.to_integer_32
				l_dir [1].thunk_pos := l_pe_header.iat_rva
				put_import_dir (l_dir)
				put_natural_32 (l_main_name)
				l_item := 0
					-- thunk
				put_natural_32 (l_item)
				align (16)
					-- ord
				put_natural_16 (l_item.to_natural_16)
				if dll then
					put_string (create {STRING_32}.make_from_string ("_CorDllMain"))
				else
					put_string (create {STRING_32}.make_from_string ("mscoree.dll"))
				end
				align (4)
			end
			Result := True
		end

	write_entry_point: BOOLEAN
		local
			l_item: NATURAL_32
		do
			if attached pe_objects as l_pe_objects and then
				attached pe_header as l_pe_header
			then
				l_item := 0
				put_natural_16 (l_item.to_natural_16)
				l_item := 0x25ff -- JMP[xxx]
				put_natural_16 (l_item.to_natural_16)
				l_item := l_pe_objects [1].virtual_addr.to_natural_32 + l_pe_header.image_base.to_natural_32
				put_natural_32 (l_item)
			end
			Result := True
		end

	write_version_info (a_file_name: STRING_32): BOOLEAN
		local
			l_res_table: PE_RESOURCE_DIR_TABLE
			l_dir: PE_RESOURCE_DIR_ENTRY
			l_resource_data: PE_RESOURCE_DATA_ENTRY
			l_n1: NATURAL_16
			l_version_info_string: STRING_32
			l_version_info: PE_FIXED_VERSION_INFO
			l_n: NATURAL_64
			l_path: PATH
			l_index: INTEGER
			l_file_name: STRING_32
			l_versions: ARRAYED_LIST [STRING_32]
			l_buf: STRING_32
		do
			if attached pe_header as l_pe_header then
				align (file_align)
				create l_res_table
				create l_dir
				l_res_table.ident_entry := 1

					--version info
				l_dir.rva_or_id := 16

					-- points to a subdir
				l_dir.escape := 1

				l_dir.subdir_or_data := {PE_RESOURCE_DIR_TABLE}.size_of + {PE_RESOURCE_DIR_ENTRY}.size_of
				put_resource_dir_table (l_res_table)
				put_resource_dir_entry (l_dir)

					-- index
				l_dir.rva_or_id := 1
				l_dir.subdir_or_data := l_dir.subdir_or_data + {PE_RESOURCE_DIR_TABLE}.size_of + {PE_RESOURCE_DIR_ENTRY}.size_of
				put_resource_dir_table (l_res_table)
				put_resource_dir_entry (l_dir)

				l_dir.rva_or_id := 0
					-- points to a data table
				l_dir.escape := 0
				l_dir.subdir_or_data := l_dir.subdir_or_data + {PE_RESOURCE_DIR_TABLE}.size_of + {PE_RESOURCE_DIR_ENTRY}.size_of
				put_resource_dir_table (l_res_table)
				put_resource_dir_entry (l_dir)

				create l_resource_data
				l_resource_data.rva := l_dir.subdir_or_data + l_pe_header.resource_rva + {PE_RESOURCE_DATA_ENTRY}.size_of
				l_resource_data.size := l_pe_header.resource_size - l_dir.subdir_or_data + {PE_RESOURCE_DATA_ENTRY}.size_of
				put_resource_data_entry (l_resource_data)
				l_n1 := l_resource_data.size_of.to_natural_16
					-- length of resource
				put_natural_16 (l_n1)
					-- length of the first record
				l_n1 := 0x34
				put_natural_16 (l_n1)
					-- Type bin
				l_n1 := 0
				put_natural_16 (l_n1)

					-- the strings in this section presume WINDOWS compilers which compile
					-- strings to two Bytes, GNU compilers would compile them to 4.
					--| we don't have put_string_32
				put_string_32 ({STRING_32} "VS_VERSION_INFO")
				align (4)

				create l_version_info
				l_version_info.signature := 0x0FEEF04BD
				l_version_info.struct_version := 0x10000
				l_version_info.file_flags_mask := 0x3f
				l_version_info.file_os := 4
				l_version_info.file_type := 1
				l_version_info.file_version_ms := (file_version [4] |<< 16) + file_version [3]
				l_version_info.file_version_ls := (file_version [2] |<< 16) + file_version [1]
				l_version_info.product_version_ms := (product_version [4] |<< 16) + product_version [3]
				l_version_info.product_version_ls := (product_version [2] |<< 16) + product_version [1]
				put_version_info (l_version_info)

					-- length
				l_n1 := 0x44
				put_natural_16 (l_n1)
					-- value length
				l_n1 := 0
				put_natural_16 (l_n1)
					--type text
				l_n1 := 1
				put_natural_16 (l_n1)
				put_string_32 ({STRING_32} "VarFileInfo")
				align (4)
					-- length (nester)
				l_n1 := 0x24
				put_natural_16 (l_n1)
					-- value length
				l_n1 := 4
				put_natural_16 (l_n1)
					-- type text
				l_n1 := 1
				put_natural_16 (l_n1)
				put_string_32 ({STRING_32} "VarFileInfo")
				align (4)
					-- C++ uses Translation with the size of Language.
					-- seems to be wrong.
				put_string_32 ({STRING_32} "Translation")
				align (4)
				l_n := language |<< 16
				put_natural_32 (l_n.to_natural_32)

					-- C++ code leave the \ in the filename, seems to be wrong.
					-- Check PEWriter::WriteVersionInfo
				create l_path.make_from_string (a_file_name)
				l_index := l_path.components.count
				l_file_name := l_path.components [l_index].name

				l_n := l_file_name.count.to_natural_64
				l_n := l_n + 368

				create l_versions.make (3)
				l_versions.force (file_version [1].out + "." + file_version [2].out + "." + file_version [3].out + "." + file_version [4].out)
				l_n := l_n + l_versions [1].count.to_natural_64
				l_versions.force (file_version [1].out + "." + file_version [2].out + "." + file_version [3].out + "." + file_version [4].out)
				l_n := l_n + l_versions [2].count.to_natural_64
				l_versions.force (file_version [1].out + "." + file_version [2].out + "." + file_version [3].out + "." + file_version [4].out)
				l_n := l_n + l_versions [3].count.to_natural_64

					-- outer length
				l_n1 := (l_n + 0x24).to_natural_16
				put_natural_16 (l_n1)

					-- value length
				l_n1 := 0
				put_natural_16 (l_n1)

					-- type text
				l_n1 := 1
				put_natural_16 (l_n1)

					-- inner length
				l_n1 := l_n.to_natural_16
				put_natural_16 (l_n1)

					-- value length
				l_n1 := 0
				put_natural_16 (l_n1)

					--type text
				l_n1 := 1
				put_natural_16 (l_n1)

				l_buf := language.to_hex_string.to_string_32
				l_buf.append_character ('%U')
				put_string_32 (l_buf)
				align (4)
				version_string ({STRING_32} "FileDescription", " ")
				version_string ({STRING_32} "FileVersion", l_versions [1])
				version_string ({STRING_32} "InternalName", l_file_name)
				version_string ({STRING_32} "LegalCopyright", " ")
				version_string ({STRING_32} "OriginalFileName", l_file_name)
				version_string ({STRING_32} "ProductVersion", l_versions [2])
				version_string ({STRING_32} "Assembly Version", l_versions [3])
			end
			Result := True

		end

	write_relocs: BOOLEAN
		local
			n: NATURAL_32
			n1: NATURAL_16
			l_value: INTEGER
		do
			l_value := 0xfff
			if attached pe_header as l_pe_header then
				align (file_align)
				n1 := (({PE_HEADER_CONSTANTS}.pe_fixup_highlow |<< 12) | (n.to_integer_32 & 0xfff)).to_natural_16
				n := (n.to_integer_32 & l_value.bit_not).to_natural_32
				put_natural_32 (n)
					-- block size
				n := 12
				put_natural_32 (n)
				put_natural_16 (n1)
				n1 := 0
				put_natural_16 (n1)
					-- aligns the end of the file
				align (file_align)
			end
			Result := True
		end

feature {NONE} -- Output Helpers

	version_string (a_name: STRING_32; a_value: STRING_32)
			-- a helper to put a string into the string area of the version information
		local
			n1: NATURAL_16
			n: NATURAL_32
			l_buf: STRING_32
			l_name: STRING_32
			l_index: INTEGER
		do

			n1 := (a_name.count * 2 + a_value.count * 2 + 6 + 2 + 2).to_natural_16
			n := (a_name.count + 2).to_natural_32
			if n \\ 4 /= 0 then
				n1 := n1 + (n - n \\ 4).to_natural_16
			end
			n := ((a_value.count + 1) * 2).to_natural_32
			if n \\ 4 /= 0 then
				n1 := n1 + (n - n \\ 4).to_natural_16
			end
				-- length
			put_natural_16 (n1)
				-- value length
			n1 := ((a_value.count + 1) * 2).to_natural_16
				-- length
			put_natural_16 (n1)
			create l_buf.make_from_string_general (a_value)
			l_buf.append_character ('%U')
				-- type string
			n1 := 1
				-- length
			put_natural_16 (n1)

				-- put_wide_character.
			create l_name.make_from_string_general (a_name)
			l_name.append_character ('%U')
			l_index := l_name.count // 2
			across 1 |..| l_index as i loop
				put_natural_16 (l_name.code (i).to_natural_16)
			end
			put_character (l_name.at (l_index + 1).to_character_8)

			align (4)
			across 1 |..| ((n1 * 2).to_integer_32 - 1) as i loop
				put_natural_16 (l_buf.code (i).to_natural_16)
			end
			align (4)
		end

	put (a_data: ANY; a_size: NATURAL)
		do
			if attached output_file as l_file then
					-- outputFile_->write((char *)data, size)
			end
		end

	put_mz_header (a_data: ARRAY [NATURAL_8])
		do
			if attached output_file as l_stream then
				l_stream.put_string (byte_array_to_string (a_data, a_data.count))
			end
		end

	put_pe_header (a_header: PE_HEADER)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_header.managed_pointer)
			end
		end

	put_pe_objects (a_objects: LIST [PE_OBJECT])
		local
			l_mp: MANAGED_POINTER
		do
			if attached output_file as l_stream then
				create l_mp.make (0)
				across a_objects as l_item loop
					l_mp.append (l_item.managed_pointer)
				end
				l_stream.put_managed_pointer (l_mp)
			end
		end

	put_array (a_data: ARRAY [NATURAL_8])
		local
			mp: MANAGED_POINTER
		do
			fixme ("Double check if we need to merge the current code with put_mz_header")
			create mp.make (a_data.count)
			mp.put_array (a_data, 0)
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (mp)
			end
		end

	put_array_with_size (a_data: ARRAY [NATURAL_8]; a_size: INTEGER_32)
		local
			mp: MANAGED_POINTER
		do
			fixme ("Double check if we need to merge the current code with put_mz_header")
			create mp.make (a_size)
			mp.put_array (a_data.subarray (1, a_size), 0)
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (mp)
			end
		end

	put_natural_32 (a_value: NATURAL_32)
		do
			if attached output_file as l_stream then
				l_stream.put_natural_32 (a_value)
			end
		end

	put_natural_64 (a_value: NATURAL_64)
		do
			if attached output_file as l_stream then
				l_stream.put_natural_64 (a_value)
			end
		end

	put_integer_32 (a_value: INTEGER_32)
		do
			if attached output_file as l_stream then
				l_stream.put_integer (a_value)
			end
		end

	put_natural_16 (a_value: NATURAL_16)
		do
			if attached output_file as l_stream then
				l_stream.put_natural_16 (a_value)
			end
		end

	put_core20_header (a_core20_header: PE_DOTNET_COR20_HEADER)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_core20_header.managed_pointer)
			end
		end

	put_metadata_headers (a_header: PE_DOTNET_META_HEADER)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_header.managed_pointer)
			end
		end

	put_string (a_str: READABLE_STRING_GENERAL)
		do
			if attached output_file as l_stream then
				l_stream.put_string (a_str)
			end
		end

	put_tables_header (a_header: PE_DOTNET_META_TABLES_HEADER)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_header.managed_pointer)
			end
		end

	put_import_dir (a_dirs: ARRAY [PE_IMPORT_DIR])
		local
			l_mp: MANAGED_POINTER
		do
			if attached output_file as l_stream then
				create l_mp.make (0)
				across a_dirs as l_dir loop
					l_mp.append (l_dir.managed_pointer)
				end
				l_stream.put_managed_pointer (l_mp)
			end
		end

	put_resource_dir_table (a_table: PE_RESOURCE_DIR_TABLE)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_table.managed_pointer)
			end
		end

	put_resource_dir_entry (a_entry: PE_RESOURCE_DIR_ENTRY)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_entry.managed_pointer)
			end
		end

	put_resource_data_entry (a_data: PE_RESOURCE_DATA_ENTRY)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_data.managed_pointer)
			end
		end

	put_version_info (a_version_info: PE_FIXED_VERSION_INFO)
		do
			if attached output_file as l_stream then
				l_stream.put_managed_pointer (a_version_info.managed_pointer)
			end
		end

	put_string_32 (a_str: READABLE_STRING_32)
		do
			across 1 |..| a_str.count as i loop put_natural_32 (a_str.code (i)) end
		end

	put_character (a_char: CHARACTER_8)
		do
			if attached output_file as l_stream then
				l_stream.put_character (a_char)
			end
		end

	align (a_align: NATURAL_64)
		local
			l_current_offset: NATURAL_64
			l_array: ARRAY [NATURAL_8]
			l_bytes_needed: NATURAL_64

		do
			if attached output_file as l_stream then
					-- Current offset.
				l_current_offset := l_stream.count.to_natural_64

					-- Check if the current offset is align with the desired value.
				if (l_current_offset \\ a_align) /= 0 then
						-- assumes the alignments are 65536 or less

						-- Compute the number of 0 bytes needed to align the offset.
					l_bytes_needed := a_align - (l_current_offset \\ a_align)
					create l_array.make_filled (0, 1, l_bytes_needed.to_integer_32)
					put_array (l_array)
				end
			end
		end

feature -- Constants

	MAX_PE_OBJECTS: INTEGER = 4
			-- the maximum number of PE objects we will generate
			-- this includes the following:
			-- 	.text / cildata
			-- 	.reloc (for the single necessary reloc entry)
			-- 	.rsrc (not implemented yet, will hold version info record)

feature {NONE} -- Helper features

	byte_array_to_string (a_arr: ARRAY [NATURAL_8]; a_len: INTEGER): STRING_32
		do
			create Result.make (a_len)
			across 1 |..| a_len as i loop
				Result.append_character (a_arr [i].to_character_8)
			end
		end

feature {NONE} -- C++ externals

	c_create_guid (a_guid: POINTER)
		external "C++ inline use <random>, <array>, <algorithm>, <functional>"
		alias
			"{
			std::array<unsigned char, 128 / 8> rnd;

		    std::uniform_int_distribution<int> distribution(0, 0xff);
		    // note that this whole thing will fall apart if the C++ lib uses
		    // a prng with constant seed for the random_device implementation.
		    // that shouldn't be a problem on OS we are interested in.
		    std::random_device dev;
		    std::mt19937 engine(dev());
		    auto generator = std::bind(distribution, engine);

		    std::generate(rnd.begin(), rnd.end(), generator);

		    // make it a valid version 4 (random) GUID
		    // remember that on windows GUIDs are native endianness so this may need
		    // work if you port it
		    rnd[7 /*6*/] &= 0xf;
		    rnd[7 /*6*/] |= 0x40;
		    rnd[9 /*8*/] &= 0x3f;
		    rnd[9 /*8*/] |= 0x80;

		    memcpy($a_guid, rnd.data(), rnd.size());
			}"
		end

end
