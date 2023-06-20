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
			struct.add_type_attributes ("Flags")
			struct.add_string_index ("Name")
			struct.add_string_index ("Namespace")
			struct.add_type_def_or_ref_or_spec ("Extends")
			struct.add_field_list_index ("FieldList")
			struct.add_method_def_list_index ("MethodList")
		end

feature -- Access

	extends_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Extends")
		end

	type_attributes: detachable PE_TYPE_ATTRIBUTES_ITEM
		do
			if attached {PE_TYPE_ATTRIBUTES_ITEM} structure.item ("Flags") as ta then
				Result := ta
			else
				check False end
			end
		end

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	namespace_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Namespace")
		end

	field_list: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("FieldList")
		end

	method_list: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("MethodList")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.ttypedef
		end

end
