indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_LINK

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_URL

	XMLDOC_WITH_LABEL

	XMLDOC_WITH_TARGET

	XMLDOC_WITH_ANCHOR_NAME

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
			v.process_link (Current)
		end

end
