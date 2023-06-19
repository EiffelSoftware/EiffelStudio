class
	PE_MD_TABLE_INTERFACEIMPL_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "InterfaceImpl")
			structure := struct
			struct.add_type_def_index ("Class")
			struct.add_type_def_or_ref_or_spec ("Interface")
		end

end
