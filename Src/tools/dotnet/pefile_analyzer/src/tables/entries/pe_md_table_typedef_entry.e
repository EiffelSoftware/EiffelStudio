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
			if attached structure.item ("Flags") as i then
				if attached {like type_attributes} i as v then
					Result := v
				else
					check is_type_attribute: False end
				end
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

	field_list: detachable PE_FIELD_INDEX_ITEM
		do
			if attached structure.index_item ("FieldList") as i then
				if attached {like field_list} i as v then
					Result := v
				else
					check is_field_list: False end
				end
			end
		end

	method_list: detachable PE_METHOD_DEF_INDEX_ITEM
		do
			if attached structure.index_item ("MethodList") as i then
				if attached {like method_list} i as v then
					Result := v
				else
					check is_method_list: False end
				end
			end
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.ttypedef
		end

end
