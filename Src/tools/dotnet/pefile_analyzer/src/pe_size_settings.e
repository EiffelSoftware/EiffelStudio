class
	PE_SIZE_SETTINGS

feature {NONE} -- Access

	is_initialized: BOOLEAN

	is_table_using_4_bytes (tb: NATURAL_8; a_tables: PE_MD_TABLES; tagbit: INTEGER): BOOLEAN
		do
			if tagbit = 0 then
				Result := a_tables.table_size (tb) >= 0x1_0000  -- 2^16
			else
				Result := a_tables.table_size (tb) >= (2 ^ (16 - tagbit))  -- 2^(16-tagbit)
			end
		end

feature -- Initialization

	initialize (a_tables: PE_MD_TABLES)
		do
			-- Heap
			is_string_heap_using_4_bytes := a_tables.string_heap_index_bytes_size = 4
			is_guid_heap_using_4_bytes := a_tables.guid_heap_index_bytes_size = 4
			is_blob_heap_using_4_bytes := a_tables.blob_heap_index_bytes_size = 4

			-- Table
			is_field_table_using_4_bytes		:=	is_table_using_4_bytes ({PE_TABLES}.tfield, a_tables, 0)
			is_method_def_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tmethoddef, a_tables, 0)
			is_member_ref_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tmemberref, a_tables, 0)
			is_param_table_using_4_bytes		:=	is_table_using_4_bytes ({PE_TABLES}.tparam, a_tables, 0)
			is_property_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tproperty, a_tables, 0)
			is_type_def_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.ttypedef, a_tables, 0)
			is_type_ref_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.ttyperef, a_tables, 0)
			is_type_spec_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.ttypespec, a_tables, 0)
			is_file_table_using_4_bytes			:=	is_table_using_4_bytes ({PE_TABLES}.tfile, a_tables, 0)
			is_assemblyref_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tassemblyref, a_tables, 0)
			is_exportedtype_table_using_4_bytes :=	is_table_using_4_bytes ({PE_TABLES}.texportedtype, a_tables, 0)

			is_type_def_or_ref_or_spec_using_4_bytes :=
					is_type_def_table_using_4_bytes
					or is_type_ref_table_using_4_bytes
					or is_type_spec_table_using_4_bytes

			is_memberref_parent_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.ttypedef, a_tables, {PE_MEMBER_REF_PARENT_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.ttyperef, a_tables, {PE_MEMBER_REF_PARENT_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmoduleref, a_tables, {PE_MEMBER_REF_PARENT_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmethoddef, a_tables, {PE_MEMBER_REF_PARENT_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.ttypespec, a_tables, {PE_MEMBER_REF_PARENT_INDEX}.tagbit)

			is_has_constant_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tfield, a_tables, {PE_HAS_CONSTANT_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tparam, a_tables, {PE_HAS_CONSTANT_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tproperty, a_tables, {PE_HAS_CONSTANT_INDEX}.tagbit)

			is_has_field_marshal_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tfield, a_tables, {PE_HAS_FIELD_MARSHAL_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tparam, a_tables, {PE_HAS_FIELD_MARSHAL_INDEX}.tagbit)

			is_has_semantic_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tproperty, a_tables, {PE_HAS_SEMANTIC_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tevent, a_tables, {PE_HAS_SEMANTIC_INDEX}.tagbit)

			is_resolution_scope_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tmodule, a_tables, {PE_RESOLUTION_SCOPE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmoduleref, a_tables, {PE_RESOLUTION_SCOPE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tassemblyref, a_tables, {PE_RESOLUTION_SCOPE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.ttyperef, a_tables, {PE_RESOLUTION_SCOPE_INDEX}.tagbit)

			is_custom_attribute_type_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tmodule, a_tables, {PE_CUSTOM_ATTRIBUTE_TYPE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmemberref, a_tables, {PE_CUSTOM_ATTRIBUTE_TYPE_INDEX}.tagbit)

			is_has_custom_attribute_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tmethoddef, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmethodspec, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmemberref, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tfield, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.ttypedef, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.ttyperef, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.ttypespec, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tparam, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tproperty, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tinterfaceimpl, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmodule, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
	--				or is_table_using_4_bytes ({PE_TABLES}.tpermission, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit) -- Permission

					or is_table_using_4_bytes ({PE_TABLES}.tevent, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tstandalonesig, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmoduleref, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tassemblydef, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tassemblyref, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tfile, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.texportedtype, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmanifestresource, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tgenericparam, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tgenericparamconstraint, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmethodspec, a_tables, {PE_HAS_CUSTOM_ATTRIBUTE_INDEX}.tagbit)

			is_method_def_or_member_ref_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tmethoddef, a_tables, {PE_METHOD_DEF_OR_MEMBER_REF_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tmemberref, a_tables, {PE_METHOD_DEF_OR_MEMBER_REF_INDEX}.tagbit)

			is_implementation_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tfile, a_tables, {PE_IMPLEMENTATION_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.tassemblyref, a_tables, {PE_IMPLEMENTATION_INDEX}.tagbit)
					or is_table_using_4_bytes ({PE_TABLES}.texportedtype, a_tables, {PE_IMPLEMENTATION_INDEX}.tagbit)

			is_initialized := True
		end

feature -- Heap settings

	is_string_heap_using_4_bytes,
	is_guid_heap_using_4_bytes,
	is_blob_heap_using_4_bytes: BOOLEAN

feature -- Settings

	is_field_table_using_4_bytes: BOOLEAN
	is_method_def_table_using_4_bytes: BOOLEAN
	is_member_ref_table_using_4_bytes: BOOLEAN
	is_param_table_using_4_bytes: BOOLEAN
	is_property_table_using_4_bytes: BOOLEAN
	is_type_def_table_using_4_bytes: BOOLEAN
	is_type_ref_table_using_4_bytes: BOOLEAN
	is_type_spec_table_using_4_bytes: BOOLEAN
	is_file_table_using_4_bytes: BOOLEAN
	is_assemblyref_table_using_4_bytes: BOOLEAN
	is_exportedtype_table_using_4_bytes: BOOLEAN
	is_event_table_using_4_bytes: BOOLEAN

feature -- Multi index size

	is_type_def_or_ref_or_spec_using_4_bytes: BOOLEAN

	is_memberref_parent_using_4_bytes: BOOLEAN

	is_has_constant_using_4_bytes: BOOLEAN

	is_has_field_marshal_using_4_bytes: BOOLEAN

	is_has_semantic_using_4_bytes: BOOLEAN

	is_resolution_scope_using_4_bytes: BOOLEAN

	is_custom_attribute_type_using_4_bytes: BOOLEAN

	is_has_custom_attribute_using_4_bytes: BOOLEAN

	is_method_def_or_member_ref_using_4_bytes: BOOLEAN

	is_implementation_using_4_bytes: BOOLEAN

end
