class
	PE_MD_TABLE_PROPERTYMAP_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "PropertyMap")
			structure := struct
			struct.add_type_def_index ("Parent")
			struct.add_property_list_index ("PropertyList")
		end

feature -- Access

	parent_index: detachable PE_TYPE_DEF_INDEX_ITEM
		local
			i: PE_ITEM
		do
			i := structure.index_item ("Parent")
			if attached {PE_TYPE_DEF_INDEX_ITEM} i as t then
				Result := t
			else
				check is_typedef_or_void: i = Void end
			end
		end

	property_list: detachable PE_PROPERTY_INDEX_ITEM
		local
			i: PE_ITEM
		do
			i := structure.index_item ("PropertyList")
			if attached {PE_PROPERTY_INDEX_ITEM} i as t then
				Result := t
			else
				check is_proplist_or_void: i = Void end
			end
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tpropertymap
		end

end
