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

	WIKI_ANALYZER_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Query

	is_alias_for_code (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' an alias of "<code>" ?
		do
			Result := s.is_case_insensitive_equal ("code") or else s.is_case_insensitive_equal ("source")
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
			w_ext_lnk: WIKI_EXTERNAL_LINK
			t,s: STRING
			s_last: STRING
			s_link: detachable STRING
			in_items: ARRAYED_STACK [TUPLE [position: INTEGER; kind: STRING]] -- Names
			done: BOOLEAN
		do
			n := a_text.count
			from
				create in_items.make (0)
				create s_last.make (n)
				s := s_last
				i := 1
			until
				i > n
			loop
				c := a_text.item (i)
				inspect c
				when '{' then
					if safe_character (a_text, i + 1) = '{' then
						if safe_character (a_text, i + 2).is_alpha_numeric then
								-- Wiki Template
							p := next_closing_template (a_text, i + 2)
							if p > i then
								if in_items.is_empty then
									flush_buffer (a_parts, s)
									create {WIKI_TEMPLATE} w_item.make (a_text.substring (i, p + 2))
									a_parts.add_element (w_item)
									w_item.process (Current) -- Check recursion...							
									w_item := Void
								else
									s.append (a_text.substring (i, p + 2))
								end
								i := p + 2
							else
								--| Ignore this one ..
								s.extend (c)
							end
						else
							s.extend (c)
							i := i + 1
							s.extend ('{')
						end
					elseif safe_character (a_text, i + 1) = '|' then
							-- Wiki Table
						p := next_closing_table (a_text, i + 2)
						if p > i then
							if in_items.is_empty then
								flush_buffer (a_parts, s)
								create {WIKI_TABLE} w_item.make (a_text.substring (i, p + 2))
								a_parts.add_element (w_item)
								w_item.process (Current) -- Check recursion...							
								w_item := Void
							else
								s.append (a_text.substring (i, p + 2))
							end
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
							-- Wiki link
						p := next_closing_link (a_text, i + 2)
						if p > i then
							if in_items.is_empty then
								flush_buffer (a_parts, s)
								w_item := new_wiki_link (a_text.substring (i, p + 2), safe_character (a_text, p + 2 + 1) = '%N')
								a_parts.add_element (w_item)
								w_item.process (Current) -- Check recursion...
								w_item := Void
							else
								s.append (a_text.substring (i, p + 2))
							end
							i := p + 2
						else
							--| Ignore this one ..
							s.extend (c)
						end
					else
							--| find closing external link bracket ']'
							--| external link "[href a title for the link]"
						p := a_text.index_of (']', i + 1)
						if p > 0 and p <= n then
							create w_ext_lnk.make (a_text.substring (i, p))
							if
								in_items.is_empty and
								w_ext_lnk.has_valid_url
							then
								flush_buffer (a_parts, s)
								w_item := w_ext_lnk
								a_parts.add_element (w_item)
								w_item.process (Current) -- Check recursion...							
								w_item := Void
							else
								s.append (a_text.substring (i, p))
							end
							i := p
						else
							s.extend (c)
						end
					end
				when ']' then
					debug ("wikitext")
						check no_link_closure: False end
					end
					s.extend (c)
				when '\' then
					if safe_character (a_text, i + 1) = '`' then
						i := i + 1
						s.extend ('`')
					else
						s.extend ('\')
					end
				when '`' then
					if safe_character (a_text, i + 1) = '`' then
						if
							safe_character (a_text, i + 2) = '`'
						then
								-- Support ```lang%N....%N```
							p := a_text.substring_index ("```", i + 3)
							if p > 0 then
								r := p + 2

								flush_buffer (a_parts, s)
								if in_items.is_empty then
									create {WIKI_CODE} w_item.make_from_3backticks_source (a_text.substring (i, p + 2))
									a_parts.add_element (w_item)
									w_item.process (Current) -- Check recursion...
									w_item := Void
									create s.make_empty
								else
									s.append (a_text.substring (i, r))
								end
								i := r
							else
								s.extend (c)
							end
						else
								-- Support ``...``, usually to escape backtick ` such as in `` `foo' ``
							p := a_text.substring_index ("``", i + 2)
							if p > 0 then
									-- Only for inline code, without any new line
								q := a_text.index_of ('%N', i + 2)
								if q > p then
									q := 0
								end
							else
								q := 0
							end
							if p > 0 and then q = 0 then --| q = 0 means no new line between the two double backtik ``..``
								r := p + 1

								flush_buffer (a_parts, s)
								if in_items.is_empty then
									create {WIKI_CODE} w_item.make_from_double_backtick_source (a_text.substring (i, p + 1))
									a_parts.add_element (w_item)
									w_item.process (Current) -- Check recursion...
									w_item := Void
									create s.make_empty
								else
									s.append (a_text.substring (i, r))
								end
								i := r
							else
								s.extend (c)
							end
						end
					else
						p := a_text.substring_index ("`", i + 1)
						if p > 0 then
								-- Only for inline code, without any new line
							q := a_text.index_of ('%N', i + 1)
							if q > p then
								q := 0
							end
						else
							q := 0
						end
						if p > 0 and then q = 0 then --| q = 0 means no new line between the two single backtik `..`
							r := p

							flush_buffer (a_parts, s)
							if in_items.is_empty then
								create {WIKI_CODE} w_item.make_from_single_backtick_source (a_text.substring (i, p))
								a_parts.add_element (w_item)
								w_item.process (Current) -- Check recursion...
								w_item := Void
								create s.make_empty
							else
								s.append (a_text.substring (i, r))
							end
							i := r
						else
							s.extend (c)
						end
					end
				when '<' then
					if
						safe_character (a_text, i + 1) = '!' and then
						safe_following_character_count (a_text, i + 2, '-') = 2
					then
						p := a_text.substring_index ("-->", i + 4)
						if p > 0 then
							if in_items.is_empty then
								flush_buffer (a_parts, s)
								--| End comment found
								a_parts.add_element (create {WIKI_COMMENT}.make (a_text.substring (i + 4, p - 1)))
							else
								s.append (a_text.substring (i, p + 2))
							end
							i := p + 2
						else
							s.extend (c)
						end
					elseif safe_character (a_text, i + 1) = '/' then
						s.extend (c)
					else
							-- HTML tag  <tag>
						p := next_end_of_tag_character (a_text, i + 1)
						if p > 0 then
							t := tag_name_from (a_text.substring (i, p))
								-- FIXME: do not ignore params ...

							if a_text [p - 1] = '/' then
									-- <tag/>
								q := p
								r := p

								flush_buffer (a_parts, s)
								if in_items.is_empty then
									if
										is_alias_for_code (t)
									then
										create {WIKI_CODE} w_item.make (a_text.substring (i, p), "")
									elseif t.is_case_insensitive_equal_general ("nowiki") then
										create {WIKI_RAW_STRING} w_item.make ("")
									else
										create {WIKI_TAG} w_item.make (a_text.substring (i, p), "")
									end
									a_parts.add_element (w_item)
									w_item.process (Current) -- Check recursion...							
									w_item := Void
									create s.make_empty
								else
									s.append (a_text.substring (i, r))
								end
								i := r
							else
								q := next_closing_tag (a_text, t, p + 1)
								if q > 0 then
									r := next_end_of_tag_character (a_text, q + 1)
									if r > 0 then
										flush_buffer (a_parts, s)
										if in_items.is_empty then
											if
												is_alias_for_code (t)
											then
												create {WIKI_CODE} w_item.make_from_source (a_text.substring (i, r))
											elseif t.is_case_insensitive_equal_general ("nowiki") then
												create {WIKI_RAW_STRING} w_item.make (a_text.substring (p + 1, q - 1))
											else
												create {WIKI_TAG} w_item.make_from_source (a_text.substring (i, r))
											end
											a_parts.add_element (w_item)
											w_item.process (Current) -- Check recursion...							
											w_item := Void
											create s.make_empty
										else
											s.append (a_text.substring (i, r))
										end
										i := r
									else
										s.extend (c)
									end
								else
									s.extend (c)
								end
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

					if not in_items.is_empty then
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
								p > n or q = m
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
							i := p + m
						else
							check should_not_occur: False end
						end
					end
				when '_' then
					if not in_items.is_empty then
						--| do not process this for now
						s.extend (c)
					elseif safe_character (a_text, i + 1) = '_' then
						from
							p := i + 2
						until
							not (a_text[p].is_alpha and a_text[p].is_upper) or p > n
						loop
							p := p + 1
						end
						if
							p > i + 2 and
							safe_character (a_text, p) = '_' and
							safe_character (a_text, p + 1) = '_'
						then
							p := p + 1
							flush_buffer (a_parts, s)
							a_parts.add_element (create {WIKI_MAGIC_WORD}.make_from_source (a_text.substring (i, p)))
							i := p
						else
							s.extend (c)
						end
					else
						s.extend (c)
					end
				when '&' then
					if not in_items.is_empty then
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
				--TODO: find what is the use of s_last, and check the former assertion: check s = s_last end
			flush_buffer (a_parts, s)
			check s.is_empty end
			check s_last.is_empty end
			check s_link = Void end
		end

	on_wiki_item_begin_token (a_items: ARRAYED_STACK [TUPLE [position: INTEGER; kind: STRING]]; a_position: INTEGER; a_kind: STRING)
		do
			a_items.extend ([a_position, a_kind])
		end

	on_wiki_item_end_token (a_items: ARRAYED_STACK [TUPLE [position: INTEGER; kind: STRING]]; a_position: INTEGER; a_kind: STRING)
		do
			if a_items.is_empty then
				check False end
			else
				if a_items.item.kind.is_case_insensitive_equal (a_kind) then
					a_items.remove
				end
			end
		end

	flush_buffer (a_parts: WIKI_STRING_LIST; a_buffer: STRING)
		do
			if not a_buffer.is_empty then
				a_parts.add_raw_string (a_buffer.string)
				a_buffer.wipe_out
			end
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

note
	copyright: "2011-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
