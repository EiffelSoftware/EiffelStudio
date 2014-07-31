note
	description: "Summary description for {WIKI_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TEMPLATE

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
		require
			starts_with_double_curly_bracket: s.starts_with ("{{")
			ends_with_double_curly_bracket: s.ends_with ("}}")
		local
			p: INTEGER
--			t: STRING
--			subs: LIST [STRING]
		do
			p := s.index_of ('|', 3)
			if p > 0 then
				name := s.substring (3, p - 1)
				if p < s.count - 2 then
					parameters_string := s.substring (p + 1, s.count - 2)
				end
			else
				name := s.string
			end
		end

feature -- Access

	name: STRING

	parameters_string: detachable WIKI_STRING

	expression: detachable WIKI_STRING

	text (tpl: READABLE_STRING_8): WIKI_STRING
		local
			s: STRING
			i: INTEGER
			lst: LIST [READABLE_STRING_8]
			vis: WIKI_STRING_ANALYZER
		do
			create s.make_from_string (tpl)
			if attached parameters_string as pstr then
				lst := pstr.text.split ('|')
				across
					lst as ic
				loop
					i := i + 1
					s.replace_substring_all ("{{{" + i.out  + "}}}", ic.item)
				end
			end
			create Result.make (s)
			create vis.make
			Result.process (vis)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
				-- TODO: check that.
			Result := False
		end

feature -- Element change

	set_expression (a_exp: like expression)
		do
			expression := a_exp
		end

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
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
