indexing
	description: "Objects that include all test necessary for compilation."
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
			button_select_actions_test: BUTTON_SELECT_ACTIONS_TEST
			label_basic_test: LABEL_BASIC_TEST
			label_text_alignment_test: LABEL_TEXT_ALIGNMENT_TEST
			label_multi_line_test: LABEL_MULTI_LINE_TEST
			notebook_extend_test: NOTEBOOK_EXTEND_TEST
			notebook_item_text_test: NOTEBOOK_ITEM_TEXT_TEST
			notebook_tab_position_test: NOTEBOOK_TAB_POSITION_TEST
			notebook_selection_actions_test: NOTEBOOK_SELECTION_ACTIONS_TEST
			horizontal_box_padding_width_test: HORIZONTAL_BOX_PADDING_WIDTH_TEST
			vertical_box_padding_width_test: VERTICAL_BOX_PADDING_WIDTH_TEST
			horizontal_box_border_width_test: HORIZONTAL_BOX_BORDER_WIDTH_TEST
			vertical_box_border_width_test: VERTICAL_BOX_BORDER_WIDTH_TEST
			horizontal_split_area_extend_test: HORIZONTAL_SPLIT_AREA_EXTEND_TEST
			vertical_split_area_extend_test: VERTICAL_SPLIT_AREA_EXTEND_TEST
			check_button_simple_test: CHECK_BUTTON_SIMPLE_TEST
			check_button_select_actions_test: CHECK_BUTTON_SELECT_ACTIONS_TEST
			combo_box_simple_test: COMBO_BOX_SIMPLE_TEST
			list_basic_test: LIST_BASIC_TEST
			password_field_basic_test: PASSWORD_FIELD_BASIC_TEST
			password_field_validate_entry_test: PASSWORD_FIELD_VALIDATE_ENTRY_TEST
			toggle_button_is_toggled_test: TOGGLE_BUTTON_IS_SELECTED_TEST
			frame_basic_test: FRAME_BASIC_TEST
			frame_text_alignment_test: FRAME_TEXT_ALIGNMENT_TEST
			frame_style_test: FRAME_STYLE_TEST
			scrollable_area_small_item_test: SCROLLABLE_AREA_SMALL_ITEM_TEST
			scrollable_area_large_item_test: SCROLLABLE_AREA_LARGE_ITEM_TEST
			viewport_small_item_test: VIEWPORT_SMALL_ITEM_TEST
			viewport_small_item_move_test: VIEWPORT_OFFSET_TEST
			table_single_child: TABLE_SINGLE_CHILD_TEST
			table_three_children_test: TABLE_THREE_CHILDREN_TEST
			table_spacing_test: TABLE_SPACING_TEST
			radio_button_basic_test: RADIO_BUTTON_BASIC_TEST
			radio_button_multiple_test: RADIO_BUTTON_MULTIPLE_TEST
			radio_button_grouping_test: RADIO_BUTTON_GROUPING_TEST
			radio_button_selected_test: RADIO_BUTTON_SELECTED_TEST
			horizontal_separator_basic_test: HORIZONTAL_SEPARATOR_BASIC_TEST
			vertical_separator_basic_test: VERTICAL_SEPARATOR_BASIC_TEST
		do
		end

end -- class WIDGET_TEST_INCLUDE
