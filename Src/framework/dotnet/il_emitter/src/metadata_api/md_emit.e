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
			initialize_string_heap
			create assembly_emitter
				-- we don't initialize the compilation unit since we don't provide the name of it (similar to the COM interface)
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
			module_GUID := pe_writer.create_guid
			guid_index := pe_writer.hash_guid (module_guid)
		end

	initialize_string_heap
			-- Initialize the heap used to store
			-- user defined strings
		do
				-- TODO double check. how many space we need to reserve?
				-- TODO check alternatives implementations to improve efficiency.
			create string_heap.make (10)
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

	string_heap: HASH_TABLE [READABLE_STRING_GENERAL, INTEGER]
			--  metadata table used to store user-defined strings.

feature -- Status report

	is_successful: BOOLEAN
			-- Was last call successful?	
		do
			to_implement ("TODO: for now, always return True")
			Result := True
		end

feature -- Access

	save_size: INTEGER
			-- Size of Current emitted assembly in memory if we were to emit it now.
		do
			to_implement ("TODO implement, double check if we really need it")
		end

feature -- Save

	assembly_memory: MANAGED_POINTER
			-- Save Current into a MEMORY location.
			-- Allocated here and needs to be freed by caller.
		local
			l_size: INTEGER
		do
			l_size := save_size
			create Result.make (l_size)
			to_implement ("TODO implement, double check if we really need it")
		ensure
			valid_result: Result /= Void
		end

	save (f_name: NATIVE_STRING)
			-- Save current assembly to file `f_name'.
		do
			to_implement ("TODO implement, double check if we really ned it.")
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

feature -- Settings

	set_module_name (a_name: NATIVE_STRING)
			-- Set the module name for the compilation unit being emitted.
		local
			l_name_index: NATURAL_64
			n: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
		do
			l_name_index := pe_writer.hash_string (a_name.string)
			create {PE_MODULE_TABLE_ENTRY} l_entry.make_with_data (l_name_index, guid_index)
			n := add_table_entry (l_entry)
		end

	set_method_rva (method_token, rva: INTEGER)
			-- Set RVA of `method_token' to `rva'.
		do
			to_implement ("TODO implement")
		end

feature -- Definition: Access

	define_assembly_ref (assembly_name: NATIVE_STRING; assembly_info: MD_ASSEMBLY_INFO;
			public_key_token: MD_PUBLIC_KEY_TOKEN): INTEGER
			-- Add assembly reference information to the metadata tables.
		local
			l_name_index: NATURAL_64
			l_public_key_token_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_dis: NATURAL_64
		do
			l_name_index := pe_writer.hash_string (assembly_name.string)
			to_implement ("TODO refactor pe_writer.hash_blob")
			l_public_key_token_index := pe_writer.hash_blob (public_key_token.item.read_array (0, public_key_token.item.count), public_key_token.item.count.to_natural_64)
			create {PE_ASSEMBLY_REF_TABLE_ENTRY} l_entry.make_with_data ({PE_ASSEMBLY_FLAGS}.PA_none, assembly_info.major_version, assembly_info.minor_version, assembly_info.build_number, assembly_info.revision_number, l_name_index, l_public_key_token_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		end

	define_type_ref (type_name: NATIVE_STRING; resolution_scope: INTEGER): INTEGER
			-- Adds type reference information to the metadata tables.
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

			l_name_index := pe_writer.hash_string (type_name.string)
			create {PE_TYPE_REF_TABLE_ENTRY} l_entry.make_with_data (create {PE_RESOLUTION_SCOPE}.make_with_tag_and_index (l_scope, l_tuple.table_row_index), l_name_index, l_namespace_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		end

	define_member_ref (method_name: NATIVE_STRING; in_class_token: INTEGER; a_signature: MD_SIGNATURE): INTEGER
			-- Create reference to member in class `in_class_token'.
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
			l_name_index := pe_writer.hash_string (method_name.string)

				-- Create a new PE_MEMBER_REF_TABLE_ENTRY instance with the given data
			create l_member_ref_entry.make_with_data (l_member_ref, l_name_index, l_method_signature)

				-- Add the new PE_MEMBER_REF_TABLE_ENTRY instance to the metadata tables.
			l_member_ref_index := add_table_entry (l_member_ref_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_module_ref (a_name: NATIVE_STRING): INTEGER
			-- Define a new module reference for the given `module_name`.
			-- Returns the generated token.
		local
			l_name_index: NATURAL_64
			l_module_ref_entry: PE_MODULE_REF_TABLE_ENTRY
			l_module_ref_index: NATURAL_64
		do
				-- Hash the module name and create a new PE_MODULE_REF_TABLE_ENTRY instance.
			l_name_index := pe_writer.hash_string (a_name.string)
			create l_module_ref_entry.make_with_data (l_name_index)

				-- Add the new PE_MODULE_REF_TABLE_ENTRY instance to the metadata tables.
			l_module_ref_index := add_table_entry (l_module_ref_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

feature -- Definition: Creation

	define_assembly (assembly_name: NATIVE_STRING; assembly_flags: INTEGER;
			assembly_info: MD_ASSEMBLY_INFO; public_key: detachable MD_PUBLIC_KEY): INTEGER
			-- Add assembly metadata information to the metadata tables.
			--| the public key could be null.
		local
			l_name_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_public_key_index: NATURAL_64
			l_dis: NATURAL_64
		do
			l_name_index := pe_writer.hash_string (assembly_name.string)
			if public_key /= Void then
					--l_public_key_index := pe_writer.hash_blob (public_key)
			else
				l_public_key_index := 0
			end
			create {PE_ASSEMBLY_DEF_TABLE_ENTRY} l_entry.make_with_data (assembly_flags, assembly_info.major, assembly_info.minor, assembly_info.build, assembly_info.revision, l_name_index, l_public_key_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		end

	define_manifest_resource (resource_name: NATIVE_STRING; implementation_token: INTEGER;
			offset, resource_flags: INTEGER): INTEGER
			-- Define a new assembly.
		do
			to_implement ("TODO add implementation")
		end

	define_type (type_name: NATIVE_STRING; flags: INTEGER; extend_token: INTEGER; implements: detachable ARRAY [INTEGER]): INTEGER
			-- Define a new type in the metadata.
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
			l_name_index := pe_writer.hash_string (type_name.string)
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
		end

	define_type_spec (a_signature: MD_TYPE_SIGNATURE): INTEGER
			-- Define a new token of TypeSpec for a type represented by `a_signature'.
			-- To be used to define different type for .NET arrays.
		local
			l_table_type, l_table_row: NATURAL_64
			l_type_def_entry: PE_TYPE_SPEC_TABLE_ENTRY
			l_type_def_index: NATURAL_64
			l_type_signature: NATURAL_64
		do
			l_type_signature := pe_writer.hash_blob (a_signature.as_array, a_signature.count.to_natural_64)

				-- Create a new PE_TYPE_SPEC_TABLE_ENTRY instance with the given data
			create l_type_def_entry.make_with_data (l_type_signature)

				-- Add the new PE_TYPE_SPEC_TABLE_ENTRY instance to the metadata tables.
			l_type_def_index := add_table_entry (l_type_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_exported_type (type_name: NATIVE_STRING; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER): INTEGER
			-- Create a row in ExportedType table.
		do
			to_implement ("TODO add implementation")
		end

	define_file (file_name: NATIVE_STRING; hash_value: MANAGED_POINTER; file_flags: INTEGER): INTEGER
			-- Create a row in File table
		do
			to_implement ("TODO implement")
		end

	define_method (method_name: NATIVE_STRING; in_class_token: INTEGER; method_flags: INTEGER;
			a_signature: MD_METHOD_SIGNATURE; impl_flags: INTEGER): INTEGER
			-- Create reference to method in class `in_class_token`.
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
			l_name_index := pe_writer.hash_string (method_name.string)

				-- Create a new PE_METHOD_DEF_TABLE_ENTRY instance with the given data
			create l_method_def_entry.make (method_flags, impl_flags, l_name_index, l_method_signature, l_param_index)

				-- Add the new PE_METHOD_DEF_TABLE_ENTRY instance to the metadata tables.
			l_method_def_index := add_table_entry (l_method_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_method_impl (in_class_token, method_token, used_method_declaration_token: INTEGER)
			-- Define a method impl from `used_method_declaration_token' from inherited
			-- class to method `method_token' defined in `in_class_token'.
		local
			l_table_type, l_table_row: NATURAL_64
			l_method_impl_entry: PE_METHOD_IMPL_TABLE_ENTRY
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_method_body: PE_METHOD_DEF_OR_REF
			l_method_declaration: PE_METHOD_DEF_OR_REF
			l_dis: NATURAL_64
		do
				-- Extract table type and row from the in_class_token
			l_tuple := extract_table_type_and_row (in_class_token)

				-- Get the method body and method declaration from their tokens
			l_method_body := create_method_def_or_ref (method_token, l_tuple.table_type_index)
			l_method_declaration := create_method_def_or_ref (used_method_declaration_token, l_tuple.table_type_index)

				-- Create a new PE_METHOD_IMPL_TABLE_ENTRY instance with the given data
			create l_method_impl_entry.make_with_data (l_tuple.table_row_index, l_method_body, l_method_declaration)

				-- Add the new PE_METHOD_IMPL_TABLE_ENTRY instance to the metadata tables.
			l_dis := add_table_entry (l_method_impl_entry)
		end

	define_property (type_token: INTEGER; name: NATIVE_STRING; flags: NATURAL_32;
			signature: MD_PROPERTY_SIGNATURE; setter_token: INTEGER; getter_token: INTEGER): INTEGER
			-- Define property `name' for a type `type_token'.
		local
			l_property: PE_PROPERTY_TABLE_ENTRY
			l_dis: NATURAL_64
			l_property_signature: NATURAL_64
			l_semantics: PE_SEMANTICS
			l_table: PE_TABLE_ENTRY_BASE
			l_tuple: TUPLE [table_type_index: NATURAL_64; table_row_index: NATURAL_64]
			l_property_index: NATURAL_64
		do
				-- Compute the signature token
			l_property_signature := pe_writer.hash_blob (signature.as_array, signature.count.to_natural_64)

			l_property_index := pe_writer.next_table_index ({PE_TABLES}.tproperty.value.to_integer_32)

				-- Create a new PE_PROPERTY_TABLE_ENTRY instance with the given data.
			create {PE_PROPERTY_TABLE_ENTRY} l_property.make_with_data (
					flags.to_natural_16,
					pe_writer.hash_string (name.string),
					l_property_signature
				)

				-- Add the new PE_PROPERTY_TABLE_ENTRY instance to the metadata tables.
			l_dis := add_table_entry (l_property)

				-- Define the method implementations for the getter and setter, if provided.
			if getter_token /= 0 then
				l_tuple := extract_table_type_and_row (getter_token)
				create l_semantics.make_with_tag_and_index ({PE_SEMANTICS}.property, l_property_index)

				create {PE_METHOD_SEMANTICS_TABLE_ENTRY} l_table.make_with_data
					({PE_METHOD_SEMANTICS_TABLE_ENTRY}.getter.to_natural_16, l_tuple.table_type_index, l_semantics)
				l_dis := add_table_entry (l_table)
			end

			if setter_token /= 0 then
				l_tuple := extract_table_type_and_row (setter_token)
				create l_semantics.make_with_tag_and_index ({PE_SEMANTICS}.property, l_property_index)

				create {PE_METHOD_SEMANTICS_TABLE_ENTRY} l_table.make_with_data
					({PE_METHOD_SEMANTICS_TABLE_ENTRY}.setter.to_natural_16, l_tuple.table_type_index, l_semantics)
				l_dis := add_table_entry (l_table)
			end

				-- Return the metadata token for the new property.
			Result := last_token.to_integer_32
		end

	define_pinvoke_map (method_token, mapping_flags: INTEGER;
			import_name: NATIVE_STRING; module_ref: INTEGER)
			-- Further specification of a pinvoke method location defined by `method_token'.
		do
			to_implement ("TODO implement")
		end

	define_parameter (in_method_token: INTEGER; param_name: NATIVE_STRING;
			param_pos: INTEGER; param_flags: INTEGER): INTEGER
			-- Create a new parameter specification token for method `in_method_token'.
		do
			to_implement ("TODO add implementation")
		end

	set_field_marshal (a_token: INTEGER; a_native_type_sig: MD_NATIVE_TYPE_SIGNATURE)
			-- Set a particular marshaling for `a_token'. Limited to parameter token for the moment.
		do
			to_implement ("TODO implement")
		end

	define_field (field_name: NATIVE_STRING; in_class_token: INTEGER; field_flags: INTEGER; a_signature: MD_FIELD_SIGNATURE): INTEGER
			-- Create a new field in class `in_class_token'.
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
			l_name_index := pe_writer.hash_string (field_name.string)

				-- Create a new PE_FIELD_TABLE_ENTRY instance with the given data
			create l_field_def_entry.make_with_data (field_flags, l_name_index, l_field_signature)

				-- Add the new PE_FIELD_TABLE_ENTRY instance to the metadata tables.
			l_field_def_index := add_table_entry (l_field_def_entry)

				-- Return the generated token.
			Result := last_token.to_integer_32
		end

	define_signature (a_signature: MD_LOCAL_SIGNATURE): INTEGER
			-- Define a new token for `a_signature'. To be used only for
			-- local signature.
		local
			l_signature_hash: NATURAL_64
			l_signature_index: NATURAL_64
			l_signature_entry: PE_STANDALONE_SIG_TABLE_ENTRY
		do
			l_signature_hash := pe_writer.hash_blob (a_signature.as_array, a_signature.count.to_natural_64)

			create l_signature_entry.make_with_data (l_signature_hash)
			l_signature_index := add_table_entry (l_signature_entry)

			Result := last_token.to_integer_32
		end

	define_string_constant (field_name: NATIVE_STRING; in_class_token: INTEGER;
			field_flags: INTEGER; a_string: STRING): INTEGER

			-- Create a new field in class `in_class_token'.
		local
			l_field_signature: MD_FIELD_SIGNATURE
			l_uni_str: STRING_32
		do
			create l_field_signature.make
			to_implement ("TODO implement")
		end

	define_string (str: NATIVE_STRING): INTEGER
			-- Define a new token for `str'.
		local
			l_result: NATURAL_64
			l_str: STRING_32
			l_us_index: NATURAL_64
		do
				--| add the null character
			create l_str.make_from_string (str.string)
			l_str.append_character ('%U')
			l_us_index := pe_writer.hash_us (l_str, l_str.count)
			l_result := l_us_index | ({NATURAL_64} 0x70 |<< 24)
			Result := l_result.to_integer_32
			string_heap.force (l_str, Result)
		end

	define_custom_attribute (owner, constructor: INTEGER; ca: MD_CUSTOM_ATTRIBUTE): INTEGER
			-- Define a new token for `ca' applied on token `owner' with using `constructor'
			-- as creation procedure.
		local
			blob: POINTER
			blob_count: INTEGER
		do
			if ca /= Void then
				blob := ca.item.item
				blob_count := ca.count
			end
			to_implement ("TODO add implementation")
		end

feature -- Constants

	accurate: INTEGER = 0x0000
	quick: INTEGER = 0x0001
			-- Value taken from CorSaveSize enumeration in `correg.h'.
feature {NONE} -- Access

	assembly_emitter: MD_ASSEMBLY_EMIT
			-- COM interface that knows how to define assemblies.
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

feature {CIL_PE_FILE} -- Metadata Tables

	tables: SPECIAL [MD_TABLES]
			--  in-memory metadata tables

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.

end
