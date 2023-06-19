class
	PE_MD_TABLE_TYPEDEF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (6, "TypeDef")
			structure := struct
			struct.add_flags_32 ("Flags")
			struct.add_string_index ("Name")
			struct.add_string_index ("Namespace")
			struct.add_type_def_or_ref_or_spec ("Extends") -- TODO Def,Ref,Spec?
			struct.add_field_index ("FieldList")
			struct.add_method_def_index ("MethodList")
		end

feature -- Access

	extends_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Extends")
		end

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	namespace_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Namespace")
		end

end
