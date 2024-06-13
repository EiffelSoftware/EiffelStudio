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

	register_resolvers (r: WIKI_ITEM_RESOLVER)
			-- Auto detect available resolvers
		do
			if attached {WIKI_LINK_RESOLVER} r as l_link_resolver then
				set_link_resolver (l_link_resolver)
			end
			if attached {WIKI_FILE_RESOLVER} r as l_file_resolver then
				set_file_resolver (l_file_resolver)
			end
			if attached {WIKI_TEMPLATE_RESOLVER} r as l_tpl_resolver then
				set_template_resolver (l_tpl_resolver)
			end
			if attached {WIKI_IMAGE_RESOLVER} r as l_img_resolver then
				set_image_resolver (l_img_resolver)
			end
		end

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

	output (s: READABLE_STRING_8)
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

	append_html_escaped_to (s: READABLE_STRING_8; a_output: STRING_8)
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

	page_title (a_page: WIKI_PAGE): READABLE_STRING_8
			-- Title for page `a_page'.
		do
			Result := a_page.title
		end

	book_title (a_book: WIKI_BOOK): READABLE_STRING_8
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
			l_section_node: WIKI_SECTION_NODE
			curr, prev: NATURAL_8
			l_is_horizontal: BOOLEAN
			l_list_tag: STRING
			l_css_class: STRING
		do
			if attached current_page as pg and then attached pg.structure as l_structure then
				create it.make
				it.set_depth_limit (toc_depth_limit)
				if a_wiki /= Void then
						-- Useful to get TOC limit and other settings.
					it.import_settings_from (a_wiki)
					l_is_horizontal := it.is_horizontal
				end
				l_structure.process (it)

				l_sections := it.sections
				l_section_node := it.root_section_node
				if
					not l_section_node.is_empty and then
					(
							-- TOC is automatically generated for each structure with at least 4 headinds, and if no __NOTOC__ is set.
						not is_auto_toc
						or else it.has_auto_generated_toc
					)
				then
					create l_css_class.make_empty
					l_css_class.append ("wiki-toc")
					if l_is_horizontal then
						l_list_tag := "ul"
						l_css_class.append (" horizontal")
					else
						l_list_tag := "ol"
					end
					if is_auto_toc then
						l_css_class.append (" wiki-toc-auto")
					end
					output ("%N<div class=%""+ l_css_class + "%">")
					output ("%N<" + l_list_tag)
					if attached it.style as l_css_style then
						output (" style=%"" + l_css_style + "%"")
					end
					output (">")
					if is_auto_toc or not it.has_auto_generated_toc then
						output ("<a id=%"toc%"></a>")
					end
					output ("<span class=%"title%">Contents</span>%N")
					curr := 1
					prev := curr
					if attached l_section_node.items as l_items and then not l_items.is_empty then
						across
							l_items as ic
						loop
							output_section_node (ic.item, l_list_tag)
						end
					end
					output ("</" + l_list_tag + ">%N")
					output ("</div>%N")
				end
			end
		end

	output_section_node (a_node: WIKI_SECTION_NODE; a_list_tag: READABLE_STRING_8)
		do
			if
				a_node.section = Void and then
			 	attached a_node.items as l_items and then not l_items.is_empty
			then
				across
					l_items as ic
				loop
					output_section_node (ic.item, a_list_tag)
				end
			else
				output_indentation
				output ("<li>")
				if
					attached a_node.section as w_section and then
					attached w_section.text as l_text
				then
					output ("<a href=%"#" + anchor_name (l_text.text, True) + "%">")
					l_text.process (Current)
					output ("</a>")
				else
--					output ("...")
				end
				if attached a_node.items as l_items and then not l_items.is_empty then
					output ("<" + a_list_tag + ">%N")
					indent
					across
						l_items as ic
					loop
						output_section_node (ic.item, a_list_tag)
					end
					output_indentation
					output ("</" + a_list_tag + ">%N")
					exdent
				end
				output ("</li>%N")
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
					output ("<a id=%"")
					output (anchor_name (l_text.text, True))
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
			l_is_def: BOOLEAN
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
				l_is_def := True
				l_tag := ""
				l_item_tag := "dt"
			elseif a_list_item.is_definition_description_kind then
				l_is_def := True
				l_tag := ""
				l_item_tag := "dd"
			else
				l_tag := "ul"
				l_item_tag := "li"
			end
			output ("<" + l_item_tag + ">")
			unset_next_output_require_newline

			if attached a_list_item.text as t then
				t.process (Current)
			end
			if not l_is_def and a_list_item.count > 0 then
				if not l_tag.is_empty then
					output ("<" + l_tag + ">")
				end
				visit_composite (a_list_item)
				if not l_tag.is_empty then
					output ("</" + l_tag + ">")
				end
			end
			unset_next_output_require_newline
			output ("</" + l_item_tag + ">%N")
			if a_list_item.is_definition_term_kind and then
				attached {WIKI_DEFINITION_TERM} a_list_item as l_term and then
				attached l_term.definition_description as l_def
			then
				l_def.process (Current)
			end
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
				elseif list_level = 0 then
						-- new line, but not a break <br/> !
						-- but not in list item.
					output ("%N")
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
			create s.make_from_string (a_raw_string.text)
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
			s: STRING
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
				create s.make_empty
				if attached a_template.parameters as l_params then
					l_is_first := True
					across
						l_params as ic
					loop
						if l_is_first then
							l_is_first := False
						else
							s.append (" | ")
						end
						s.append (ic.item)
					end
				end
				witem := a_template.text (s)
				witem.process (Current)
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
			-- FIXME jfiat [2020/03/17] : convert lang="foo" into class="lang-foo" or class="language-foo"
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
			output ("<a href=%"" + a_link.url + "%" class=%"wiki_ext_link%"")
			if attached a_link.parameters as l_params then
				across
					l_params as ic
				loop
					if not ic.item.is_whitespace then
						output (" ")
							-- No check if this is valid xhtml or not ... it is up to the wiki source.
						output (ic.item)
					end
				end
			end
			output (">")
			a_link.text.process (Current)
			output ("</a>")
		end

	visit_link (a_link: WIKI_LINK)
		local
			l_css_class: STRING
			l_url: detachable STRING
		do
			create l_css_class.make_from_string ("wiki_link")
			if a_link.name.is_whitespace then
				if attached a_link.fragment as l_fragment then
					l_url := "#" + anchor_name (l_fragment, True)
				else
					l_url := ""
				end
			elseif
				attached link_resolver as r and then
				attached r.wiki_url (a_link, current_page) as u
			then
				if attached a_link.fragment as l_fragment then
					l_url := u + "#" + anchor_name (l_fragment, True)
				else
					l_url := u
				end
			end
			if l_url /= Void then
				output ("<a href=%"" + l_url + "%" class=%"" + l_css_class + "%"")
				if attached a_link.parameters as l_params then
					across
						l_params as ic
					loop
						if not ic.item.is_whitespace then
							output (" ")
								-- No check if this is valid xhtml or not ... it is up to the wiki source.
							output (ic.item)
						end
					end
				end
				output (">")
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
			if
				attached link_resolver as r and then
				attached r.missing_wiki_url (a_link, current_page) as u
			then
				create l_url.make_from_string (u)
			else
				create l_url.make_from_string (a_link.name)
			end
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
			l_lnk_name: READABLE_STRING_8
		do
			l_lnk_name := a_link.name
			if attached image_resolver as r then
				l_url := r.url (a_link, current_page)
				l_wiki_url := r.wiki_url (a_link, current_page)
			end
			if l_url = Void then
				l_url := l_lnk_name
			end
			if not a_link.inlined then
				output ("<div class=%"wiki_image")
				if a_link.has_frame or a_link.has_thumb_parameter or a_link.has_border then
					output (" wiki_frame")
				end
				output ("%"")
				if attached a_link.location_parameter as l_location then
					output (" style=%"text-align: "+ l_location +"%"")
				end
				output (">")
			end
			if l_wiki_url /= Void then
				output ("<a href=%"" + l_wiki_url + "%">")
			end
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
			if attached a_link.alt_parameter as l_alt then
				output (" alt=%"")
				output (l_alt)
				output ("%"")
			end
			output ("/>")
			if l_wiki_url /= Void then
				output ("</a>")
			end
			if not a_link.inlined then
				if not a_link.text.is_empty then
					output ("<div class=%"wiki_caption%">")
					if attached {WIKI_RAW_STRING} a_link.text as l_raw then
						visit_raw_string (l_raw)
					else
						a_link.text.process (Current)
					end
					output ("</div>")
				end
			end
			if not a_link.inlined then
				output ("</div>")
--				set_next_output_require_newline
			end
		end

	link_paramter_to_url (lnk: READABLE_STRING_8; a_page: detachable WIKI_PAGE): detachable READABLE_STRING_8
			-- Resolved link provided as parameter.
		require
			lnk /= Void
		local
			w_link: WIKI_LINK
			e_link: WIKI_EXTERNAL_LINK
		do
			if lnk.is_whitespace then
				Result := Void
			elseif
				lnk.starts_with_general ("http://")
				or lnk.starts_with_general ("https://")
				or lnk.starts_with_general ("mailto:")
				or lnk.starts_with_general ("file://")
				or lnk.starts_with_general ("#") -- Anchor name ...
			then
				Result := lnk
			else
				create w_link.make ("[["+ lnk +"]]")
				if
					attached link_resolver as r and then
					attached r.wiki_url (w_link, a_page) as w_url
				then
					Result := w_url
				else
					Result := lnk
				end
			end
		end

	visit_file_link (a_link: WIKI_FILE_LINK)
		local
			l_wiki_url, l_file_url, l_url: detachable READABLE_STRING_8
			l_lnk_name: READABLE_STRING_8
		do
			if
				attached file_resolver as r and then
				attached r.file_to_url (a_link, current_page) as u
			then
				l_file_url := u
			else
				l_file_url := a_link.name
			end
			if attached a_link.link_parameter as lnk then
				l_url := link_paramter_to_url (lnk, current_page)
				-- l_url can be Void, in this case, no link is generated
			else
				l_url := l_file_url
			end
			if a_link.is_image then
				l_lnk_name := a_link.name
				if not a_link.inlined then
					output ("<div class=%"wiki_image")
					if a_link.has_frame or a_link.has_thumb_parameter or a_link.has_border then
						output (" wiki_frame")
					end
					output ("%"")
					if attached a_link.location_parameter as l_location then
						output (" style=%"text-align: "+ l_location +"%"")
					end
					output (">")
				end
				if l_url /= Void then
					output ("<a href=%"" + l_url + "%">")
				end
				output ("<img src=%"" + l_file_url + "%" border=%"0%"")
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
				if attached a_link.alt_parameter as l_alt then
					output (" alt=%"")
					output (l_alt)
					output ("%"")
				end
				output ("/>")
				if l_url /= Void then
					output ("</a>")
				end
				if not a_link.inlined then
					if not a_link.text.is_empty then
						output ("<div class=%"wiki_caption%">")
						if attached {WIKI_RAW_STRING} a_link.text as l_raw then
							visit_raw_string (l_raw)
						else
							a_link.text.process (Current)
						end
						output ("</div>")
					end
				end
				if not a_link.inlined then
					output ("</div>")
	--				set_next_output_require_newline
				end
			else
				if l_url /= Void then
					output ("<a href=%"" + l_url + "%" class=%"wiki_link%">")
				end
				a_link.text.process (Current)
				if l_url /= Void then
					output ("</a>")
				end
			end
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
			if attached a_table.style as st and then not st.is_whitespace then
				output ("<table " + st + ">")
			else
				output ("<table>")
			end
			if attached a_table.caption as l_caption and then not l_caption.is_whitespace then
				if attached a_table.caption_style as st and then not st.is_whitespace then
					output ("<caption " + st + ">")
				else
					output ("<caption>")
				end
				l_caption.process (Current)
				output ("</caption>%N")
			end

			visit_composite (a_table)
			output ("</table>")
			ignore_next_newline
		end

	visit_table_row (a_row: WIKI_TABLE_ROW)
		do
			if attached a_row.style as st and then not st.is_whitespace then
				output ("<tr " + st + ">")
			else
				output ("<tr>")
			end
			visit_composite (a_row)
			output ("</tr>%N")
		end

	visit_table_header_cell (a_cell: WIKI_TABLE_HEADER_CELL)
		do
			if attached a_cell.modifiers as lst and then not lst.is_empty then
				output ("<th")
				across
					lst as ic
				loop
					if not ic.item.is_whitespace then
						output (" ")
						output (ic.item)
					end
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
					if not ic.item.is_whitespace then
						output (" ")
						output (ic.item)
					end
				end
				output (">")
			else
				output ("<td>")
			end
			a_cell.text.process (Current)
			output ("</td>")
		end

feature -- Helpers

	anchor_name (a_text: READABLE_STRING_GENERAL; a_user_friendly_mode: BOOLEAN): STRING_8
			-- Anchor name for text `a_text'.
			-- Remove/replace space and unexpected characters.
		local
			i,n: INTEGER
			curr: CHARACTER_32
			prev: CHARACTER_8
		do
			n := a_text.count
			create Result.make (a_text.count)
			from
				i := 1
				prev := '_' -- Do not start with underscore as replacement.
			until
				i > n
			loop
				curr := a_text [i]
				if curr.code <= 0x7F and then curr.is_alpha_numeric then
						-- Valid characters in URL fragment.
					prev := curr.to_character_8
					Result.append_character (prev)
				else
					inspect a_text [i]
					when
						'/',  '?', '-', '.', '_',
						'~', ':', '@', '!', '$', '&', '%'', '(', ')', '*', '+',
						',', ';', '='
					then
							-- Valid characters in URL fragment.
						prev := curr.to_character_8
						Result.append_character (prev)
					when ' ', '%T', '%N' then
						if a_user_friendly_mode then

								-- Note: those char should be %-encoded, but for user convenience
								-- we use '_'.
							if prev /= '_' then
								prev := '_'
								Result.append_character (prev)
							end
						else
								-- %-encode the char
							prev := '%U'
							append_percent_encoded_to (curr.natural_32_code, Result)
						end
					else
							-- %-encode the char
						prev := '%U'
						append_percent_encoded_to (curr.natural_32_code, Result)
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation: percent encoding		

	append_percent_encoded_to (a_code: NATURAL_32; a_result: STRING_8)
		do
			if a_code > 0xFF then
					-- Unicode
				append_percent_encoded_unicode_character_code_to (a_code, a_result)
			elseif a_code > 0x7F then
					-- Extended ASCII
					-- This requires percent-encoding on UTF-8 converted character.
				append_percent_encoded_unicode_character_code_to (a_code, a_result)
			else
					-- ASCII
				append_percent_encoded_ascii_character_code_to (a_code, a_result)
			end
		end

	append_percent_encoded_ascii_character_code_to (a_code: NATURAL_32; a_result: STRING_GENERAL)
			-- Append extended ascii character code `a_code' as percent-encoded content into `a_result'
			-- Note: it does not UTF-8 convert this extended ASCII.
		require
			is_extended_ascii: a_code <= 0xFF
		local
			c: INTEGER
		do
				-- Extended ASCII
			c := a_code.to_integer_32
			a_result.append_code (37) -- 37 '%%'
 			a_result.append_code (hex_digit [c |>> 4])
 			a_result.append_code (hex_digit [c & 0xF])
		ensure
			appended: a_result.count > old a_result.count
		end

	append_percent_encoded_unicode_character_code_to (a_code: NATURAL_32; a_result: STRING_GENERAL)
			-- Append Unicode character code `a_code' as UTF-8 and percent-encoded content into `a_result'
			-- Note: it does include UTF-8 conversion of extended ASCII and Unicode.
		do
			if a_code <= 0x7F then
					-- 0xxxxxxx
				append_percent_encoded_ascii_character_code_to (a_code, a_result)
			elseif a_code <= 0x7FF then
					-- 110xxxxx 10xxxxxx
				append_percent_encoded_ascii_character_code_to ((a_code |>> 6) | 0xC0, a_result)
				append_percent_encoded_ascii_character_code_to ((a_code & 0x3F) | 0x80, a_result)
			elseif a_code <= 0xFFFF then
					-- 1110xxxx 10xxxxxx 10xxxxxx
				append_percent_encoded_ascii_character_code_to ((a_code |>> 12) | 0xE0, a_result)
				append_percent_encoded_ascii_character_code_to (((a_code |>> 6) & 0x3F) | 0x80, a_result)
				append_percent_encoded_ascii_character_code_to ((a_code & 0x3F) | 0x80, a_result)
			else
					-- c <= 1FFFFF - there are no higher code points
					-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
				append_percent_encoded_ascii_character_code_to ((a_code |>> 18) | 0xF0, a_result)
				append_percent_encoded_ascii_character_code_to (((a_code |>> 12) & 0x3F) | 0x80, a_result)
				append_percent_encoded_ascii_character_code_to (((a_code |>> 6) & 0x3F) | 0x80, a_result)
				append_percent_encoded_ascii_character_code_to ((a_code & 0x3F) | 0x80, a_result)
			end
		ensure
			appended: a_result.count > old a_result.count
		end

 	hex_digit: SPECIAL [NATURAL_32]
 			-- Hexadecimal digits.
 		once
 			create Result.make_filled (0, 16)
 			Result [0] := {NATURAL_32} 48 -- 48 '0'
 			Result [1] := {NATURAL_32} 49 -- 49 '1'
 			Result [2] := {NATURAL_32} 50 -- 50 '2'
 			Result [3] := {NATURAL_32} 51 -- 51 '3'
 			Result [4] := {NATURAL_32} 52 -- 52 '4'
 			Result [5] := {NATURAL_32} 53 -- 53 '5'
 			Result [6] := {NATURAL_32} 54 -- 54 '6'
 			Result [7] := {NATURAL_32} 55 -- 55 '7'
 			Result [8] := {NATURAL_32} 56 -- 56 '8'
 			Result [9] := {NATURAL_32} 57 -- 57 '9'
 			Result [10] := {NATURAL_32} 65 -- 65 'A'
 			Result [11] := {NATURAL_32} 66 -- 66 'B'
 			Result [12] := {NATURAL_32} 67 -- 67 'C'
 			Result [13] := {NATURAL_32} 68 -- 68 'D'
 			Result [14] := {NATURAL_32} 69 -- 69 'E'
 			Result [15] := {NATURAL_32} 70 -- 70 'F'
 		end

feature -- Implementation

	section_level: INTEGER

	list_level: INTEGER

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
	copyright: "2011-2024, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
