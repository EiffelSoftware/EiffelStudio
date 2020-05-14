note
	description: "Summary description for {WIKI_RAW_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_RAW_STRING

inherit
	WIKI_STRING_ITEM
		redefine
			is_whitespace
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		do
			text := s
		end

feature -- Access

	text: READABLE_STRING_8

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := text.is_empty
		end

	is_whitespace: BOOLEAN
			-- <Precursor>
		do
			Result := text.is_whitespace
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_raw_string (Current)
		end

feature -- Status report

	debug_output: READABLE_STRING_8
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := text
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
