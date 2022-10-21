note
	description: "Base class for the metadata tables"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TABLE_ENTRY_BASE

inherit

	PE_META_BASE

	REFACTORING_HELPER

feature -- Access

	table_index: INTEGER
		do
			to_implement ("Add implemenation")
		end


end
