class
	PE_MD_TABLE_CONSTANT_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Constant")
			structure := struct
			struct.add_natural_16 ("Type")
			struct.add_has_constant ("Parent")
			struct.add_blob_index ("Value")
		end

end
