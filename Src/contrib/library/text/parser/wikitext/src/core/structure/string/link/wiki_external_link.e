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
			starts_with_bracket: s.starts_with ("[")
			ends_with_bracket: s.ends_with ("]")
			valid_wiki_link: s.count > 0
		local
			p, n: INTEGER
			l_text: detachable READABLE_STRING_8
		do
			from
				n := s.count
				p := 1 + 1 -- skip first "["
			until
				p > n or s.item (p).is_space
			loop
				p := p + 1
			end
			if p > n then
				url := s.substring (2, n - 1)
			else
				url := s.substring (2, p - 1)
			end
			if p < n then
				l_text := s.substring (p + 1, n - 1) --| n -1: to ignore last "]"
				if l_text.is_whitespace then
					l_text := Void
				end
			end
			if l_text = Void then
				text := wiki_raw_string (url)
			else
				text := wiki_raw_string (l_text)
			end
		end

feature -- Access

	url: STRING

	text: WIKI_STRING_ITEM

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := text.is_empty and url.is_empty
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_external_link (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
