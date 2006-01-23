indexing
	description: "Objects that include all test necessary for compilation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_TEST_INCLUDE
	
feature {NONE} -- Implementation
	
	included_classes is
			-- All classes that must be explicitly included in system.
		local
			fixed_set_item_position_demo: FIXED_SET_ITEM_POSITION_TEST
			fixed_increase_item_position_demo: FIXED_INCREASE_ITEM_POSITION_TEST
			fixed_z_order_test: FIXED_Z_ORDER_TEST
			fixed_pixmap_test: FIXED_PIXMAP_TEST
			button_select_actions_test: BUTTON_SELECT_ACTIONS_TEST
			button_pixmp_test: BUTTON_PIXMAP_TEST
			label_basic_test: LABEL_BASIC_TEST
			label_text_alignment_test: LABEL_TEXT_ALIGNMENT_TEST
			label_multi_line_test: LABEL_MULTI_LINE_TEST
			notebook_extend_test: NOTEBOOK_EXTEND_TEST
			notebook_item_text_test: NOTEBOOK_ITEM_TEXT_TEST
			notebook_tab_position_test: NOTEBOOK_TAB_POSITION_TEST
			notebook_selection_actions_test: NOTEBOOK_SELECTION_ACTIONS_TEST
			horizontal_box_padding_width_test: HORIZONTAL_BOX_PADDING_WIDTH_TEST
			vertical_box_padding_width_test: VERTICAL_BOX_PADDING_WIDTH_TEST
			vertical_box_disable_item_expand_test: VERTICAL_BOX_DISABLE_ITEM_EXPAND_TEST
			horizontal_box_border_width_test: HORIZONTAL_BOX_BORDER_WIDTH_TEST
			horizontal_box_disable_item_expand_test: HORIZONTAL_BOX_DISABLE_ITEM_EXPAND_TEST
			vertical_box_border_width_test: VERTICAL_BOX_BORDER_WIDTH_TEST
			horizontal_split_area_extend_test: HORIZONTAL_SPLIT_AREA_EXTEND_TEST
			vertical_split_area_extend_test: VERTICAL_SPLIT_AREA_EXTEND_TEST
			horizontal_split_area_single_child_test: HORIZONTAL_SPLIT_AREA_SINGLE_CHILD_TEST
			vertical_split_area_single_child_test: VERTICAL_SPLIT_AREA_SINGLE_CHILD_TEST
			check_button_simple_test: CHECK_BUTTON_SIMPLE_TEST
			check_button_select_actions_test: CHECK_BUTTON_SELECT_ACTIONS_TEST
			combo_box_simple_test: COMBO_BOX_SIMPLE_TEST
			combo_box_pixmap_test: COMBO_BOX_PIXMAP_TEST
			list_basic_test: LIST_BASIC_TEST
			list_pixmap_test: LIST_PIXMAP_TEST
			list_multiple_selection_test: LIST_MULTIPLE_SELECTION_TEST
			password_field_basic_test: PASSWORD_FIELD_BASIC_TEST
			password_field_validate_entry_test: PASSWORD_FIELD_VALIDATE_ENTRY_TEST
			toggle_button_is_toggled_test: TOGGLE_BUTTON_IS_SELECTED_TEST
			toggle_button_pixmap_test: TOGGLE_BUTTON_PIXMAP_TEST
			frame_basic_test: FRAME_BASIC_TEST
			frame_text_alignment_test: FRAME_TEXT_ALIGNMENT_TEST
			frame_style_test: FRAME_STYLE_TEST
			scrollable_area_small_item_test: SCROLLABLE_AREA_SMALL_ITEM_TEST
			scrollable_area_large_item_test: SCROLLABLE_AREA_LARGE_ITEM_TEST
			viewport_small_item_test: VIEWPORT_SMALL_ITEM_TEST
			viewport_small_item_move_test: VIEWPORT_OFFSET_TEST
			viewport_advanced_offset_test: VIEWPORT_ADVANCED_OFFSET_TEST
			table_single_child: TABLE_SINGLE_CHILD_TEST
			table_three_children_test: TABLE_THREE_CHILDREN_TEST
			table_many_children_test: TABLE_MANY_CHILDREN_TEST
			table_spacing_test: TABLE_SPACING_TEST
			radio_button_basic_test: RADIO_BUTTON_BASIC_TEST
			radio_button_multiple_test: RADIO_BUTTON_MULTIPLE_TEST
			radio_button_grouping_test: RADIO_BUTTON_GROUPING_TEST
			radio_button_selected_test: RADIO_BUTTON_SELECTED_TEST
			horizontal_separator_basic_test: HORIZONTAL_SEPARATOR_BASIC_TEST
			vertical_separator_basic_test: VERTICAL_SEPARATOR_BASIC_TEST
			horizontal_progress_bar_simple_test: HORIZONTAL_PROGRESS_BAR_SIMPLE_TEST
			vertical_progress_bar_simple_test: VERTICAL_PROGRESS_BAR_SIMPLE_TEST
			vertical_progress_bar_segmentation_test: VERTICAL_PROGRESS_BAR_SEGMENTATION_TEST
			horizontal_progress_bar_adjusting_test: HORIZONTAL_PROGRESS_BAR_ADJUSTING_TEST
			vertical_progress_bar_adjusting_test: VERTICAL_PROGRESS_BAR_ADJUSTING_TEST
			horizontal_range_bar_simple_test: HORIZONTAL_RANGE_SIMPLE_TEST
			horizontal_range_value_test: HORIZONTAL_RANGE_VALUE_TEST
			horizontal_progress_bar_segmentation_test: HORIZONTAL_PROGRESS_BAR_SEGMENTATION_TEST
			vertical_range_bar_simple_test: VERTICAL_RANGE_SIMPLE_TEST
			vertical_range_value_test: VERTICAL_RANGE_VALUE_TEST
			horizontal_range_bar_adjusting_test: HORIZONTAL_RANGE_ADJUSTING_TEST
			vertical_range_bar_adjusting_test: VERTICAL_RANGE_ADJUSTING_TEST
			horizontal_scroll_bar_bar_simple_test: HORIZONTAL_SCROLL_BAR_SIMPLE_TEST
			vertical_scroll_bar_bar_simple_test: VERTICAL_SCROLL_BAR_SIMPLE_TEST
			horizontal_scroll_bar_bar_adjusting_test: HORIZONTAL_SCROLL_BAR_ADJUSTING_TEST
			horizontal_scroll_bar_value_test: HORIZONTAL_SCROLL_BAR_VALUE_TEST
			vertical_scroll_bar_bar_adjusting_test: VERTICAL_SCROLL_BAR_ADJUSTING_TEST
			vertical_scroll_bar_value_test: VERTICAL_SCROLL_BAR_VALUE_TEST
			tree_basic_test: TREE_BASIC_TEST
			tree_expand_test: TREE_EXPAND_TEST
			tree_dynamic_test: TREE_DYNAMIC_TEST
			tree_pixmap_test: TREE_PIXMAP_TEST
			multi_column_list_basic_test: MULTI_COLUMN_LIST_BASIC_TEST
			multi_column_list_column_resizing_test: MULTI_COLUMN_LIST_COLUMN_RESIZING_TEST
			multi_column_list_pixmap_test: MULTI_COLUMN_LIST_PIXMAP_TEST
			multi_column_list_multiple_selection_test: MULTI_COLUMN_LIST_MULTIPLE_SELECTION_TEST
			text_field_basic_test: TEXT_FIELD_BASIC_TEST
			text_field_validate_entry_test: TEXT_FIELD_VALIDATE_ENTRY_TEST
			spin_button_basic_test: SPIN_BUTTON_BASIC_TEST
			spin_button_range_test: SPIN_BUTTON_RANGE_TEST
			tool_bar_basic_test: TOOL_BAR_BASIC_TEST
			tool_bar_pixmap_test: TOOL_BAR_PIXMAP_TEST
			tool_bar_radio_button_test: TOOL_BAR_RADIO_BUTTON_TEST
			tool_bar_toggle_button_test: TOOL_BAR_TOGGLE_BUTTON_TEST
			tool_bar_combo_box_test: TOOL_BAR_COMBO_BOX_TEST
			checkable_list_test: CHECKABLE_LIST_BASIC_TEST
			checkable_list_pixmap_test: CHECKABLE_LIST_PIXMAP_TEST
			pixmap_basic_test: PIXMAP_BASIC_TEST
			pixmap_drawing_test: PIXMAP_DRAWING_TEST
			pixmap_figure_string_size_test: PIXMAP_FIGURE_STRING_SIZE_TEST
			text_basic_test: TEXT_BASIC_TEST
			rich_text_basic_test: RICH_TEXT_BASIC_TEST
			rich_text_buffering_test: RICH_TEXT_BUFFERING_TEST
			rich_text_tab_test: RICH_TEXT_TAB_TEST
			rich_text_formatting_test: RICH_TEXT_FORMATTING_TEST
			test_scroll_to_line_test: TEXT_SCROLL_TO_LINE_TEST
			cell_background_pixmap_test: CELL_BACKGROUND_PIXMAP_TEST
			cell_basic_test: CELL_BASIC_TEST
			cell_as_padding_test: CELL_AS_PADDING_TEST
			drawing_area_simple_drawing_test: DRAWING_AREA_SIMPLE_DRAWING_TEST
			drawing_area_expose_actions_test: DRAWING_AREA_EXPOSE_ACTIONS_TEST
			drawing_area_clipped_test: DRAWING_AREA_CLIPPED_TEST
			checkable_tree_basic_test: CHECKABLE_TREE_BASIC_TEST
			checkable_tree_advanced_test: CHECKABLE_TREE_ADVANCED_TEST
			header_basic_test: HEADER_BASIC_TEST
			header_resizing_test: HEADER_RESIZING_TEST
			header_resize_to_content_test: HEADER_RESIZE_TO_CONTENT_TEST
			grid_basic_test: GRID_BASIC_TEST
			grid_tree_test: GRID_TREE_TEST
			grid_row_height: GRID_ROW_HEIGHT_TEST
			grid_colors_test: GRID_COLORS_TEST
			grid_texture_test: GRID_TEXTURE_TEST
			grid_icon_test: GRID_ICON_VIEW_TEST
			grid_dynamic_test: GRID_DYNAMIC_TEST
			grid_separator_test: GRID_SEPARATOR_TEST
			grid_pixmap_test: GRID_PIXMAP_TEST
			grid_drawable_test: GRID_DRAWABLE_TEST
			grid_dynamic_tree_test: GRID_DYNAMIC_TREE_TEST
			grid_draw_tree_test: GRID_DRAW_TREE_TEST
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class WIDGET_TEST_INCLUDE
