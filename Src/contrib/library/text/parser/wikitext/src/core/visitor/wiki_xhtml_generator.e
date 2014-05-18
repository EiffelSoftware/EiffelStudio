note
	description: "Summary description for {WIKI_XHTML_GENERATOR}."
	author: ""
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
--			create section_indexes.make_filled (0, 0, 50)
--			create list_indexes.make_filled (0, 0, 50)
		end

feature -- Output

	buffer: STRING

	output (s: STRING)
		local
			buf: like buffer
		do
			buf := buffer
			if next_output_require_newline then
				buf.append ("<br/>%N")
				next_output_require_newline := False
			else
--				buf.append_character ('%N')
--				buf.append ("<br/>%N")
--				buf.append (create {STRING}.make_filled (' ', level * 2))
			end
			buf.append (s)
		end

	unset_next_output_require_newline
		do
			next_output_require_newline := False
		end

	set_next_output_require_newline
		do
			next_output_require_newline := True
		end

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

feature -- Book processing

	visit_book (a_book: WIKI_BOOK)
		do
			output ("<div class=%"wikibook%">")
			output ("<div class=%"title%">"+ a_book.name +"</div>")

			across
				a_book.pages as c
			loop

				output ("<div class=%"wikipage%">")
				output ("<div class=%"title%">"+ c.item.title +"</div>")
				c.item.process (Current)
				output ("</div>%N")
			end
			output ("</div>%N")
		end

	visit_page (a_page: WIKI_PAGE)
		do
			if attached a_page.structure as st then
				output ("<div>")
				st.process (Current)
				output ("</div>%N")
			end
		end

feature -- Processing

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
				output ("%N<h" + l_level.out + ">%N")
				t.process (Current)
				output ("</h" + l_level.out + ">%N")
				unset_next_output_require_newline
			else
				output ("!!INVALID SECTION!!")
			end
			visit_composite (a_section)
		end

	visit_paragraph (a_paragraph: WIKI_PARAGRAPH)
		do
--			output("%N")
			visit_composite (a_paragraph)
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
			l_tag: READABLE_STRING_8
		do
			l_level := a_list_item.level
			list_level := l_level
			if a_list_item.is_ordered_kind then
				l_tag := "li"
			elseif a_list_item.is_unordered_kind then
				l_tag := "li"
			elseif a_list_item.is_definition_term_kind then
				l_tag := "dt"
			elseif a_list_item.is_definition_description_kind then
				l_tag := "div"
			else
				l_tag := "li"
			end
			output ("<" + l_tag + ">")
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
			visit_composite (a_list_item)
			unset_next_output_require_newline
			output ("</" + l_tag + ">%N")
		end

	visit_preformatted_text (a_block: WIKI_PREFORMATTED_TEXT)
		do
			output ("<pre>")
			visit_composite (a_block)
			output ("</pre>")
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
			if not a_line.is_empty then
				a_line.text.process (Current)
				set_next_output_require_newline
			else
				output ("")
				set_next_output_require_newline
			end
		end

	visit_line_separator (a_sep: WIKI_LINE_SEPARATOR)
		do
			output (create {STRING}.make_filled ('-', 72))
		end

	visit_string (a_string: WIKI_STRING)
		do
			if attached a_string.parts as l_parts then
				l_parts.process (Current)
			else
				output (a_string.text)
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
		do
			output ("<div class=%"wiki-template " + a_template.name + "%" class=%"inline%">")
			output ("<strong>" + a_template.name + "</strong>: ")
			if attached a_template.parameters_string as st then
				st.process (Current)
			end
			output ("</div>")
			debug
				output ("{{TEMPLATE %"" + a_template.name + "%"")
				if attached a_template.parameters_string as str then
					output (" => ")
					str.process (Current)
				end
				output ("}}")
				set_next_output_require_newline
			end
		end

feature -- Tag

	visit_code (a_code: WIKI_CODE)
		do
			if a_code.is_inline then
				output ("<" + a_code.tag_name + " class=%"inline%">")
			else
				output ("<" + a_code.tag_name + ">")
			end
			a_code.text.process (Current)
			output ("</" + a_code.tag_name + ">")
		end

	visit_tag (a_tag: WIKI_TAG)
		local
			n: READABLE_STRING_8
		do
			n := a_tag.tag_name
			output ("<" + n + ">")
			a_tag.text.process (Current)
			output ("</" + n + ">")
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
		do
			output ("<a href=%"" + a_link.name + ".html%" class=%"wiki_link%">")
			a_link.text.process (Current)
			output ("</a>")
		end

	visit_image_link (a_link: WIKI_IMAGE_LINK)
		do
			-- FIXME!!!
			if a_link.inlined then
				output ("<img src=%"" + a_link.name + "%">")
				if not attached {WIKI_RAW_STRING} a_link.text then
					a_link.text.process (Current)
				end
				output ("</img>")
			else
				output ("<img src=%"" + a_link.name + "%">")
				if not attached {WIKI_RAW_STRING} a_link.text then
					a_link.text.process (Current)
				end
				output ("</img>")
				set_next_output_require_newline
			end
		end

	visit_category_link (a_link: WIKI_CATEGORY_LINK)
		do
			if a_link.inlined then
				output ("CATEGORY("+ a_link.name + ", %"")
				a_link.text.process (Current)
				output ("%")")
			else
				-- FIXME
			end
		end

	visit_media_link (a_link: WIKI_MEDIA_LINK)
		do
			output ("MEDIA("+ a_link.name + ", %"")
			a_link.text.process (Current)
			output ("%")")
		end

feature -- Table

	visit_table (a_table: WIKI_TABLE)
		do
			if attached a_table.style as st then
				output ("<table " + st + ">")
			else
				output ("<table>")
			end

			visit_composite (a_table)
			output ("</table>")
		end

	visit_table_row (a_row: WIKI_TABLE_ROW)
		do
			output ("<tr>")
			visit_composite (a_row)
			output ("</tr>")
		end

	visit_table_header_cell (a_cell: WIKI_TABLE_HEADER_CELL)
		do
			output ("<th>")
			a_cell.text.process (Current)
			output ("</th>")
		end

	visit_table_cell (a_cell: WIKI_TABLE_CELL)
		do
			output ("<td>")
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
				indent
				from
					elts.start
				until
					elts.after
				loop
					elts.item.process (Current)
					elts.forth
				end
				exdent
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
