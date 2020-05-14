note
	description: "[
			Summary description for {WIKI_EXTERNAL_LINK}.

			[http://www.example.com Example site]
			[http://www.example.com|Example site]
			[#anchor_name Title]
			[http://www.example.com|param1|param2|Example site]
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

	make (s: READABLE_STRING_8)
			-- [schema:resource title]
		require
			starts_with_bracket: s.starts_with ("[")
			ends_with_bracket: s.ends_with ("]")
			valid_wiki_link: s.count > 0
		local
			i, p, n: INTEGER
			l_text: detachable READABLE_STRING_8
		do
			from
				n := s.count
				p := 1 + 1 -- skip first "["
			until
				p > n or s.item (p).is_space or s.item (p) = '|'
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
				i := l_text.last_index_of ('|', l_text.count)
				if i > 0 then
					text := wiki_raw_string (l_text.substring (i + 1, l_text.count))
					l_text := l_text.head (i - 1)
					across
						l_text.split ('|') as ic
					loop
						add_parameter (ic.item)
					end
				else
					text := wiki_raw_string (l_text)
				end
			end
		end

feature -- Access

	url: READABLE_STRING_8

	text: WIKI_STRING_ITEM

	parameters: detachable ARRAYED_LIST [READABLE_STRING_8]

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := text.is_empty and url.is_empty
		end

	has_valid_url: BOOLEAN
			-- Is `url' a valid url for wiki external link?
			--| simple validation, it should match [a-z0-9]+:[^\s]
			--| i.e starts with a scheme composed of alpha-numeric char, then a ":"
			--|     and then a non whitespace char.
			--|		no further validation for now.
			--|	Examples of valid urls:
			--|		https://example.com
			--|		mailto:foo@bar.com
			--|		foo:bar
			--|		#anchor_name
			--| Also accept absolute path such as /foo/bar as it may be convenient when using wikitext feature in a non full wiki site.
			--| But "foo: bar", "foo:", ":bar" will return False.
		local
			l_url: like url
			i: INTEGER
			s: READABLE_STRING_8
		do
			l_url := url
			if l_url.is_whitespace then
				Result := False
			elseif l_url [1] = '#' then
				Result := True
			elseif l_url [1] = '/' then
				Result := True
			else
				i := l_url.index_of (':', 1)
				if i > 1 and i < l_url.count then
						-- Has ':', and does not ends with it.
					s := l_url.head (i - 1)
					Result := across s as ic all ic.item.is_alpha_numeric end
					if Result then
							-- This should not be usefull to check, since `make' is extracting
							-- the `url', thanks to the first whitespace.
							-- But in case, someone update the `url' in a different manner.!
						check l_url.valid_index (i + 1) end
						Result := not l_url[i + 1].is_space
					end
				else
					Result := False
				end
			end
		end

feature -- Element change

	add_parameter (p: READABLE_STRING_8)
		local
			lst: like parameters
		do
			lst := parameters
			if lst = Void then
				create lst.make (1)
				parameters := lst
			end
			lst.force (p)
		ensure
			parameters /= Void
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_external_link (Current)
		end

note
	copyright: "2011-2019, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
