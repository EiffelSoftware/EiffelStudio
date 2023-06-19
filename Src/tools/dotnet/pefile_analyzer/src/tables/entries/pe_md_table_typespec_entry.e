class
	PE_MD_TABLE_TYPESPEC_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (1, "TypeSpec")
			structure := struct
			struct.add_blob_index ("Signature")
		end

end
