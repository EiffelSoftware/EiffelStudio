indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_EIFFEL_LINK

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_LIKE_EIFFEL_LINK

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_eiffel_link (Current)
		end

end
