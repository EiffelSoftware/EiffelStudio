note
	description: "[
			Summary description for {WIKI_EXTERNAL_LINK}.

			[http://www.example.com Example site]
			[mailto:me@address.com Email me]
			[file://.... the local file]

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_EXTERNAL_LINK

inherit
	WIKI_STRING_ITEM

create
	make

feature {NONE} -- Initialization

	make (s: STRING)
			-- [schema:resource title]
		require
			valid_wiki_link: s.count > 0
		local
			p, n: INTEGER
		do
			from
				n := s.count
				p := 1
			until
				p > n or s.item (p).is_space
			loop
				p := p + 1
			end
			url := s.substring (1, p - 1)
			if p < n then
				text := wiki_string (s.substring (p + 1, n))
			else
				text := wiki_raw_string (url)
			end
		end

feature -- Access

	url: STRING

	text: WIKI_STRING_ITEM

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_external_link (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
