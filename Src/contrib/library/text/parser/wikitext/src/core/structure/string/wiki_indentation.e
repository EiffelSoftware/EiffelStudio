note
	description: "Summary description for {WIKI_INDENTATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_INDENTATION

inherit
	WIKI_BOX [WIKI_ITEM]
		redefine
			process,
			valid_element
		end

create
	make

feature {NONE} -- Initialization

	make (a_indentation_level: NATURAL)
		do
			indentation_level := a_indentation_level
			initialize
			create text.make_empty
		end

feature -- Access

	indentation_level: NATURAL

	text: STRING

	structure: detachable WIKI_STRUCTURE

feature -- Status report

	valid_element (e: WIKI_ITEM): BOOLEAN
		do
			Result := False -- Do not accept any element !!!
		end

feature -- Element change

	get_structure
		do
			if structure = Void then
				create structure.make (text)
			end
		end

	append_text (s: READABLE_STRING_8)
		do
			structure := Void
			text.append_string (s)
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_indentation (Current)
		end

invariant
	indentation_level >= 0

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
