class
	PE_MD_TABLE_METHODSEMANTICS_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (6, "MethodSemantics")
			structure := struct
			struct.add_natural_16 ("Semantics")
			struct.add_method_def_index ("Method")
			struct.add_has_semantic ("Association")
		end

end
