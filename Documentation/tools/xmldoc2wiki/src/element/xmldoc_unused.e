indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_UNUSED

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_CONTENT
		rename
			make as make_with_content
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
			make_with_content
		end

feature -- Access

	tagname: STRING
			-- Associated tag name

	text_representation: XMLDOC_CONTENT
		local
			i: XMLDOC_ITEM
			s: STRING
		do
			from
				create s.make_empty
				items.start
			until
				items.after
			loop
				i := items.item
				if {t: XMLDOC_WITH_TEXT} i then
					s.append (t.text)
				elseif {tc: XMLDOC_TEXT_CONTAINER} i then
					s.append (tc.text_representation.text)
				end
				items.forth
			end
			create Result.make_with_text (s)
		ensure
			Result_attached: Result /= Void
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_unused (Current)
		end

feature -- Status report

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string ("Unused: " + tagname)
		end

invariant
	tagname_attached: tagname /= Void

end
