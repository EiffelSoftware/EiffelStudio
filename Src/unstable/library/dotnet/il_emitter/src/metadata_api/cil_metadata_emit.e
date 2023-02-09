note
	description: "[
		CIL_METADATA_EMIT represent a set of in-memory metadata tables and creates a unique module version identifier (GUID) for the metadata. 
		The class has the ability to add entries to the metadata tables and define the assembly information in the metadata.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_METADATA_EMIT

inherit

	CIL_TOKEN_TYPES

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
				tables.force ((create {CIL_METADATA_TABLES}.make), i)
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
			l_token: NATURAL_32
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
			assembly_info: CIL_ASSEMBLY_INFO; public_key: detachable CIL_PUBLIC_KEY): INTEGER
			-- Add assembly metadata information to the metadata tables.
			--| the public key could be null.
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
		end

	define_assembly_ref (assembly_name: STRING_32; assembly_info: CIL_ASSEMBLY_INFO;
			public_key_token: ARRAY [NATURAL_8]): INTEGER
			-- Add assembly reference information to the metadata tables.
		local
			l_name_index: NATURAL_64
			l_public_key_token_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_dis: NATURAL_64
		do
			l_name_index := pe_writer.hash_string (assembly_name)
			l_public_key_token_index := pe_writer.hash_blob (public_key_token, public_key_token.count.to_natural_64)
			create {PE_ASSEMBLY_REF_TABLE_ENTRY} l_entry.make_with_data ({PE_ASSEMBLY_FLAGS}.PA_none, assembly_info.major, assembly_info.minor, assembly_info.build, assembly_info.revision, l_name_index, l_public_key_token_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		end

	define_type_ref (type_name: STRING_32; resolution_scope: INTEGER): INTEGER
			-- Adds type reference information to the metadata tables.
		local
			l_name_index: NATURAL_64
			l_entry: PE_TABLE_ENTRY_BASE
			l_dis: NATURAL_64
			l_rs: PE_RESOLUTION_SCOPE
			l_mask: INTEGER_32
			l_token_type: INTEGER_32
			l_table_row: INTEGER_32
			l_table_type: INTEGER_32
			l_res: INTEGER_32
			l_scope: INTEGER
			l_namespace_index: NATURAL_64
		do

				--2^8 -1 = 256 - 1 = 255
				-- l_table_type := resolution_scope |>> 24
			l_table_type := (resolution_scope |>> 24) & (255)

				-- 2^ 24 -1 = 16777215
			l_table_row := resolution_scope & (16777215)

				--| TODO checks
				--| l_table_type is valid.  We need to add a is_valid_table
				--| {PE_TABLES}.is_valid_table (l_table_type)
				--|
				--| l_table_row: exists.
			check exist_table_row: attached tables[l_table_type].table[l_table_row] end

			if (resolution_scope & Md_mask = Md_module_ref)
			then
				l_scope:= {PE_RESOLUTION_SCOPE}.moduleref
			elseif(resolution_scope & Md_mask = Md_assembly_ref)
 			then
				l_scope:= {PE_RESOLUTION_SCOPE}.assemblyref
			elseif  (resolution_scope & Md_mask = Md_type_ref) then
				l_scope:= {PE_RESOLUTION_SCOPE}.typeref
			end

				-- If the table type is TypeDef or TypeRef, WE can retrieve the
				-- namespace index from the corresponding row in the TypeDef or TypeRef table.
			if l_table_type =  {PE_TABLES}.tTypeRef and then
				attached {PE_TYPE_REF_TABLE_ENTRY}tables[l_table_type].table[l_table_row] as l_type_ref
			then
				l_namespace_index := l_type_ref.type_name_space_index.index
			elseif l_table_type = {PE_TABLES}.tTypeDef and then
				attached {PE_TYPE_DEF_TABLE_ENTRY}tables[l_table_type].table[l_table_row] as l_type_def
			then
				l_namespace_index := l_type_def.type_name_space_index.index
			else
				l_namespace_index := 0
			end

			l_name_index := pe_writer.hash_string (type_name)
			create {PE_TYPE_REF_TABLE_ENTRY} l_entry.make_with_data (create {PE_RESOLUTION_SCOPE}.make_with_tag_and_index (l_scope, l_table_row.to_natural_64), l_name_index, l_namespace_index)
			l_dis := add_table_entry (l_entry)
			Result := last_token.to_integer_32
		end


	define_type (type_name: STRING_32; flags: INTEGER; extend_token: INTEGER; implements: detachable ARRAY [INTEGER]): INTEGER
		-- Define a new type in the metadata.
		local
			l_type_def_token: INTEGER
			l_name_index: NATURAL_64
			l_namespace_index: NATURAL_64
			l_extends_index: NATURAL_64
			implements_index: INTEGER
			l_entry: PE_TABLE_ENTRY_BASE
			i: INTEGER
			l_type_def_index: NATURAL_64
			l_tag: INTEGER
			l_extends: PE_TYPEDEF_OR_REF
		do
			l_name_index := pe_writer.hash_string (type_name)
				-- TODO double check if we need to compute the namespace_index, since we are creating a new type
				-- we could assume the namespace_index is 0.
			l_namespace_index := 0


			to_implement ("TODO create a feature to retrieve a tuple with the [table_index and table_row] for  a given token")
				--2^8 -1 = 256 - 1 = 255
				-- l_table_type := resolution_scope |>> 24
			l_extends_index := ((extend_token |>> 24) & (255)).to_natural_64

					-- 2^ 24 -1 = 16777215
			--l_extends_index_row := extend_token & (16777215)


			to_implement ("TODO implemente a helper feature that given a token return a PE_TYPEDEF_OR_REF instance")
			if (extend_token & Md_mask = Md_type_def)
			then
				l_tag := {PE_TYPEDEF_OR_REF}.typedef
			elseif(extend_token & Md_mask = Md_type_ref)
		 	then
				l_tag := {PE_TYPEDEF_OR_REF}.typeref
			elseif  (extend_token & Md_mask = Md_type_spec) then
				l_tag := {PE_TYPEDEF_OR_REF}.typespec
			else
				l_tag := 0
			end

			create l_extends.make_with_tag_and_index (l_tag, l_extends_index)


			create {PE_TYPE_DEF_TABLE_ENTRY} l_entry.make_with_data (flags, l_name_index, l_namespace_index, l_extends, 0, 0)
			l_type_def_index := add_table_entry (l_entry)
			Result := last_token.to_integer_32


			if attached implements then
				to_implement ("Add entries to the PE_INTERFACE_IMPL_TABLE_ENTRY looping through the implementations ARRAY")
				--across implements as i loop
					--l_implements_index := i
					--the array is a list of tokens
					--create {PE_INTERFACE_IMPL_TABLE_ENTRY} l_entry.make_with_data (l_type_def_index; a_interface: PE_TYPEDEF_OR_REF)
				--end
			end

		end




feature {NONE} -- Metadata Tables

	tables: SPECIAL [CIL_METADATA_TABLES]
			--  in-memory metadata tables

	pe_writer: PE_WRITER
			-- class to generate the PE file.
			--| using as a helper class to access needed features.

end
