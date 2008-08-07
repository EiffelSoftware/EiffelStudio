indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_WARNING

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
			v.process_warning (Current)
		end
	
end
