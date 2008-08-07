indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_DOC_LINK

inherit
	XMLDOC_LINK
		redefine
			process_visitor
		end

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
			v.process_doc_link (Current)
		end

end
