note
	description: "Summary description for {WIKI_CODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_CODE

inherit
	WIKI_TAG
		redefine
			default_tag_name,
			process
		end

create
	make,
	make_from_source

feature -- Access

	default_tag_name: STRING
		do
			Result := "code"
		end

feature -- Status report

	is_inline: BOOLEAN
		do
			Result := text.is_single_line
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_code (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
