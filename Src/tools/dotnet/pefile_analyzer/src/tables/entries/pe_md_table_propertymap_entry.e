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
			struct.add_property_index ("PropertyList")
		end

end
