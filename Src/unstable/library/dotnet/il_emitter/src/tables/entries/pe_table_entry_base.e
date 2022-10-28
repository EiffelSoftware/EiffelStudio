note
	description: "Base class for the metadata tables"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TABLE_ENTRY_BASE

inherit

	PE_META_BASE

feature -- Access

	table_index: INTEGER
		do
			to_implement ("Add implemenation or make it deferred")
		end

feature -- Operations

	render (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement  ("Add implementation")
		end

	get (a_sizes: ARRAY [NATURAL]; a_bytes: ARRAY [NATURAL_8]): NATURAL
		do
			to_implement ("Add implementation")
		end
end
