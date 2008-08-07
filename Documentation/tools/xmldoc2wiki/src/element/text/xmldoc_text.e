indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_TEXT

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	DEBUG_OUTPUT

	XMLDOC_WITH_TEXT

create
	make

feature {NONE} -- Initialization

	make (c: XMLDOC_CONTENT) is
			-- Initialize `Current'.
		do
			set_text (c.text)
		end
		
feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_text (Current)
		end

feature -- Status report

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (generator + "(" + text.count.out + ")=")
			if text.count > 10 then
				Result.append_string (text.substring (1, 10) + "...")
			else
				Result.append_string (text)
			end
		end
end
