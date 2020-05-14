note
	description: "Summary description for {WIKI_STYLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_STYLE

inherit
	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_kind: INTEGER; s: READABLE_STRING_8)
		require
			valid_kind: valid_kind (a_kind)
			s_attached: s /= Void
		do
			kind := a_kind
			text := s
		end

feature -- Access

	kind: INTEGER

	text: WIKI_STRING

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := text.is_empty
		end

	is_italic: BOOLEAN
		do
			Result := kind = italic_kind
		end

	is_bold: BOOLEAN
		do
			Result := kind = bold_kind
		end

	is_italic_bold: BOOLEAN
		do
			Result := kind = italic_bold_kind
		end

feature -- Valid kind

	italic_kind: INTEGER = 2
	bold_kind: INTEGER = 3
	italic_bold_kind: INTEGER = 5

	valid_kind (k: like kind): BOOLEAN
		do
			inspect
				k
			when italic_kind, bold_kind, italic_bold_kind then
				Result := True
			else
			end
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_style (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

