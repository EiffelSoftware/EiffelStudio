note
	description: "[
			CIL_METADATA_EMIT represent a set of in-memory metadata tables and creates a unique module version identifier (GUID) for the metadata. 
			The class has the ability to add entries to the metadata tables and define the assembly information in the metadata.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_METADATA_EMIT

inherit

	CIL_MD_TOKEN_TYPES

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
			initialize_metadata_tables
			initialize_module
			initialize_guid

				-- we don't initialize the compilation unit since we don't provide the name of it (similar to the COM interface)
		ensure
			module_guid_set: module_guid.count = 16
		end

	initialize_metadata_tables
			-- Initialize an in-memory metadata tables
		do
			create tables.make_empty ({PE_TABLE_CONSTANTS}.max_tables)
			across 0 |..| ({PE_TABLE_CONSTANTS}.max_tables - 1) as i loop
				tables.force ((create {CIL_MD_METADATA_TABLES}.make), i)
			end
		end

	initialize_module
			-- Initialize the type Module.
		local
			l_type_def: PE_TYPEDEF_OR_REF
			l_table: PE_TABLE_ENTRY_BASE
			l_dis: NATURAL_64
		do
			module_index := pe_writer.hash_string ({STRING_32} "<Module>")

			create l_type_def.make_with_tag_and_index ({PE_TYPEDEF_OR_REF}.typedef, 0)
			create {PE_TYPE_DEF_TABLE_ENTRY} l_table.make_with_data (0, module_index, 0, l_type_def, 1, 1)
			l_dis := add_table_entry (l_table)
		end

	initialize_guid
			-- Create a unide GUID.
			--| The module version identifier.
		do
			create module_guid.make_filled (0, 1, 16)
			pe_writer.create_guid (module_guid)
			guid_index := pe_writer.hash_guid (module_guid)
		end

feature -- Access

	module_GUID: ARRAY [NATURAL_8]
			-- Unique GUID
			--|the length should be 16.

	guid_index: NATURAL_64
			-- Guid index

	module_index: NATURAL_64
			-- Index of the GUID
			-- where it should be located in the metadata tables.

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

feature -- Module Definition

	set_module_name (a_name: STRING_32)
			-- Set the module name for the compilation unit being emitted.
		local
			l_name_index: NATURAL_64
			n: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
		do
			l_name_index := pe_writer.hash_string (a_name)
			create {PE_MODULE_TABLE_ENTRY} l_entry.make_with_data (l_name_index, guid_index)
			n := add_table_entry (l_entry)
		end

feature -- Assembly Definition

	define_assembly (assembly_name: STRING_32; assembly_flags: INTEGER;
			assembly_info: CIL_MD_ASSEMBLY_INFO; public_key: detachable CIL_MD_PUBLIC_KEY): INTEGER
			-- Add assembly metadata information to the metadata tables.
			--| the public key could be null.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			assembly_info_not_void: assembly_info /= Void
			valid_flags: public_key /= Void implies assembly_flags &
				{CIL_MD_ASSEMBLY_FLAGS}.public_key = {CIL_MD_ASSEMBLY_FLAGS}.public_key
		local
			l_name_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_public_key_index: NATURAL_64
			l_dis: NATURAL_64
		do
			l_name_index := pe_writer.hash_string (assembly_name)
			if public_key /= Void then
					--l_public_key_index := pe_writer.hash_blob (public_key)
			else
				l_public_key_index := 0
			end
			create {PE_ASSEMBLY_DEF_TABLE_ENTRY} l_entry.make_with_data (assembly_flags, assembly_info.major, assembly_info.minor, assembly_info.build, assembly_info.revision, l_name_index, l_public_key_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		ensure
			valid_result: Result & Md_mask = Md_assembly
		end

	define_assembly_ref (assembly_name: STRING_32; assembly_info: CIL_MD_ASSEMBLY_INFO;
			public_key_token: CIL_MD_PUBLIC_KEY_TOKEN): INTEGER
			-- Add assembly reference information to the metadata tables.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_name_not_empty: not assembly_name.is_empty
			assembly_info_not_void: assembly_info /= Void
		local
			l_name_index: NATURAL_64
			l_public_key_token_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_dis: NATURAL_64
		do
			l_name_index := pe_writer.hash_string (assembly_name)
			to_implement ("TODO refactor pe_writer.hash_blob")
			l_public_key_token_index := pe_writer.hash_blob (public_key_token.item.read_array (0, public_key_token.item.count), public_key_token.item.count.to_natural_64)
			create {PE_ASSEMBLY_REF_TABLE_ENTRY} l_entry.make_with_data ({PE_ASSEMBLY_FLAGS}.PA_none, assembly_info.major, assembly_info.minor, assembly_info.build, assembly_info.revision, l_name_index, l_public_key_token_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		ensure
			valid_result: Result > 0
		end

	define_type_ref (type_name: STRING_32; resolution_scope: INTEGER): INTEGER
			-- Adds type reference information to the metadata tables.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			resolution_scope_valid:
				(resolution_scope = 0) or
				(resolution_scope & Md_mask = Md_module_ref) or
				(resolution_scope & Md_mask = Md_assembly_ref) or
				(resolution_scope & Md_mask = Md_type_ref)
		local
			l_name_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_dis: NATURAL_64
			l_scope: INTEGER
			l_namespace_index: NATURAL_64
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
		do

			l_tuple := extract_table_type_and_row (resolution_scope)

				--| TODO checks
				--| l_table_type is valid.  We need to add a is_valid_table
				--| {PE_TABLES}.is_valid_table (l_table_type)
				--|
				--| l_table_row: exists.
			check exist_table_row: attached tables [l_tuple.table_type_index.to_integer_32].table [l_tuple.table_row_index.to_integer_32] end

			if (resolution_scope & Md_mask = Md_module_ref)
			then
				l_scope := {PE_RESOLUTION_SCOPE}.moduleref
			elseif (resolution_scope & Md_mask = Md_assembly_ref)
			then
				l_scope := {PE_RESOLUTION_SCOPE}.assemblyref
			elseif (resolution_scope & Md_mask = Md_type_ref) then
				l_scope := {PE_RESOLUTION_SCOPE}.typeref
			end

				-- If the table type is TypeDef or TypeRef, WE can retrieve the
				-- namespace index from the corresponding row in the TypeDef or TypeRef table.
			if l_tuple.table_type_index = {PE_TABLES}.tTypeRef.value and then
				attached {PE_TYPE_REF_TABLE_ENTRY} tables [l_tuple.table_type_index.to_integer_32].table [l_tuple.table_row_index.to_integer_32] as l_type_ref
			then
				l_namespace_index := l_type_ref.type_name_space_index.index
			elseif l_tuple.table_type_index = {PE_TABLES}.tTypeDef.value and then
				attached {PE_TYPE_DEF_TABLE_ENTRY} tables [l_tuple.table_type_index.to_integer_32].table [l_tuple.table_row_index.to_integer_32] as l_type_def
			then
				l_namespace_index := l_type_def.type_name_space_index.index
			else
				l_namespace_index := 0
			end

			l_name_index := pe_writer.hash_string (type_name)
			create {PE_TYPE_REF_TABLE_ENTRY} l_entry.make_with_data (create {PE_RESOLUTION_SCOPE}.make_with_tag_and_index (l_scope, l_tuple.table_row_index), l_name_index, l_namespace_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		ensure
			result_valid: Result & Md_mask = Md_type_ref
		end

	define_type (type_name: STRING_32; flags: INTEGER; extend_token: INTEGER; implements: detachable ARRAY [INTEGER]): INTEGER
			-- Define a new type in the metadata.
		require
			type_name_not_void: type_name /= Void
			type_name_not_empty: not type_name.is_empty
			extend_token_valid:
				(extend_token & Md_mask = Md_type_def) or
				(extend_token & Md_mask = Md_type_ref) or
				(extend_token & Md_mask = Md_type_spec) or
				extend_token = 0
		local
			l_name_index: NATURAL_64
			l_namespace_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
				--i: INTEGER
			l_type_def_index: NATURAL_64
			l_extends: PE_TYPEDEF_OR_REF
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_dis: NATURAL_64
		do
			l_name_index := pe_writer.hash_string (type_name)
				-- TODO double check if we need to compute the namespace_index, since we are creating a new type
				-- we could assume the namespace_index is 0.
			l_namespace_index := 0

			l_tuple := extract_table_type_and_row (extend_token)

			l_extends := create_type_def_or_ref (extend_token, l_tuple.table_type_index)

			create {PE_TYPE_DEF_TABLE_ENTRY} l_entry.make_with_data (flags, l_name_index, l_namespace_index, l_extends, 0, 0)
			l_type_def_index := add_table_entry (l_entry)
			Result := last_token.to_integer_32

				-- Adds entries in the PE_INTERFACE_IMPL_TABLE_ENTRY table for each implemented interface, if any.
			if attached implements then
				across implements as i loop
					to_implement ("TODO double check and test this code!!!")
					l_extends := create_type_def_or_ref (i, l_tuple.table_type_index)
					create {PE_INTERFACE_IMPL_TABLE_ENTRY} l_entry.make_with_data (l_type_def_index, l_extends)
						--note: l_dis is not used.
					l_dis := add_table_entry (l_entry)
				end
			end
		ensure
			result_valid: Result & Md_mask = Md_type_def
		end

	define_member_ref (method_name: STRING_32; in_class_token: INTEGER; a_signature: CIL_MD_SIGNATURE): INTEGER
			-- Create reference to member in class `in_class_token'.
		require
			method_name_not_void: method_name /= Void
			method_name_not_empty: not method_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_ref or
				in_class_token & Md_mask = Md_type_def or
				in_class_token & md_mask = md_type_spec
			signature_not_void: a_signature /= Void
		local
			l_table_type, l_table_row: NATURAL_64
			l_member_ref_index: NATURAL_64
			l_member_ref: PE_MEMBER_REF_PARENT
			l_member_ref_entry: PE_MEMBER_REF_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_method_signature: NATURAL_64
			l_name_index: NATURAL_64
		do
				-- Extract table type and row from the in_class_token
			l_tuple := extract_table_type_and_row (in_class_token)

				-- Create a new PE_MEMBER_REF_PARENT instance with the extracted table type index and the in_class_tokebn
			l_member_ref := create_member_ref (in_class_token, l_tuple.table_type_index)

			l_method_signature := pe_writer.hash_blob (a_signature.as_array, a_signature.count.to_natural_64)
			l_name_index := pe_writer.hash_string (method_name)

				-- Create a new PE_MEMBER_REF_TABLE_ENTRY instance with the given data
			create l_member_ref_entry.make_with_data (l_member_ref, l_name_index, l_method_signature)

				-- Add the new PE_MEMBER_REF_TABLE_ENTRY instance to the metadata tables.
			l_member_ref_index := add_table_entry (l_member_ref_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		ensure
			result_valid: Result & Md_mask = Md_member_ref
		end

	define_method (method_name: STRING_32; in_class_token: INTEGER; method_flags: INTEGER;
			a_signature: CIL_MD_METHOD_SIGNATURE; impl_flags: INTEGER): INTEGER
			-- Create reference to method in class `in_class_token`.
		require
			method_name_not_void: method_name /= Void
			method_name_not_empty: not method_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_ref or
				in_class_token & Md_mask = Md_type_def or
				in_class_token & md_mask = md_type_spec
			signature_not_void: a_signature /= Void
		local
			l_table_type, l_table_row: NATURAL_64
			l_method_def_index: NATURAL_64
			l_method_def_entry: PE_METHOD_DEF_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_method_signature: NATURAL_64
			l_name_index: NATURAL_64
			l_param_index: NATURAL_64
		do
				-- Extract table type and row from the in_class_token
			l_tuple := extract_table_type_and_row (in_class_token)

				-- Param index is the number of parameters.
				--| TODO double check.
			l_param_index := a_signature.parameter_count.to_natural_64

			l_method_signature := pe_writer.hash_blob (a_signature.as_array, a_signature.count.to_natural_64)
			l_name_index := pe_writer.hash_string (method_name)

				-- Create a new PE_METHOD_DEF_TABLE_ENTRY instance with the given data
			create l_method_def_entry.make (method_flags, impl_flags, l_name_index, l_method_signature, l_param_index)

				-- Add the new PE_METHOD_DEF_TABLE_ENTRY instance to the metadata tables.
			l_method_def_index := add_table_entry (l_method_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		ensure
			result_valid: Result & Md_mask = Md_method_def
		end

	define_field (field_name: STRING_32; in_class_token: INTEGER; field_flags: INTEGER; a_signature: CIL_MD_FIELD_SIGNATURE): INTEGER
			-- Create a new field in class `in_class_token'.
		require
			field_name_not_void: field_name /= Void
			field_name_not_empty: not field_name.is_empty
			in_class_token_valid: in_class_token & Md_mask = Md_type_def
			signature_not_void: a_signature /= Void
		local
			l_table_type, l_table_row: NATURAL_64
			l_field_def_index: NATURAL_64
			l_field_def_entry: PE_FIELD_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_field_signature: NATURAL_64
			l_name_index: NATURAL_64
		do
				-- Extract table type and row from the in_class_token
			l_tuple := extract_table_type_and_row (in_class_token)

			l_field_signature := pe_writer.hash_blob (a_signature.as_array, a_signature.count.to_natural_64)
			l_name_index := pe_writer.hash_string (field_name)

				-- Create a new PE_FIELD_TABLE_ENTRY instance with the given data
			create l_field_def_entry.make_with_data (field_flags, l_name_index, l_field_signature)

				-- Add the new PE_FIELD_TABLE_ENTRY instance to the metadata tables.
			l_field_def_index := add_table_entry (l_field_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		ensure
			result_valid: Result & Md_mask = Md_field_def
		end

	define_signature (a_signature: CIL_MD_LOCAL_SIGNATURE): INTEGER
			-- Define a new token for `a_signature'. To be used only for
			-- local signature.
		require
				signature_not_void: a_signature /= Void
		local
			l_signature_hash: NATURAL_64
			l_signature_index: NATURAL_64
			l_signature_entry: PE_STANDALONE_SIG_TABLE_ENTRY
		do
			l_signature_hash := pe_writer.hash_blob (a_signature.as_array, a_signature.count.to_natural_64)

			create l_signature_entry.make_with_data (l_signature_hash)
			l_signature_index := add_table_entry (l_signature_entry)

			Result := last_token.to_integer_32
		ensure
			result_valid: Result & Md_mask = Md_signature
		end

feature {NONE} -- Helper

	extract_table_type_and_row (a_token: INTEGER): TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			-- Given a token `a_token' return a TUPLE with the table_type_index and the
			-- table_row_index.
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

feature {NONE} -- Metadata Tables

	tables: SPECIAL [CIL_MD_METADATA_TABLES]
			--  in-memory metadata tables

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.

end
