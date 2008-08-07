indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_IMAGE_LINK

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_URL

	XMLDOC_WITH_TARGET

	XMLDOC_WITH_IMAGE

	XMLDOC_WITH_BORDER
		rename
			make as make_border
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			make_border
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_image_link (Current)
		end

end
