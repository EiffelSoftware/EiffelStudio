note
	description: "Summary description for {WIKI_DEBUG_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_NULL_VISITOR

inherit
	WIKI_VISITOR

feature -- Book processing

	visit_book (a_book: WIKI_BOOK)
		do
		end

	visit_page (a_page: WIKI_PAGE)
		do
		end

feature -- Processing

	visit_composite (a_composite: WIKI_COMPOSITE [WIKI_ITEM])
		do
		end

	visit_structure (a_structure: WIKI_STRUCTURE)
		do
		end

	visit_section (a_section: WIKI_SECTION)
		do
		end

	visit_indentation (a_indentation: WIKI_INDENTATION)
		do
		end

	visit_paragraph (a_paragraph: WIKI_PARAGRAPH)
		do
		end

	visit_list (a_list: WIKI_LIST)
		do
		end

	visit_list_item (a_list_item: WIKI_LIST_ITEM)
		do
		end

	visit_preformatted_text (a_block: WIKI_PREFORMATTED_TEXT)
		do
		end

--	visit_indented_text (a_text: WIKI_INDENTED_TEXT)
--		do
--		end

	visit_line (a_line: WIKI_LINE)
		do
		end

	visit_line_separator (a_sep: WIKI_LINE_SEPARATOR)
		do
		end

	visit_string (a_string: WIKI_STRING)
		do
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
		end

	visit_comment (a_comment: WIKI_COMMENT)
		do
		end

feature -- Entity		

	visit_entity (a_entity: WIKI_ENTITY)
		do
		end

feature -- Template

	visit_template (a_template: WIKI_TEMPLATE)
		do
		end

feature -- Tag

	visit_code (a_code: WIKI_CODE)
		do
		end

	visit_tag (a_tag: WIKI_TAG)
		do
		end

feature -- Links

	visit_external_link (a_link: WIKI_EXTERNAL_LINK)
		do
		end

	visit_link (a_link: WIKI_LINK)
		do
		end

	visit_image_link (a_link: WIKI_IMAGE_LINK)
		do
		end

	visit_file_link (a_link: WIKI_FILE_LINK)
		do
		end

	visit_category_link (a_link: WIKI_CATEGORY_LINK)
		do
		end

	visit_media_link (a_link: WIKI_MEDIA_LINK)
		do
		end

feature -- Property

	visit_property (a_prop: WIKI_PROPERTY)
		do
		end

feature -- Table

	visit_table (a_table: WIKI_TABLE)
		do
		end

	visit_table_row (a_row: WIKI_TABLE_ROW)
		do
		end

	visit_table_header_cell (a_cell: WIKI_TABLE_HEADER_CELL)
		do
		end

	visit_table_cell (a_cell: WIKI_TABLE_CELL)
		do
		end

note
	copyright: "2011-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
