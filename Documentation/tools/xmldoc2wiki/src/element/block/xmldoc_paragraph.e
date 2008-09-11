indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_PARAGRAPH

inherit
	XMLDOC_COMPOSITE_TEXT
		redefine
			process_visitor,
			add_item
		end

	XMLDOC_BLOCK_I

	XMLDOC_WITH_TITLE

create
	make

feature -- Access

	add_item (i: XMLDOC_ITEM)
			-- Add item `i' to `items'
		do
			if
				{t: XMLDOC_TEXT} i and then
				not t.is_empty and then
				(items.is_empty
				 --or else not {tt: XMLDOC_TEXT} items.last
				)
			then
				t.clean_first_blank
			end
			Precursor (i)
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_paragraph (Current)
		end

end
