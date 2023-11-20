note
	description: "Summary description for {MD_EMIT_IMPLEMENTATION}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT_IMPLEMENTATION

inherit
	MD_TOKEN_TYPES

feature -- Access

	tables: SPECIAL [MD_TABLE]
			--  in-memory metadata tables
		deferred
		end

	pe_writer: PE_GENERATOR
			-- helper class to generate the PE file.
			--| using as a helper class to access needed features.
		deferred
		end

--	Heap_size_: INTEGER = 0x1_0000
			--   If the maximum size of the heap is less than 2^16, then the heap offset size is 2 bytes (16 bits), otherwise it is 4 bytes

feature -- Status report

	us_heap_size: NATURAL_32
			-- User string heap size.
		do
			Result := pe_writer.us.size
		end

	guid_heap_size: NATURAL_32
			-- Guid heap size
		do
			Result := pe_writer.guid.size
		end

	blob_heap_size: NATURAL_32
			-- Blob heap size
		do
			Result := pe_writer.blob.size
		end

	strings_heap_size: NATURAL_32
			-- String heap size
		do
			Result := pe_writer.strings.size
		end

feature {MD_EMIT_BRIDGE} -- Change tables

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_32
			-- Index in related MD_TABLE
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		require
			valid_entry_table_index: tables.valid_index (a_entry.table_index.to_integer_32)
		local
			l_table_id: NATURAL_32
			l_md_table: MD_TABLE
		do
			l_table_id := a_entry.table_index
			l_md_table := tables [l_table_id.to_integer_32]

			inspect a_entry.table_index
			when
				{PE_TABLES}.tmethoddef,
				{PE_TABLES}.tparam,
				{PE_TABLES}.tfield,
				{PE_TABLES}.tassemblydef,
				{PE_TABLES}.tClassLayout, -- Not used.
				{PE_TABLES}.tconstant, -- Not used.
				{PE_TABLES}.tcustomattribute,
				{PE_TABLES}.tfieldmarshal,
				{PE_TABLES}.tfieldrva,
				{PE_TABLES}.tGenericParam, -- Not used.
				{PE_TABLES}.tImplMap,
				{PE_TABLES}.tMethodSemantics,
				{PE_TABLES}.tNestedClass, -- Not used
				{PE_TABLES}.tStandaloneSig
			then
				-- No duplication checking
			else
				Result := a_entry.token_from_table (l_md_table)
			end
			if Result = 0 then
				l_md_table.force (a_entry)
				Result := l_md_table.size
			end
			Result := (l_table_id |<< 24) | Result
		ensure
			entry_added: a_entry.token_from_table (tables [a_entry.table_index.to_integer_32]) > 0
		end

feature {MD_EMIT_BRIDGE} -- Helper

	extract_table_type_and_row (a_token: INTEGER): TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
			-- Given a token `a_token' return a TUPLE with the table_type_index and the
			-- table_row_index.
			--| Metadata tokens
			--| Many CIL instructions are followed by a "metadata token". This is a 4-byte value, that specifies a
			--| row in a metadata table, or a starting byte offset in the User String heap. The most-significant
			--| byte of the token specifies the table or heap. For example, a value of 0x02 specifies the TypeDef
			--| table; a value of 0x70 specifies the User String heap. The value corresponds to the number
			--| assigned to that metadata table (see Partition II for the full list of tables) or to 0x70 for the User
			--| String heap. The least-significant 3 bytes specify the target row within that metadata table, or
			--| starting byte offset within the User String heap. The rows within metadata tables are numbered
			--| one upwards, whilst offsets in the heap are numbered zero upwards. (So, for example, the
			--| metadata token with value 0x02000007 specifies row number 7 in the TypeDef table)
		local
			l_table_type_index: NATURAL_32
			l_table_row_index: NATURAL_32
		do
				-- 2^8 -1 = 255 = 0xFF
			l_table_type_index := ((a_token |>> 24) & 0xFF).to_natural_32
				-- 2^ 24 -1 = 16777215 = 0xFF_FFFF
			l_table_row_index := (a_token & 0xFF_FFFF).to_natural_32
			Result := [l_table_type_index, l_table_row_index]
		end

feature -- Factory		

	create_method_def_or_ref (a_token: INTEGER; a_index: NATURAL_32): PE_METHOD_DEF_OR_REF
			 -- Create a new PE_METHOD_DEF_OR_REF instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_METHOD_DEF_OR_REF}.methoddef
			elseif a_token & Md_mask = Md_member_ref then
				l_tag := {PE_METHOD_DEF_OR_REF}.memberref
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_type_def_or_ref (a_token: INTEGER; a_index: NATURAL_32): PE_TYPEDEF_OR_REF
			-- Create a new PE_TYPEDEF_OR_REF instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def then
				l_tag := {PE_TYPEDEF_OR_REF}.typedef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_TYPEDEF_OR_REF}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_TYPEDEF_OR_REF}.typespec
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_member_ref (a_token: INTEGER; a_index: NATURAL_32): PE_MEMBER_REF_PARENT
			-- Create a new PE_MEMBER_REF_PARENT instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def then
				l_tag := {PE_MEMBER_REF_PARENT}.typedef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_MEMBER_REF_PARENT}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_MEMBER_REF_PARENT}.typespec
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_MEMBER_REF_PARENT}.moduleref
			elseif a_token & Md_mask = Md_method_def then
				l_tag := {PE_MEMBER_REF_PARENT}.methoddef
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_implementation (a_token: INTEGER; a_index: NATURAL_32): PE_IMPLEMENTATION
			-- Create a new PE_IMPLEMENTATION instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_file then
				l_tag := {PE_IMPLEMENTATION}.File
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_IMPLEMENTATION}.AssemblyRef
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute (a_token: INTEGER; a_index: NATURAL_32): PE_CUSTOM_ATTRIBUTE
		 	-- Create a new PE_CUSTOM_ATTRIBUTE instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.MethodDef
			elseif a_token & Md_mask = Md_field_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.FieldDef
			elseif a_token & Md_mask = Md_type_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeRef
			elseif a_token & Md_mask = Md_type_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeDef
			elseif a_token & Md_mask = Md_param_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ParamDef
			elseif a_token & Md_mask = Md_interface_impl then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.InterfaceImpl
			elseif a_token & Md_mask = Md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.MemberRef
			elseif a_token & Md_mask = Md_module then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Module
			elseif a_token & Md_mask = Md_permission then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Permission
			elseif a_token & Md_mask = Md_property then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Property
			elseif a_token & Md_mask = Md_event then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Event
			elseif a_token & Md_mask = Md_signature then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.StandaloneSig
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ModuleRef
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.TypeSpec
			elseif a_token & Md_mask = Md_assembly then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.Assembly
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.AssemblyRef
			elseif a_token & Md_mask = Md_file then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.File
			elseif a_token & Md_mask = Md_exported_type then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ExportedType
			elseif a_token & Md_mask = Md_manifest_resource then
				l_tag := {PE_CUSTOM_ATTRIBUTE}.ManifestResource
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute_type (a_token: INTEGER; a_index: NATURAL_32): PE_CUSTOM_ATTRIBUTE_TYPE
			-- Create a new PE_CUSTOM_ATTRIBUTE_TYPE instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MethodDef
			elseif a_token & Md_mask = md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MemberRef
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_field_marshal (a_token: INTEGER; a_index: NATURAL_32): PE_FIELD_MARSHAL
			-- Create a new `PE_FIELD_MARSHAL` instance with the specified `a_token` and `a_index`.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = md_field_def then
				l_tag := {PE_FIELD_MARSHAL}.Field
			elseif a_token & Md_mask = md_param_def then
				l_tag := {PE_FIELD_MARSHAL}.Param
			else
				check should_not_occur: False end
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

feature -- Access

	next_table_index (a_table_id: NATURAL_32): NATURAL_32
			-- Table for id `a_table_id`
			-- See `{PE_TABLES}` for table ids.
		require
			valid_table_index: tables.valid_index (a_table_id.to_integer_32)
		do
			Result := tables [a_table_id.to_integer_32].next_index
		end

feature -- Heaps

	hash_blob (a_blob_data: ARRAY [NATURAL_8]; a_blob_len: NATURAL_32): NATURAL_32
			-- Computes the hash of a blob `a_blob_data'
			-- if the blob already exists in a heap, returns the index of the existing blob
			-- otherwise computes the hash and returns the index of the new blob.
		do
			Result := check_blob (pe_writer.blob, a_blob_data)
			if Result = 0 then
				Result := pe_writer.hash_blob (a_blob_data, a_blob_len)
			end
		ensure
			hashed: Result = check_blob (pe_writer.blob, a_blob_data)
		end

	hash_us (a_str: STRING_32; a_len: INTEGER): NATURAL_32
			-- Converts a UTF-16 string `a_str` to UTF-8, checks for an existing hash value,
			-- and calculates a new hash value if necessary.
			-- To replace the use of {PE_WRITER}.hash_us
		local
			l_converter: BYTE_ARRAY_CONVERTER
		do
			create l_converter.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_16le_string_8 (a_str))
			Result := check_us (pe_writer.us, l_converter.to_natural_8_array)
			if Result = 0 then
				Result := pe_writer.hash_us (a_str, a_len)
			end
		ensure
			hashed: check_us (pe_writer.us, (create {BYTE_ARRAY_CONVERTER}.make_from_string ({UTF_CONVERTER}.utf_32_string_to_utf_16le_string_8 (a_str))).to_natural_8_array) = Result
		end

	check_blob (blob: PE_POOL; target_blob: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_blob` exists in `blob_heap` and return its index if found, otherwise return 0.
		local
			blob_heap: SPECIAL [NATURAL_8]
			blob_size: NATURAL_32
			i, j, k, target_size, current_size: INTEGER
		do
--			Result := 0 -- not found (yet)
			blob_heap := blob.base
			blob_size := blob.size
			target_size := target_blob.count
			from
				i := 1 --| 2 - 1  Special are 0-based
			until
				i.to_natural_32 >= blob_size or else Result /= 0
			loop
					-- Check if the blob header matches the target blob size.
				if blob_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := blob_heap [i]
					j := i + 1
				elseif blob_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (blob_heap [i] - 0x80) * 0x100
									+ blob_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100 0000 = 1 00000000 00000000 00000000
					-- 65 536 	=   0x1 0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (blob_heap [i] - 0xC0) * 0x100_0000
									+ blob_heap [i + 1] * 0x1_0000
									+ blob_heap [i + 2] * 0x100
									+ blob_heap [i + 3]
					j := i + 4
				end
					-- Check if the current blob matches the target blob.
				if current_size = target_size then
					from
						k := 1
					until
						(j + k - 1).to_natural_32 > blob_size
						or else k > target_size
						or else target_blob [k] /= blob_heap [j + k - 1]
					loop
						k := k + 1
					end
					if (k - 1) = target_size then
							-- Found a match.
						Result := i.to_natural_32
					end
				end
				i := j + current_size
			end
		ensure
			valid_result: Result >= 0
		end

	check_us (us: PE_POOL; target_us: ARRAY [NATURAL_8]): NATURAL_32
			-- Check if `target_us` exists in `us` and return its index if found, otherwise return 0.
		local
			us_heap: SPECIAL [NATURAL_8]
			us_size: NATURAL_32;
			i, j, k, target_size, current_size: INTEGER
		do
			us_heap := us.base
			us_size := us.size

--			Result := 0 -- not found (yet)

			target_size := target_us.count
			from
					-- note: The first entry in both these heaps is the empty 'blob' that consists of the single byte 0x00.
					-- SPECIAL are 0-based, skip first entry.
				i := 1
			until
				i.to_natural_32 >= us_size or else Result > 0
			loop
					-- Check if the current user string matches the target user string.
				if us_heap [i] < 0x80 then
					-- 128 = 0x80 = 1000 0000
					current_size := us_heap [i]
					j := i + 1
				elseif us_heap [i] < 0xC0 then -- 0xC0 = 1100 0000
					-- 192 = 0xC0  =   1100 0000
					-- 256 = 0x100 = 1 0000 0000
					current_size := (us_heap [i] - 0x80) * 0x100
									+ us_heap [i + 1]
					j := i + 2
				else
					-- 16777216 = 0x100_0000 = 1 00000000 00000000 00000000
					-- 65 536  	=   0x1_0000 =          1 00000000 00000000
					-- 256 		=      0x100 =                   1 00000000
					current_size := (us_heap [i] - 0xC0) * 0x100_0000
									+ us_heap [i + 1] * 0x1_0000
									+ us_heap [i + 2] * 0x100
									+ us_heap [i + 3]
					j := i + 4
				end

					-- Note: the `current_size` for #US includes the final byte 0 or 1.
				if current_size - 1 = target_size then
						-- Exclude the final byte from the comparison: 0 or 1
					from
						k := 1
					until
						(j + k - 1).to_natural_32 >= us_size
						or else k > target_size
						or else target_us [k] /= us_heap [j + k - 1]
					loop
						k := k + 1
					end
					if (k - 1) = target_size then
							-- Found a match.
						Result := i.to_natural_32
					end
				end
				i := j + current_size
			end
		ensure
			valid_result: Result >= 0
		end

end

