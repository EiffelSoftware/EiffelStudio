note
	description: "Summary description for {WIKI_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_STRING

inherit
	WIKI_STRING_ITEM
		redefine
			is_whitespace
		end

	DEBUG_OUTPUT

create
	make

convert
	make ({STRING, READABLE_STRING_8})

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		do
			text := s
		end

feature -- Access

	text: READABLE_STRING_8

	parts: detachable WIKI_STRING_LIST

feature {WIKI_STRING_ANALYZER} -- Element change

	set_parts (p: attached like parts)
		do
			parts := p
		end

feature -- Status

	is_single_line: BOOLEAN
		do
			Result := not text.has ('%N')
		end

	is_empty: BOOLEAN
		do
			Result := text.is_empty and ((attached parts as l_parts and then l_parts.count = 0) or else parts = Void)
		end

	is_whitespace: BOOLEAN
		do
			Result := text.is_whitespace and ((attached parts as l_parts and then l_parts.count = 0) or else parts = Void)
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_string (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (text)
			if Result.count > 50 then
				Result.keep_head (50 - 3)
				Result.append_string ("...")
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
