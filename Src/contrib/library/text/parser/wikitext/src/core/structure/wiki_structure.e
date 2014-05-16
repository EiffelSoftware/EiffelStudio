note
	description: "Summary description for {WIKI_STRUCTURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_STRUCTURE

inherit
	WIKI_COMPOSITE [WIKI_BOX [WIKI_ITEM]]
		redefine
			process
		end

create
	make

feature {NONE} -- Make

	make (a_meta_data: like meta_data; a_text: STRING)
		do
			initialize
			meta_data := a_meta_data
			analyze (a_text)
		end

feature -- Access

	meta_data: detachable STRING_TABLE [STRING]

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

	analyze (t: STRING)
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
			--? <eiffel>text</eiffel>
		local
			i,n,ln,m: INTEGER
			b: INTEGER --| Beginning of line
			p: INTEGER
			is_start_of_line: BOOLEAN
			c: CHARACTER
			w_box: detachable WIKI_BOX [WIKI_ITEM]
			w_item: WIKI_ITEM
			w_line: WIKI_LINE
			w_psec, w_sec: detachable WIKI_SECTION
			w_list_item: detachable WIKI_LIST
			w_plist: detachable WIKI_LIST
			w_block: detachable WIKI_PREFORMATTED_TEXT
			tpl: detachable ARRAYED_STACK [INTEGER]
			tbls: detachable ARRAYED_STACK [INTEGER]
			w_tags: detachable ARRAYED_STACK [STRING]
			multiline_level: INTEGER
			ignore_wiki: BOOLEAN
			keep_formatting: BOOLEAN
			mt_ln: INTEGER
			s: STRING
		do
			from
				create {WIKI_PARAGRAPH} w_box.make
				add_element (w_box)
				i := 1
				b := 1
				is_start_of_line := True
				ln := 1
				n := t.count
			until
				i > n
			loop
				c := t.item (i)
				if is_start_of_line then
					p := index_of_end_of_line (t, i)
					inspect c
					when '-' then
						w_plist := Void
						w_block := Void
						is_start_of_line := False
						if safe_following_character_count (t, i + 1, '-') = 3 then
							is_start_of_line := True

							w_item := new_boxed_item (create {WIKI_LINE_SEPARATOR})
							add_element_box_to (w_psec, new_boxed_item (create {WIKI_LINE_SEPARATOR}))

							w_box := new_paragraph (w_psec)
							add_element_to (w_box, create {WIKI_LINE}.make (t.substring (i + 4, p)))
						end
					when '=' then
						w_block := Void
						w_plist := Void
						create w_sec.make (t.substring (i, p))
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
					when '*','#',';',':' then
						w_box := Void
						w_block := Void
						s := t.substring (i, p)
--						if s.substring_index ("{|", 1) > 0 then
--							p := t.substring_index ("|}", 1)
--							if p > 0 then
--								p := index_of_end_of_line (t, p + 1)
--							end
--							s := t.substring (i, p)
--						end
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
					when ' ', '%T' then
						w_box := Void
						w_plist := Void
						if w_block /= Void then
							w_block.add_element (create {WIKI_LINE}.make (t.substring (i + 1, p)))
						else
							create w_block.make (t.substring (i, p))
							add_element_box_to (w_psec, w_block)
						end
						is_start_of_line := True
					else
						w_plist := Void
						w_block := Void
						is_start_of_line := False
					end

					if is_start_of_line then
						i := p + 1
						b := i + 1
						ln := ln + 1
					end
				end
				inspect c
				when '%N' then
					if multiline_level > 0 then
						-- Continue to next line ...
						mt_ln := mt_ln + 1
						p := index_of_end_of_line (t, i + 1)
						check w_plist = Void and w_block = Void end
					else
						w_plist := Void
						w_block := Void
						is_start_of_line := True
						create w_line.make (t.substring (b, p))

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
						b := i + 1
					end
				when '{' then
					if safe_character (t, i + 1) = '{' then
						if tpl = Void then
							create tpl.make (3)
						end
						i := i + 1
						tpl.extend (i + 1)
						multiline_level := multiline_level + 1
					elseif safe_character (t, i + 1) = '|' then
							-- Table
						if tbls = Void then
							create tbls.make (3)
						end
						i := i + 1
						tbls.extend (i + 1)
						multiline_level := multiline_level + 1
					end
				when '|' then
					if multiline_level > 0 and t.item (i + 1) = '}' then
						i := i + 1
						if tbls /= Void and then tbls.count > 0 then
							tbls.remove
							multiline_level := multiline_level - 1
						else
							check multiline_level = 0 end
						end
					end
				when '}' then
					if multiline_level > 0 and t.item (i + 1) = '}' then
						i := i + 1
						if tpl /= Void and then tpl.count > 0 then
							tpl.remove
							multiline_level := multiline_level - 1
						else
							check multiline_level = 0 end
						end
					end
				when '<' then
					if w_tags = Void then
						create w_tags.make (3)
					end
						--| Builtin tags
						-- nowiki, ref, blockquote, center, pre, ...
					if ignore_wiki then
						if next_following_character_matched (t, i + 1, "/nowiki>", True) then
							if w_tags /= Void and then w_tags.count > 0 and then attached w_tags.item as l_tag and then l_tag.same_string ("nowiki") then
								w_tags.remove
								ignore_wiki := False
								multiline_level := multiline_level - 1
								i := i + 8 --| = ("/nowiki>").count
							else
								check False end
							end
						elseif next_following_character_matched (t, i + 1, "/pre>", True) then
							if w_tags /= Void and then w_tags.count > 0 and then attached w_tags.item as l_tag and then l_tag.same_string ("pre") then
								w_tags.remove
								ignore_wiki := False
								keep_formatting := False
								multiline_level := multiline_level - 1
								i := i + 5 --| = ("/pre>").count
							else
								check False end
							end
						end

					elseif safe_character (t, i + 1) = '!' then
						if safe_following_character_count (t, i + 2, '-') = 2 then
							m := t.substring_index ("-->", i + 4)
							if m > 0 then
								i := m + 3
								p := index_of_end_of_line (t, i)
							end
						end
					elseif safe_character (t, i + 1) = '/' then
						if w_tags /= Void and then w_tags.count > 0 then
							if attached w_tags.item as l_tag then
								if next_following_character_matched (t, i + 2, l_tag + ">", True) then
									do_nothing
									w_tags.remove
									multiline_level := multiline_level - 1
									i := i + 2 + l_tag.count + 1
								end
							end
						end
					else
						if next_following_character_matched (t, i, "<nowiki>", True) then
							multiline_level := multiline_level + 1
							ignore_wiki := True
							w_tags.extend ("nowiki")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<pre>", True) then
							multiline_level := multiline_level + 1
							ignore_wiki := True
							keep_formatting := True
							w_tags.extend ("pre")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<code>", True) then
							multiline_level := multiline_level + 1
							w_tags.extend ("code")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<blockquote>", True) then
							multiline_level := multiline_level + 1
							w_tags.extend ("blockquote")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<center>", True) then
							multiline_level := multiline_level + 1
							w_tags.extend ("center")
							i := i + w_tags.item.count + 1

						elseif next_following_character_matched (t, i, "<strike>", True) then
								-- Style: strike
							multiline_level := multiline_level + 1
							w_tags.extend ("strike")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<u>", True) then
								-- Style: underline							
							multiline_level := multiline_level + 1
							w_tags.extend ("u")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<sup>", True) then
								-- Style: superscripts							
							multiline_level := multiline_level + 1
							w_tags.extend ("sup")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<sub>", True) then
								-- Style: subscripts							
							multiline_level := multiline_level + 1
							w_tags.extend ("sub")
							i := i + w_tags.item.count + 1
						elseif next_following_character_matched (t, i, "<tt>", True) then
								-- Style: TypeWriter
							multiline_level := multiline_level + 1
							w_tags.extend ("tt")
							i := i + w_tags.item.count + 1
--						elseif next_following_character_matched (t, i, "<ref>", True) then
--							multiline_level := multiline_level + 1
--							w_tags.extend ("ref")
--							i := i + w_tags.item.count + 1

						else

						end
					end
				else
				end
				i := i + 1
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

	new_list_item (s: detachable STRING): WIKI_LIST
		local
			f: WIKI_LIST_FACTORY
		do
			create f
			Result := f.new_list (s)
		end

feature -- Query

--	last_element (s: WIKI_SECTION): WIKI_ITEM
--		do
--			
--		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_structure (Current)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
