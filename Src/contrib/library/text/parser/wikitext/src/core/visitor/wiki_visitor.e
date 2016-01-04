note
	description: "Summary description for {WIKI_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_VISITOR

feature -- Book processing

	visit_book (a_book: WIKI_BOOK)
		deferred
		end

	visit_page (a_page: WIKI_PAGE)
		deferred
		end

feature -- Processing

	visit_composite (a_composite: WIKI_COMPOSITE [WIKI_ITEM])
		require
			a_composite_attached: a_composite /= Void
		deferred
		end

	visit_structure (a_structure: WIKI_STRUCTURE)
		require
			a_structure_attached: a_structure /= Void
		deferred
		end

	visit_section (a_section: WIKI_SECTION)
		require
			a_section_attached: a_section /= Void
		deferred
		end

	visit_indentation (a_indent: WIKI_INDENTATION)
		require
			a_indent_attached: a_indent /= Void
		deferred
		end

	visit_paragraph (a_paragraph: WIKI_PARAGRAPH)
		require
			a_paragraph_attached: a_paragraph /= Void
		deferred
		end

	visit_list (a_list: WIKI_LIST)
		require
			a_list_attached: a_list /= Void
		deferred
		end

	visit_list_item (a_item: WIKI_LIST_ITEM)
		require
			a_item_attached: a_item /= Void
		deferred
		end

	visit_preformatted_text (a_block: WIKI_PREFORMATTED_TEXT)
		require
			a_block_attached: a_block /= Void
		deferred
		end

--	visit_indented_text (a_text: WIKI_INDENTED_TEXT)
--		require
--			a_text_attached: a_text /= Void
--		deferred
--		end

	visit_line (a_line: WIKI_LINE)
		require
			a_line_attached: a_line /= Void
		deferred
		end

	visit_line_separator (a_sep: WIKI_LINE_SEPARATOR)
		require
			a_sep_attached: a_sep /= Void
		deferred
		end

	visit_string (a_string: WIKI_STRING)
		require
			a_string_attached: a_string /= Void
		deferred
		end

	visit_magic_word (a_word: WIKI_MAGIC_WORD)
		require
			a_word_attached: a_word /= Void
		deferred
		end

feature -- Strings

	visit_raw_string (a_raw_string: WIKI_RAW_STRING)
		require
			a_raw_string_attached: a_raw_string /= Void
		deferred
		end

	visit_style (a_style: WIKI_STYLE)
		require
			a_style_attached: a_style /= Void
		deferred
		end

	visit_comment (a_comment: WIKI_COMMENT)
		require
			a_comment_attached: a_comment /= Void
		deferred
		end

feature -- Template

	visit_template (a_template: WIKI_TEMPLATE)
		require
			a_template_attached: a_template /= Void
		deferred
		end

feature -- Tag	

	visit_code (a_code: WIKI_CODE)
		require
			a_code_attached: a_code /= Void
		deferred
		end

	visit_tag (a_tag: WIKI_TAG)
		require
			a_tag_attached: a_tag /= Void
		deferred
		end

feature -- Entity		

	visit_entity (a_entity: WIKI_ENTITY)
		require
			a_entity_attached: a_entity /= Void
		deferred
		end

feature -- Links

	visit_external_link (a_link: WIKI_EXTERNAL_LINK)
		require
			a_link_attached: a_link /= Void
		deferred
		end

	visit_link (a_link: WIKI_LINK)
		require
			a_link_attached: a_link /= Void
		deferred
		end

	visit_image_link (a_link: WIKI_IMAGE_LINK)
		require
			a_link_attached: a_link /= Void
		deferred
		end

	visit_file_link (a_file: WIKI_FILE_LINK)
		require
			a_file_attached: a_file /= Void
		deferred
		end

	visit_category_link (a_link: WIKI_CATEGORY_LINK)
		require
			a_link_attached: a_link /= Void
		deferred
		end

	visit_media_link (a_link: WIKI_MEDIA_LINK)
		require
			a_link_attached: a_link /= Void
		deferred
		end

	visit_property (a_prop: WIKI_PROPERTY)
		require
			a_prop_attached: a_prop /= Void
		deferred
		end

feature -- Table

	visit_table (a_table: WIKI_TABLE)
		require
			a_table_attached: a_table /= Void
		deferred
		end

	visit_table_row (a_row: WIKI_TABLE_ROW)
		require
			a_row_attached: a_row /= Void
		deferred
		end

	visit_table_header_cell (a_cell: WIKI_TABLE_HEADER_CELL)
		require
			a_cell_attached: a_cell /= Void
		deferred
		end

	visit_table_cell (a_cell: WIKI_TABLE_CELL)
		require
			a_cell_attached: a_cell /= Void
		deferred
		end


note
	copyright: "2011-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
