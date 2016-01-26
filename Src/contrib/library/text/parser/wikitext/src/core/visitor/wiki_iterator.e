note
	description: "Iterator on WIKI objects."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_ITERATOR

inherit
	WIKI_VISITOR

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

	visit_structure (a_structure: WIKI_STRUCTURE)
		do
			visit_composite (a_structure)
		end

	visit_section (a_section: WIKI_SECTION)
		do
			if attached a_section.text as t then
				t.process (Current)
			end
			visit_composite (a_section)
		end

	visit_indentation (a_indent: WIKI_INDENTATION)
		do
			a_indent.get_structure
			if attached a_indent.structure as struct then
				visit_structure (struct)
			end
		end

	visit_paragraph (a_paragraph: WIKI_PARAGRAPH)
		do
			visit_composite (a_paragraph)
		end

	visit_list (a_list: WIKI_LIST)
		do
			visit_composite (a_list)
		end

	visit_list_item (a_list_item: WIKI_LIST_ITEM)
		do
			if attached a_list_item.text as t then
				t.process (Current)
			end
			visit_composite (a_list_item)
		end

	visit_preformatted_text (a_block: WIKI_PREFORMATTED_TEXT)
		do
			visit_composite (a_block)
		end

--	process_indented_text (a_text: WIKI_INDENTED_TEXT)
--		do
--			a_text.text.process (Current)
--			process_composite (a_text)
--		end

	visit_line (a_line: WIKI_LINE)
		do
			a_line.text.process (Current)
		end

	visit_line_separator (a_sep: WIKI_LINE_SEPARATOR)
		do
		end

	visit_string (a_string: WIKI_STRING)
		do
			if attached a_string.parts as l_parts then
				visit_composite (l_parts)
			end
		end

	visit_magic_word (a_word: WIKI_MAGIC_WORD)
		do
		end

feature -- Strings

	visit_raw_string (a_raw_string: WIKI_RAW_STRING)
		do
		end

	visit_style (a_style: WIKI_STYLE)
		do
			a_style.text.process (Current)
		end

	visit_comment (a_comment: WIKI_COMMENT)
		do
		end

feature -- Template

	visit_template (a_template: WIKI_TEMPLATE)
		do
		end

feature -- Tag

	visit_code (a_code: WIKI_CODE)
		do
			-- Code content should not be processed for other wiki entities.
		end

	visit_tag (a_tag: WIKI_TAG)
		do
			a_tag.text.process (Current)
		end

feature -- Entity

	visit_entity (a_entity: WIKI_ENTITY)
		do
		end

feature -- Links

	visit_external_link (a_link: WIKI_EXTERNAL_LINK)
		do
			a_link.text.process (Current)
		end

	visit_link (a_link: WIKI_LINK)
		do
			a_link.text.process (Current)
		end

	visit_image_link (a_link: WIKI_IMAGE_LINK)
		do
			a_link.text.process (Current)
		end

	visit_file_link (a_link: WIKI_FILE_LINK)
		do
			a_link.text.process (Current)
		end

	visit_category_link (a_link: WIKI_CATEGORY_LINK)
		do
			a_link.text.process (Current)
		end

	visit_media_link (a_link: WIKI_MEDIA_LINK)
		do
			a_link.text.process (Current)
		end

	visit_property (a_prop: WIKI_PROPERTY)
		do
			a_prop.text.process (Current)
		end

feature -- Table

	visit_table (a_table: WIKI_TABLE)
		do
			if attached a_table.caption as c then
				visit_string (c)
			end
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

note
	copyright: "2011-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
