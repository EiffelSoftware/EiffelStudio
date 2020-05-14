note
	description: "Summary description for {WIKI_INSTRUCTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_MAGIC_WORD

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make_from_source

feature {NONE} -- Initialization

	make_from_source (s: READABLE_STRING_8)
		require
			s.starts_with ("__") and s.ends_with ("__")
		do
			value := s.substring (3, s.count - 2)
		end

feature -- Access

	value: READABLE_STRING_8

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := value.is_empty
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_magic_word (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "__" + value + "__"
		end

note
	copyright: "2011-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
