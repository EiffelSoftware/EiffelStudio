indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_TABLE

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_LEGEND
	XMLDOC_WITH_WIDTH
	XMLDOC_WITH_HEIGHT
	XMLDOC_WITH_STYLE

	XMLDOC_WITH_BORDER
		rename
			make as make_border
		end

	XMLDOC_BLOCK_I

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			make_border
			create {LINKED_LIST [XMLDOC_TABLE_ROW]} rows.make
		end

feature -- Access

	rows: LIST [XMLDOC_TABLE_ROW]
			-- Contained rows

feature -- Element change

	add_row (i: XMLDOC_TABLE_ROW)
			-- Add item `i' to `rows'
		require
			i_attached: i /= Void
		do
			rows.extend (i)
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_table (Current)
		end

feature -- Status report

	debug_output: STRING is
		do
			Result := "Table: " + rows.count.out + " row(s)"
		end

end
