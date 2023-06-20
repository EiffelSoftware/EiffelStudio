class
	PE_MD_TABLE_EVENT_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "TypeDef")
			structure := struct
			struct.add_flags_16 ("EventFlags")
			struct.add_string_index ("Name")
			struct.add_type_def_or_ref_or_spec ("EventType")
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tevent
		end

end
