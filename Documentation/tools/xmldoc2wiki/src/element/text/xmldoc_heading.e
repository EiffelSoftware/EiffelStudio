indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_HEADING

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_CONTENT
		rename
			make as make_with_content
		end

	XMLDOC_WITH_SIZE
		rename
			make as make_with_size
		end

create
	make

feature -- Initialization

	make
		do
			make_with_size
			make_with_content
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_heading (Current)
		end

end
