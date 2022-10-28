note
	description: "[
			Represent tables that can appear in a PE file
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DNL_TABLE

create
	make

feature {NONE} -- Initialization

	make
		do
			create {ARRAYED_LIST [PE_TABLE_ENTRY_BASE]} table.make (0)
		end

feature -- Access

	table: LIST [PE_TABLE_ENTRY_BASE]
			-- vector of tables that can appear in a PE file
			-- empty tables are elided / pass over?

end
