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
			notebook_extend_test: NOTEBOOK_EXTEND_TEST
			notebook_item_text_test: NOTEBOOK_ITEM_TEXT_TEST
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
		do
		end

end -- class WIDGET_TEST_INCLUDE
