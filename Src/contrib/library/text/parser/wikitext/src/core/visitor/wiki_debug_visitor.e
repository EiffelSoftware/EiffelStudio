note
	description: "Summary description for {WIKI_DEBUG_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_DEBUG_VISITOR

inherit
	WIKI_VISITOR

create
	make

feature {NONE} -- Initialization

	make
		do
			create section_indexes.make_filled (0, 0, 50)
			create list_indexes.make_filled (0, 0, 50)
		end

feature -- Output

	output (s: READABLE_STRING_GENERAL)
		local
			tab: STRING
		do
			if next_output_appended then
				next_output_appended := False
			else
				create tab.make_filled (' ', level * 2)
				io.put_new_line
--				io.put_integer (level)
			end
			io.put_string_32 (s.to_string_32)
		end

	set_next_output_appended
		do
			next_output_appended := True
		end

	unset_next_output_appended
		do
			next_output_appended := False
		end

	next_output_appended: BOOLEAN

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
			across
				a_book.pages as c
			loop
				c.item.process (Current)
			end
		end

	visit_page (a_page: WIKI_PAGE)
		do
			if attached a_page.structure as st then
				st.process (Current)
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
				if l_level < section_level then
					reset_indexes (section_indexes, l_level + 1)
				end
				section_indexes[l_level] := section_indexes[l_level] + 1
				section_level := l_level
				output (section_index_representation (section_level, True) + " ")
				set_next_output_appended
				t.process (Current)
				unset_next_output_appended
			else
				output ("!!INVALID SECTION")
			end
			visit_composite (a_section)
		end

	visit_indentation (a_indentation: WIKI_INDENTATION)
		do
			a_indentation.get_structure
			if attached a_indentation.structure as struct then
				visit_structure (struct)
			end
		end

	visit_paragraph (a_paragraph: WIKI_PARAGRAPH)
		do
--			output("%N")
			visit_composite (a_paragraph)
		end

	visit_list (a_list: WIKI_LIST)
		local
			l_level: like {WIKI_LIST}.level
		do
			l_level := a_list.level
			if a_list.count = 1 then

				if l_level <= list_level then
					reset_indexes (list_indexes, l_level)
				end
				list_indexes[l_level] := list_indexes[l_level] + 1
				list_level := l_level
				if a_list.is_ordered_kind then
					output (ordered_list_index_representation (list_level, True) + "%N")
--					set_next_output_appended
				elseif a_list.is_unordered_kind then
--					output ("%N")
--					set_next_output_appended
--				elseif a_list.is_definition_term_kind then
--					output ("%N")
--				elseif a_list.is_definition_description_kind then
--					output ("%N")
				else
				end

			end
			visit_composite (a_list)
			reset_indexes (list_indexes, l_level + 1)
		end

	visit_list_item (a_list_item: WIKI_LIST_ITEM)
		local
			l_level: like {WIKI_LIST}.level
		do
			l_level := a_list_item.level
			if l_level < list_level then
				reset_indexes (list_indexes, list_level)
			end
			list_indexes[l_level] := list_indexes[l_level] + 1
			list_level := l_level
			if a_list_item.is_ordered_kind then
				output (ordered_list_index_representation (list_level, True) + " ")
				set_next_output_appended
			elseif a_list_item.is_unordered_kind then
				output ("- ")
				set_next_output_appended
			elseif a_list_item.is_definition_term_kind then
				output ("def: ")
				set_next_output_appended
			elseif a_list_item.is_definition_description_kind then
				output ("%T= ")
				set_next_output_appended
			else
			end
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
			reset_indexes (list_indexes, l_level + 1)
		end

	visit_preformatted_text (a_block: WIKI_PREFORMATTED_TEXT)
		do
			output ("----------")
			visit_composite (a_block)
			output ("----------")
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
				debug
					output ("LINE:")
					set_next_output_appended
				end
				a_line.text.process (Current)
				unset_next_output_appended
			else
				output ("")
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
				set_next_output_appended
			end
		end

	visit_magic_word (a_word: WIKI_MAGIC_WORD)
		do
			output (a_word.debug_output)
		end

feature -- Strings

	visit_raw_string (a_raw_string: WIKI_RAW_STRING)
		do
			output (a_raw_string.text)
			set_next_output_appended
		end

	visit_style (a_style: WIKI_STYLE)
		local
			k: STRING
		do
			if a_style.is_bold then
				k := "strong"
			elseif a_style.is_italic then
				k := "italic"
			elseif a_style.is_italic_bold then
				k := "italic-bold"
			else
				check False end
				k := "..."
			end

			output ("<" + k + ">")
--			output ("STYLE("+ a_style.kind.out + ":%"")

			set_next_output_appended
			a_style.text.process (Current)
			set_next_output_appended
			output ("</" + k + ">")
--			output ("%")")
			set_next_output_appended
		end

	visit_comment (a_comment: WIKI_COMMENT)
		do
			output ("<!--Comment: " + a_comment.text +  " -->")
			set_next_output_appended
		end

feature -- Template

	visit_template (a_template: WIKI_TEMPLATE)
		local
			k: READABLE_STRING_GENERAL
			l_key: STRING
		do
			output ("{{TEMPLATE %"" + a_template.name + "%"")
			set_next_output_appended
			if attached a_template.parameters as lst then
				output (" => ")
				set_next_output_appended
				across
					lst as ic
				loop
					k := ic.key
					if k.is_valid_as_string_8 then
						l_key := k.to_string_8
					else
						l_key := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (k)
					end
					visit_raw_string (create {WIKI_RAW_STRING}.make (l_key + "="))
					visit_string (create {WIKI_STRING}.make (ic.item))
				end
				set_next_output_appended
			end
			output ("}}")
			set_next_output_appended
		end

feature -- Tag

	visit_code (a_code: WIKI_CODE)
		do
			output (a_code.tag)
			set_next_output_appended
			if attached a_code.text as str then
				str.process (Current)
				set_next_output_appended
			end
			output ("</" + a_code.tag_name + ">")
			set_next_output_appended
		end

	visit_tag (a_tag: WIKI_TAG)
		do
			output ("<" + a_tag.tag_name + ">")
			set_next_output_appended
			if attached a_tag.text as str then
				str.process (Current)
				set_next_output_appended
			end
			output ("</" + a_tag.tag_name + ">")
			set_next_output_appended
		end

feature -- Entity

	visit_entity (a_entity: WIKI_ENTITY)
		do
			output ("&" + a_entity.value + ";")
			set_next_output_appended
		end

feature -- Links

	visit_external_link (a_link: WIKI_EXTERNAL_LINK)
		do
			output ("EXTERNAL_LINK(url="+ a_link.url + ", %"")
			set_next_output_appended
			a_link.text.process (Current)
			set_next_output_appended
			output ("%")")
			set_next_output_appended
		end

	visit_link (a_link: WIKI_LINK)
		do
			output ("LINK("+ a_link.name + ", %"")
			set_next_output_appended
			a_link.text.process (Current)
			set_next_output_appended
			output ("%")")
			set_next_output_appended
		end

	visit_image_link (a_link: WIKI_IMAGE_LINK)
		do
			if a_link.inlined then
				output ("IMAGE_LINK("+ a_link.name + ", %"")
				set_next_output_appended
				a_link.text.process (Current)
				set_next_output_appended
				output ("%")")
				set_next_output_appended
			else
				output ("IMAGE("+ a_link.name + ", %"")
				set_next_output_appended
				a_link.text.process (Current)
				set_next_output_appended
				output ("%")")
				set_next_output_appended
			end
		end

	visit_file_link (a_link: WIKI_FILE_LINK)
		do
			output ("FILE("+ a_link.name + ", %"")
			set_next_output_appended
			a_link.text.process (Current)
			set_next_output_appended
			output ("%")")
			set_next_output_appended
		end

	visit_category_link (a_link: WIKI_CATEGORY_LINK)
		do
			if a_link.inlined then
				output ("CATEGORY("+ a_link.name + ", %"")
				set_next_output_appended
				a_link.text.process (Current)
				set_next_output_appended
				output ("%")")
				set_next_output_appended
			else
				-- FIXME
			end
		end

	visit_media_link (a_link: WIKI_MEDIA_LINK)
		do
			output ("MEDIA("+ a_link.name + ", %"")
			set_next_output_appended
			a_link.text.process (Current)
			set_next_output_appended
			output ("%")")
			set_next_output_appended
		end

feature -- Property

	visit_property (a_prop: WIKI_PROPERTY)
		do
			output ("Property("+ a_prop.name + ", %"")
			set_next_output_appended
			a_prop.text.process (Current)
			set_next_output_appended
			output ("%")")
			set_next_output_appended
		end

feature -- Table

	visit_table (a_table: WIKI_TABLE)
		do
			visit_composite (a_table)
		end

	visit_table_row (a_row: WIKI_TABLE_ROW)
		do
			visit_composite (a_row)
		end

	visit_table_header_cell (a_cell: WIKI_TABLE_HEADER_CELL)
		do
			a_cell.text.process (Current)
		end

	visit_table_cell (a_cell: WIKI_TABLE_CELL)
		do
			a_cell.text.process (Current)
		end

feature -- Implementation

	reset_indexes (lst: ARRAY [INTEGER]; a_index: INTEGER)
		require
			lst.valid_index (a_index)
		local
			i: INTEGER
		do
			from
				i := a_index
			until
				i > lst.upper
			loop
				lst[i] := 0
				i := i + 1
			end
		end

	section_indexes: ARRAY [INTEGER]

	section_level: INTEGER

	section_index_representation (v: like list_level; a_postfix: BOOLEAN): STRING
		local
			l_index: INTEGER
		do
			l_index := section_indexes[v]
			inspect v
			when 1 then
				Result := (<<"I", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X">>)[l_index + 1]
			when 2 then
				Result := ('A' + l_index - 1).out
				if a_postfix then
					Result.append_string (".")
				end
			when 3 then
				Result := l_index.out
				if a_postfix then
					Result.append_string ("/")
				end
--				Result := section_index_representation (v - 1, False) + "." + l_index.out
			when 4 then
				Result := ('a' + l_index - 1).out
				if a_postfix then
					Result.append_string ("/")
				end
			when 5 then
				Result := section_index_representation (v - 1, False) + "." + l_index.out
				if a_postfix then
					Result.append_string ("/")
				end
			else
				Result := l_index.out
				if a_postfix then
					Result.append_string ("/")
				end
			end
		end

	list_indexes: ARRAY [INTEGER]

	list_level: INTEGER

	ordered_list_index_representation (v: like list_level; a_postfix: BOOLEAN): STRING
		local
			l_index: INTEGER
		do
			l_index := list_indexes[v]
			inspect v
			when 1 then
				Result := l_index.out
				if a_postfix then
					Result.append_string (".")
				end
			when 2 then
				Result := ('a' + l_index - 1).out
				if a_postfix then
					Result.append_string (")")
				end
			when 3 then
				Result := ordered_list_index_representation (v - 1, False) + "." + l_index.out
				if a_postfix then
					Result.append_string (")")
				end
			when 4 then
				Result := (<<"i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix", "x">>)[l_index]
			else
				Result := l_index.out
				if a_postfix then
					Result.append_string (".")
				end
			end
		end

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
	copyright: "2011-2023, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
