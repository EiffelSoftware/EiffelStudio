class
	PE_MD_TABLE_EVENTMAP_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (2, "EventMap")
			structure := struct
			struct.add_type_def_index ("Parent")
			struct.add_event_list_index ("EventList")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.teventmap
		end

end
