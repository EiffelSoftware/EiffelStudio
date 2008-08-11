indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_TABLE_CELL

inherit
	XMLDOC_COMPOSITE_TEXT
		redefine
			process_visitor
		end

	XMLDOC_WITH_WIDTH

	XMLDOC_WITH_HEIGHT

create
	make

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_table_cell (Current)
		end

end
