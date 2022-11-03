note
	description: "Summary description for {PE_EVENT_MAP_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EVENT_MAP_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Implementation

	make_with_data (a_parent: NATURAL; a_event_list: NATURAL)
		do
			create parent.make_with_index (a_parent)
			create event_list.make_with_index (a_event_list)
		end

feature -- Access

	parent: PE_TYPE_DEF

	event_list: PE_EVENT_LIST


feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tEventMap.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement  ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end

end

