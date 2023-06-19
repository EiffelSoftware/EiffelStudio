class
	PE_MD_TABLE_METHODSPEC_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "TypeRef")
			structure := struct
			struct.add_method_def_or_member_ref_index ("Method")
			struct.add_blob_index ("Instantiation")

		end

end
