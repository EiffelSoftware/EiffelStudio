indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_PAGE

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_TITLE

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make
		do
			create {ARRAYED_LIST [XMLDOC_COMPOSITE_TEXT]} composite_texts.make (10)
		end

feature -- Access

	composite_texts: LIST [XMLDOC_COMPOSITE_TEXT]
			-- Associated composite_texts

	meta_data: XMLDOC_METADATA
			-- Meta data

feature -- Element change

	set_meta_data (v: like meta_data)
		do
			meta_data := v
		end

	add_composite_text (p: XMLDOC_COMPOSITE_TEXT)
			-- Add composite text `p' to `composite_texts'
		require
			p_attached: p /= Void
		do
			composite_texts.extend (p)
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_page (Current)
		end

feature -- Status report

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := composite_texts.count.out + " composite text(s)"
		end


end
