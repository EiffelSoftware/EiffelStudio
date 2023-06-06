note
	description: "[
			MD_EMIT represents a set of in-memory metadata tables and creates a unique module version identifier (GUID) for the metadata. 
			The class has the ability to add entries to the metadata tables and define the assembly information in the metadata.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_EMIT

inherit

	MD_EMIT_I

	MD_EMIT_SHARED

	PE_TABLE_CONSTANTS

	REFACTORING_HELPER
		export {NONE} all end

create
	make

feature {NONE}

	make
			-- Create a new instance of METADATA_EMIT
			--| creates a set of in-memory metadata tables,
			--| generates a unique GUID (module version identifier, or MVID) for the metadata,
		do
				-- Using PE_WRITER to get access helper features.
			create pe_writer.make (True, False, "")
			create stream_headers.make_filled (0, 5, 2)
			initialize_metadata_tables
			initialize_guid
			initialize_unit
			create tables_header
			create assembly_emitter.make (tables, pe_writer)
				-- we don't initialize the compilation unit since we don't provide the name of it (similar to the COM interface)
			initialize_entry_size

		ensure
			module_guid_set: module_guid.count = 16
		end

	initialize_metadata_tables
			-- Initialize an in-memory metadata tables
		do
			create tables.make_empty ({PE_TABLE_CONSTANTS}.max_tables)
			across 0 |..| ({PE_TABLE_CONSTANTS}.max_tables - 1) as i loop
				tables.force ((create {MD_TABLES}.make), i)
			end
		end

	initialize_entry_size
		do
			create entry_sizes.make (31)
			entry_sizes.force (agent module_table_entry_size, {PE_TABLES}.tModule.to_integer_32)
			entry_sizes.force (agent type_ref_entry_size, {PE_TABLES}.tTypeRef.to_integer_32)
			entry_sizes.force (agent type_def_table_entry_size, {PE_TABLES}.tTypeDef.to_integer_32)
			entry_sizes.force (agent field_table_entry_size, {PE_TABLES}.tField.to_integer_32)
			entry_sizes.force (agent method_def_table_entry_size, {PE_TABLES}.tMethodDef.to_integer_32)
			entry_sizes.force (agent param_table_entry_size, {PE_TABLES}.tParam.to_integer_32)
			entry_sizes.force (agent interface_impl_table_entry_size, {PE_TABLES}.tInterfaceImpl.to_integer_32)
			entry_sizes.force (agent member_ref_table_entry_size, {PE_TABLES}.tMemberRef.to_integer_32)
			entry_sizes.force (agent constant_table_entry_size, {PE_TABLES}.tConstant.to_integer_32)
			entry_sizes.force (agent custom_attribute_table_entry_size, {PE_TABLES}.tCustomAttribute.to_integer_32)
			entry_sizes.force (agent field_marshal_table_entry_size, {PE_TABLES}.tFieldMarshal.to_integer_32)
			entry_sizes.force (agent decl_security_table_entry_size, {PE_TABLES}.tDeclSecurity.to_integer_32)
			entry_sizes.force (agent class_layout_table_entry_size, {PE_TABLES}.tClassLayout.to_integer_32)
			entry_sizes.force (agent field_layout_table_entry_size, {PE_TABLES}.tFieldLayout.to_integer_32)
			entry_sizes.force (agent standalone_sig_table_entry_size, {PE_TABLES}.tStandaloneSig.to_integer_32)
			entry_sizes.force (agent property_map_table_entry_size, {PE_TABLES}.tPropertyMap.to_integer_32)
			entry_sizes.force (agent property_table_entry_size, {PE_TABLES}.tProperty.to_integer_32)
			entry_sizes.force (agent method_semantics_table_entry_size, {PE_TABLES}.tMethodSemantics.to_integer_32)
			entry_sizes.force (agent method_impl_table_entry_size, {PE_TABLES}.tMethodImpl.to_integer_32)
			entry_sizes.force (agent module_ref_table_entry_size, {PE_TABLES}.tModuleRef.to_integer_32)
			entry_sizes.force (agent type_spec_table_entry_size, {PE_TABLES}.tTypeSpec.to_integer_32)
			entry_sizes.force (agent impl_map_table_entry_size, {PE_TABLES}.tImplMap.to_integer_32)
			entry_sizes.force (agent field_rva_table_entry_size, {PE_TABLES}.tFieldRVA.to_integer_32)
			entry_sizes.force (agent assembly_table_entry_size, {PE_TABLES}.tAssemblyDef.to_integer_32)
			entry_sizes.force (agent assembly_ref_table_entry_size, {PE_TABLES}.tAssemblyRef.to_integer_32)
			entry_sizes.force (agent file_table_entry_size, {PE_TABLES}.tFile.to_integer_32)
			entry_sizes.force (agent exported_type_table_entry_size, {PE_TABLES}.tExportedType.to_integer_32)
			entry_sizes.force (agent manifest_resource_table_entry_size, {PE_TABLES}.tManifestResource.to_integer_32)
			entry_sizes.force (agent nested_class_table_entry_size, {PE_TABLES}.tNestedClass.to_integer_32)
			entry_sizes.force (agent generic_param_table_entry_size, {PE_TABLES}.tGenericParam.to_integer_32)
			entry_sizes.force (agent method_spec_table_entry_size, {PE_TABLES}.tMethodSpec.to_integer_32)
			entry_sizes.force (agent generic_param_constraint_table_entry_size, {PE_TABLES}.tGenericParamConstraint.to_integer_32)
		end

	initialize_unit
			-- Initialize the compilation unit
		local
			l_type_def: PE_TYPEDEF_OR_REF
			l_table: PE_TABLE_ENTRY_BASE
		do
				-- initializes the necessary metadata tables for the module and type definition entries.
			module_index := pe_writer.hash_string ({STRING_32} "<Module>")

			create l_type_def.make_with_tag_and_index ({PE_TYPEDEF_OR_REF}.typedef, 0)
			create {PE_TYPE_DEF_TABLE_ENTRY} l_table.make_with_data (0, module_index, 0, l_type_def, 1, 1)
			pe_index := add_table_entry (l_table)
		end

	initialize_guid
			-- Create a unide GUID.
			--| The module version identifier.
		do
			module_GUID := pe_writer.create_guid
			guid_index := pe_writer.hash_guid (module_guid)
		end

feature -- Access

	tables: SPECIAL [MD_TABLES]
			--  in-memory metadata tables

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.
			--| TODO, we don't need the full class we need to extract the needed features.

feature -- Access

	module_GUID: ARRAY [NATURAL_8]
			-- Unique GUID
			--|the length should be 16.

	guid_index: NATURAL_64
			-- Guid index

	module_index: NATURAL_64
			-- Index of the GUID
			-- where it should be located in the metadata tables.

	tables_header: PE_DOTNET_META_TABLES_HEADER
			-- `tables_header'

	stream_headers: ARRAY2 [NATURAL_64]
			-- defined as streamHeaders_[5][2];

feature -- Status report

	is_successful: BOOLEAN
			-- Was last call successful?
		do
			to_implement ("TODO: for now, always return True")
			Result := True
		end

	appending_to_file_supported: BOOLEAN = True
			-- Is `append_to_file` supported?

feature -- Access

	save_size: INTEGER
			-- Size of Current emitted assembly in memory if we were to emit it now.
		do
				--| Computes the size of the metadata for the current emitted assembly.
				--| Iterate through each table and multiplying the size of the table by the number of entries in the table.
				--| Adds the size of each heap (string, user string, blob, and GUID)
				--| The size of the metadata header and table header.
				--| The final result is the size of the metadata in bytes.

			Result := compute_metadata_size
		end

	entry_sizes: HASH_TABLE [FUNCTION [INTEGER], INTEGER]
			-- Hash table of functions to compute the size of a Metadata Table.
			-- The key is the Metadata Table Key.

	retrieve_user_string (a_token: INTEGER): STRING_32
			-- Retrieve the user string for `token'.
		require
			valid_user_string_token: is_user_string_token (a_token)
		local
			l_index: INTEGER_32
			l_length: INTEGER_32
			l_bytes: STRING_8
			i: INTEGER_32
			j: INTEGER_32
			us_heap: SPECIAL [NATURAL_8]
		do
				-- <<0, 1, 58, 0, 36, 0, ..... >>
				--      ^   - -
				-- Copy the Userstring heap,
				-- the underlying String needs to be retrieved as UTF-16
				-- TODO check if we have an efficient algorithm to
				-- convert an array of bytes to utf-16.

			us_heap := pe_writer.us.base

				-- Compute the index.
			l_index := a_token - 0x70000000 -- 0x70 table type: UserString heap

				-- Get the length of the string, reading the next byte.
				-- Per character we use two bytes and it ends with a null character.
			l_length := us_heap [l_index] -- 0-based container

			i := l_index
			if us_heap [i] < 128 then -- 0x80 = 1000 0000
				l_length := us_heap [i]
				i := i + 1
			elseif us_heap [i] < 192 then -- 0xC0 = 1100 0000
				-- 256 = 0x100 = 1 0000 0000
				l_length := (us_heap [i] - 128) * 256 + us_heap [i + 1]
				i := i + 2
			else
				-- 16777216 = 0x100 0000 = 1 00000000 00000000 00000000
				-- 65536 	=   0x1 0000 =          1 00000000 00000000
				-- 256 		=      0x100 =                   1 00000000
				l_length := (us_heap [i] - 192) * 16777216
							+ us_heap [i + 1] * 65536
							+ us_heap [i + 2] * 256
							+ us_heap [i + 3]
				i := i + 4
			end

			create l_bytes.make (l_length - 1)
			from
				j := 0
			until
				j > l_length - 1 --| Do not load the final flag 0 or 1
			loop
				l_bytes.append_character (us_heap[i + j].to_character_8)
				j := j + 1
			end

			Result := {UTF_CONVERTER}.utf_16le_string_8_to_string_32 (l_bytes)
		end

	is_user_string_token (a_token: INTEGER_32): BOOLEAN
			-- Checks if the given integer value `a_token` corresponds to a valid user string token.
		do
			Result := (a_token >= 0x70000000) and (a_token < (0x70000000 + pe_writer.us.size.to_integer_32))
		end

feature {NONE} -- Implementation

	compute_metadata_size: INTEGER
			--| Computes the size of the metadata for the current emitted assembly.
			--| Iterate through each table and multiplying the size of the table by the number of entries in the table.
			--| Adds the size of each heap (string, user string, blob, and GUID)
			--| The size of the metadata header and table header.
			--| The final result is the size of the metadata in bytes.
		note
			EIS: "name=Metadata Root", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=297", "protocol=uri"
		local
			l_current_rva: NATURAL_32
			l_counts: ARRAY [NATURAL_64]
			l_temp: NATURAL_32
			l_buffer: ARRAY [NATURAL_8]
		do

			l_current_rva := 16
				-- metadata header offest
				-- Signature + Major Version + MinorVersion + Reserved + Length

			l_current_rva := l_current_rva + pe_writer.compute_rtv_string_size
				-- Version.
				--| The Version string shall be
				--| Standard CLI 2005

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end
				-- Padding to next 4 byte boundary

			l_current_rva := l_current_rva + 2
				-- flags

			l_current_rva := l_current_rva + 2
				-- streams, will be 5 in our implementation
				-- check stream_names feature.

				-- StreamHeaders. Array of n StreamHdr structures
				-- "#~", "#Strings", "#US", "#GUID", "#Blob"
				--   1 ,      2    ,   3  ,     4  ,    5
			across pe_writer.stream_names as elem loop
				l_current_rva := l_current_rva + 8 + (elem.count + 1).to_natural_32
				if (l_current_rva \\ 4) /= 0 then
					l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
				end
			end

			stream_headers [1, 1] := l_current_rva

			tables_header.major_version := 2
			tables_header.reserved2 := 1
			tables_header.mask_sorted := ({INTEGER_64} 0x1600 |<< 32) + 0x3325FA00
			if strings_heap_size = 65536 then
				tables_header.heap_offset_sizes := tables_header.heap_offset_sizes | 1
			end
			if guid_heap_size >= 65536 then
				tables_header.heap_offset_sizes := tables_header.heap_offset_sizes | 2
			end
			if blob_heap_size >= 65536 then
				tables_header.heap_offset_sizes := tables_header.heap_offset_sizes | 4
			end

			create l_counts.make_filled (0, 1, Max_tables + Extra_indexes)
			l_counts [t_string + 1] := strings_heap_size
			l_counts [t_us + 1] := us_heap_size
			l_counts [t_guid + 1] := guid_heap_size
			l_counts [t_blob + 1] := blob_heap_size

			across 0 |..| (max_tables - 1) as ic loop
				if not tables [ic].is_empty then
					l_counts [ic + 1] := tables [ic].size.to_natural_32
					tables_header.mask_valid := tables_header.mask_valid | ({INTEGER_64} 1 |<< ic)
					l_temp := l_temp + 1
				end
			end
			l_current_rva := l_current_rva + {PE_DOTNET_META_TABLES_HEADER}.size_of.to_natural_32
				-- tables header
			l_current_rva := l_current_rva + (l_temp * ({PLATFORM}.natural_32_bytes).to_natural_32)
				--table counts
				-- Dword is 4 bytes.

			across 0 |..| (max_tables - 1) as ic loop
				if l_counts [ic + 1] /= 0 then
					create l_buffer.make_filled (0, 1, 512)
					l_temp := tables [ic].table [1].render (l_counts, l_buffer).to_natural_32
					l_temp := l_temp * (l_counts [ic + 1]).to_natural_32
					l_current_rva := l_current_rva + l_temp
				end
			end

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [1, 2] := l_current_rva - stream_headers [1, 1]
			stream_headers [2, 1] := l_current_rva
			l_current_rva := l_current_rva + pe_writer.strings.size.to_natural_32

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [2, 2] := l_current_rva - stream_headers [2, 1]
			stream_headers [3, 1] := l_current_rva
			if pe_writer.us.size = 0 then
				l_current_rva := l_current_rva + pe_writer.default_us.count.to_natural_32
					-- US May be empty in our implementation we put an empty string there
			else
				l_current_rva := l_current_rva + pe_writer.us.size.to_natural_32
			end

				-- TODO refactor this code into a feature.
			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [3, 2] := l_current_rva - stream_headers [3, 1]
			stream_headers [4, 1] := l_current_rva
			l_current_rva := l_current_rva + pe_writer.guid.size.to_natural_32

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [4, 2] := l_current_rva - stream_headers [4, 1]
			stream_headers [5, 1] := l_current_rva
			l_current_rva := l_current_rva + pe_writer.blob.size.to_natural_32

			if (l_current_rva \\ 4) /= 0 then
				l_current_rva := l_current_rva + 4 - (l_current_rva \\ 4)
			end

			stream_headers [5, 2] := l_current_rva - stream_headers [5, 1]

			Result := l_current_rva.to_integer_32
		end

feature -- Save

	assembly_memory: MANAGED_POINTER
			-- Save Current into a MEMORY location.
			-- Allocated here and needs to be freed by caller.
		do
			create Result.make (save_size)
			to_implement ("TODO implement, double check if we really need it")
		ensure
			valid_result: Result /= Void
		end

	save (f_name: CLI_STRING)
			-- Save current assembly to file `f_name'.
		local
			l_file: FILE
		do
				-- This code also writes the PE_DOTNET_META_HEADER
				-- see II.24.2 File headers, II.24.2.1 Metadata root
				-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=297
				-- and the rtv_string.

			create {RAW_FILE} l_file.make_create_read_write (f_name.string_32)
			append_to_file (l_file)
			l_file.close
		end

	append_to_file (f: FILE)
			-- Append current assembly to file `f`.
		do
				-- This code also writes the PE_DOTNET_META_HEADER
				-- see II.24.2 File headers, II.24.2.1 Metadata root
				-- https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=297
				-- and the rtv_string.

			write_metadata_headers (f)
			write_tables (f)
			write_strings (f)
			write_us (f)
			write_guid (f)
			write_blob (f)

				-- Workaround to align
			if not is_aligned (f, 4) then
				check should_not_happen: False end
 				align (f, 4)
			end
		end

feature {NONE} -- Implementation

	write_tables (a_file: FILE)
			-- Write the metadata table to a binary file `a_file'.
		require
			open_write: a_file.is_open_write
		local
			l_counts: ARRAY [NATURAL_64]
			l_item: NATURAL_32
			l_buffer: ARRAY [NATURAL_8]
			l_sz: NATURAL_32
		do
			create l_counts.make_filled (0, 1, max_tables + extra_indexes)
			l_counts [t_string + 1] := strings_heap_size
			l_counts [t_us + 1] := us_heap_size
			l_counts [t_guid + 1] := guid_heap_size
			l_counts [t_blob + 1] := blob_heap_size

			put_tables_header (a_file, tables_header)

			across 0 |..| (max_tables - 1) as i loop
				l_counts [i + 1] := tables [i].size.to_natural_64
				l_item := l_counts [i + 1].to_natural_32
				if l_item /= 0 then
					a_file.put_natural_32 (l_item)
				end
			end

			across 0 |..| (max_tables - 1) as i loop
				l_item := tables [i].size.to_natural_32
				across 0 |..| (l_item - 1).to_integer_32 as j loop
					create l_buffer.make_filled (0, 1, 512)
					l_sz := tables [i].table [j + 1].render (l_counts, l_buffer).to_natural_32
						-- TODO double check
						-- this is not efficient.
					put_array (a_file, l_buffer.subarray (1, l_sz.as_integer_32))
				end
			end
			align (a_file, 4)
		end

	write_strings (a_file: FILE)
			-- Write the string heap to a binary file.
			-- II.24.2.3 #Strings heap
		require
			open_write: a_file.is_open_write
		do
			put_array_with_size (a_file, pe_writer.strings.base.to_array, pe_writer.strings.size.to_integer_32)
			align (a_file, 4)
		end

	write_us (a_file: FILE)
			-- Write the user string heap to a binary file
			-- II.24.2.4 #US heap
		require
			open_write: a_file.is_open_write
		do
				-- TODO check how to write String as a manifest string instead of a Byte Array.
			if pe_writer.us.size = 0 then
				put_array (a_file, pe_writer.default_us)
			else
				put_array_with_size (a_file, pe_writer.us.base.to_array, pe_writer.us.size.to_integer_32)
			end
			align (a_file, 4)
		end

	write_guid (a_file: FILE)
			-- Write the guid heap to a file.
			-- II.24.2.5 #GUID heap
		require
			open_write: a_file.is_open_write
		do
			put_array_with_size (a_file, pe_writer.guid.base.to_array, pe_writer.guid.size.to_integer_32)
			align (a_file, 4)
		end

	write_blob (a_file: FILE)
			-- Write the blob heap to a binary file
			-- II.24.2.4 #Blob heap
		require
			open_write: a_file.is_open_write
		do
			put_array_with_size (a_file, pe_writer.blob.base.to_array, pe_writer.blob.size.to_integer_32)
			align (a_file, 4)
		end

	write_metadata_headers (a_file: FILE)
			-- Write the metadata headers to binary file.
		require
			open_write: a_file.is_open_write
		local
			n: INTEGER
			l_flags: NATURAL_16
			l_data: NATURAL_16
			l_names: STRING_32
			l_rvt_string: STRING_32
		do
				--| TODO: check if we need to use
				--| UTF-8 for l_names.
			align (a_file, 4)
			put_metadata_headers (a_file, pe_writer.meta_header1)
			l_rvt_string := pe_writer.rtv_string + "%U"
			n := l_rvt_string.count
			if n \\ 4 /= 0 then
				n := n + 4 - (n \\ 4)
			end
			a_file.put_integer_32 (n)
			a_file.put_string (l_rvt_string.to_string_8)
			align (a_file, 4)
			l_flags := 0
			a_file.put_natural_16 (0)
			l_data := 5
			a_file.put_natural_16 (l_data)
			across 1 |..| 5 as i loop

					-- TODO double check
					-- C++ code uses put(&streamHeaders_[i][0], 4);
				a_file.put_natural_32 (stream_headers [i, 1].to_natural_32)
				a_file.put_natural_32 (stream_headers [i, 2].to_natural_32)

					-- Adding a null character a the end of the string
					-- C++ code uses put(streamNames_[i], strlen(streamNames_[i]) + 1);
				l_names := pe_writer.stream_names [i].twin
				l_names.append_character ('%U')
				a_file.put_string (l_names.to_string_8)
				align (a_file, 4)
			end
		end

	put_array_with_size (a_file: FILE; a_data: ARRAY [NATURAL_8]; a_size: INTEGER_32)
		local
			mp: MANAGED_POINTER
		do
			create mp.make (a_size)
			mp.put_array (a_data.subarray (1, a_size), 0)
			a_file.put_managed_pointer (mp, 0, mp.count)
		end

	put_metadata_headers (a_file: FILE; a_header: PE_DOTNET_META_HEADER)
		do
			a_file.put_managed_pointer (a_header.managed_pointer, 0, a_header.managed_pointer.count)
		end

	put_tables_header (a_file: FILE; a_header: PE_DOTNET_META_TABLES_HEADER)
		do
			a_file.put_managed_pointer (a_header.managed_pointer, 0, a_header.managed_pointer.count)
		end

	put_array (a_file: FILE; a_data: ARRAY [NATURAL_8])
		local
			mp: MANAGED_POINTER
		do
			create mp.make (a_data.count)
			mp.put_array (a_data, 0)
			a_file.put_managed_pointer (mp, 0, mp.count)
		ensure
			a_file.count = old (a_file.count) + a_data.count * {PLATFORM}.natural_8_bytes
		end

	align (a_file: FILE; a_align: INTEGER)
			-- Aligns the output file `a_file' by appending zero bytes to the end of the file until the current offset
			-- is aligned with the desired value `a_align'.
		local
			l_current_offset: INTEGER
			l_array: ARRAY [NATURAL_8]
			l_bytes_needed: INTEGER

		do
				-- Current offset.
			l_current_offset := a_file.count

				-- Check if the current offset is align with the desired value.
			if (l_current_offset \\ a_align) /= 0 then
					-- assumes the alignments are 65536 or less

					-- Compute the number of 0 bytes needed to align the offset.
				l_bytes_needed := a_align - (l_current_offset \\ a_align)
				create l_array.make_filled (0, 1, l_bytes_needed.to_integer_32)
				put_array (a_file, l_array)
			end
		ensure
			is_aligned (a_file, a_align)
		end

	is_aligned (a_file: FILE; a_align: INTEGER): BOOLEAN
			-- Is `a_file` content aligned on `a_align` bytes.
		do
			Result := (a_file.count \\ a_align) = 0
		end

feature -- Settings

	set_module_name (a_name: CLI_STRING)
			-- Set the module name for the compilation unit being emitted.
		local
			l_name_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
		do
			l_name_index := pe_writer.hash_string (a_name.string_32)
			create {PE_MODULE_TABLE_ENTRY} l_entry.make_with_data (l_name_index, guid_index)
			pe_index := add_table_entry (l_entry)
		end

	set_method_rva (method_token, rva: INTEGER)
			-- Set RVA of `method_token' to `rva'.
		local
			l_tuple_method: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
		do
				-- Extract table type and row index from method token
			l_tuple_method := extract_table_type_and_row (method_token)

				-- Retrieve method definition table entry using row index
				-- TODO create a helper features
				-- 		retrieve_table_entry (from the metadata tables),
				--  	retrieve_table_row (from specific table entry)
			if attached {PE_METHOD_DEF_TABLE_ENTRY} tables [l_tuple_method.table_type_index.to_integer_32].table [l_tuple_method.table_row_index.to_integer_32] as l_method_def then

					-- Set RVA value in method definition table entry
				l_method_def.set_rva (rva)

					-- Update method definition table entry in metadata tables
					-- Create a helper feature to update an entry in a table row.
				tables [l_tuple_method.table_type_index.to_integer_32].replace (l_method_def, l_tuple_method.table_row_index.to_integer_32)
			else
					-- TODO
			end
		end

feature -- Definition: Access

	define_assembly_ref (assembly_name: CLI_STRING; assembly_info: MD_ASSEMBLY_INFO;
			public_key_token: MD_PUBLIC_KEY_TOKEN): INTEGER
			-- Add assembly reference information to the metadata tables.
		do
			Result := assembly_emitter.define_assembly_ref (assembly_name, assembly_info, public_key_token)
		end

	define_type_ref (type_name: CLI_STRING; resolution_scope: INTEGER): INTEGER
			-- Adds type reference information to the metadata tables.
		note
			EIS: "name=TypeRef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=273", "protocol=uri"
		local
			l_name_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_scope: INTEGER
			l_namespace_index: NATURAL_64
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			last_dot: INTEGER
			l_type_name: STRING_32
		do
				-- II.22.38 TypeRef : 0x01
			l_tuple := extract_table_type_and_row (resolution_scope)

				--| TODO checks
				--| l_table_type is valid.  We need to add a is_valid_table
				--| {PE_TABLES}.is_valid_table (l_table_type)
				--|
				--| l_table_row: exists.
			check exist_table_row: attached tables [l_tuple.table_type_index.to_integer_32].table [l_tuple.table_row_index.to_integer_32] end

				-- ResolutionScope : an index into a Module, ModuleRef, AssemblyRef or TypeRef table,or null
			if resolution_scope & Md_mask = md_module then
				l_scope := {PE_RESOLUTION_SCOPE}.module
			elseif resolution_scope & Md_mask = Md_module_ref then
				l_scope := {PE_RESOLUTION_SCOPE}.moduleref
			elseif resolution_scope & Md_mask = Md_assembly_ref then
				l_scope := {PE_RESOLUTION_SCOPE}.assemblyref
			elseif resolution_scope & Md_mask = Md_type_ref then
				l_scope := {PE_RESOLUTION_SCOPE}.typeref
			end

				-- NamespaceIndex and TypeIndex
				-- The full name of the type need not be stored directly. Instead, it can be split into two parts at any
				-- included “.” (although typically this is done at the last “.” in the full name). The part preceding the “.”
				-- is stored as the TypeNamespace and that following the “.” is stored as the TypeName. If there is no “.”
				-- in the full name, then the TypeNamespace shall be the index of the empty string.

			l_type_name := type_name.string_32
			last_dot := l_type_name.last_index_of ('.', l_type_name.count)
			if last_dot = 0 then
				l_namespace_index := 0
				l_name_index := pe_writer.hash_string (l_type_name)
			else
				l_namespace_index := pe_writer.hash_string (l_type_name.substring (1, last_dot - 1))
				l_name_index := pe_writer.hash_string (l_type_name.substring (last_dot + 1, l_type_name.count))
			end

				-- TODO: ResolutionScope : null needs to be checked.

			create {PE_TYPE_REF_TABLE_ENTRY} l_entry.make_with_data (create {PE_RESOLUTION_SCOPE}.make_with_tag_and_index (l_scope, l_tuple.table_row_index), l_name_index, l_namespace_index)
			pe_index := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		end

	define_member_ref (method_name: CLI_STRING; in_class_token: INTEGER; a_signature: MD_SIGNATURE): INTEGER
			-- Create reference to member in class `in_class_token'.
		local
			l_member_ref: PE_MEMBER_REF_PARENT
			l_member_ref_entry: PE_MEMBER_REF_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_method_signature: NATURAL_64
			l_name_index: NATURAL_64
		do
				-- Extract table type and row from the in_class_token
			l_tuple := extract_table_type_and_row (in_class_token)

				-- Create a new PE_MEMBER_REF_PARENT instance with the extracted table row index and the in_class_tokebn
			l_member_ref := create_member_ref (in_class_token, l_tuple.table_row_index)

			l_method_signature := hash_blob (a_signature.as_array, a_signature.count.to_natural_64)
			l_name_index := pe_writer.hash_string (method_name.string_32)

				-- Create a new PE_MEMBER_REF_TABLE_ENTRY instance with the given data
			create l_member_ref_entry.make_with_data (l_member_ref, l_name_index, l_method_signature)

				-- Add the new PE_MEMBER_REF_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_member_ref_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_module_ref (a_name: CLI_STRING): INTEGER
			-- Define a new module reference for the given `module_name`.
			-- Returns the generated token.
		local
			l_name_index: NATURAL_64
			l_module_ref_entry: PE_MODULE_REF_TABLE_ENTRY
		do
				-- Hash the module name and create a new PE_MODULE_REF_TABLE_ENTRY instance.
			l_name_index := pe_writer.hash_string (a_name.string_32)
			create l_module_ref_entry.make_with_data (l_name_index)

				-- Add the new PE_MODULE_REF_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_module_ref_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

feature -- Definition: Creation

	define_assembly (assembly_name: CLI_STRING; assembly_flags: INTEGER;
			assembly_info: MD_ASSEMBLY_INFO; public_key: detachable MD_PUBLIC_KEY): INTEGER
			-- Add assembly metadata information to the metadata tables.
			--| the public key could be null.
		do
			Result := assembly_emitter.define_assembly (assembly_name, assembly_flags, assembly_info, public_key)
		end

	define_manifest_resource (resource_name: CLI_STRING; implementation_token: INTEGER;
			offset, resource_flags: INTEGER): INTEGER
			-- Define a new assembly.
		do
			Result := assembly_emitter.define_manifest_resource (resource_name, implementation_token, offset, resource_flags)
		end

	define_type (type_name: CLI_STRING; flags: INTEGER; extend_token: INTEGER; implements: detachable ARRAY [INTEGER]): INTEGER
			-- Define a new type in the metadata.
		note
			EIS: "name=TypeDef", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=270", "protocol=uri"
		local
			l_name_index: NATURAL_64
			l_namespace_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
				--i: INTEGER
			l_extends: PE_TYPEDEF_OR_REF
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			last_dot: INTEGER
			l_type_name: STRING_32
			l_field_index, l_method_index: NATURAL
			l_class_index: NATURAL_64
		do
				-- FieldList (an index into the Field table; it marks the first of a contiguous run of Fields owned by this Type).
			l_field_index := next_table_index ({PE_TABLES}.tfield.to_integer_32)
				-- MethodList (an index into the MethodDef table; it marks the first of a continguous run of Methods owned by this Type).
			l_method_index := next_table_index ({PE_TABLES}.tmethoddef.to_integer_32)

			l_type_name := type_name.string_32
			last_dot := l_type_name.last_index_of ('.', l_type_name.count)
			if last_dot = 0 then
				l_namespace_index := 0
				l_name_index := pe_writer.hash_string (l_type_name)
			else
				l_namespace_index := pe_writer.hash_string (l_type_name.substring (1, last_dot - 1))
				l_name_index := pe_writer.hash_string (l_type_name.substring (last_dot + 1, l_type_name.count))
			end

			l_tuple := extract_table_type_and_row (extend_token)

			l_extends := create_type_def_or_ref (extend_token, l_tuple.table_row_index)

			create {PE_TYPE_DEF_TABLE_ENTRY} l_entry.make_with_data (flags, l_name_index, l_namespace_index, l_extends, l_field_index, l_method_index)
			pe_index := add_table_entry (l_entry)
			l_class_index := pe_index
			Result := last_token.to_integer_32

				-- Adds entries in the PE_INTERFACE_IMPL_TABLE_ENTRY table for each implemented interface, if any.
			if attached implements then
				across implements as i loop
					if i /= 0 then
						l_tuple := extract_table_type_and_row (i)
						l_extends := create_type_def_or_ref (i, l_tuple.table_row_index)
						create {PE_INTERFACE_IMPL_TABLE_ENTRY} l_entry.make_with_data (l_class_index, l_extends)
							--note: l_dis is not used.
						pe_index := add_table_entry (l_entry)
					else
						-- '0' seems to be passed as the end of the container
						-- but more for the cli_writer implementation, that
						-- passes the native C array ending with 0.
						-- For the il_emitter, no need for final 0
						-- thus ignore it.
					end
				end
			end
		end

	define_type_spec (a_signature: MD_TYPE_SIGNATURE): INTEGER
			-- Define a new token of TypeSpec for a type represented by `a_signature'.
			-- To be used to define different type for .NET arrays.
		local
			l_type_def_entry: PE_TYPE_SPEC_TABLE_ENTRY
			l_type_signature: NATURAL_64
		do
			l_type_signature := hash_blob (a_signature.as_array, a_signature.count.to_natural_64)

				-- Create a new PE_TYPE_SPEC_TABLE_ENTRY instance with the given data
			create l_type_def_entry.make_with_data (l_type_signature)

				-- Add the new PE_TYPE_SPEC_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_type_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_exported_type (type_name: CLI_STRING; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER): INTEGER
			-- Create a row in ExportedType table.
		do
			Result := assembly_emitter.define_exported_type (type_name, implementation_token, type_def_token, type_flags)
		end

	define_file (file_name: CLI_STRING; hash_value: MANAGED_POINTER; file_flags: INTEGER): INTEGER
			-- Create a row in File table
		do
			Result := assembly_emitter.define_file (file_name, hash_value, file_flags)
		end

	define_method (method_name: CLI_STRING; in_class_token: INTEGER; method_flags: INTEGER;
			a_signature: MD_METHOD_SIGNATURE; impl_flags: INTEGER): INTEGER
			-- Create reference to method in class `in_class_token`.
		local
			l_method_def_entry: PE_METHOD_DEF_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_method_signature: NATURAL_64
			l_name_index: NATURAL_64
			l_param_index: NATURAL_64
		do
				-- See II.22.26 MethodDef : 0x06
				-- Extract table type and row from the in_class_token
				-- TODO doube check: why we are not using the l_tuple?
			l_tuple := extract_table_type_and_row (in_class_token)

			l_param_index := next_table_index ({PE_TABLES}.tparam.to_integer_32)

			l_method_signature := hash_blob (a_signature.as_array, a_signature.count.to_natural_64)
			l_name_index := pe_writer.hash_string (method_name.string_32)

				-- Create a new PE_METHOD_DEF_TABLE_ENTRY instance with the given data
			create l_method_def_entry.make (impl_flags.to_integer_16, method_flags.to_integer_16, l_name_index, l_method_signature, l_param_index)

				-- Add the new PE_METHOD_DEF_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_method_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_method_impl (in_class_token, method_token, used_method_declaration_token: INTEGER)
			-- Define a method impl from `used_method_declaration_token' from inherited
			-- class to method `method_token' defined in `in_class_token'.
		local
			l_method_impl_entry: PE_METHOD_IMPL_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_method_body: PE_METHOD_DEF_OR_REF
			l_method_declaration: PE_METHOD_DEF_OR_REF
		do
				-- Extract table type and row from the in_class_token
			l_tuple := extract_table_type_and_row (in_class_token)

				-- Get the method body and method declaration from their tokens
			l_method_body := create_method_def_or_ref (method_token, extract_table_type_and_row(method_token).table_row_index)
			l_method_declaration := create_method_def_or_ref (used_method_declaration_token, extract_table_type_and_row(used_method_declaration_token).table_row_index)

				-- Create a new PE_METHOD_IMPL_TABLE_ENTRY instance with the given data
			create l_method_impl_entry.make_with_data (l_tuple.table_row_index, l_method_body, l_method_declaration)

				-- Add the new PE_METHOD_IMPL_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_method_impl_entry)
		end

	define_property (type_token: INTEGER; name: CLI_STRING; flags: NATURAL_32;
			signature: MD_PROPERTY_SIGNATURE; setter_token: INTEGER; getter_token: INTEGER): INTEGER
			-- Define property `name' for a type `type_token'.
		local
			l_property: PE_PROPERTY_TABLE_ENTRY
			l_property_signature: NATURAL_64
			l_semantics: PE_SEMANTICS
			l_table: PE_TABLE_ENTRY_BASE
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_property_index: NATURAL_64
		do
				-- Compute the signature token
			l_property_signature := hash_blob (signature.as_array, signature.count.to_natural_64)

			l_property_index := next_table_index ({PE_TABLES}.tproperty.to_integer_32)

				-- Create a new PE_PROPERTY_TABLE_ENTRY instance with the given data.
			create {PE_PROPERTY_TABLE_ENTRY} l_property.make_with_data (
					flags.to_natural_16,
					pe_writer.hash_string (name.string_32),
					l_property_signature
				)

				-- Add the new PE_PROPERTY_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_property)
				-- Return the metadata token for the new property.
			Result := last_token.to_integer_32

				-- Define the method implementations for the getter and setter, if provided.
			create l_semantics.make_with_tag_and_index ({PE_SEMANTICS}.property, l_property_index)
			if getter_token /= 0 then
				l_tuple := extract_table_type_and_row (getter_token)
				create {PE_METHOD_SEMANTICS_TABLE_ENTRY} l_table.make_with_data
					({PE_METHOD_SEMANTICS_TABLE_ENTRY}.getter.to_natural_16, l_tuple.table_row_index, l_semantics)
				pe_index := add_table_entry (l_table)
			end

			if setter_token /= 0 then
				l_tuple := extract_table_type_and_row (setter_token)
				create {PE_METHOD_SEMANTICS_TABLE_ENTRY} l_table.make_with_data
					({PE_METHOD_SEMANTICS_TABLE_ENTRY}.setter.to_natural_16, l_tuple.table_row_index, l_semantics)
				pe_index := add_table_entry (l_table)
			end

			l_tuple := extract_table_type_and_row (type_token)
			create {PE_PROPERTY_MAP_TABLE_ENTRY} l_table.make_with_data (l_tuple.table_row_index, l_property_index)
			pe_index := add_table_entry (l_table)
		end

	define_pinvoke_map (method_token, mapping_flags: INTEGER;
			import_name: CLI_STRING; module_ref: INTEGER)
			-- Further specification of a pinvoke method location defined by `method_token'.
		local
			l_member_forwarded: PE_MEMBER_FORWARDED
			l_name_index: NATURAL_64
			l_impl_map_entry: PE_IMPL_MAP_TABLE_ENTRY
			l_tuple_method: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
		do
			l_tuple_method := extract_table_type_and_row (method_token)

				-- Get the name index of the imported function
			l_name_index := pe_writer.hash_string (import_name.string_32)

				-- Create a new PE_MEMBER_FORWARDED instance with the given data
			create l_member_forwarded.make_with_tag_and_index ({PE_MEMBER_FORWARDED}.MethodDef, l_tuple_method.table_row_index)

				-- Create a new PE_IMPL_MAP_TABLE_ENTRY instance with the given data
			create l_impl_map_entry.make_with_data (mapping_flags.to_integer_16, l_member_forwarded, l_name_index, module_ref.to_natural_64)

				-- Add the PE_IMPL_MAP_TABLE_ENTRY instance to the table
			pe_index := add_table_entry (l_impl_map_entry)
		end

	define_parameter (in_method_token: INTEGER; param_name: CLI_STRING;
			param_pos: INTEGER; param_flags: INTEGER): INTEGER
			-- Create a new parameter specification token for method `in_method_token'.
		note
			eis: "name=Param Attributes", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=279&zoom=100,116,938", "protocolo"
		local
			l_method_index: NATURAL_64
			l_param_entry: PE_PARAM_TABLE_ENTRY
			l_method_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_param_name_index: INTEGER_32
			l_param_flags: INTEGER_16
			l_param_index: NATURAL
		do
			to_implement ("Review need ensure every row in the Param table is owned by one, and only one, row in the MethodDef table")

				-- Extract table type and row from the method token
			l_method_tuple := extract_table_type_and_row (in_method_token)

				-- Convert the parameter name to UTF-16 and add it to the string heap
			l_param_name_index := pe_writer.hash_string (param_name.string_32).to_integer_32

			l_param_flags := param_flags.to_integer_16

			l_param_index := next_table_index ({PE_TABLES}.tparam.to_integer_32)

				-- Create a new PE_PARAM_TABLE_ENTRY instance with the given data
			l_method_index := l_method_tuple.table_row_index
			create l_param_entry.make_with_data (l_param_flags, l_param_index.to_natural_16, l_param_name_index.to_natural_64)

				-- Add the new PE_PARAM_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_param_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	set_field_marshal (a_token: INTEGER; a_native_type_sig: MD_NATIVE_TYPE_SIGNATURE)
			-- Set a particular marshaling for `a_token'.
			--| TODO: double check this: Limited to parameter token for the moment.
		local
			l_entry: PE_FIELD_MARSHAL_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_parent: PE_FIELD_MARSHAL
			l_index_native_type: NATURAL_64
		do
				-- Extract the table type and row index from `a_token`.
			l_tuple := extract_table_type_and_row (a_token)

				-- Create a new `PE_FIELD_MARSHAL` instance with the given `a_token` and row index.
			l_parent := create_field_marshal (a_token, l_tuple.table_row_index)

				-- Generate an index for the native type by hashing its blob representation.
			l_index_native_type := hash_blob (a_native_type_sig.as_array, a_native_type_sig.count.to_natural_64)

				-- Create a new `PE_FIELD_MARSHAL_TABLE_ENTRY` instance with the parent and native type index.
			create l_entry.make_with_data (l_parent, l_index_native_type)

				-- Add the new `PE_FIELD_MARSHAL_TABLE_ENTRY` instance to the metadata tables.
			pe_index := add_table_entry (l_entry)
		end

	define_field (field_name: CLI_STRING; in_class_token: INTEGER; field_flags: INTEGER; a_signature: MD_FIELD_SIGNATURE): INTEGER
			-- Create a new field in class `in_class_token'.
		local
			l_field_def_entry: PE_FIELD_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_field_signature: NATURAL_64
			l_name_index: NATURAL_64
		do
				-- Extract table type and row from the in_class_token
				-- TODO double check: Why we are not using l_tuple?
			l_tuple := extract_table_type_and_row (in_class_token)

			l_field_signature := hash_blob (a_signature.as_array, a_signature.count.to_natural_64)
			l_name_index := pe_writer.hash_string (field_name.string_32)

				-- Create a new PE_FIELD_TABLE_ENTRY instance with the given data
			create l_field_def_entry.make_with_data (field_flags, l_name_index, l_field_signature)

				-- Add the new PE_FIELD_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_field_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_signature (a_signature: MD_LOCAL_SIGNATURE): INTEGER
			-- Define a new token for `a_signature'. To be used only for
			-- local signature.
		local
			l_signature_hash: NATURAL_64
			l_signature_entry: PE_STANDALONE_SIG_TABLE_ENTRY
		do
			l_signature_hash := hash_blob (a_signature.as_array, a_signature.count.to_natural_64)

			create l_signature_entry.make_with_data (l_signature_hash)
			pe_index := add_table_entry (l_signature_entry)

			Result := last_token.to_integer_32
		end

	define_string_constant (field_name: CLI_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; a_string: STRING): INTEGER
		do
			to_implement ("TODO add implementation, not used by cli_writer on EiffelStudio.")
		end

	define_string (str: CLI_STRING): INTEGER
			-- Define a new token for `str'.
		local
			l_str: STRING_32
			l_us_index: NATURAL_64
		do
				--| add the null character
			create l_str.make_from_string (str.string_32)
			l_us_index := hash_us (l_str, l_str.count)
			Result := (l_us_index | ({NATURAL_64} 0x70 |<< 24)).to_integer_32
		end

	define_custom_attribute (owner, constructor: INTEGER; ca: MD_CUSTOM_ATTRIBUTE): INTEGER
			-- Define a new token for `ca' applied on token `owner' with using `constructor' as creation procedure.
		note
			eis: "name=CustomAttribute", "src=https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf#page=242&zoom=100,116,794", "protocol=uri"
		local
			l_ca_blob: NATURAL_64
			l_ca_entry: PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY
			l_owner_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_constructor_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			blob_count: INTEGER
			l_ca: PE_CUSTOM_ATTRIBUTE
			l_ca_type: PE_CUSTOM_ATTRIBUTE_TYPE
		do
				-- See II.22.10 CustomAttribute : 0x0C
				-- Extract table type and row from the owner token
			l_owner_tuple := extract_table_type_and_row (owner)

			if ca /= Void then
				blob_count := ca.count
					-- Compute the blob signature of the custom attribute
				l_ca_blob := hash_blob (ca.item.read_array (0, blob_count), blob_count.to_natural_64)
			end

				-- Create a new PE_CUSTOM_ATTRIBUTE instance with the corresponding tag and index
			l_ca := create_pe_custom_attribute (owner, l_owner_tuple.table_row_index)

				-- Extract table type and row from the l_constructor_tuple token
			l_constructor_tuple := extract_table_type_and_row (constructor)

				-- Create a new PE_CUSTOM_ATTRIBUTE_TYPE instance with the corresponding tag and index
			l_ca_type := create_pe_custom_attribute_type (constructor, l_constructor_tuple.table_row_index)

			pe_index := l_owner_tuple.table_row_index

			create l_ca_entry.make_with_data (l_ca, l_ca_type, l_ca_blob)

				-- Add the new PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_ca_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

feature -- Constants

	accurate: INTEGER = 0x0000
	quick: INTEGER = 0x0001
			-- Value taken from CorSaveSize enumeration in `correg.h'.

feature {NONE} -- Access

	assembly_emitter: MD_ASSEMBLY_EMIT
			-- Interface that knows how to define assemblies

end
