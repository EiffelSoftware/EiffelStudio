note
	description: "[
			Wiki tree structure builder.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_STRUCTURE

inherit
	WIKI_COMPOSITE [WIKI_BOX [WIKI_ITEM]]
		redefine
			process
		end

	WIKI_ANALYZER_HELPER

create
	make

feature {NONE} -- Make

	make (a_text: READABLE_STRING_8)
		do
			initialize
			analyze (a_text)
		end

feature -- Basic operation

	add_element_to (a_box: detachable WIKI_COMPOSITE [WIKI_ITEM]; a_item: WIKI_ITEM)
		require
			a_item_attached: a_item /= Void
		local
			p: WIKI_BOXED_ITEM
		do
			if a_box /= Void then
				a_box.add_element (a_item)
			else
				create p.make (a_item)
				add_element (p)
			end
		end

	add_element_box_to (a_section: detachable WIKI_COMPOSITE [WIKI_ITEM]; a_item: WIKI_BOX [WIKI_ITEM])
		require
			a_item_attached: a_item /= Void
		do
			if a_section /= Void then
				a_section.add_element (a_item)
			else
				add_element (a_item)
			end
		end

	last_element (a_section: detachable WIKI_COMPOSITE [WIKI_ITEM]): detachable WIKI_ITEM
		do
			if a_section /= Void then
				if a_section.count = 0 then
					Result := a_section
				else
					Result := a_section.elements.last
				end
			elseif count > 0 then
				Result := elements.last
			end
		end

	analyze (a_text: READABLE_STRING_8)
			--| To support:
			--| = Text =
			--| == Text ==
			--| === Text ===
			--| ==== Text ====
			--| * Text
			--| ** Text
			--| *** Text						
			--| # Text			
			--| ## Text			
			--| ### Text			
			--| : ...
			--| space + 			
			--| {{template}}
			--? <nowiki>Text </nowiki>
			--? <pre>..</pre>
			--? <!-- comment ... -->
			--? <ref>...</ref> ... with <references/>
			--| ''Text''
			--| '''Text'''
			--| [url Title]
			--| [[Image:name]]
			--| [[Image:name|title]]
			--| [[Page Name|Title]]
			--| ---   separator line
			--? <blockquote> ... multiline </blockquote>
			--? <center> ... multiline </center>
			--| ; word : definition of the word
			--| ; longer phrase
			--| : phrase defined
			--? #REDIRECT [[Other page]]
			--/ *** Plugins *** /--
			--?	<code lang="text"> ... </code>
			--? <code>text</code>
			--? <source>text</source>
		local
			i,j,n,ln,m,tmp: INTEGER
			b: INTEGER --| Beginning of line
			q: INTEGER
			l_eol: INTEGER
			is_start_of_line: BOOLEAN
			c: CHARACTER
			w_box: detachable WIKI_BOX [WIKI_ITEM]
			w_item: WIKI_ITEM
			w_line: WIKI_LINE
			w_psec, w_sec: detachable WIKI_SECTION
			w_list_item: detachable WIKI_LIST
			w_plist: detachable WIKI_LIST
			w_block: detachable WIKI_PREFORMATTED_TEXT
			w_indent: detachable WIKI_INDENTATION
			multiline_level: INTEGER
			in_tag: BOOLEAN
			mt_ln: INTEGER
			s: READABLE_STRING_8
			l_items: ARRAYED_STACK [TUPLE [pos: INTEGER; kind: STRING]]
			l_tag: detachable READABLE_STRING_8
			l_line: detachable READABLE_STRING_8
		do
			create l_items.make (0)
			from
				create {WIKI_PARAGRAPH} w_box.make
				add_element (w_box)
				i := 1
				b := 1
				is_start_of_line := True
				ln := 1
				n := a_text.count
			until
				i > n
			loop
				c := a_text.item (i)
				if is_start_of_line then
--				from until not is_start_of_line loop
					l_eol := index_of_end_of_line (a_text, i)
					inspect c
					when '-' then
						w_plist := Void
						w_block := Void
						is_start_of_line := False
						if safe_following_character_count (a_text, i + 1, '-') = 3 then
							is_start_of_line := True

							w_item := new_boxed_item (create {WIKI_LINE_SEPARATOR})
							add_element_box_to (w_psec, new_boxed_item (create {WIKI_LINE_SEPARATOR}))

							w_box := new_paragraph (w_psec)
							add_element_to (w_box, create {WIKI_LINE}.make (a_text.substring (i + 4, l_eol)))
						end
					when '=' then
						w_block := Void
						w_plist := Void
						create w_sec.make (a_text.substring (i, l_eol))
						if w_sec.is_valid then
							if
								w_sec.level > 1 and then
								w_psec /= Void and then --| has previous section, check if is potential parent
								attached w_psec.adapted_parent_section (w_sec) as l_parent_section
							then
								w_sec.set_parent (l_parent_section)
								l_parent_section.add_element (w_sec)
							else
								w_psec := w_sec
								add_element (w_sec)
							end
							w_psec := w_sec
							w_sec := Void

							is_start_of_line := True
						end
						w_box := Void
					when '*','#',';' then
						w_box := Void
						w_block := Void

						s := a_text.substring (i, l_eol)
						w_list_item := new_list_item (s)
						if
							w_plist /= Void and then --| has previous section, check if is potential parent
							attached w_plist.adapted_parent_list (w_list_item) as l_parent_list
						then
								--| FIXME: should check if list's kind is the same ... otherwise close/open lists
							l_parent_list.add_element (w_list_item)
						else
							if w_plist = Void then
								w_plist := new_list_item (Void)
								w_plist.add_element (w_list_item)
								add_element_box_to (w_psec, w_plist)
							else
								w_plist.add_element (w_list_item)
							end
						end
						w_plist := w_list_item
						w_list_item := Void

						is_start_of_line := True
					when ':' then
						w_box := Void
						w_block := Void
						w_indent := Void

						s := a_text.substring (i, l_eol)
							-- Hack to handle indented table
						tmp := a_text.substring_index_in_bounds ("{|", i + 1, l_eol)
						if tmp > 0 then
							tmp := next_closing_table (a_text, tmp + 2)
							if tmp > 0 then
								s := a_text.substring (i, tmp + 2)
								ln := ln + s.occurrences ('%N')
								i := tmp + 2
								l_eol := index_of_end_of_line (a_text, tmp + 1)
							end
						end
						w_indent := new_indented_string (s)
						if
							attached {WIKI_INDENTATION} last_element (w_psec) as l_prev_indent and then
							l_prev_indent.indentation_level = w_indent.indentation_level
						then
							l_prev_indent.append_text ("%N")
							l_prev_indent.append_text (w_indent.text)
						else
							add_element_box_to (w_psec, w_indent)
						end
						w_indent := Void
						is_start_of_line := True
					when ' ', '%T' then
						w_box := Void
						w_plist := Void
						if w_block /= Void then
							w_block.add_element (create {WIKI_LINE}.make (a_text.substring (i + 1, l_eol)))
						else
							create w_block.make (a_text.substring (i, l_eol))
							add_element_box_to (w_psec, w_block)
						end
						is_start_of_line := True
					else
						w_plist := Void
						w_block := Void
						is_start_of_line := False
					end

					if is_start_of_line then
						i := l_eol + 1
						b := i + 1
						ln := ln + 1
					end
--					c := a_text.item (i)
				end
--				c := a_text.item (i)
				inspect c
				when '%N' then
					if multiline_level > 0 then
						-- Continue to next line ...
						mt_ln := mt_ln + 1
						l_eol := index_of_end_of_line (a_text, i + 1)
						check w_plist = Void and w_block = Void end
					else
						w_plist := Void
						w_block := Void
						is_start_of_line := True
						l_line := a_text.substring (b, l_eol)
-- Remove any '%R' in text...
--						if not l_line.is_empty and then l_line[l_line.count] = '%R' then
--							l_line := l_line.substring (1, l_line.count - 1)
--						end

						if
							l_line.is_empty
							or (l_line.count = 1 and then l_line[1] = '%R')
						then
							w_box := new_paragraph (w_psec)
--							add_element_to (w_box, w_line)
						else
							create w_line.make (l_line)
							if w_box = Void then
								w_box := new_paragraph (w_psec)
							end
							add_element_to (w_box, w_line)
							if mt_ln > 0 then
								w_line.set_line_count (mt_ln)
								mt_ln := 0
								ln := ln + 1 + mt_ln
							else
								ln := ln + 1
							end
						end

						b := i + 1
					end
				when '{' then
					if safe_character (a_text, i + 1) = '{' then
						i := i + 1
						on_wiki_item_begin_token (l_items, i+1, "template")
						multiline_level := multiline_level + 1
					elseif safe_character (a_text, i + 1) = '|' then
							-- Table
						i := i + 1
						on_wiki_item_begin_token (l_items, i + 1, "table")
						multiline_level := multiline_level + 1
					end
				when '|' then
					if multiline_level > 0 and a_text.item (i + 1) = '}' then
						i := i + 1
						if is_wiki_item_token_of_kind (l_items, "table") then
							on_wiki_item_end_token (l_items, i, "table")
							multiline_level := multiline_level - 1
						else
							check multiline_level = 0 end
						end
					end
				when '}' then
					if multiline_level > 0 and a_text.item (i + 1) = '}' then
						i := i + 1
						if is_wiki_item_token_of_kind (l_items, "template") then
							on_wiki_item_end_token (l_items, i, "template")
							multiline_level := multiline_level - 1
						else
							check multiline_level = 0 end
						end
					end
				when '`' then
					if safe_character (a_text, i + 1) = '`' and then safe_character (a_text, i + 2) = '`' then
							-- 3backtiks code
						if multiline_level = 0 then
							on_wiki_item_begin_token (l_items, i, "```")
							multiline_level := multiline_level + 1
							in_tag := True
							i := i + 2
						else
							i := i + 2
							if is_wiki_item_token_of_kind (l_items, "```") then
								on_wiki_item_end_token (l_items, i, "```")
								in_tag := False
								multiline_level := multiline_level - 1
							end
						end
					else
							-- Single backtik
							-- Search until end of line!
						tmp := index_of_char_before_end_of_line (a_text, '`', i + 1)
						if tmp > 0 then
							i := tmp
						end
					end
				when '<' then
						--| Builtin tags
						-- nowiki, ref, blockquote, center, pre, ...
					if in_tag then
						if safe_character (a_text, i + 1) = '/' then
							j := next_end_of_tag_character (a_text, i + 2)
							if j > i + 2 then
								s := a_text.substring (i + 2, j - 1)
								if is_wiki_item_token_of_kind (l_items, "tag:" + s) then
									on_wiki_item_end_token (l_items, i, "tag:" + s)
									in_tag := False
									multiline_level := multiline_level - 1
									i := j -- after ending '>'
								else
									check False end
								end
							end
						end
					elseif safe_character (a_text, i + 1) = '!' then
						if safe_following_character_count (a_text, i + 2, '-') = 2 then
							m := a_text.substring_index ("-->", i + 4)
							if m > 0 then
								i := m + 3
								l_eol := index_of_end_of_line (a_text, i)
							end
						end
					elseif safe_character (a_text, i + 1) = '/' then
							-- FIXME: if closing tag does not match previous
							-- cancel previous, until expected tag is found, if any...
						if
							l_tag /= Void and then
							next_following_character_matched (a_text, i + 2, l_tag + ">", True)
						then
							on_wiki_item_end_token (l_items, i, "tag:" + l_tag)
							multiline_level := multiline_level - 1
							i := i + 1 + l_tag.count + 1  --| /tag>
						end
					else
						q := next_end_of_tag_character (a_text, i + 1)
						if q > 0 then
							l_tag := tag_name_from (a_text.substring (i, q))
							if l_tag = Void or else l_tag.is_empty then
									-- Invalid tag name!
									-- Ignore...
							elseif a_text[q-1] = '/' then
								on_wiki_item_begin_token (l_items, i + 1, "tag:" + l_tag)
								on_wiki_item_end_token (l_items, i + 1, "tag:" + l_tag)
								if q > 0 then
									i := q
								else
									check has_end_of_tag_character: False end
									i := i + (l_tag).count + 1 + 1
								end
							else
								multiline_level := multiline_level + 1
								in_tag := True
								on_wiki_item_begin_token (l_items, i + 1, "tag:" + l_tag)
								if q > 0 then
									i := q
								else
									check has_end_of_tag_character: False end
									i := i + (l_tag).count + 1
								end
							end
						else
							l_tag := Void
						end
					end
				else

				end
				i := i + 1
			end
				-- Remaining entries.
			if l_eol > b then
				create w_line.make (a_text.substring (b, l_eol))
				if w_box = Void then
					w_box := new_paragraph (w_psec)
				end
				add_element_to (w_box, w_line)
				if mt_ln > 0 then
					w_line.set_line_count (mt_ln)
					mt_ln := 0
					ln := ln + 1 + mt_ln
				else
					ln := ln + 1
				end
				b := l_eol + 1
			end

			analyze_strings
		end

	analyze_strings
		local
			v: WIKI_STRING_ANALYZER
		do
			create v.make
			process (v)
		end

feature {NONE} -- Internal events

	is_wiki_item_token_of_kind (a_items: ARRAYED_STACK [TUPLE [position: INTEGER; kind: STRING]]; a_kind: STRING): BOOLEAN
		do
			Result := attached wiki_item_token_kind (a_items) as tok and then tok.is_case_insensitive_equal (a_kind)
		end

	wiki_item_token_kind (a_items: ARRAYED_STACK [TUPLE [position: INTEGER; kind: STRING]]): detachable STRING
		do
			if not a_items.is_empty then
				Result := a_items.item.kind
			end
		end

	wiki_item_tag_token_kind (a_items: ARRAYED_STACK [TUPLE [position: INTEGER; kind: STRING]]): detachable STRING
		do
			if
				attached wiki_item_token_kind (a_items) as s and then
				s.starts_with ("tag:")
			then
				Result := s.substring (4 + 1, s.count)
			end
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

feature -- Factory

	new_paragraph (a_box: detachable WIKI_COMPOSITE [WIKI_ITEM]): WIKI_PARAGRAPH
		do
			create Result.make
			if a_box /= Void then
				a_box.add_element (Result)
				Result.set_parent (a_box)
			else
				add_element (Result)
				Result.set_parent (a_box)
			end
		end

	new_boxed_item (a_item: WIKI_ITEM): WIKI_BOXED_ITEM
		do
			create Result.make (a_item)
		end

	new_list_item (s: detachable READABLE_STRING_8): WIKI_LIST
		local
			f: WIKI_LIST_FACTORY
		do
			create f
			Result := f.new_list (s)
		end

	new_indented_string (s: READABLE_STRING_8): WIKI_INDENTATION
		local
			f: WIKI_FACTORY
		do
			create f
			Result := f.new_indented_string (s)
		end

	new_indentation (s: READABLE_STRING_8): WIKI_INDENTATION
		local
			f: WIKI_FACTORY
		do
			create f
			Result := f.new_indentation (s)
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_structure (Current)
		end

note
	copyright: "2011-2017, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
