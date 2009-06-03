note
	description: "Summary description for {NS_COMBO_BOX_DELEGATE}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_COMBO_BOX_DELEGATE

inherit
	NS_OBJECT

feature -- Access

--	number_of_items_in_combo_box (a_a_combo_box: NS_COMBO_BOX): INTEGER
--		do
--			Result := combo_box_number_of_items_in_combo_box (cocoa_object, a_a_combo_box.cocoa_object)
--		end

--	combo_box_object_value_for_item_at_index (a_combo_box: NS_COMBO_BOX; a_index: INTEGER): NS_OBJECT
--		do
--			Result := create {NS_OBJECT}.make_shared(combo_box_combo_box_object_value_for_item_at_index (cocoa_object, a_combo_box.cocoa_object, a_index))
--		end

--	combo_box_index_of_item_with_string_value (a_combo_box: NS_COMBO_BOX; a_string: NS_STRING): INTEGER
--			-- todo: actually return NS_U_INTEGER
--		do
--			Result := combo_box_combo_box_index_of_item_with_string_value (cocoa_object, a_combo_box.cocoa_object, a_string.cocoa_object)
--		end

--	combo_box_completed_string (a_a_combo_box: NS_COMBO_BOX; a_string: NS_STRING): STRING
--		do
--			Result := (create {NS_STRING}.make_shared (combo_box_combo_box_completed_string (cocoa_object, a_combo_box.cocoa_object, a_string.cocoa_object))).to_string
--		end

feature {NONE} -- Implementation

--	frozen combo_box_number_of_items_in_combo_box (a_combo_box: POINTER; a_a_combo_box: POINTER): INTEGER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSComboBox*)$a_combo_box numberOfItemsInComboBox: $a_a_combo_box];"
--		end

--	frozen combo_box_combo_box_object_value_for_item_at_index (a_combo_box: POINTER; a_a_combo_box: POINTER; a_index: INTEGER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSComboBox*)$a_combo_box comboBox: $a_a_combo_box objectValueForItemAtIndex: $a_index];"
--		end

--	frozen combo_box_combo_box_index_of_item_with_string_value (a_combo_box: POINTER; a_a_combo_box: POINTER; a_string: POINTER): INTEGER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSComboBox*)$a_combo_box comboBox: $a_a_combo_box indexOfItemWithStringValue: $a_string];"
--		end

--	frozen combo_box_combo_box_completed_string (a_combo_box: POINTER; a_a_combo_box: POINTER; a_string: POINTER): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSComboBox*)$a_combo_box comboBox: $a_a_combo_box completedString: $a_string];"
--		end
end
