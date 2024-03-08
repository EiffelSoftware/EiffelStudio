note
	description: "A Metadata table"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLE

inherit
	ITERABLE [PE_TABLE_ENTRY_BASE]

	MD_VISITABLE

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_id: NATURAL_32)
		do
			table_id := a_id
			create {ARRAYED_LIST [PE_TABLE_ENTRY_BASE]} items.make (0)
		end

feature -- Access

	table_id: NATURAL_32

feature {MD_TABLE_ACCESS} -- Access	

	items: LIST [PE_TABLE_ENTRY_BASE]
			-- vector of tables that can appear in a PE file
			-- empty tables are elided / pass over?

feature {MD_TABLE_ACCESS} -- Access	

	replace_items (lst: LIST [PE_TABLE_ENTRY_BASE])
			-- Replace `items` with `lst`.
		do
			items := lst
		end

feature -- Access

	item alias "[]" (i: NATURAL_32): PE_TABLE_ENTRY_BASE assign replace
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

feature -- Sorting

	sort (a_sorter: SORTER [PE_TABLE_ENTRY_BASE])
			-- Sort `items` using `a_sorter`
		do
			a_sorter.sort (items)
		ensure
			is_sorted: is_sorted (a_sorter)
		end

	is_sorted (a_sorter: SORTER [PE_TABLE_ENTRY_BASE]): BOOLEAN
			-- Is `items` container sorter using `a_sorter`?
		do
			Result := a_sorter.sorted (items)
		end

feature -- Status Report

	debug_output: STRING
		do
			Result := "[0x"+ table_id.to_natural_8.to_hex_string +"] size=" + size.out
		end

	count: INTEGER
			-- Table count
		do
			Result := items.count
		end

	size: NATURAL_32
			-- Table size
		do
			Result := count.to_natural_32
		end

	next_index: NATURAL_32
		do
			Result := size + 1
		end

	is_empty: BOOLEAN
			-- Is the table empty?
		do
			Result := items.is_empty
		end

	valid_index (idx: NATURAL_32): BOOLEAN
		do
			Result := idx >= 0 and idx <= size + 1
		end

feature -- Visitor

	accepts (vis: MD_VISITOR)
		do
			vis.visit_table (Current)
		end

end
