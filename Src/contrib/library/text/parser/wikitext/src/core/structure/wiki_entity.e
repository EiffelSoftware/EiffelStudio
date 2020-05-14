note
	description: "Summary description for {WIKI_ENTITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_ENTITY

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		do
			value := s
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
			a_visitor.visit_entity (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "&" + value + ";"
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
