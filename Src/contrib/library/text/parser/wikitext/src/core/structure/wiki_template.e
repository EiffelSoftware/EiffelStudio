note
	description: "Summary description for {WIKI_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TEMPLATE

inherit
	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
		local
			p: INTEGER
--			t: STRING
--			subs: LIST [STRING]
		do
			p := s.index_of ('|', 1)
			if p > 0 then
				name := s.substring (1, p - 1)
				if p < s.count then
					parameters_string := s.substring (p + 1, s.count)
				end
			else
				name := s.string
			end
		end

feature -- Access

	name: STRING

	parameters_string: detachable WIKI_STRING

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_template (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "{{" + name + "}}"
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
