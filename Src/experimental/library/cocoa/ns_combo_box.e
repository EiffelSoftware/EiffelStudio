note
	description: "Wrapper for NSComboBox."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMBO_BOX

inherit
	NS_TEXT_FIELD
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer (combo_box_new)
		end

feature

	has_vertical_scroller: BOOLEAN
		do
			Result := combo_box_has_vertical_scroller (item)
		end

	set_has_vertical_scroller (a_flag: BOOLEAN)
		do
			combo_box_set_has_vertical_scroller (item, a_flag)
		end

	intercell_spacing: NS_SIZE
		do
			create Result.make
			combo_box_intercell_spacing (item, Result.item)
		end

	set_intercell_spacing (a_size: NS_SIZE)
		do
			combo_box_set_intercell_spacing (item, a_size.item)
		end

	item_height: REAL
		do
			Result := combo_box_item_height (item)
		end

	set_item_height (a_item_height: REAL)
		do
			combo_box_set_item_height (item, a_item_height)
		end

	number_of_visible_items: INTEGER
		do
			Result := combo_box_number_of_visible_items (item)
		end

	set_number_of_visible_items (a_visible_items: INTEGER)
		do
			combo_box_set_number_of_visible_items (item, a_visible_items)
		end

	set_button_bordered (a_flag: BOOLEAN)
		do
			combo_box_set_button_bordered (item, a_flag)
		end

	is_button_bordered: BOOLEAN
		do
			Result := combo_box_is_button_bordered (item)
		end

	reload_data
		do
			combo_box_reload_data (item)
		end

	note_number_of_items_changed
		do
			combo_box_note_number_of_items_changed (item)
		end

	set_uses_data_source (a_flag: BOOLEAN)
		do
			combo_box_set_uses_data_source (item, a_flag)
		end

	uses_data_source: BOOLEAN
		do
			Result := combo_box_uses_data_source (item)
		end

	scroll_item_at_index_to_top (a_index: INTEGER)
		do
			combo_box_scroll_item_at_index_to_top (item, a_index)
		end

	scroll_item_at_index_to_visible (a_index: INTEGER)
		do
			combo_box_scroll_item_at_index_to_visible (item, a_index)
		end

	select_item_at_index (a_index: INTEGER)
		do
			combo_box_select_item_at_index (item, a_index)
		end

	deselect_item_at_index (a_index: INTEGER)
		do
			combo_box_deselect_item_at_index (item, a_index)
		end

	index_of_selected_item: INTEGER
		do
			Result := combo_box_index_of_selected_item (item)
		end

	number_of_items: INTEGER
		do
			Result := combo_box_number_of_items (item)
		end

	completes: BOOLEAN
		do
			Result := combo_box_completes (item)
		end

	set_completes (a_completes: BOOLEAN)
		do
			combo_box_set_completes (item, a_completes)
		end

	data_source: NS_OBJECT
		do
			Result := create {NS_OBJECT}.share_from_pointer (combo_box_data_source (item))
		end

	set_data_source (a_a_source: NS_OBJECT)
		do
			combo_box_set_data_source (item, a_a_source.item)
		end

	add_item_with_object_value (a_object: NS_OBJECT)
		do
			combo_box_add_item_with_object_value (item, a_object.item)
		end

	add_items_with_object_values (a_objects: NS_ARRAY[NS_OBJECT])
		do
			combo_box_add_items_with_object_values (item, a_objects.object_item)
		end

	insert_item_with_object_value_at_index (a_object: NS_OBJECT; a_index: INTEGER)
			-- Cocoa accepts an (id) type, but what does it actually display?
		do
			combo_box_insert_item_with_object_value_at_index (item, a_object.item, a_index)
		end

	remove_item_with_object_value (a_object: NS_OBJECT)
		do
			combo_box_remove_item_with_object_value (item, a_object.item)
		end

	remove_item_at_index (a_index: INTEGER)
		do
			combo_box_remove_item_at_index (item, a_index)
		end

	remove_all_items
		do
			combo_box_remove_all_items (item)
		end

	select_item_with_object_value (a_object: NS_OBJECT)
		do
			combo_box_select_item_with_object_value (item, a_object.item)
		end

	item_object_value_at_index (a_index: INTEGER): NS_OBJECT
		do
			Result := create {NS_OBJECT}.share_from_pointer (combo_box_item_object_value_at_index (item, a_index))
		end

	object_value_of_selected_item: NS_OBJECT
		do
			Result := create {NS_OBJECT}.share_from_pointer (combo_box_object_value_of_selected_item (item))
		end

	index_of_item_with_object_value (a_object: NS_OBJECT): INTEGER
		do
			Result := combo_box_index_of_item_with_object_value (item, a_object.item)
		end

--	object_values: NS_ARRAY[NS_OBJECT]
--		do
--			Result := combo_box_object_values (cocoa_object)
--		end

feature {NONE} -- Objective-C implementation

	frozen combo_box_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSComboBox new];"
		end

	frozen combo_box_has_vertical_scroller (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box hasVerticalScroller];"
		end

	frozen combo_box_set_has_vertical_scroller (a_combo_box: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setHasVerticalScroller: $a_flag];"
		end

	frozen combo_box_intercell_spacing (a_combo_box: POINTER; a_res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"NSSize size = [(NSComboBox*)$a_combo_box intercellSpacing]; memcpy($a_res, &size, sizeof(NSSize));"
		end

	frozen combo_box_set_intercell_spacing (a_combo_box: POINTER; a_size: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setIntercellSpacing: *(NSSize*)$a_size];"
		end

	frozen combo_box_item_height (a_combo_box: POINTER): REAL
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box itemHeight];"
		end

	frozen combo_box_set_item_height (a_combo_box: POINTER; a_item_height: REAL)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setItemHeight: $a_item_height];"
		end

	frozen combo_box_number_of_visible_items (a_combo_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box numberOfVisibleItems];"
		end

	frozen combo_box_set_number_of_visible_items (a_combo_box: POINTER; a_visible_items: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setNumberOfVisibleItems: $a_visible_items];"
		end

	frozen combo_box_set_button_bordered (a_combo_box: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setButtonBordered: $a_flag];"
		end

	frozen combo_box_is_button_bordered (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box isButtonBordered];"
		end

	frozen combo_box_reload_data (a_combo_box: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box reloadData];"
		end

	frozen combo_box_note_number_of_items_changed (a_combo_box: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box noteNumberOfItemsChanged];"
		end

	frozen combo_box_set_uses_data_source (a_combo_box: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setUsesDataSource: $a_flag];"
		end

	frozen combo_box_uses_data_source (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box usesDataSource];"
		end

	frozen combo_box_scroll_item_at_index_to_top (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box scrollItemAtIndexToTop: $a_index];"
		end

	frozen combo_box_scroll_item_at_index_to_visible (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box scrollItemAtIndexToVisible: $a_index];"
		end

	frozen combo_box_select_item_at_index (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box selectItemAtIndex: $a_index];"
		end

	frozen combo_box_deselect_item_at_index (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box deselectItemAtIndex: $a_index];"
		end

	frozen combo_box_index_of_selected_item (a_combo_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box indexOfSelectedItem];"
		end

	frozen combo_box_number_of_items (a_combo_box: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box numberOfItems];"
		end

	frozen combo_box_completes (a_combo_box: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box completes];"
		end

	frozen combo_box_set_completes (a_combo_box: POINTER; a_completes: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setCompletes: $a_completes];"
		end

	frozen combo_box_data_source (a_combo_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box dataSource];"
		end

	frozen combo_box_set_data_source (a_combo_box: POINTER; a_a_source: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box setDataSource: $a_a_source];"
		end

	frozen combo_box_add_item_with_object_value (a_combo_box: POINTER; a_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box addItemWithObjectValue: $a_object];"
		end

	frozen combo_box_add_items_with_object_values (a_combo_box: POINTER; a_objects: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box addItemsWithObjectValues: $a_objects];"
		end

	frozen combo_box_insert_item_with_object_value_at_index (a_combo_box: POINTER; a_object: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box insertItemWithObjectValue: $a_object atIndex: $a_index];"
		end

	frozen combo_box_remove_item_with_object_value (a_combo_box: POINTER; a_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box removeItemWithObjectValue: $a_object];"
		end

	frozen combo_box_remove_item_at_index (a_combo_box: POINTER; a_index: INTEGER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box removeItemAtIndex: $a_index];"
		end

	frozen combo_box_remove_all_items (a_combo_box: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box removeAllItems];"
		end

	frozen combo_box_select_item_with_object_value (a_combo_box: POINTER; a_object: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSComboBox*)$a_combo_box selectItemWithObjectValue: $a_object];"
		end

	frozen combo_box_item_object_value_at_index (a_combo_box: POINTER; a_index: INTEGER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box itemObjectValueAtIndex: $a_index];"
		end

	frozen combo_box_object_value_of_selected_item (a_combo_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box objectValueOfSelectedItem];"
		end

	frozen combo_box_index_of_item_with_object_value (a_combo_box: POINTER; a_object: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box indexOfItemWithObjectValue: $a_object];"
		end

	frozen combo_box_object_values (a_combo_box: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSComboBox*)$a_combo_box objectValues];"
		end
end
