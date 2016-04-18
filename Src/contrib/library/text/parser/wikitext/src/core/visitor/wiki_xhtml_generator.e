note
	description: "Wiki page visitor to generate XHTML with wikidocs parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_XHTML_GENERATOR

inherit
	WIKI_VISITOR

create
	make

feature {NONE} -- Initialization

	make (b: like buffer)
		do
			buffer := b
			create code_aliases.make (2)
			code_aliases.force ("code")
			code_aliases.force ("source")
			is_auto_toc_enabled := True
		end

feature -- Basic operation

	reset
		do
			level := 0
			list_level := 0
			section_level := 0
			pre_block_level := 0
			next_output_require_newline := False
			next_newline_ignored := False
			current_page := Void
		end

feature -- Settings

	code_aliases: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Aliases for <code>

	is_alias_for_code (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' an alias of "<code>" ?
		do
			Result := across code_aliases as ic some ic.item.is_case_insensitive_equal (s) end
		end

	is_auto_toc_enabled: BOOLEAN
			-- Generate TOC automatically.

	toc_depth_limit: NATURAL_8
			-- Limit depth of TOC.
			-- If 0, no limit.

feature -- Callback

	link_resolver: detachable WIKI_LINK_RESOLVER assign set_link_resolver

	image_resolver: detachable WIKI_IMAGE_RESOLVER assign set_image_resolver

	template_resolver: detachable WIKI_TEMPLATE_RESOLVER assign set_template_resolver

	file_resolver: detachable WIKI_FILE_RESOLVER assign set_file_resolver

feature -- Callback change

	set_link_resolver (r: like link_resolver)
		do
			link_resolver := r
		end

	set_image_resolver (r: like image_resolver)
		do
			image_resolver := r
		end

	set_template_resolver (r: like template_resolver)
		do
			template_resolver := r
		end

	set_file_resolver (r: like file_resolver)
		do
			file_resolver := r
		end

feature -- Setting change	

	set_is_auto_toc_enabled (b: BOOLEAN)
			-- Set `is_auto_toc_enabled' to `b'.
		do
			is_auto_toc_enabled := b
		end

	set_toc_depth_limit (n: NATURAL_8)
			-- Set toc depth limit to `n'.
			-- No limit if `n' is 0.
		do
			toc_depth_limit := n
		end

feature -- Output

	buffer: STRING

feature {NONE} -- Implementation	

	output_indentation
		do
			if level > 0 then
				output (create {STRING}.make_filled ('%T', level))
			end
		end

	output (s: STRING)
		local
			buf: like buffer
		do
			buf := buffer
			if next_newline_ignored then
				reset_ignore_next_newline
				next_output_require_newline := False
			elseif next_output_require_newline then
				if in_pre_block then
					buf.append ("%N")
				else
					buf.append ("<br/>%N")
				end
				next_output_require_newline := False
			else
--				buf.append_character ('%N')
--				buf.append ("<br/>%N")
--				buf.append (create {STRING}.make_filled (' ', level * 2))
			end
			if is_html_encoded_output then
				append_html_escaped_to (s, buf)
			else
				buf.append (s)
			end
		end

	append_html_escaped_to (s: STRING; a_output: STRING)
		local
			i,n: INTEGER
			c: CHARACTER
		do
			from
				i := 1
				n := s.count
			until
				i > n
			loop
				c := s[i]
				inspect
					c
				when '<' then
					a_output.append ("&lt;")
				when '>' then
					a_output.append ("&gt;")
				when '&' then
					a_output.append ("&amp;")
				else
					a_output.append_character (c)
				end
				i := i + 1
			end
		end

	ignore_next_newline
		do
			next_newline_ignored := True
		end

	reset_ignore_next_newline
		do
			next_newline_ignored := False
		end

	is_html_encoded_output: BOOLEAN
			-- Does `output' html escape text?

	set_html_encoded_output (b: BOOLEAN)
		do
			is_html_encoded_output := b
		end

	unset_next_output_require_newline
		do
			next_output_require_newline := False
		end

	set_next_output_require_newline
		do
			next_output_require_newline := True
		end

	next_newline_ignored: BOOLEAN

	next_output_require_newline: BOOLEAN

	level: INTEGER

	indent
		do
			set_level (level + 1)
		end

	exdent
		do
			set_level (level - 1)
		end

	set_level (v: like level)
		do
			level := v
		end

feature -- status: pre block	

	pre_block_level: INTEGER

	in_pre_block: BOOLEAN
		do
			Result := pre_block_level > 0
		end

	enter_pre_block
		do
			pre_block_level := pre_block_level + 1
		end

	exit_pre_block
		do
			pre_block_level := pre_block_level - 1
		end

	current_page: detachable WIKI_PAGE
			-- Current page being processed.

feature -- Helper

	page_title (a_page: WIKI_PAGE): STRING_8
			-- Title for page `a_page'.
		do
			Result := a_page.title
		end

	book_title (a_book: WIKI_BOOK): STRING_8
			-- Title for book `a_book'.
		do
			Result := a_book.name
		end

feature -- Book processing

	visit_book (a_book: WIKI_BOOK)
		do
			output ("<div class=%"wikibook%">")
			output ("<div class=%"title%">"+ book_title (a_book) +"</div>")

			across
				a_book.pages as c
			loop

				output ("<div class=%"wikipage%">")
				output ("<div class=%"title%">"+ page_title (c.item) +"</div>")
				c.item.process (Current)
				output ("</div>%N")
			end
			output ("</div>%N")
		end

	visit_page (a_page: WIKI_PAGE)
		do
			current_page := a_page
			if attached a_page.structure as st then
				output ("<div class=%"wikipage%">")
				if is_auto_toc_enabled then
					output_toc (Void, True)
				end
				st.process (Current)
				output ("</div>%N")
			end
			current_page := Void
		end

feature -- Internal

	last_structure: detachable WIKI_STRUCTURE
			-- Last visited WIKI_STRUCTURE.

feature -- Processing

	output_toc (a_wiki: detachable WIKI_ITEM; is_auto_toc: BOOLEAN)
			-- Output the TOC from `a_structure'.
			-- This is the automatically generated TOC if `is_auto_toc' is True.
		local
			it: WIKI_TOC_VISITOR
			l_sections: LIST [WIKI_SECTION]
			curr, prev: NATURAL_8
			l_is_horizontal: BOOLEAN
			l_list_tag: STRING
		do
			if attached current_page as pg and then attached pg.structure as l_structure then
				create it.make
				it.set_depth_limit (toc_depth_limit)
				l_structure.process (it)
				if a_wiki /= Void then
						-- Useful to get TOC limit and other settings.
					it.import_settings_from (a_wiki)
					l_is_horizontal := it.is_horizontal
				end
				l_sections := it.sections
				if
					not l_sections.is_empty and then
					(
							-- TOC is automatically generated for each structure with at least 4 headinds, and if no __NOTOC__ is set.
						not is_auto_toc
						or else it.has_auto_generated_toc
					)
				then
					if l_is_horizontal then
						l_list_tag := "ul"
						output ("%N<" + l_list_tag + " class=%"wiki-toc horizontal%">")
					else
						l_list_tag := "ol"
						output ("%N<" + l_list_tag + " class=%"wiki-toc%">")
					end
					if is_auto_toc or not it.has_auto_generated_toc then
						output ("<a name=%"toc%"></a>")
					end
					output ("<span class=%"title%">Contents</span>%N")
					indent
					curr := 1
					prev := curr
					across
						l_sections as ic
					loop
						if attached {WIKI_SECTION} ic.item as w_section then
							curr := w_section.level
							if curr = prev then
							elseif curr > prev then
								from
								until
									prev = curr
								loop
									output_indentation
									output ("<" + l_list_tag + ">%N")
									indent
									prev := prev + 1
								end
							else
								from
								until
									prev = curr
								loop
									exdent
									output_indentation
									output ("</" + l_list_tag + ">%N")
									prev := prev - 1
								end
							end
							output_indentation
							output ("<li>")
							if attached w_section.text as l_text then
								output ("<a href=%"#" + l_text.text + "%">")
								output (l_text.text)
								output ("</a>")
							else
								output ("...")
							end
							output ("</li>%N")
						end
						prev := curr
					end
					curr := 1
					if prev > curr then
						from
						until
							prev = curr
						loop
							exdent
							output_indentation
							output ("</" + l_list_tag + ">%N")
							prev := prev - 1
						end
					end
					exdent
					output ("</" + l_list_tag + ">%N")
				end
			end
		end

	visit_structure (a_structure: WIKI_STRUCTURE)
		do
			level := 0
			visit_composite (a_structure)
		end

	visit_section (a_section: WIKI_SECTION)
		local
			l_level: like {WIKI_SECTION}.level
		do
			if
				a_section.is_valid and then
				attached a_section.text as t
			then
				l_level := a_section.level
				set_level (l_level)
				unset_next_output_require_newline
				output ("%N")
				if attached a_section.text as l_text then
					output ("<a name=%"")
					output (l_text.text)
					output ("%"></a>")
				end
				output ("<h" + l_level.out + ">")
				t.process (Current)
				output ("</h" + l_level.out + ">%N")
				unset_next_output_require_newline
			else
				output ("!!INVALID SECTION!!")
			end
			visit_composite (a_section)
		end

	visit_indentation (a_indent: WIKI_INDENTATION)
		local
			i, lev: NATURAL
		do
			lev := a_indent.indentation_level
			from
				i := 1
			until
				i > lev
			loop
				output ("<dl><dd>")
				i := i + 1
			end
			a_indent.get_structure
			if attached a_indent.structure as struct then
				struct.process (Current)
			end
			from
				i := 1
			until
				i > lev
			loop
				output ("</dd></dl>")
				i := i + 1
			end
		end

	visit_paragraph (a_paragraph: WIKI_PARAGRAPH)
		do
			if a_paragraph.count > 0 then
				output ("<p>")
				visit_composite (a_paragraph)
				output ("</p>%N")
			end
		end

	visit_list (a_list: WIKI_LIST)
		local
			l_level: like {WIKI_LIST}.level
			l_tag: READABLE_STRING_8
		do
			l_level := a_list.level
--			if a_list.count = 1 then
--				output ("<" + l_tag + ">")
--				visit_composite (a_list)
--			else
				unset_next_output_require_newline
				list_level := l_level
				if a_list.is_ordered_kind then
					l_tag := "ol"
				elseif a_list.is_unordered_kind then
					l_tag := "ul"
				elseif a_list.is_definition_term_kind then
					l_tag := "dl"
				elseif a_list.is_definition_description_kind then
					l_tag := "dl"
				else
					l_tag := "ul"
				end
				output ("<" + l_tag + ">")
				unset_next_output_require_newline
				visit_composite (a_list)
				unset_next_output_require_newline
				output ("</" + l_tag + ">%N")
				unset_next_output_require_newline
--			end
		end

	visit_list_item (a_list_item: WIKI_LIST_ITEM)
		local
			l_level: like {WIKI_LIST}.level
			l_item_tag, l_tag: READABLE_STRING_8
		do
			l_level := a_list_item.level
			list_level := l_level
			if a_list_item.is_ordered_kind then
				l_tag := "ol"
				l_item_tag := "li"
			elseif a_list_item.is_unordered_kind then
				l_tag := "ul"
				l_item_tag := "li"
			elseif a_list_item.is_definition_term_kind then
				l_tag := "dl"
				l_item_tag := "dt"
			elseif a_list_item.is_definition_description_kind then
				l_tag := "dl"
				l_item_tag := "div"
			else
				l_tag := "ul"
				l_item_tag := "li"
			end
			output ("<" + l_item_tag + ">")
			unset_next_output_require_newline

			if attached a_list_item.text as t then
				t.process (Current)
			end
			if a_list_item.is_definition_term_kind and then
				attached {WIKI_DEFINITION_TERM} a_list_item as l_term and then
				attached l_term.definition_description as l_def
			then
				l_def.process (Current)
			end
			if a_list_item.count > 0 then
				output ("<" + l_tag + ">")
				visit_composite (a_list_item)
				output ("</" + l_tag + ">")
			end
			unset_next_output_require_newline
			output ("</" + l_item_tag + ">%N")
		end

	visit_preformatted_text (a_block: WIKI_PREFORMATTED_TEXT)
		do
			if a_block.is_empty then
				output ("")
				set_next_output_require_newline
			else
				output ("<pre>")
				enter_pre_block
				visit_composite (a_block)
				ignore_next_newline
				exit_pre_block
				output ("</pre>")
				ignore_next_newline
			end
		end

--	process_indented_text (a_text: WIKI_INDENTED_TEXT)
--		do
--			if not a_text.is_empty then
--				debug
--					output ("LINE(" + a_text.level.out + "):")
--					set_next_output_appended
--				end
--				output ((create {STRING}.make_filled (' ', a_text.level)))
--				set_next_output_appended
--				a_text.text.process (Current)
--				unset_next_output_appended
--			else
--				output ("")
--			end
--			process_composite (a_text)
--		end

	visit_line (a_line: WIKI_LINE)
		do
			if a_line.is_property_line then
					-- skip
			else
				if a_line.is_empty then -- FIXME: or is_whitespace ??
					output ("")
--					set_next_output_require_newline
				else
					a_line.text.process (Current)
--					set_next_output_require_newline
				end
				if in_pre_block then
					set_next_output_require_newline
				end
			end
		end

	visit_line_separator (a_sep: WIKI_LINE_SEPARATOR)
		do
			output ("<hr/>")
		end

	visit_string (a_string: WIKI_STRING)
		do
			if attached a_string.parts as l_parts then
				l_parts.process (Current)
			else
				output (a_string.text)
			end
		end

	visit_magic_word (a_word: WIKI_MAGIC_WORD)
		do
			if
				a_word.value.is_case_insensitive_equal_general ("TOC")
				or a_word.value.is_case_insensitive_equal_general ("FORCETOC")
			then
				output_toc (a_word, False)
			end
		end

feature -- Strings

	visit_raw_string (a_raw_string: WIKI_RAW_STRING)
		local
			s: STRING
		do
			s := a_raw_string.text.twin
			s.replace_substring_all ("&", "&amp;")
			s.replace_substring_all ("<", "&lt;")
			s.replace_substring_all (">", "&gt;")

			output (s)
		end

	visit_style (a_style: WIKI_STYLE)
		do
			if a_style.is_bold then
				output ("<strong>")
			elseif a_style.is_italic then
				output ("<em>")
			elseif a_style.is_italic_bold then
				output ("<strong><em>")
			else
				check False end
			end
			a_style.text.process (Current)
			if a_style.is_bold then
				output ("</strong>")
			elseif a_style.is_italic then
				output ("</em>")
			elseif a_style.is_italic_bold then
				output ("</em></strong>")
			else
				check False end
			end
		end

	visit_comment (a_comment: WIKI_COMMENT)
		do
			output ("<!-- " + a_comment.text +  " -->")
			set_next_output_require_newline
		end

feature -- Template

	visit_template (a_template: WIKI_TEMPLATE)
		local
			witem: WIKI_ITEM
			l_is_first: BOOLEAN
		do
			if
				attached template_resolver as r and then
				attached r.content (a_template, current_page) as tpl
			then
				witem := a_template.text (tpl)
				witem.process (Current)
			elseif
				a_template.name.is_case_insensitive_equal_general ("TOC")
				or a_template.name.is_case_insensitive_equal_general ("Horizontal TOC")
			then
				output_toc (a_template, False)
			elseif a_template.name.is_case_insensitive_equal_general ("TOC limit") then
					-- ignore
			else

				output ("<div class=%"wiki-template " + a_template.name + "%" class=%"inline%">")
				output ("<strong>" + a_template.name + "</strong>: ")
				if attached a_template.parameters as l_params then
					l_is_first := True
					across
						l_params as ic
					loop
						if l_is_first then
							l_is_first := False
						else
							output (" | ")
						end
						visit_string (create {WIKI_STRING}.make (ic.item))
					end
				end
				output ("</div>")
			end
		end

feature -- Tag

	visit_code (a_code: WIKI_CODE)
		local
			l_is_inline: BOOLEAN
			l_tag: STRING
			b: BOOLEAN
		do
			if a_code.is_open_close_tag then
					-- Ignore
			else
				l_tag := a_code.tag
				l_is_inline := a_code.is_inline
				if l_is_inline then
					l_tag := l_tag.substring (1, l_tag.count - 1)
					if l_tag.ends_with_general ("/") then
						check is_not_open_close_tag: False end
						l_tag.remove_tail (1)
					end
					output (l_tag)
					output (" class=%"inline%">")
				else
					output (l_tag)
				end
				unset_next_output_require_newline
				b := is_html_encoded_output
				set_html_encoded_output (True)
				a_code.text.process (Current)
				set_html_encoded_output (b)
				output ("</" + a_code.tag_name + ">")
				if not l_is_inline and is_newline_required_after_code_block then
					set_next_output_require_newline
				end
			end
		end

	is_newline_required_after_code_block: BOOLEAN
			-- Is newline required after a code block?
			--		True by default (for backward compatibility),
			--		but as this can be done via css style,
			-- 		one can redefine this function.
		do
			Result := True
		end

	visit_tag (a_tag: WIKI_TAG)
		local
			s: STRING
			l_code: WIKI_CODE
		do
			if is_alias_for_code (a_tag.tag_name) then
				create l_code.make_from_tag (a_tag)
				visit_code (l_code)
			else
				if in_pre_block then
					create s.make_empty
					append_html_escaped_to (a_tag.tag, s)
					output (s)

					if not a_tag.is_open_close_tag then
						a_tag.text.process (Current)
						create s.make_empty
						append_html_escaped_to ("</" + a_tag.tag_name + ">", s)
						output (s)
					end
				else
					output (a_tag.tag)
					if not a_tag.is_open_close_tag then
						a_tag.text.process (Current)
						output ("</" + a_tag.tag_name + ">")
					end
				end
			end
		end

feature -- Entity

	visit_entity (a_entity: WIKI_ENTITY)
		do
			output ("&" + a_entity.value + ";")
		end

feature -- Links

	visit_external_link (a_link: WIKI_EXTERNAL_LINK)
		do
			output ("<a href=%"" + a_link.url + "%" class=%"wiki_ext_link%">")
			a_link.text.process (Current)
			output ("</a>")
		end

	visit_link (a_link: WIKI_LINK)
		local
			l_css_class: STRING
			l_url: STRING
		do
			create l_css_class.make_from_string ("wiki_link")
			if a_link.name.is_whitespace then
				if attached a_link.fragment as l_fragment then
					l_url := "#" + l_fragment
				else
					l_url := ""
				end
				output ("<a href=%"" + l_url + "%" class=%"" + l_css_class + "%">")
				a_link.text.process (Current)
				output ("</a>")
			elseif
				attached link_resolver as r and then
				attached r.wiki_url (a_link, current_page) as u
			then
				if attached a_link.fragment as l_fragment then
					l_url := u + "#" + l_fragment
				else
					l_url := u
				end
				output ("<a href=%"" + l_url + "%" class=%"" + l_css_class + "%">")
				a_link.text.process (Current)
				output ("</a>")
			else
				visit_missing_link (a_link)
			end
		end

	visit_missing_link (a_link: WIKI_LINK)
		local
			l_url: detachable STRING_8
			l_css_class: STRING
		do
			create l_css_class.make_from_string ("wiki_link")
			create l_url.make_from_string (a_link.name)
			if attached a_link.fragment as l_fragment then
				l_url.append_character ('#')
				l_url.append (l_fragment)
			end
			l_css_class.append (" wiki_notfound")
			output ("<a href=%"" + l_url + "%" class=%"" + l_css_class + "%">")
			a_link.text.process (Current)
			output ("</a>")
		end

	visit_image_link (a_link: WIKI_IMAGE_LINK)
		local
			l_wiki_url, l_url: detachable READABLE_STRING_8
		do
			if attached image_resolver as r then
				l_url := r.url (a_link, current_page)
				l_wiki_url := r.wiki_url (a_link, current_page)
			end
			if l_wiki_url = Void then
				l_wiki_url := a_link.name
			end
			if l_url = Void then
				l_url := l_wiki_url
			end
			if attached a_link.location_parameter as l_location then
				output ("<div style=%"text-align: "+ l_location +"%">")
			end
			output ("<a href=%"" + l_wiki_url + "%">")
			output ("<img src=%"" + l_url + "%" border=%"0%"")
			if attached a_link.width_parameter as w then
				output (" width=%"")
				output (w)
				output ("%"")
			end
			if attached a_link.height_parameter as h then
				output (" height=%"")
				output (h)
				output ("%"")
			end
			output ("/>")
			output ("</a>")
			if not a_link.inlined then
				output ("<br/>")
			end

			if not attached {WIKI_RAW_STRING} a_link.text then
				a_link.text.process (Current)
			end
			if a_link.location_parameter /= Void then
				output ("</div>")
			end
			if not a_link.inlined then
				set_next_output_require_newline
			end
		end

	visit_file_link (a_link: WIKI_FILE_LINK)
		local
			l_url: detachable READABLE_STRING_8
		do
			if
				attached file_resolver as r and then
				attached r.file_to_url (a_link, current_page) as u
			then
				l_url := u
			else
				l_url := a_link.name
			end
			output ("<a href=%"" + l_url + "%" class=%"wiki_link%">")
			a_link.text.process (Current)
			output ("</a>")
		end

	visit_category_link (a_link: WIKI_CATEGORY_LINK)
		do
			if a_link.inlined then
				output ("<!-- Category: "+ a_link.name + "=")
				a_link.text.process (Current)
				output (" -->")
			else
				-- FIXME: not implemented
			end
		end

	visit_media_link (a_link: WIKI_MEDIA_LINK)
		do
				-- FIXME: not implemented
			output ("<!-- Media: "+ a_link.name + "=")
			a_link.text.process (Current)
			output (" -->")
		end

	visit_property (a_prop: WIKI_PROPERTY)
		do
			output ("<!-- Property: "+ a_prop.name + "=")
			a_prop.text.process (Current)
			output (" -->%N")
		end

feature -- Table

	visit_table (a_table: WIKI_TABLE)
		do
			if attached a_table.style as st then
				output ("<table " + st + ">")
			else
				output ("<table>")
			end
			if attached a_table.caption as l_caption then
				output ("<caption>")
				l_caption.process (Current)
				output ("</caption>")
			end

			visit_composite (a_table)
			output ("</table>")
			ignore_next_newline
		end

	visit_table_row (a_row: WIKI_TABLE_ROW)
		do
			output ("<tr>")
			visit_composite (a_row)
			output ("</tr>")
		end

	visit_table_header_cell (a_cell: WIKI_TABLE_HEADER_CELL)
		do
			if attached a_cell.modifiers as lst and then not lst.is_empty then
				output ("<th")
				across
					lst as ic
				loop
					output (" ")
					output (ic.item)
				end
				output (">")
			else
				output ("<th>")
			end
			a_cell.text.process (Current)
			output ("</th>")
		end

	visit_table_cell (a_cell: WIKI_TABLE_CELL)
		do
			if attached a_cell.modifiers as lst and then not lst.is_empty then
				output ("<td")
				across
					lst as ic
				loop
					output (" ")
					output (ic.item)
				end
				output (">")
			else
				output ("<td>")
			end
			a_cell.text.process (Current)
			output ("</td>")
		end

feature -- Implementation

--	reset_indexes (lst: ARRAY [INTEGER]; a_index: INTEGER)
--		require
--			lst.valid_index (a_index)
--		local
--			i: INTEGER
--		do
--			from
--				i := a_index
--			until
--				i > lst.upper
--			loop
--				lst[i] := 0
--				i := i + 1
--			end
--		end

--	section_indexes: ARRAY [INTEGER]

	section_level: INTEGER

--	section_index_representation (v: like list_level; a_postfix: BOOLEAN): STRING
--		local
--			l_index: INTEGER
--		do
--			l_index := section_indexes[v]
--			inspect v
--			when 1 then
--				Result := (<<"I", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X">>)[l_index + 1]
--			when 2 then
--				Result := ('A' + l_index - 1).out
--				if a_postfix then
--					Result.append_string (".")
--				end
--			when 3 then
--				Result := l_index.out
--				if a_postfix then
--					Result.append_string ("/")
--				end
----				Result := section_index_representation (v - 1, False) + "." + l_index.out
--			when 4 then
--				Result := ('a' + l_index - 1).out
--				if a_postfix then
--					Result.append_string ("/")
--				end
--			when 5 then
--				Result := section_index_representation (v - 1, False) + "." + l_index.out
--				if a_postfix then
--					Result.append_string ("/")
--				end
--			else
--				Result := l_index.out
--				if a_postfix then
--					Result.append_string ("/")
--				end
--			end
--		end

--	list_indexes: ARRAY [INTEGER]

	list_level: INTEGER

--	ordered_list_index_representation (v: like list_level; a_postfix: BOOLEAN): STRING
--		local
--			l_index: INTEGER
--		do
--			l_index := list_indexes[v]
--			inspect v
--			when 1 then
--				Result := l_index.out
--				if a_postfix then
--					Result.append_string (".")
--				end
--			when 2 then
--				Result := ('a' + l_index - 1).out
--				if a_postfix then
--					Result.append_string (")")
--				end
--			when 3 then
--				Result := ordered_list_index_representation (v - 1, False) + "." + l_index.out
--				if a_postfix then
--					Result.append_string (")")
--				end
--			when 4 then
--				Result := (<<"i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x">>)[l_index]
--			else
--				Result := l_index.out
--				if a_postfix then
--					Result.append_string (".")
--				end
--			end
--		end

	visit_composite (a_composite: WIKI_COMPOSITE [WIKI_ITEM])
		local
			elts: like {WIKI_COMPOSITE [WIKI_ITEM]}.elements
		do
			elts := a_composite.elements
			if elts.count > 0 then
				across
					elts as ic
				loop
					ic.item.process (Current)
				end
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
