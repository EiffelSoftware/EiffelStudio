indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_UNDERLINE

inherit
	XMLDOC_TEXT_CONTAINER
		redefine
			process_visitor
		end

create
	make


feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_underline (Current)
		end	

end
