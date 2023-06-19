class
	PE_MD_TABLE_EXPORTEDTYPE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (5, "ExportedType")
			structure := struct
			struct.add_flags_32 ("Flags")
			struct.add_type_def_index ("TypeDefId")
			struct.add_string_index ("Name")
			struct.add_string_index ("Namespace")
			struct.add_index ("Implementation")
		end

end
