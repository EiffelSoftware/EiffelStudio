note
	description: "Summary description for {PE_EVENT_MAP_TABLE_ENTRY}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EVENT_MAP_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE

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

	table_index: NATURAL_32
		once
			Result := {PE_TABLES}.tEventMap.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Write parent and event_list to the buffer and update the number of bytes.
			l_bytes := parent.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + event_list.render (a_sizes, a_dest, l_bytes.to_integer_32)
				-- Return the number of bytes.		
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]): NATURAL_32
		local
			l_bytes: NATURAL_32
		do
				-- Read parent and event_list from the buffer and update the number of bytes.
			l_bytes := parent.render (a_sizes, a_src, 0)
			l_bytes := l_bytes + event_list.render (a_sizes, a_src, l_bytes.to_integer_32)
				-- Return the number of bytes.		
			Result := l_bytes
		end

end

