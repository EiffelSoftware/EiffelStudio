class
	PE_MD_TABLE_METHODIMPL_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "MethodImpl")
			structure := struct
			struct.add_type_def_index ("Class")
			struct.add_method_def_or_member_ref_index ("MethodBody")
			struct.add_method_def_or_member_ref_index ("MethodDeclaration")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tmethodimpl
		end

end
