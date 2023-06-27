class
	PE_MD_TABLE_TYPEDEF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

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

	resolved_identifier (pe: PE_FILE): detachable STRING_32
			-- Human identifier
		do
			create Result.make_empty
			if
				attached namespace_index as tns_idx and then
				attached pe.string_heap_item (tns_idx) as s
			then
				Result.append_string_general (s)
				Result.append_character ('.')
			end
			if
				attached name_index as tn_idx  and then
				attached pe.string_heap_item (tn_idx) as s
			then
				Result.append_string_general (s)
			end
			if Result.is_whitespace then
				Result := Void
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.ttypedef
		end

end
