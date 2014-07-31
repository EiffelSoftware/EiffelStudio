note
	description: "Summary description for {WIKI_TABLE_CELL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TABLE_CELL

inherit
	WIKI_ITEM

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
		do
			text := s
		end

feature -- Access

	text: WIKI_STRING
			-- A table cell can contain another table, ...

	modifiers: detachable ARRAYED_LIST [READABLE_STRING_8]

feature -- Element change

	add_modifier (s: READABLE_STRING_8)
		local
			lst: like modifiers
		do
			lst := modifiers
			if lst = Void then
				create lst.make (1)
				modifiers := lst
			end
			lst.force (s)
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_table_cell (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
