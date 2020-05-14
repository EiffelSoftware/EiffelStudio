note
	description: "Summary description for {WIKI_BLOCKQUOTE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_PREFORMATTED_TEXT

inherit
	WIKI_BOX [WIKI_LINE]
		redefine
			process
		end

create
	make

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
		require
			s_attached: s /= Void
			s_starts_with_space: s.count > 0 and then s.item (1).is_space
		do
			initialize
			add_element (create {WIKI_LINE}.make (s.substring (2, s.count)))
		end

feature -- Status

	is_empty: BOOLEAN
		do
			if count = 0 then
				Result := True
			elseif count = 1 then
				if attached elements.first as e then
					Result := e.is_empty
				end
			end
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_preformatted_text (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
