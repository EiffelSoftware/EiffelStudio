class
	PE_MD_TABLE_MODULEREF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (1, "ModuleRef")
			structure := struct
			struct.add_string_index ("Name")
		end

end
