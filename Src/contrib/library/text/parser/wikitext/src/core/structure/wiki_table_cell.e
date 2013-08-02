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

	text: WIKI_STRING --\ WIKI_ITEM ... since a table cell can contain another table ...

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_table_cell (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
