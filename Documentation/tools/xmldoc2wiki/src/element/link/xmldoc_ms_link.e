indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_MS_LINK

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

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
			v.process_ms_link (Current)
		end

end
