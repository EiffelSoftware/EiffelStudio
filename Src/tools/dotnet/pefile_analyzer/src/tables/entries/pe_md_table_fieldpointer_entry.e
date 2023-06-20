class
	PE_MD_TABLE_FIELDPOINTER_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (1, "FieldPointer")
			structure := struct
			struct.add_natural_16 ("?")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tfieldpointer
		end

end
