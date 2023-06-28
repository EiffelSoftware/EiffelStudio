class
	PE_SIZE_SETTINGS

feature {NONE} -- Access

	is_initialized: BOOLEAN

	is_table_using_4_bytes (tb: NATURAL_8; a_tables: PE_MD_TABLES): BOOLEAN
		do
			Result := a_tables.table_size (tb) >= 0x1_0000  -- 2^16
		end

feature {NONE} -- Initialization

	initialize (a_tables: PE_MD_TABLES)
		do
			is_field_table_using_4_bytes		:=	is_table_using_4_bytes ({PE_TABLES}.tfield, a_tables)
			is_method_def_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tmethoddef, a_tables)
			is_member_ref_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tmemberref, a_tables)
			is_param_table_using_4_bytes		:=	is_table_using_4_bytes ({PE_TABLES}.tparam, a_tables)
			is_property_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tproperty, a_tables)
			is_type_def_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.ttypedef, a_tables)
			is_type_ref_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.ttyperef, a_tables)
			is_type_spec_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.ttypespec, a_tables)
			is_file_table_using_4_bytes			:=	is_table_using_4_bytes ({PE_TABLES}.tfile, a_tables)
			is_assemblyref_table_using_4_bytes 	:=	is_table_using_4_bytes ({PE_TABLES}.tassemblyref, a_tables)
			is_exportedtype_table_using_4_bytes :=	is_table_using_4_bytes ({PE_TABLES}.texportedtype, a_tables)

			is_type_def_or_ref_or_spec_using_4_bytes :=
					is_type_def_table_using_4_bytes
					or is_type_ref_table_using_4_bytes
					or is_type_spec_table_using_4_bytes

			is_memberref_parent_using_4_bytes :=
					is_type_def_table_using_4_bytes
					or is_type_ref_table_using_4_bytes
					or is_table_using_4_bytes ({PE_TABLES}.tmoduleref, a_tables)
					or is_method_def_table_using_4_bytes
					or is_type_spec_table_using_4_bytes

			is_has_constant_using_4_bytes :=
					is_field_table_using_4_bytes
					or is_param_table_using_4_bytes
					or is_property_table_using_4_bytes

			is_has_field_marshal_using_4_bytes :=
					is_field_table_using_4_bytes
					or is_param_table_using_4_bytes

			is_has_semantic_using_4_bytes :=
					is_property_table_using_4_bytes
					or is_table_using_4_bytes ({PE_TABLES}.tevent, a_tables)

			is_resolution_scope_using_4_bytes :=
					is_table_using_4_bytes ({PE_TABLES}.tmodule, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tmoduleref, a_tables)
					or is_assemblyref_table_using_4_bytes
					or is_type_ref_table_using_4_bytes

			is_custom_attribute_type_using_4_bytes :=
					is_method_def_table_using_4_bytes
					or is_member_ref_table_using_4_bytes

			is_has_custom_attribute_using_4_bytes :=
					is_method_def_table_using_4_bytes
					or is_table_using_4_bytes ({PE_TABLES}.tmethodspec, a_tables)
					or is_member_ref_table_using_4_bytes
					or is_field_table_using_4_bytes
					or is_type_def_table_using_4_bytes
					or is_type_ref_table_using_4_bytes
					or is_type_spec_table_using_4_bytes
					or is_param_table_using_4_bytes
					or is_property_table_using_4_bytes
					or is_table_using_4_bytes ({PE_TABLES}.tinterfaceimpl, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tmodule, a_tables)
	--				or is_table_using_4_bytes ({PE_TABLES}.tpermission, a_tables) -- Permission
					or is_table_using_4_bytes ({PE_TABLES}.tevent, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tstandalonesig, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tmoduleref, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tassemblydef, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tassemblyref, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tfile, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.texportedtype, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tmanifestresource, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tgenericparam, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tgenericparamconstraint, a_tables)
					or is_table_using_4_bytes ({PE_TABLES}.tmethodspec, a_tables)

			is_initialized := True
		end

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

feature -- Multi index size

	is_type_def_or_ref_or_spec_using_4_bytes: BOOLEAN

	is_memberref_parent_using_4_bytes: BOOLEAN

	is_has_constant_using_4_bytes: BOOLEAN

	is_has_field_marshal_using_4_bytes: BOOLEAN

	is_has_semantic_using_4_bytes: BOOLEAN

	is_resolution_scope_using_4_bytes: BOOLEAN

	is_custom_attribute_type_using_4_bytes: BOOLEAN

	is_has_custom_attribute_using_4_bytes: BOOLEAN

end
