indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_LINE_BREAK

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_BLOCK_I

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current.
		do
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_line_break (Current)
		end


end
