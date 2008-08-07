indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_METADATA

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

create
	make

feature {NONE} -- Initialization

	make
		do

		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_metadata (Current)
		end

end
