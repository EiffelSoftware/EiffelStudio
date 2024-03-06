class
	PDB_MD_TABLE_STATE_MACHINE_METHOD_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE


create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "StateMachineMethod")
			structure := struct
			struct.add_natural_32 ("MoveNextMethod") -- MethodDef
			struct.add_natural_32 ("KickoffMethod") -- MethodDef
		end

feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tstatemachinemethod
		end

end

