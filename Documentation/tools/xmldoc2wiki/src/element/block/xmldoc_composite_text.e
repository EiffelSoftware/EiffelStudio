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
		redefine
			add_item
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

feature -- Element change

	add_item (i: XMLDOC_ITEM)
			-- Add item `i' to `items'
		do
--			if
--				{t: XMLDOC_TEXT} i and then
--				not t.is_empty and then
--				(items.is_empty or else not {tt: XMLDOC_TEXT} items.last)
--			then
--				t.clean_first_blank
--			end
			Precursor (i)
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
