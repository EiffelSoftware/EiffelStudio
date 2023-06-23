class
	PE_MD_TABLE_MODULE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Module")
			structure := struct
			struct.add_natural_16 ("Generation")
			struct.add_string_index ("Name")
			struct.add_guid_index ("Mvid")
			struct.add_guid_index ("EncId")
			struct.add_guid_index ("EncBaseId")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmodule
		end

end
