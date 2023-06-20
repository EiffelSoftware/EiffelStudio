class
	PE_MD_TABLE_PARAM_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Param")
			structure := struct
			struct.add_flags_16 ("Flags")
			struct.add_natural_16 ("Sequence")
			struct.add_string_index ("Name")
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	sequence: detachable PE_NATURAL_16_ITEM
		do
			Result := structure.natural_16_item ("Sequence")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tparam
		end

end
