note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_COMBO_BOX_CELL_DATA_SOURCE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Optional Methods

	number_of_items_in_combo_box_cell_ (a_combo_box_cell: detachable NS_COMBO_BOX_CELL): INTEGER_64
			-- Auto generated Objective-C wrapper.
		require
			has_number_of_items_in_combo_box_cell_: has_number_of_items_in_combo_box_cell_
		local
			a_combo_box_cell__item: POINTER
		do
			if attached a_combo_box_cell as a_combo_box_cell_attached then
				a_combo_box_cell__item := a_combo_box_cell_attached.item
			end
			Result := objc_number_of_items_in_combo_box_cell_ (item, a_combo_box_cell__item)
		end

	combo_box_cell__object_value_for_item_at_index_ (a_combo_box_cell: detachable NS_COMBO_BOX_CELL; a_index: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_cell__object_value_for_item_at_index_: has_combo_box_cell__object_value_for_item_at_index_
		local
			result_pointer: POINTER
			a_combo_box_cell__item: POINTER
		do
			if attached a_combo_box_cell as a_combo_box_cell_attached then
				a_combo_box_cell__item := a_combo_box_cell_attached.item
			end
			result_pointer := objc_combo_box_cell__object_value_for_item_at_index_ (item, a_combo_box_cell__item, a_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like combo_box_cell__object_value_for_item_at_index_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like combo_box_cell__object_value_for_item_at_index_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	combo_box_cell__index_of_item_with_string_value_ (a_combo_box_cell: detachable NS_COMBO_BOX_CELL; a_string: detachable NS_STRING): NATURAL_64
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_cell__index_of_item_with_string_value_: has_combo_box_cell__index_of_item_with_string_value_
		local
			a_combo_box_cell__item: POINTER
			a_string__item: POINTER
		do
			if attached a_combo_box_cell as a_combo_box_cell_attached then
				a_combo_box_cell__item := a_combo_box_cell_attached.item
			end
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_combo_box_cell__index_of_item_with_string_value_ (item, a_combo_box_cell__item, a_string__item)
		end

	combo_box_cell__completed_string_ (a_combo_box_cell: detachable NS_COMBO_BOX_CELL; a_uncompleted_string: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		require
			has_combo_box_cell__completed_string_: has_combo_box_cell__completed_string_
		local
			result_pointer: POINTER
			a_combo_box_cell__item: POINTER
			a_uncompleted_string__item: POINTER
		do
			if attached a_combo_box_cell as a_combo_box_cell_attached then
				a_combo_box_cell__item := a_combo_box_cell_attached.item
			end
			if attached a_uncompleted_string as a_uncompleted_string_attached then
				a_uncompleted_string__item := a_uncompleted_string_attached.item
			end
			result_pointer := objc_combo_box_cell__completed_string_ (item, a_combo_box_cell__item, a_uncompleted_string__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like combo_box_cell__completed_string_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like combo_box_cell__completed_string_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- Status Report

	has_number_of_items_in_combo_box_cell_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_number_of_items_in_combo_box_cell_ (item)
		end

	has_combo_box_cell__object_value_for_item_at_index_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_cell__object_value_for_item_at_index_ (item)
		end

	has_combo_box_cell__index_of_item_with_string_value_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_cell__index_of_item_with_string_value_ (item)
		end

	has_combo_box_cell__completed_string_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_combo_box_cell__completed_string_ (item)
		end

feature -- Status Report Externals

	objc_has_number_of_items_in_combo_box_cell_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(numberOfItemsInComboBoxCell:)];
			 ]"
		end

	objc_has_combo_box_cell__object_value_for_item_at_index_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxCell:objectValueForItemAtIndex:)];
			 ]"
		end

	objc_has_combo_box_cell__index_of_item_with_string_value_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxCell:indexOfItemWithStringValue:)];
			 ]"
		end

	objc_has_combo_box_cell__completed_string_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(comboBoxCell:completedString:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_number_of_items_in_combo_box_cell_ (an_item: POINTER; a_combo_box_cell: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSComboBoxCellDataSource>)$an_item numberOfItemsInComboBoxCell:$a_combo_box_cell];
			 ]"
		end

	objc_combo_box_cell__object_value_for_item_at_index_ (an_item: POINTER; a_combo_box_cell: POINTER; a_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSComboBoxCellDataSource>)$an_item comboBoxCell:$a_combo_box_cell objectValueForItemAtIndex:$a_index];
			 ]"
		end

	objc_combo_box_cell__index_of_item_with_string_value_ (an_item: POINTER; a_combo_box_cell: POINTER; a_string: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSComboBoxCellDataSource>)$an_item comboBoxCell:$a_combo_box_cell indexOfItemWithStringValue:$a_string];
			 ]"
		end

	objc_combo_box_cell__completed_string_ (an_item: POINTER; a_combo_box_cell: POINTER; a_uncompleted_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSComboBoxCellDataSource>)$an_item comboBoxCell:$a_combo_box_cell completedString:$a_uncompleted_string];
			 ]"
		end

end
