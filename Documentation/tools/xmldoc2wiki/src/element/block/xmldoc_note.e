indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_NOTE

inherit
	XMLDOC_COMPOSITE_TEXT
		redefine
			process_visitor
		end

	XMLDOC_BLOCK_I

create
	make

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_note (Current)
		end

end
