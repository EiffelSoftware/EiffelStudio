note
	description: "Summary description for {WIKI_PARAGRAPH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_PARAGRAPH

inherit
	WIKI_BOX [WIKI_ITEM]
		redefine
			process,
			valid_element
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
		end

feature -- Status report

	valid_element (e: WIKI_ITEM): BOOLEAN
		do
			Result := attached {WIKI_LINE} e
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_paragraph (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
