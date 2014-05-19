note
	description: "Summary description for {WIKI_LINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_LINE

inherit
	WIKI_ITEM

	DEBUG_OUTPUT

create
	make

convert
	make ({STRING})

feature {NONE} -- Initialization

	make (s: STRING)
		do
			text := s
		end

feature -- Access

	text: WIKI_STRING

feature -- Status report

	line_count: INTEGER

	is_empty: BOOLEAN
		do
			Result := text.is_empty
		end

	is_whitespace: BOOLEAN
		do
			Result := text.is_whitespace
		end

feature -- Element change

	set_line_count (n: like line_count)
		require
			n >= 0
		do
			line_count := n
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_line (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := text.debug_output
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
