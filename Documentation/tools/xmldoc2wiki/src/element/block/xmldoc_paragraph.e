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
			process_visitor
		end

	XMLDOC_WITH_TITLE

create
	make

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_paragraph (Current)
		end

end
