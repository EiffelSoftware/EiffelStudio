note
	description: "Summary description for {MD_EMIT_IMPLEMENTATION}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MD_EMIT_IMPLEMENTATION

inherit
	MD_TOKEN_TYPES

feature -- Access

	pe_writer: PE_GENERATOR
			-- helper class to generate the PE file.
			--| using as a helper class to access needed features.
		deferred
		end

	pdb_writer: PE_GENERATOR
			-- helper class to generate the PE file.
			--| using as a helper class to access needed features.
		deferred
		end

feature {MD_EMIT_BRIDGE, DBG_WRITER_I, DBG_DOCUMENT_WRITER_I} -- Change tables

	add_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_32
			-- Index in related MD_TABLE
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		require
			valid_entry_table_index: pe_writer.is_valid_md_table_id (a_entry.table_index)
		do
			Result := pe_writer.add_table_entry (a_entry)
		ensure
			entry_added: a_entry.token_from_table (pe_writer.md_table (a_entry.table_index)) > 0
		end

	add_pdb_table_entry (a_entry: PE_TABLE_ENTRY_BASE): NATURAL_32
			-- Index in related MD_TABLE
			-- add an entry to one of the tables
			-- note the data for the table will be a class inherited from TableEntryBase,
			--  and this class will self-report the table index to use
		require
			valid_entry_table_index: pdb_writer.is_valid_md_table_id (a_entry.table_index)
			valid_pdb_entry: a_entry.table_index >= 0x30
		do
			Result := pdb_writer.add_table_entry (a_entry)
		ensure
			entry_added: a_entry.token_from_table (pdb_writer.md_table (a_entry.table_index)) > 0
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

	create_type_def_or_method_def (a_token: INTEGER; a_index: NATURAL_32): PE_TYPE_OR_METHOD_DEF
			-- Create a new PE_TYPE_OR_METHOD_DEF instance with the given `a_token' and `a_index'.
		local
			l_tag: INTEGER
		do
			if a_token & Md_mask = Md_type_def then
				l_tag := {PE_TYPE_OR_METHOD_DEF}.typedef
			elseif a_token & Md_mask = md_method_def then
				l_tag := {PE_TYPE_OR_METHOD_DEF}.methoddef
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
			valid_table_index: pe_writer.is_valid_md_table_id (a_table_id)
		do
			Result := pe_writer.next_md_table_index (a_table_id)
		end

end

