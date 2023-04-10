note
	description: "Summary description for {MD_EMIT_SHARED}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT_SHARED

inherit

	MD_TOKEN_TYPES

feature -- Access

	tables: SPECIAL [MD_TABLES]
			--  in-memory metadata tables

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.
			--| TODO, we don't need the full class we need to extract the needed features.

	pe_index: NATURAL_64
			-- metatable index in the PE file for this data container.

feature -- Status report

	us_heap_size: NATURAL_64
			-- User string heap size.
		do
			Result := pe_writer.us.size
		end

	guid_heap_size: NATURAL_64
			-- Guid heap size
		do
			Result := pe_writer.guid.size
		end

	blog_heap_size: NATURAL_64
			-- Blob heap size
		do
			Result := pe_writer.blob.size
		end

	strings_heap_size: NATURAL_64
			-- String heap size
		do
			Result := pe_writer.strings.size
		end

	table_index_size (a_index: PE_TABLES): INTEGER
			-- Table index size for the given table.
		do
			Result := tables [a_index.value.to_integer_32].table.count
		end

feature {NONE} -- Change tables

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_64
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		local
			n: INTEGER
		do
			n := a_entry.table_index
			tables [n].table.force (a_entry)
			Result := tables [n].table.count.to_natural_32
			last_token := (n |<< 24).to_natural_32 | Result.to_natural_32
		end

	last_token: NATURAL_32

feature {NONE} -- Helper

	extract_table_type_and_row (a_token: INTEGER): TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
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
			l_table_type_index: NATURAL_64
			l_table_row_index: NATURAL_64
		do
				-- 2^8 -1 = 255
			l_table_type_index := ((a_token |>> 24) & 255).to_natural_64
				-- 2^ 24 -1 = 16777215
			l_table_row_index := (a_token & 16777215).to_natural_64
			Result := [l_table_type_index, l_table_row_index]
		end

	create_method_def_or_ref (a_token: INTEGER; a_index: NATURAL_64): PE_METHOD_DEF_OR_REF
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def
			then
				l_tag := {PE_METHOD_DEF_OR_REF}.methoddef
			elseif a_token & Md_mask = Md_member_ref
			then
				l_tag := {PE_METHOD_DEF_OR_REF}.memberref
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_type_def_or_ref (a_token: INTEGER; a_index: NATURAL_64): PE_TYPEDEF_OR_REF
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typedef
			elseif a_token & Md_mask = Md_type_ref
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_TYPEDEF_OR_REF}.typespec
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_member_ref (a_token: INTEGER; a_index: NATURAL_64): PE_MEMBER_REF_PARENT
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def
			then
				l_tag := {PE_MEMBER_REF_PARENT}.typedef
			elseif a_token & Md_mask = Md_type_ref
			then
				l_tag := {PE_MEMBER_REF_PARENT}.typeref
			elseif a_token & Md_mask = Md_type_spec then
				l_tag := {PE_MEMBER_REF_PARENT}.typespec
			elseif a_token & Md_mask = Md_module_ref then
				l_tag := {PE_MEMBER_REF_PARENT}.moduleref
			elseif a_token & Md_mask = Md_method_def then
				l_tag := {PE_MEMBER_REF_PARENT}.methoddef
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_implementation (a_token: INTEGER; a_index: NATURAL_64): PE_IMPLEMENTATION
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_file then
				l_tag := {PE_IMPLEMENTATION}.File
			elseif a_token & Md_mask = Md_assembly_ref then
				l_tag := {PE_IMPLEMENTATION}.AssemblyRef
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute (a_token: INTEGER; a_index: NATURAL_64): PE_CUSTOM_ATTRIBUTE
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
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

	create_pe_custom_attribute_type (a_token: INTEGER; a_index: NATURAL_64): PE_CUSTOM_ATTRIBUTE_TYPE
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_method_def then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MethodDef
			elseif a_token & Md_mask = md_member_ref then
				l_tag := {PE_CUSTOM_ATTRIBUTE_TYPE}.MemberRef
			else
				l_tag := 0
			end
			create Result.make_with_tag_and_index (l_tag, a_index)
		end

feature -- Metadata Table Sizes

	module_table_entry_size: INTEGER
		note
			EIS: "name={PE_MODULE_TABLE_ENTRY}.name_index", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=name_index", "protocol=uri"
			EIS: "name={PE_MODULE_TABLE_ENTRY}.guid_index", "protocol=uri", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=guid_index"
		do
				-- Size of the name column.
			Result := if strings_heap_size < 65536 then 2 else 4 end
				-- Size of guid column
			Result := Result + if guid_heap_size < 65536 then 2 else 4 end
		end

	type_ref_entry_size: INTEGER
			-- Compute the table entry size for the TypeRef table
		note
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.resolution", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=resolution"
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.type_name_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=type_name_index"
			EIS: "name={PE_TYPE_REF_TABLE_ENTRY}.type_name_space_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_REF_ENTRY&feature=type_name_space_index"

		local
			index_size, heap_offset_size: INTEGER
		do
				-- Resolution scope
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Type name index and type_name_space_index
			if strings_heap_size < 65536 then
				heap_offset_size := 2
			else
				heap_offset_size := 4
			end

			Result := index_size + 2 * heap_offset_size
		end

	type_def_table_entry_size: INTEGER
			-- Compute the table entry size for the TypeDef table
		note
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.type_name_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=type_name_index"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.type_name_space_index", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=type_name_space_index"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.extends", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=extends"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.fields", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=fields"
			EIS: "name={PE_TYPE_DEF_TABLE_ENTRY}.methods", "protocol=uri", "src=eiffel:?class=PE_TYPE_DEF_TABLE_ENTRY&feature=methods"
		local
			index_size, heap_offset_size: INTEGER
		do
				-- extends, fields and methods
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- type_name_index and type_name_space_index
			if strings_heap_size < 65536 then
				heap_offset_size := 2
			else
				heap_offset_size := 4
			end

				-- 4 is the size of the flags
			Result := 4 + 2 * heap_offset_size + 3 * index_size
		end

	method_def_table_entry_size: INTEGER
			-- Compute the table entry size for the MethodDef table
		note
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.rva", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=rva"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.impl_flags", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=impl_flags"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=signature_index"
			EIS: "name={PE_METHOD_DEF_TABLE_ENTRY}.param_index", "protocol=uri", "src=eiffel:?class=PE_METHOD_DEF_TABLE_ENTRY&feature=param_index"
		local
			index_size, string_heap_offset_size, blob_heap_offset_size: INTEGER
		do
				-- param_index
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- name_index
			if strings_heap_size < 65536 then
				string_heap_offset_size := 2
			else
				string_heap_offset_size := 4
			end

				-- signature_index
			if blog_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end
				-- Size of rva column 4
				-- Size of impl_flags column 2
				-- Size of flags column 2
				-- 8
			Result := 8 + string_heap_offset_size + blob_heap_offset_size + index_size
		end

	param_table_entry_size: INTEGER
			-- Compute the table entry size for the Param table
		note
			EIS: "name={PE_PARAM_TABLE_ENTRY}.flags", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=flags"
			EIS: "name={PE_PARAM_TABLE_ENTRY}.sequence_index", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=sequence_index"
			EIS: "name={PE_PARAM_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_PARAM_TABLE_ENTRY&feature=name_index"
		local
			index_size: INTEGER
		do
				-- name_index
			if strings_heap_size < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Size of flags column 2
				-- Size of sequence_index column 2
				-- 4
			Result := 4 + index_size
		end

	interface_impl_table_entry_size: INTEGER
			-- Compute the table entry size for the InterfaceImpl table
		note
			EIS: "name={PE_INTERFACE_IMPL_TABLE_ENTRY}.class_", "protocol=uri", "src=eiffel:?class=PE_INTERFACE_IMPL_TABLE_ENTRY&feature=class_"
			EIS: "name={PE_INTERFACE_IMPL_TABLE_ENTRY}.interface", "protocol=uri", "src=eiffel:?class=PE_INTERFACE_IMPL_TABLE_ENTRY&feature=interface"
			-- Compute the table entry size for the InterfaceImpl table
		local
			index_size: INTEGER
		do
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- Size of class_ and interface index..
			Result := 2 * index_size
		end

	member_ref_table_entry_size: INTEGER
			-- Compute the table entry size for the MemberRef table
		note
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.name_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=name_index"
			EIS: "name={PE_MEMBER_REF_TABLE_ENTRY}.signature_index", "protocol=uri", "src=eiffel:?class=PE_MEMBER_REF_TABLE_ENTRY&feature=signature_index"
		local
			index_size, string_heap_offset_size, blob_heap_offset_size: INTEGER
		do
				-- parent_index or class_index see spec.
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- name_index
			if strings_heap_size < 65536 then
				string_heap_offset_size := 2
			else
				string_heap_offset_size := 4
			end

				-- signature_index
			if blog_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

			Result := index_size + string_heap_offset_size + blob_heap_offset_size
		end

	constant_table_entry_size: INTEGER
			-- Compute the table entry size for the Constant table
		note
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.type", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=type"
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.parent_index", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=parent_index"
			EIS: "name={PE_CONSTANT_TABLE_ENTRY}.value_index", "protocol=uri", "src=eiffel:?class=PE_CONSTANT_TABLE_ENTRY&feature=value_index"
		local
			index_size, blob_heap_offset_size: INTEGER
		do
				-- parent_index
			if pe_index.to_integer_32 < 65536 then
				index_size := 2
			else
				index_size := 4
			end

				-- value_index
			if blog_heap_size < 65536 then
				blob_heap_offset_size := 2
			else
				blob_heap_offset_size := 4
			end

				-- Size of type column 2 (1 byte for the constant and 1 byte for padding)
				-- 2
			Result := 2 + index_size + blob_heap_offset_size
		end

end
