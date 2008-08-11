indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_TABLE_ROW

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_STYLE

	XMLDOC_WITH_HEIGHT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create {LINKED_LIST [XMLDOC_TABLE_CELL]} cells.make
		end

feature -- Access

	cells: LIST [XMLDOC_TABLE_CELL]
			-- Contained cells

feature -- Element change

	add_cell (i: XMLDOC_TABLE_CELL)
			-- Add item `i' to `cells'
		require
			i_attached: i /= Void
		do
			cells.extend (i)
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_table_row (Current)
		end

end
