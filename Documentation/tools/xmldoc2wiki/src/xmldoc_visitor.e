indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_VISITOR

feature -- Basic operations

	process_item (i: XMLDOC_ITEM)
		require
			i_attached: i /= Void
		deferred
		end

	process_unused (i: XMLDOC_UNUSED)
		require
			i_attached: i /= Void
		deferred
		end

	process_unavailable (i: XMLDOC_UNAVAILABLE)
		require
			i_attached: i /= Void
		deferred
		end

	process_metadata (i: XMLDOC_METADATA)
		require
			i_attached: i /= Void
		deferred
		end

	process_anchor (i: XMLDOC_ANCHOR)
		require
			i_attached: i /= Void
		deferred
		end

	process_heading (i: XMLDOC_HEADING)
		require
			i_attached: i /= Void
		deferred
		end

	process_image (i: XMLDOC_IMAGE)
		require
			i_attached: i /= Void
		deferred
		end

	process_link (i: XMLDOC_LINK)
		require
			i_attached: i /= Void
		deferred
		end

	process_page (i: XMLDOC_PAGE)
		require
			i_attached: i /= Void
		deferred
		end

	process_list (i: XMLDOC_LIST)
		require
			i_attached: i /= Void
		deferred
		end

	process_list_item (i: XMLDOC_LIST_ITEM)
		require
			i_attached: i /= Void
		deferred
		end

	process_text (i: XMLDOC_TEXT)
		require
			i_attached: i /= Void
		deferred
		end

	process_line_break (i: XMLDOC_LINE_BREAK)
		require
			i_attached: i /= Void
		deferred
		end

	process_image_link (i: XMLDOC_IMAGE_LINK)
		require
			i_attached: i /= Void
		deferred
		end

	process_composite_text (i: XMLDOC_COMPOSITE_TEXT)
		require
			i_attached: i /= Void
		deferred
		end

	process_code (i: XMLDOC_CODE)
		require
			i_attached: i /= Void
		deferred
		end

	process_note (i: XMLDOC_NOTE)
		require
			i_attached: i /= Void
		deferred
		end

	process_paragraph (i: XMLDOC_PARAGRAPH)
		require
			i_attached: i /= Void
		deferred
		end

	process_sample (i: XMLDOC_SAMPLE)
		require
			i_attached: i /= Void
		deferred
		end

	process_seealso (i: XMLDOC_SEEALSO)
		require
			i_attached: i /= Void
		deferred
		end

	process_tip (i: XMLDOC_TIP)
		require
			i_attached: i /= Void
		deferred
		end

	process_warning (i: XMLDOC_WARNING)
		require
			i_attached: i /= Void
		deferred
		end

	process_info (i: XMLDOC_INFO)
		require
			i_attached: i /= Void
		deferred
		end

	process_cluster_name (i: XMLDOC_CLUSTER_NAME)
		require
			i_attached: i /= Void
		deferred
		end

	process_class_name (i: XMLDOC_CLASS_NAME)
		require
			i_attached: i /= Void
		deferred
		end

	process_feature_name (i: XMLDOC_FEATURE_NAME)
		require
			i_attached: i /= Void
		deferred
		end

	process_bold (i: XMLDOC_BOLD)
		require
			i_attached: i /= Void
		deferred
		end

	process_italic (i: XMLDOC_ITALIC)
		require
			i_attached: i /= Void
		deferred
		end

	process_underline (i: XMLDOC_UNDERLINE)
		require
			i_attached: i /= Void
		deferred
		end

	process_span (i: XMLDOC_SPAN)
		require
			i_attached: i /= Void
		deferred
		end

	process_div (i: XMLDOC_DIV)
		require
			i_attached: i /= Void
		deferred
		end

	process_table (i: XMLDOC_TABLE)
		require
			i_attached: i /= Void
		deferred
		end

	process_table_row (i: XMLDOC_TABLE_ROW)
		require
			i_attached: i /= Void
		deferred
		end

	process_table_cell (i: XMLDOC_TABLE_CELL)
		require
			i_attached: i /= Void
		deferred
		end

	process_code_entity (i: XMLDOC_CODE_ENTITY)
		require
			i_attached: i /= Void
		deferred
		end

end
