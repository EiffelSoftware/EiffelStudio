note
	description: "Object representing in Memory Database tables"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLES

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER)
		do
			table_id := a_id
			create {ARRAYED_LIST [PE_TABLE_ENTRY_BASE]} table.make (0)
		end

feature -- Access

	table_id: INTEGER

	table: LIST [PE_TABLE_ENTRY_BASE]
			-- vector of tables that can appear in a PE file
			-- empty tables are elided / pass over?

feature -- Element Change

	replace (a_entry: PE_TABLE_ENTRY_BASE; i: INTEGER)
			-- Put `a_entry' at `i'-th position.
		do
			table.put_i_th (a_entry, i)
		end

feature -- Status Report

	debug_output: STRING
		do
			Result := "["+ table_id.out +"] size=" + size.out
		end

	size: INTEGER
			-- Table size
		do
			Result := table.count
		end

	is_empty: BOOLEAN
			-- Is the table empty?
		do
			Result := table.is_empty
		end



end
