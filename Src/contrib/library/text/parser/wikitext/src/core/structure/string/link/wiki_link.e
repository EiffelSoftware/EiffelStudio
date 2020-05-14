note
	description: "Summary description for {WIKI_LINK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=WikiText Link", "protocol=URI", "src=http://en.wikipedia.org/wiki/Help:Wiki_markup#Links_and_URLs"

class
	WIKI_LINK

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (s: READABLE_STRING_8)
			-- [[title|string]]
			-- [[title|a|b|c|string]]
			-- [[Image:title|string]]
			-- [[:spec:title|string]]
		require
			valid_wiki_link: s.count > 0
			starts_with_double_bracket: s.starts_with ("[[")
			ends_with_double_bracket: s.ends_with ("]]")
		local
			i, p, n: INTEGER
			t,l_title: detachable STRING
			in_link: INTEGER -- depth
		do
			from
				n := s.count
				p := 1 + 2 -- skip "[["
				i := p
			until
				p > n or not is_valid_wiki_name_character (s.item (p))
			loop
				p := p + 1
			end
			name := s.substring (i, p - 1).to_string_8
			name.left_adjust
			name.right_adjust
			if p < n then
				from
					create t.make_empty
				until
					p > n - 2
				loop
					if in_link > 0 then
						if s[p] = ']' and then safe_character (s, p + 1) = ']' then
							in_link := in_link - 1
							p := p + 1
							t.extend (']')
							t.extend (']')
						else
							t.extend (s[p])
						end
					else
						inspect s[p]
						when '|' then
							if l_title = Void or else l_title.is_empty then
								l_title := t
							else
								add_parameter (l_title)
								l_title := t
							end
							create t.make_empty
						when '[' then
							t.extend ('[')
							if safe_character (s, p + 1) = '[' then
								in_link := in_link + 1
								p := p + 1
								t.extend ('[')
							end
						else
							t.extend (s[p])
						end
					end
					p := p + 1
				end
				if t.is_empty then
					if l_title = Void or else l_title.is_empty then
						text := wiki_raw_string (name)
					else
						text := wiki_raw_string (l_title)
					end
				else
					if l_title /= Void then
						add_parameter (l_title)
					end
					text := wiki_string (t)
				end
			else
				text := wiki_raw_string (name)
			end
			p := name.index_of ('#', 1)
			if p > 0 then
				fragment := name.substring (p + 1, name.count)
				name.keep_head (p - 1)
			else
				fragment := Void
			end
		end

feature -- Access

	name: STRING

	fragment: detachable READABLE_STRING_8
			-- Optional fragment such as "ref" in "name#ref".

	text: WIKI_STRING_ITEM

	parameters: detachable ARRAYED_LIST [READABLE_STRING_8]

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := name.is_empty and text.is_empty
		end

feature -- Status

	inlined: BOOLEAN

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name + " {" + generator + "}"
		end

feature -- Element change

	set_inlined (b: like inlined)
		do
			inlined := b
		end

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
			a_visitor.visit_link (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
