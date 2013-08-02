note
	description: "Summary description for {WIKI_TAG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TAG

inherit
	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_tag_name: STRING; s: STRING)
		local
			i,j: INTEGER
		do
			i := a_tag_name.index_of (' ', 1)
			j := a_tag_name.index_of ('%T', 1)
			if i = 0 then
				i := j
			elseif j /= 0 then
				i := i.min (j)
			end
			if i > 0 then
				tag_name := a_tag_name.substring (1, i - 1)
			else
				tag_name := a_tag_name
			end

			text := s
		end

feature -- Access

	tag_name: STRING

	text: WIKI_STRING

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_tag (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "<" + tag_name + ">..</" + tag_name + ">"
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
