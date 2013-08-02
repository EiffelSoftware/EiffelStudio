note
	description: "Summary description for {WIKI_CODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_CODE

inherit
	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_tag: READABLE_STRING_8; s: STRING)
		do
			tag_name := "code"
			tag := a_tag
			text := s
		end

feature -- Access

	tag: READABLE_STRING_8

	tag_name: READABLE_STRING_8

	text: WIKI_STRING

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_code (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := tag + "</" + tag_name + ">"
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
