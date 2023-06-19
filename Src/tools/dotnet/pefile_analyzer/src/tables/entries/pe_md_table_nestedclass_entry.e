class
	PE_MD_TABLE_NESTEDCLASS_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "NestedClass")
			structure := struct
			struct.add_type_def_index ("NestedClass")
			struct.add_type_def_index ("EnclosingClass")
		end

end
