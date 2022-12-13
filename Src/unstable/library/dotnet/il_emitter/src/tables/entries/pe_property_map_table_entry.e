note
	description: "Summary description for {PE_PROPERTY_MAP_TABLE_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PROPERTY_MAP_TABLE_ENTRY

inherit

	PE_TABLE_ENTRY_BASE
		redefine
			render,
			get,
			table_index
		end

create
	make_with_data

feature {NONE} -- Initialization

	make_with_data (a_parent: NATURAL_64; a_property_list: NATURAL_64)
		do
			create parent.make_with_index (a_parent)
			create property_list.make_with_index (a_property_list)
		end

feature -- Access

	parent: PE_TYPE_DEF

	property_list: PE_PROPERTY_LIST

feature -- Operations

	table_index: INTEGER
		do
			Result := {PE_TABLES}.tPropertyMap.value.to_integer_32
		end

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Write parent and propety_list to the buffer and update the bytes.
			l_bytes := parent.render (a_sizes, a_dest, 0)
			l_bytes := l_bytes + property_list.render (a_sizes, a_dest, l_bytes.to_integer_32)

				-- Return the number of bytes.
			Result := l_bytes
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_src: ARRAY [NATURAL_8]): NATURAL_64
		local
			l_bytes: NATURAL_64
		do
				-- Read parent and propety_list from the buffer and update the bytes.
			l_bytes := parent.get (a_sizes, a_src, 0)
			l_bytes := l_bytes + property_list.get (a_sizes, a_src, l_bytes.to_integer_32)

				-- Return the number of bytes.
			Result := l_bytes
		end

end

