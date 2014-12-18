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
			make,
			make_from_source,
			default_tag_name,
			process
		end

create
	make,
	make_from_source

feature {NONE} -- Initialization

	make (a_tag, s: STRING_8)
			-- <Precursor>
		do
			Precursor (a_tag, s)
			set_is_inline (text.is_single_line and not s.has ('%N'))
		end

	make_from_source (s: STRING)
			-- <Precursor>
		do
			Precursor (s)
			set_is_inline (text.is_single_line and not s.has ('%N'))
		end

feature -- Access

	default_tag_name: STRING
		do
			Result := "code"
		end

feature -- Status report

	is_inline: BOOLEAN

feature -- Element change

	set_is_inline (b: BOOLEAN)
			-- Set `is_inline' to `b'.
		do
			is_inline := b
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
