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

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tpropertymap
		end

end
