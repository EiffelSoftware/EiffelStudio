indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_UNAVAILABLE

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (tn: STRING)
		require
			tn_attached: tn /= Void
		do
			tagname := tn
		end

feature -- Access

	tagname: STRING
			-- Associated tag name

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_unavailable (Current)
		end

feature -- Status report

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string ("Unavailable: " + tagname)
		end

invariant
	tagname_attached: tagname /= Void

end
