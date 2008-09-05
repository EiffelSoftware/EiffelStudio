indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_META

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

feature -- Access

	name: STRING

	content: STRING

feature -- Element change

	set_name (v: like name)
		do
			name := v
		end

	set_content (v: like content)
		do
			content := v
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_item (Current)
		end

end
