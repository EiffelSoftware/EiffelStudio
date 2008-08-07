indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_COMPOSITE_TEXT

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_CONTENT
		rename
			make as make_content
		end

	XMLDOC_WITH_STYLE

	XMLDOC_WITH_ALIGNMENT
		rename
			make as make_alignment
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			make_content
			make_alignment
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_composite_text (Current)
		end

feature -- Status report

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := items.count.out + " item(s)"
		end

end
