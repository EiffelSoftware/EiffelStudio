note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_RULE_EDITOR

inherit
	NS_CONTROL
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_frame_,
	make

feature -- NSRuleEditor

	set_delegate_ (a_delegate: detachable NS_RULE_EDITOR_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_RULE_EDITOR_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_formatting_strings_filename_ (a_strings_filename: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_strings_filename__item: POINTER
		do
			if attached a_strings_filename as a_strings_filename_attached then
				a_strings_filename__item := a_strings_filename_attached.item
			end
			objc_set_formatting_strings_filename_ (item, a_strings_filename__item)
		end

	formatting_strings_filename: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_formatting_strings_filename (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like formatting_strings_filename} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like formatting_strings_filename} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_formatting_dictionary_ (a_dictionary: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_dictionary__item: POINTER
		do
			if attached a_dictionary as a_dictionary_attached then
				a_dictionary__item := a_dictionary_attached.item
			end
			objc_set_formatting_dictionary_ (item, a_dictionary__item)
		end

	formatting_dictionary: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_formatting_dictionary (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like formatting_dictionary} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like formatting_dictionary} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reload_criteria
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reload_criteria (item)
		end

	set_nesting_mode_ (a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_nesting_mode_ (item, a_mode)
		end

	nesting_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_nesting_mode (item)
		end

	set_row_height_ (a_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_row_height_ (item, a_height)
		end

	row_height: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_row_height (item)
		end

	set_editable_ (a_editable: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_editable_ (item, a_editable)
		end

	is_editable: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_editable (item)
		end

	set_can_remove_all_rows_ (a_val: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_can_remove_all_rows_ (item, a_val)
		end

	can_remove_all_rows: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_remove_all_rows (item)
		end

	predicate: detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_predicate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	reload_predicate
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_reload_predicate (item)
		end

	predicate_for_row_ (a_row: INTEGER_64): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_predicate_for_row_ (item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_for_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_for_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	number_of_rows: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_rows (item)
		end

	subrow_indexes_for_row_ (a_row_index: INTEGER_64): detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subrow_indexes_for_row_ (item, a_row_index)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subrow_indexes_for_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subrow_indexes_for_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	criteria_for_row_ (a_row: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_criteria_for_row_ (item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like criteria_for_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like criteria_for_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	display_values_for_row_ (a_row: INTEGER_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_display_values_for_row_ (item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_values_for_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_values_for_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	row_for_display_value_ (a_display_value: detachable NS_OBJECT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_display_value__item: POINTER
		do
			if attached a_display_value as a_display_value_attached then
				a_display_value__item := a_display_value_attached.item
			end
			Result := objc_row_for_display_value_ (item, a_display_value__item)
		end

	row_type_for_row_ (a_row_index: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_row_type_for_row_ (item, a_row_index)
		end

	parent_row_for_row_ (a_row_index: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_parent_row_for_row_ (item, a_row_index)
		end

	add_row_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_add_row_ (item, a_sender__item)
		end

	insert_row_at_index__with_type__as_subrow_of_row__animate_ (a_row_index: INTEGER_64; a_row_type: NATURAL_64; a_parent_row: INTEGER_64; a_should_animate: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_insert_row_at_index__with_type__as_subrow_of_row__animate_ (item, a_row_index, a_row_type, a_parent_row, a_should_animate)
		end

	set_criteria__and_display_values__for_row_at_index_ (a_criteria: detachable NS_ARRAY; a_values: detachable NS_ARRAY; a_row_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_criteria__item: POINTER
			a_values__item: POINTER
		do
			if attached a_criteria as a_criteria_attached then
				a_criteria__item := a_criteria_attached.item
			end
			if attached a_values as a_values_attached then
				a_values__item := a_values_attached.item
			end
			objc_set_criteria__and_display_values__for_row_at_index_ (item, a_criteria__item, a_values__item, a_row_index)
		end

	remove_row_at_index_ (a_row_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_row_at_index_ (item, a_row_index)
		end

	remove_rows_at_indexes__include_subrows_ (a_row_indexes: detachable NS_INDEX_SET; a_include_subrows: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_row_indexes__item: POINTER
		do
			if attached a_row_indexes as a_row_indexes_attached then
				a_row_indexes__item := a_row_indexes_attached.item
			end
			objc_remove_rows_at_indexes__include_subrows_ (item, a_row_indexes__item, a_include_subrows)
		end

	selected_row_indexes: detachable NS_INDEX_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_row_indexes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_row_indexes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_row_indexes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	select_row_indexes__by_extending_selection_ (a_indexes: detachable NS_INDEX_SET; a_extend: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			objc_select_row_indexes__by_extending_selection_ (item, a_indexes__item, a_extend)
		end

	set_row_class_ (a_row_class: detachable OBJC_CLASS)
			-- Auto generated Objective-C wrapper.
		local
			a_row_class__item: POINTER
		do
			if attached a_row_class as a_row_class_attached then
				a_row_class__item := a_row_class_attached.item
			end
			objc_set_row_class_ (item, a_row_class__item)
		end

	row_class: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_row_class (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like row_class} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like row_class} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_row_type_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_row_type_key_path_ (item, a_key_path__item)
		end

	row_type_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_row_type_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like row_type_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like row_type_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_subrows_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_subrows_key_path_ (item, a_key_path__item)
		end

	subrows_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_subrows_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like subrows_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like subrows_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_criteria_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_criteria_key_path_ (item, a_key_path__item)
		end

	criteria_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_criteria_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like criteria_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like criteria_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_display_values_key_path_ (a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_display_values_key_path_ (item, a_key_path__item)
		end

	display_values_key_path: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_display_values_key_path (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_values_key_path} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_values_key_path} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSRuleEditor Externals

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item delegate];
			 ]"
		end

	objc_set_formatting_strings_filename_ (an_item: POINTER; a_strings_filename: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setFormattingStringsFilename:$a_strings_filename];
			 ]"
		end

	objc_formatting_strings_filename (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item formattingStringsFilename];
			 ]"
		end

	objc_set_formatting_dictionary_ (an_item: POINTER; a_dictionary: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setFormattingDictionary:$a_dictionary];
			 ]"
		end

	objc_formatting_dictionary (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item formattingDictionary];
			 ]"
		end

	objc_reload_criteria (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item reloadCriteria];
			 ]"
		end

	objc_set_nesting_mode_ (an_item: POINTER; a_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setNestingMode:$a_mode];
			 ]"
		end

	objc_nesting_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item nestingMode];
			 ]"
		end

	objc_set_row_height_ (an_item: POINTER; a_height: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setRowHeight:$a_height];
			 ]"
		end

	objc_row_height (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item rowHeight];
			 ]"
		end

	objc_set_editable_ (an_item: POINTER; a_editable: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setEditable:$a_editable];
			 ]"
		end

	objc_is_editable (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item isEditable];
			 ]"
		end

	objc_set_can_remove_all_rows_ (an_item: POINTER; a_val: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setCanRemoveAllRows:$a_val];
			 ]"
		end

	objc_can_remove_all_rows (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item canRemoveAllRows];
			 ]"
		end

	objc_predicate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item predicate];
			 ]"
		end

	objc_reload_predicate (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item reloadPredicate];
			 ]"
		end

	objc_predicate_for_row_ (an_item: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item predicateForRow:$a_row];
			 ]"
		end

	objc_number_of_rows (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item numberOfRows];
			 ]"
		end

	objc_subrow_indexes_for_row_ (an_item: POINTER; a_row_index: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item subrowIndexesForRow:$a_row_index];
			 ]"
		end

	objc_criteria_for_row_ (an_item: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item criteriaForRow:$a_row];
			 ]"
		end

	objc_display_values_for_row_ (an_item: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item displayValuesForRow:$a_row];
			 ]"
		end

	objc_row_for_display_value_ (an_item: POINTER; a_display_value: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item rowForDisplayValue:$a_display_value];
			 ]"
		end

	objc_row_type_for_row_ (an_item: POINTER; a_row_index: INTEGER_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item rowTypeForRow:$a_row_index];
			 ]"
		end

	objc_parent_row_for_row_ (an_item: POINTER; a_row_index: INTEGER_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSRuleEditor *)$an_item parentRowForRow:$a_row_index];
			 ]"
		end

	objc_add_row_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item addRow:$a_sender];
			 ]"
		end

	objc_insert_row_at_index__with_type__as_subrow_of_row__animate_ (an_item: POINTER; a_row_index: INTEGER_64; a_row_type: NATURAL_64; a_parent_row: INTEGER_64; a_should_animate: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item insertRowAtIndex:$a_row_index withType:$a_row_type asSubrowOfRow:$a_parent_row animate:$a_should_animate];
			 ]"
		end

	objc_set_criteria__and_display_values__for_row_at_index_ (an_item: POINTER; a_criteria: POINTER; a_values: POINTER; a_row_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setCriteria:$a_criteria andDisplayValues:$a_values forRowAtIndex:$a_row_index];
			 ]"
		end

	objc_remove_row_at_index_ (an_item: POINTER; a_row_index: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item removeRowAtIndex:$a_row_index];
			 ]"
		end

	objc_remove_rows_at_indexes__include_subrows_ (an_item: POINTER; a_row_indexes: POINTER; a_include_subrows: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item removeRowsAtIndexes:$a_row_indexes includeSubrows:$a_include_subrows];
			 ]"
		end

	objc_selected_row_indexes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item selectedRowIndexes];
			 ]"
		end

	objc_select_row_indexes__by_extending_selection_ (an_item: POINTER; a_indexes: POINTER; a_extend: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item selectRowIndexes:$a_indexes byExtendingSelection:$a_extend];
			 ]"
		end

	objc_set_row_class_ (an_item: POINTER; a_row_class: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setRowClass:$a_row_class];
			 ]"
		end

	objc_row_class (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item rowClass];
			 ]"
		end

	objc_set_row_type_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setRowTypeKeyPath:$a_key_path];
			 ]"
		end

	objc_row_type_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item rowTypeKeyPath];
			 ]"
		end

	objc_set_subrows_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setSubrowsKeyPath:$a_key_path];
			 ]"
		end

	objc_subrows_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item subrowsKeyPath];
			 ]"
		end

	objc_set_criteria_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setCriteriaKeyPath:$a_key_path];
			 ]"
		end

	objc_criteria_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item criteriaKeyPath];
			 ]"
		end

	objc_set_display_values_key_path_ (an_item: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSRuleEditor *)$an_item setDisplayValuesKeyPath:$a_key_path];
			 ]"
		end

	objc_display_values_key_path (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSRuleEditor *)$an_item displayValuesKeyPath];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSRuleEditor"
		end

end
