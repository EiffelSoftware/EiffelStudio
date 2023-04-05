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
			Result :=  pe_writer.blob.size
		end

	strings_heap_size: NATURAL_64
			-- String heap size
		do
			Result := pe_writer.strings.size
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
			last_token := ((n |<< 24).to_natural_32 | Result.to_natural_32)
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
			if (a_token & Md_mask = Md_method_def)
			then
				l_tag := {PE_METHOD_DEF_OR_REF}.methoddef
			elseif (a_token & Md_mask = Md_member_ref)
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
			if (a_token & Md_mask = Md_type_def)
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typedef
			elseif (a_token & Md_mask = Md_type_ref)
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typeref
			elseif (a_token & Md_mask = Md_type_spec) then
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
			if (a_token & Md_mask = Md_type_def)
			then
				l_tag := {PE_MEMBER_REF_PARENT}.typedef
			elseif (a_token & Md_mask = Md_type_ref)
			then
				l_tag := {PE_MEMBER_REF_PARENT}.typeref
			elseif (a_token & Md_mask = Md_type_spec) then
				l_tag := {PE_MEMBER_REF_PARENT}.typespec
			elseif (a_token & Md_mask = Md_module_ref) then
				l_tag := {PE_MEMBER_REF_PARENT}.moduleref
			elseif (a_token & Md_mask = Md_method_def) then
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
			EIS:"name={PE_MODULE_TABLE_ENTRY}.name_index", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=name_index","protocol=uri"
			EIS: "name={PE_MODULE_TABLE_ENTRY}.guid_index", "protocol=uri", "src=eiffel:?class=PE_MODULE_TABLE_ENTRY&feature=guid_index"
		do
				-- Size of the name column.
			Result :=  if us_heap_size < 65536 then 2 else 4 end
				-- Size of guid column
			Result :=  Result + if guid_heap_size < 65536 then 2 else 4 end
		end
end
