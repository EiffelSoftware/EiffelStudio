note
	description: "A Metadata table"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLE

inherit
	ITERABLE [PE_TABLE_ENTRY_BASE]

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER)
		do
			table_id := a_id
			create {ARRAYED_LIST [PE_TABLE_ENTRY_BASE]} items.make (0)
		end

feature -- Access

	table_id: INTEGER

feature {NONE} -- Access	

	items: LIST [PE_TABLE_ENTRY_BASE]
			-- vector of tables that can appear in a PE file
			-- empty tables are elided / pass over?

feature -- Access

	item alias "[]" (i: NATURAL_32): PE_TABLE_ENTRY_BASE
		do
			Result := items [i.to_integer_32]
		end

	new_cursor: ITERATION_CURSOR [PE_TABLE_ENTRY_BASE]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Element Change

	force (a_entry: PE_TABLE_ENTRY_BASE)
			-- Force `a_entry'
		do
			items.force (a_entry)
		end

	replace (a_entry: PE_TABLE_ENTRY_BASE; i: NATURAL_32)
			-- Put `a_entry' at `i'-th position.
		do
			items.put_i_th (a_entry, i.to_integer_32)
		end

feature -- Status Report

	debug_output: STRING
		do
			Result := "["+ table_id.out +"] size=" + size.out
		end

	size: NATURAL_32
			-- Table size
		do
			Result := items.count.to_natural_32
		end

	is_empty: BOOLEAN
			-- Is the table empty?
		do
			Result := items.is_empty
		end

end
