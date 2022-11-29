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

	render (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		do
			to_implement ("Add implementation")
		end

end

