note
	description: "Summary description for {WIKI_LINK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_LINK

inherit
	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
			-- [[title|string]]
		require
			valid_wiki_link: s.count > 0
		local
			p, n: INTEGER
		do
			from
				n := s.count
				p := 1
			until
				p > n or not is_valid_wiki_name_character (s.item (p))
			loop
				p := p + 1
			end
			name := s.substring (1, p - 1)
			name.left_adjust
			name.right_adjust
			if p < n then
				p := s.index_of ('|', p)
				if p > 0 then
					text := wiki_string (s.substring (p + 1, n))
				else
					text := wiki_raw_string (name)
				end
			else
				text := wiki_raw_string (name)
			end
		end

feature -- Access

	name: STRING

	text: WIKI_STRING_ITEM

feature -- Status

	inlined: BOOLEAN

feature -- Element change

	set_inlined (b: like inlined)
		do
			inlined := b
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_link (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
