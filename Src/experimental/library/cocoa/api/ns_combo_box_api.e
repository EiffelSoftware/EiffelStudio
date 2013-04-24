note
	description: "Summary description for {NS_COMBO_BOX_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMBO_BOX_API

feature -- Objective-C implementation

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSComboBox new];"
		end

	frozen has_vertical_scroller (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box hasVerticalScroller];"
		end

	frozen set_has_vertical_scroller (a_combo_box: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setHasVerticalScroller: $a_flag];"
		end

	frozen intercell_spacing (a_combo_box: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSComboBox*)$a_combo_box intercellSpacing]; memcpy($a_res, &size, sizeof(NSSize));"
		end

	frozen set_intercell_spacing (a_combo_box: POINTER; a_size: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setIntercellSpacing: *(NSSize*)$a_size];"
		end

	frozen item_height (a_combo_box: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box itemHeight];"
		end

	frozen set_item_height (a_combo_box: POINTER; a_item_height: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setItemHeight: $a_item_height];"
		end

	frozen number_of_visible_items (a_combo_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box numberOfVisibleItems];"
		end

	frozen set_number_of_visible_items (a_combo_box: POINTER; a_visible_items: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setNumberOfVisibleItems: $a_visible_items];"
		end

	frozen set_button_bordered (a_combo_box: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setButtonBordered: $a_flag];"
		end

	frozen is_button_bordered (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box isButtonBordered];"
		end

	frozen reload_data (a_combo_box: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box reloadData];"
		end

	frozen note_number_of_items_changed (a_combo_box: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box noteNumberOfItemsChanged];"
		end

	frozen set_uses_data_source (a_combo_box: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setUsesDataSource: $a_flag];"
		end

	frozen uses_data_source (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box usesDataSource];"
		end

	frozen scroll_item_at_index_to_top (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box scrollItemAtIndexToTop: $a_index];"
		end

	frozen scroll_item_at_index_to_visible (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box scrollItemAtIndexToVisible: $a_index];"
		end

	frozen select_item_at_index (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box selectItemAtIndex: $a_index];"
		end

	frozen deselect_item_at_index (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box deselectItemAtIndex: $a_index];"
		end

	frozen index_of_selected_item (a_combo_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box indexOfSelectedItem];"
		end

	frozen number_of_items (a_combo_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box numberOfItems];"
		end

	frozen completes (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box completes];"
		end

	frozen set_completes (a_combo_box: POINTER; a_completes: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setCompletes: $a_completes];"
		end

	frozen data_source (a_combo_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box dataSource];"
		end

	frozen set_data_source (a_combo_box: POINTER; a_a_source: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setDataSource: $a_a_source];"
		end

	frozen add_item_with_object_value (a_combo_box: POINTER; a_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box addItemWithObjectValue: $a_object];"
		end

	frozen add_items_with_object_values (a_combo_box: POINTER; a_objects: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box addItemsWithObjectValues: $a_objects];"
		end

	frozen insert_item_with_object_value_at_index (a_combo_box: POINTER; a_object: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box insertItemWithObjectValue: $a_object atIndex: $a_index];"
		end

	frozen remove_item_with_object_value (a_combo_box: POINTER; a_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box removeItemWithObjectValue: $a_object];"
		end

	frozen remove_item_at_index (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box removeItemAtIndex: $a_index];"
		end

	frozen remove_all_items (a_combo_box: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box removeAllItems];"
		end

	frozen select_item_with_object_value (a_combo_box: POINTER; a_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box selectItemWithObjectValue: $a_object];"
		end

	frozen item_object_value_at_index (a_combo_box: POINTER; a_index: INTEGER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box itemObjectValueAtIndex: $a_index];"
		end

	frozen object_value_of_selected_item (a_combo_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box objectValueOfSelectedItem];"
		end

	frozen index_of_item_with_object_value (a_combo_box: POINTER; a_object: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box indexOfItemWithObjectValue: $a_object];"
		end

	frozen object_values (a_combo_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box objectValues];"
		end
end
