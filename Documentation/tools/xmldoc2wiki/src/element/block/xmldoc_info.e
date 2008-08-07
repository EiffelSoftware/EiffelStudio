indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_INFO

inherit
	XMLDOC_COMPOSITE_TEXT
		redefine
			process_visitor
		end

create
	make

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_info (Current)
		end
	
end
