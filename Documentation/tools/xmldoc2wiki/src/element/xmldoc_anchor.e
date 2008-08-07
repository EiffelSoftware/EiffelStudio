indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_ANCHOR

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

feature -- Access

	name: STRING
			-- Associated anchor name

feature -- Element change

	set_name (v: like name)
		require
			v_attached: v /= Void
		do
			name := v
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_anchor (Current)
		end

end
