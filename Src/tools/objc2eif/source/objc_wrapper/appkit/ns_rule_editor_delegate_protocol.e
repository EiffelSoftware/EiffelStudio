note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_RULE_EDITOR_DELEGATE_PROTOCOL

inherit
	NS_OBJECT_PROTOCOL

feature -- Required Methods

	rule_editor__number_of_children_for_criterion__with_row_type_ (a_editor: detachable NS_RULE_EDITOR; a_criterion: detachable NS_OBJECT; a_row_type: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_editor__item: POINTER
			a_criterion__item: POINTER
		do
			if attached a_editor as a_editor_attached then
				a_editor__item := a_editor_attached.item
			end
			if attached a_criterion as a_criterion_attached then
				a_criterion__item := a_criterion_attached.item
			end
			Result := objc_rule_editor__number_of_children_for_criterion__with_row_type_ (item, a_editor__item, a_criterion__item, a_row_type)
		end

	rule_editor__child__for_criterion__with_row_type_ (a_editor: detachable NS_RULE_EDITOR; a_index: INTEGER_64; a_criterion: detachable NS_OBJECT; a_row_type: NATURAL_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_editor__item: POINTER
			a_criterion__item: POINTER
		do
			if attached a_editor as a_editor_attached then
				a_editor__item := a_editor_attached.item
			end
			if attached a_criterion as a_criterion_attached then
				a_criterion__item := a_criterion_attached.item
			end
			result_pointer := objc_rule_editor__child__for_criterion__with_row_type_ (item, a_editor__item, a_index, a_criterion__item, a_row_type)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rule_editor__child__for_criterion__with_row_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rule_editor__child__for_criterion__with_row_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rule_editor__display_value_for_criterion__in_row_ (a_editor: detachable NS_RULE_EDITOR; a_criterion: detachable NS_OBJECT; a_row: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_editor__item: POINTER
			a_criterion__item: POINTER
		do
			if attached a_editor as a_editor_attached then
				a_editor__item := a_editor_attached.item
			end
			if attached a_criterion as a_criterion_attached then
				a_criterion__item := a_criterion_attached.item
			end
			result_pointer := objc_rule_editor__display_value_for_criterion__in_row_ (item, a_editor__item, a_criterion__item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rule_editor__display_value_for_criterion__in_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rule_editor__display_value_for_criterion__in_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Required Methods Externals

	objc_rule_editor__number_of_children_for_criterion__with_row_type_ (an_item: POINTER; a_editor: POINTER; a_criterion: POINTER; a_row_type: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id <NSRuleEditorDelegate>)$an_item ruleEditor:$a_editor numberOfChildrenForCriterion:$a_criterion withRowType:$a_row_type];
			 ]"
		end

	objc_rule_editor__child__for_criterion__with_row_type_ (an_item: POINTER; a_editor: POINTER; a_index: INTEGER_64; a_criterion: POINTER; a_row_type: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSRuleEditorDelegate>)$an_item ruleEditor:$a_editor child:$a_index forCriterion:$a_criterion withRowType:$a_row_type];
			 ]"
		end

	objc_rule_editor__display_value_for_criterion__in_row_ (an_item: POINTER; a_editor: POINTER; a_criterion: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSRuleEditorDelegate>)$an_item ruleEditor:$a_editor displayValueForCriterion:$a_criterion inRow:$a_row];
			 ]"
		end

feature -- Optional Methods

	rule_editor__predicate_parts_for_criterion__with_display_value__in_row_ (a_editor: detachable NS_RULE_EDITOR; a_criterion: detachable NS_OBJECT; a_value: detachable NS_OBJECT; a_row: INTEGER_64): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		require
			has_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_: has_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_
		local
			result_pointer: POINTER
			a_editor__item: POINTER
			a_criterion__item: POINTER
			a_value__item: POINTER
		do
			if attached a_editor as a_editor_attached then
				a_editor__item := a_editor_attached.item
			end
			if attached a_criterion as a_criterion_attached then
				a_criterion__item := a_criterion_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			result_pointer := objc_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_ (item, a_editor__item, a_criterion__item, a_value__item, a_row)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like rule_editor__predicate_parts_for_criterion__with_display_value__in_row_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like rule_editor__predicate_parts_for_criterion__with_display_value__in_row_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	rule_editor_rows_did_change_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		require
			has_rule_editor_rows_did_change_: has_rule_editor_rows_did_change_
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_rule_editor_rows_did_change_ (item, a_notification__item)
		end

feature -- Status Report

	has_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_ (item)
		end

	has_rule_editor_rows_did_change_: BOOLEAN
			-- Auto generated Objective-C wrapper.
		do
			Result := objc_has_rule_editor_rows_did_change_ (item)
		end

feature -- Status Report Externals

	objc_has_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(ruleEditor:predicatePartsForCriterion:withDisplayValue:inRow:)];
			 ]"
		end

	objc_has_rule_editor_rows_did_change_ (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(id)$an_item respondsToSelector:@selector(ruleEditorRowsDidChange:)];
			 ]"
		end

feature {NONE} -- Optional Methods Externals

	objc_rule_editor__predicate_parts_for_criterion__with_display_value__in_row_ (an_item: POINTER; a_editor: POINTER; a_criterion: POINTER; a_value: POINTER; a_row: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(id <NSRuleEditorDelegate>)$an_item ruleEditor:$a_editor predicatePartsForCriterion:$a_criterion withDisplayValue:$a_value inRow:$a_row];
			 ]"
		end

	objc_rule_editor_rows_did_change_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(id <NSRuleEditorDelegate>)$an_item ruleEditorRowsDidChange:$a_notification];
			 ]"
		end

end
