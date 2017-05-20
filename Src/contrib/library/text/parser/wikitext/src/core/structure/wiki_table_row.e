note
	description: "[
			Summary description for {WIKI_TABLE_ROW}.

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TABLE_ROW

inherit
	WIKI_COMPOSITE [WIKI_TABLE_CELL]
		redefine
			process
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
		end

feature -- Access

	style: detachable READABLE_STRING_8
			-- Optional style.		

feature -- Element change

	set_style (s: like style)
		do
			style := s
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_table_row (Current)
		end

note
	copyright: "2011-2017, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
