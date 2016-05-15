note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMBO_BOX

inherit
	NS_TEXT_FIELD
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSComboBox

	has_vertical_scroller: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_vertical_scroller (item)
		end

	set_has_vertical_scroller_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_has_vertical_scroller_ (item, a_flag)
		end

	intercell_spacing: NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_intercell_spacing (item, Result.item)
		end

	set_intercell_spacing_ (a_size: NS_SIZE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_intercell_spacing_ (item, a_size.item)
		end

	item_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_item_height (item)
		end

	set_item_height_ (a_item_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_item_height_ (item, a_item_height)
		end

	number_of_visible_items: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_visible_items (item)
		end

	set_number_of_visible_items_ (a_visible_items: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_number_of_visible_items_ (item, a_visible_items)
		end

	set_button_bordered_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_button_bordered_ (item, a_flag)
		end

	is_button_bordered: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_button_bordered (item)
		end

	reload_data
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reload_data (item)
		end

	note_number_of_items_changed
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_note_number_of_items_changed (item)
		end

	set_uses_data_source_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_data_source_ (item, a_flag)
		end

	uses_data_source: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_data_source (item)
		end

	scroll_item_at_index_to_top_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_item_at_index_to_top_ (item, a_index)
		end

	scroll_item_at_index_to_visible_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_scroll_item_at_index_to_visible_ (item, a_index)
		end

	select_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_select_item_at_index_ (item, a_index)
		end

	deselect_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_deselect_item_at_index_ (item, a_index)
		end

	index_of_selected_item: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_index_of_selected_item (item)
		end

	number_of_items: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_items (item)
		end

	completes: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_completes (item)
		end

	set_completes_ (a_completes: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_completes_ (item, a_completes)
		end

	data_source: detachable NS_COMBO_BOX_DATA_SOURCE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_data_source (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like data_source} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like data_source} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_data_source_ (a_source: detachable NS_COMBO_BOX_DATA_SOURCE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_source__item: POINTER
		do
			if attached a_source as a_source_attached then
				a_source__item := a_source_attached.item
			end
			objc_set_data_source_ (item, a_source__item)
		end

	add_item_with_object_value_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_add_item_with_object_value_ (item, a_object__item)
		end

	add_items_with_object_values_ (a_objects: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_objects__item: POINTER
		do
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			objc_add_items_with_object_values_ (item, a_objects__item)
		end

	insert_item_with_object_value__at_index_ (a_object: detachable NS_OBJECT; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_insert_item_with_object_value__at_index_ (item, a_object__item, a_index)
		end

	remove_item_with_object_value_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_remove_item_with_object_value_ (item, a_object__item)
		end

	remove_item_at_index_ (a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_item_at_index_ (item, a_index)
		end

	remove_all_items
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_items (item)
		end

	select_item_with_object_value_ (a_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_select_item_with_object_value_ (item, a_object__item)
		end

	item_object_value_at_index_ (a_index: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_item_object_value_at_index_ (item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like item_object_value_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like item_object_value_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	object_value_of_selected_item: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_value_of_selected_item (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_value_of_selected_item} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_value_of_selected_item} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	index_of_item_with_object_value_ (a_object: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_index_of_item_with_object_value_ (item, a_object__item)
		end

	object_values: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_values (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_values} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_values} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSComboBox Externals

	objc_has_vertical_scroller (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item hasVerticalScroller];
			 ]"
		end

	objc_set_has_vertical_scroller_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setHasVerticalScroller:$a_flag];
			 ]"
		end

	objc_intercell_spacing (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSComboBox *)$an_item intercellSpacing];
			 ]"
		end

	objc_set_intercell_spacing_ (an_item: POINTER; a_size: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setIntercellSpacing:*((NSSize *)$a_size)];
			 ]"
		end

	objc_item_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item itemHeight];
			 ]"
		end

	objc_set_item_height_ (an_item: POINTER; a_item_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setItemHeight:$a_item_height];
			 ]"
		end

	objc_number_of_visible_items (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item numberOfVisibleItems];
			 ]"
		end

	objc_set_number_of_visible_items_ (an_item: POINTER; a_visible_items: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setNumberOfVisibleItems:$a_visible_items];
			 ]"
		end

	objc_set_button_bordered_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setButtonBordered:$a_flag];
			 ]"
		end

	objc_is_button_bordered (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item isButtonBordered];
			 ]"
		end

	objc_reload_data (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item reloadData];
			 ]"
		end

	objc_note_number_of_items_changed (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item noteNumberOfItemsChanged];
			 ]"
		end

	objc_set_uses_data_source_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setUsesDataSource:$a_flag];
			 ]"
		end

	objc_uses_data_source (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item usesDataSource];
			 ]"
		end

	objc_scroll_item_at_index_to_top_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item scrollItemAtIndexToTop:$a_index];
			 ]"
		end

	objc_scroll_item_at_index_to_visible_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item scrollItemAtIndexToVisible:$a_index];
			 ]"
		end

	objc_select_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item selectItemAtIndex:$a_index];
			 ]"
		end

	objc_deselect_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item deselectItemAtIndex:$a_index];
			 ]"
		end

	objc_index_of_selected_item (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item indexOfSelectedItem];
			 ]"
		end

	objc_number_of_items (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item numberOfItems];
			 ]"
		end

	objc_completes (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item completes];
			 ]"
		end

	objc_set_completes_ (an_item: POINTER; a_completes: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setCompletes:$a_completes];
			 ]"
		end

	objc_data_source (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComboBox *)$an_item dataSource];
			 ]"
		end

	objc_set_data_source_ (an_item: POINTER; a_source: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item setDataSource:$a_source];
			 ]"
		end

	objc_add_item_with_object_value_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item addItemWithObjectValue:$a_object];
			 ]"
		end

	objc_add_items_with_object_values_ (an_item: POINTER; a_objects: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item addItemsWithObjectValues:$a_objects];
			 ]"
		end

	objc_insert_item_with_object_value__at_index_ (an_item: POINTER; a_object: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item insertItemWithObjectValue:$a_object atIndex:$a_index];
			 ]"
		end

	objc_remove_item_with_object_value_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item removeItemWithObjectValue:$a_object];
			 ]"
		end

	objc_remove_item_at_index_ (an_item: POINTER; a_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item removeItemAtIndex:$a_index];
			 ]"
		end

	objc_remove_all_items (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item removeAllItems];
			 ]"
		end

	objc_select_item_with_object_value_ (an_item: POINTER; a_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSComboBox *)$an_item selectItemWithObjectValue:$a_object];
			 ]"
		end

	objc_item_object_value_at_index_ (an_item: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComboBox *)$an_item itemObjectValueAtIndex:$a_index];
			 ]"
		end

	objc_object_value_of_selected_item (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComboBox *)$an_item objectValueOfSelectedItem];
			 ]"
		end

	objc_index_of_item_with_object_value_ (an_item: POINTER; a_object: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSComboBox *)$an_item indexOfItemWithObjectValue:$a_object];
			 ]"
		end

	objc_object_values (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSComboBox *)$an_item objectValues];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSComboBox"
		end

end
