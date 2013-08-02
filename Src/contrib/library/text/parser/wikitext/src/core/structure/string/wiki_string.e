note
	description: "Summary description for {WIKI_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_STRING

inherit
	WIKI_STRING_ITEM

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

	text: STRING

	parts: detachable WIKI_STRING_LIST

feature -- Element change

	set_parts (p: attached like parts)
		do
			parts := p
		end

feature -- Status

	is_empty: BOOLEAN
		do
			Result := text.is_empty and ((attached parts as l_parts and then l_parts.count = 0) or else parts = Void)
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
			if Result.count > 30 then
				Result.keep_head (27)
				Result.append_string ("...")
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
