note
	description: "Summary description for {WIKI_STRING_ANALYZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Wikipedia Formatting", "protocol=URI", "src=https://en.wikipedia.org/wiki/Wikipedia:Tutorial/Formatting"
	EIS: "name=Wikipedia Wiki_markup", "protocol=URI", "src=https://en.wikipedia.org/wiki/Help:Wiki_markup"
	EIS: "name=Wikipedia Cheatsheet", "protocol=URI", "src=https://en.wikipedia.org/wiki/Wikipedia:Cheatsheet"

class
	WIKI_STRING_ANALYZER

inherit
	WIKI_ITERATOR
		redefine
			visit_string
		end

	WIKI_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Processing

	visit_string (a_string: WIKI_STRING)
		local
			l_parts: detachable WIKI_STRING_LIST
		do
			l_parts := a_string.parts
			if l_parts = Void then
				create l_parts.make
				analyze_string (a_string.text, l_parts)
				a_string.set_parts (l_parts)
				visit_composite (l_parts) --| FIXME: check this case
			else
				visit_composite (l_parts)
			end
		end

	analyze_string (a_text: STRING; a_parts: WIKI_STRING_LIST)
		local
			i,n, m: INTEGER
			p,q,r: INTEGER
			c: CHARACTER
			w_item: detachable WIKI_STRING_ITEM
--			tpl: detachable ARRAYED_STACK [TUPLE [position: INTEGER; tpl: WIKI_TEMPLATE]]
--			tok: STRING
			t,s: STRING
			s_last: STRING
			s_link: detachable STRING
			in_item: BOOLEAN
			done: BOOLEAN
		do
			n := a_text.count
			from
				create s_last.make (n)
				s := s_last
				i := 1
			until
				i > n
			loop
				c := a_text.item (i)
				inspect
					c
				when '{' then
					if safe_character (a_text, i + 1) = '{' then
						p := next_closing_template (a_text, i + 2)
						if p > i then
							flush_buffer (a_parts, s)
							create {WIKI_TEMPLATE} w_item.make (a_text.substring (i+2, p))
							a_parts.add_element (w_item)
							w_item.process (Current) -- Check recursion...							
							w_item := Void
							i := p + 2
						else
							--| Ignore this one ..
							s.extend (c)
						end
					elseif safe_character (a_text, i + 1) = '|' then
						p := next_closing_table (a_text, i + 2)
						if p > i then
							flush_buffer (a_parts, s)
							create {WIKI_TABLE} w_item.make (a_text.substring (i+2, p))
							a_parts.add_element (w_item)
							w_item.process (Current) -- Check recursion...							
							w_item := Void
							i := p + 2
						else
							--| Ignore this one ..
							s.extend (c)
						end
					else
						s.extend (c)
					end
				when '[' then
					if safe_character (a_text, i + 1) = '[' then
						if s_link /= Void then
								--| Cancel previous
							s_last.append (s_link)
							s_link.wipe_out
						else
							create s_link.make (20)
						end
						s := s_link
						in_item := True

						s.extend (c)
						i := i + 1
						s.extend ('[')
					elseif in_item then
						s.extend (c)
					else
						--| find closing external link bracket ']'
						p := a_text.index_of (']', i + 1)
						if p > 0 and p <= n then
							flush_buffer (a_parts, s)

							create {WIKI_EXTERNAL_LINK} w_item.make (a_text.substring (i + 1, p - 1))
							a_parts.add_element (w_item)
							w_item.process (Current) -- Check recursion...							
							w_item := Void
							i := p
						else
							s.extend (c)
						end
					end
				when ']' then
					if safe_character (a_text, i + 1) = ']' then
						s.extend (c)
						i := i + 1
						s.extend (']')

						if s_link /= Void then
							check s_is_for_link: s = s_link end
							s := s_last

							check valid_wiki_link: s_link.count > 4 and then (
									s_link.item (1) = '[' and s_link.item (2) = '[' and
									s_link.item (s_link.count - 1) = ']' and s_link.item (s_link.count) = ']'
								)
							end
							s_link := s_link.substring (3, s_link.count - 2)
							w_item := new_wiki_link (s_link)
							s_link := Void

							flush_buffer (a_parts, s)

							a_parts.add_element (w_item)
							w_item.process (Current) -- Check recursion...
							w_item := Void

							in_item := False
							s.wipe_out
						else
							check not in_item end
						end
					else
						s.extend (c)
					end
				when '<' then
					if
						safe_character (a_text, i + 1) = '!' and then
						safe_following_character_count (a_text, i + 2, '-') = 2
					then
						p := a_text.substring_index ("-->", i + 4)
						if p > 0 then
							--| End comment found
							flush_buffer (a_parts, s)

							a_parts.add_element (create {WIKI_COMMENT}.make (a_text.substring (i + 4, p - 1)))
							i := p + 2
						else
							s.extend (c)
						end
					elseif safe_character (a_text, i + 1) = '/' then
						s.extend (c)
					else
						p := next_end_of_tag_character (a_text, i + 1)
						if p > 0 then
							t := tag_name_from (a_text.substring (i, p))
							q := next_closing_tag (a_text, t, p + 1)
							if q > 0 then
								r := next_end_of_tag_character (a_text, q + 1)
								if r > 0 then
									flush_buffer (a_parts, s)
									if t.is_case_insensitive_equal_general ("code") then
										create {WIKI_CODE} w_item.make (a_text.substring (i, p), a_text.substring (p + 1, q - 1))
									elseif t.is_case_insensitive_equal_general ("nowiki") then
										create {WIKI_RAW_STRING} w_item.make (a_text.substring (p + 1, q - 1))
									else
										create {WIKI_TAG} w_item.make (t, a_text.substring (p + 1, q - 1))
									end
									a_parts.add_element (w_item)
									w_item.process (Current) -- Check recursion...							
									w_item := Void
									i := r
								else
									s.extend (c)
								end
							else
								s.extend (c)
							end
						else
							s.extend (c)
						end
					end
				when '%'' then
					--| Need fixes
					--| wikipedia:
					--| '''trois'''''deux''''' trois '''end   -> 3trois32deux23 trois 3end
					--| ''italic'''bold+italic'''italic''end ->2italic3bold+italic3italic2end
					--| Current either one or the other similar to wikipedia:
					--| 1)
					--| '''trois'''''deux''''' trois '''end   -> 3trois5deux5 trois 3end
					--| ''italic'''bold+italic'''italic''end ->2italic3bold+italic3italic2end
					--| Or 2)
					--| '''trois'''''deux''''' trois '''end   -> 3trois32deux23 trois 3end
					--| ''italic'''bold+italic'''italic''end ->2italic2'bold+italic3italic2end23
					--| For now, we adopt 2) which is more common

					if in_item then
						--| do not process this for now
						s.extend (c)
					else
						m := safe_following_character_count (a_text, i, '%'')
						if m = 4 then
							s.extend (c)
							i := i + 1
							m := 3
						elseif m > 5 then
							s.append (create {STRING}.make_filled ('%'', m - 5))
							i := i + 5
							m := 5
						end
						inspect m
						when 1 then
							s.extend (c)
						when 2,3,5 then
							from
								q := 0
								p := i + m
								done := False
							until
								p > n or done
							loop
								if a_text.item (p) = '%'' then
									q := q + 1
									--| first ending match: done := q = m
								elseif q = m then
									done := True --| exit condition
								else
									q := 0
								end
								p := p + 1
							end
							if m = q then
									--| matching end
								p := p - m - 1
--									--| best ending match:
--								p := p - 1
							else
								p := n
							end
							flush_buffer (a_parts, s)
							create {WIKI_STYLE} w_item.make (wiki_style_kind (m), a_text.substring (i + m, p))
							a_parts.add_element (w_item)
							w_item.process (Current) -- Check recursion...
							w_item := Void
							i := p + m - 1 -- + 1
						else
							check should_not_occur: False end
						end
					end
				when '&' then
					if in_item then
						s.extend (c)
					else
						p := i + 1 + 4
						if
							safe_character (a_text, i + 1) = '#' and then
							safe_character (a_text, p) = ';'
						then
							flush_buffer (a_parts, s)
							a_parts.add_element (create {WIKI_ENTITY}.make (a_text.substring (i + 1, p - 1)))
							i := p
						else
							p := a_text.index_of (';', i + 1)
							if p > 0  and p - i < 10 then
								flush_buffer (a_parts, s)
								a_parts.add_element (create {WIKI_ENTITY}.make (a_text.substring (i + 1, p - 1)))
								i := p
							else
								s.extend (c)
							end
						end
					end
				else
					s.extend (c)
				end
				i := i + 1
			end
			if s_link /= Void then
				s := s_last
				s.append (s_link)
				s_link := Void
			end
			check s = s_last end
			flush_buffer (a_parts, s)
			check s.is_empty end
			check s_last.is_empty end
			check s_link = Void end
		end

	flush_buffer (a_parts: WIKI_STRING_LIST; a_buffer: STRING)
		do
			if not a_buffer.is_empty then
				a_parts.add_raw_string (a_buffer.string)
				a_buffer.wipe_out
			end
		end

	next_closing_template (s: STRING; a_start: INTEGER): INTEGER
		local
			i,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '{' then
					if safe_character (s, i + 1) = '{' then
						v := v + 1
					end
				when '}' then
					if safe_character (s, i + 1) = '}' then
						if v = 0 then
							Result := i - 1
						else
							v := v - 1
						end
					end
				else
				end
				i := i + 1
			end
		end

	next_closing_table (s: STRING; a_start: INTEGER): INTEGER
		local
			i,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '{' then
					if safe_character (s, i + 1) = '|' then
						v := v + 1
					end
				when '|' then
					if safe_character (s, i + 1) = '}' then
						if v = 0 then
							Result := i - 1
						else
							v := v - 1
						end
					end
				else
				end
				i := i + 1
			end
		end

	next_end_of_tag_character (s: STRING; a_start: INTEGER): INTEGER
		local
			i,n: INTEGER
			v: INTEGER
		do
			from
				i := a_start
				n := s.count
			until
				Result > a_start or i > n
			loop
				inspect s[i]
				when '<' then
					v := v + 1
				when '>' then
					if v = 0 then
						Result := i
					else
						v := v - 1
					end
				else
				end
				i := i + 1
			end
		end

	next_closing_tag (s: STRING; a_tag_name: READABLE_STRING_8; a_start: INTEGER): INTEGER
		local
--			i,n,p: INTEGER
--			v: INTEGER
		do
			Result := s.substring_index ("</" + a_tag_name + ">", a_start)

--			from
--				v := 1
--				i := a_start
--				n := s.count
--			until
--				Result > a_start or i > n
--			loop
--				inspect s[i]
--				when '<' then
--					if s.valid_index (i + 1) and then s[i+1] = '/' then -- closing
--						v := v - 1
--					else
--						v := v + 1
--					end
--					if v = 0 then
--						Result := i
--					else
--						i := next_end_of_tag_character (s, i + 1)
--					end
--				else
--				end
--				i := i + 1
--			end
		end

	wiki_style_kind (n: INTEGER): INTEGER
		do
			inspect n
			when 2 then
				Result := {WIKI_STYLE}.italic_kind
			when 3 then
				Result := {WIKI_STYLE}.bold_kind
			when 5 then
				Result := {WIKI_STYLE}.italic_bold_kind
			else
			end
		end

	new_wiki_link (s: STRING): WIKI_LINK
		require
			s_not_empty: s.count > 0
		local
			n,b: INTEGER
			t: STRING
			l_inlined: BOOLEAN

		do
			n := s.count
			if s[1] = ':' then
				l_inlined := True
				b := 1
			end
			t := s.substring (b + 1, b + 6) --| ("image:").count = 6
			if     t.is_case_insensitive_equal ("image:") then
				create {WIKI_IMAGE_LINK} Result.make (s.substring (b + 7, n))
			elseif t.is_case_insensitive_equal ("category:") then
				create {WIKI_CATEGORY_LINK} Result.make (s.substring (b + 10, n))
			elseif t.is_case_insensitive_equal ("media:") then
				create {WIKI_MEDIA_LINK} Result.make (s.substring (b + 7, n))
			else
				create Result.make (s)
			end
		end

feature {NONE} -- Implementation

	tag_name_from (s: READABLE_STRING_8): STRING_8
			-- Tag name from  inside of <...>
			--| for instance ' abc def="geh"' will return abc
		local
			i,n: INTEGER
		do
			i := s.index_of (' ', 2)
			n := s.index_of ('%T', 2)
			if i = 0 then
				i := n
			elseif n /= 0 then
				i := i.min (n)
			end
			if i > 0 then
				create Result.make_from_string (s.substring (2, i - 1))
			else
				create Result.make_from_string (s.substring (2, s.count - 1))
			end
			Result.left_adjust
			Result.right_adjust
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
