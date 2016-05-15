note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FORMATTER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSFormatter

	string_for_object_value_ (a_obj: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			result_pointer := objc_string_for_object_value_ (item, a_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like string_for_object_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like string_for_object_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attributed_string_for_object_value__with_default_attributes_ (a_obj: detachable NS_OBJECT; a_attrs: detachable NS_DICTIONARY): detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_obj__item: POINTER
			a_attrs__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			result_pointer := objc_attributed_string_for_object_value__with_default_attributes_ (item, a_obj__item, a_attrs__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string_for_object_value__with_default_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string_for_object_value__with_default_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	editing_string_for_object_value_ (a_obj: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_obj__item: POINTER
		do
			if attached a_obj as a_obj_attached then
				a_obj__item := a_obj_attached.item
			end
			result_pointer := objc_editing_string_for_object_value_ (item, a_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like editing_string_for_object_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like editing_string_for_object_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	get_object_value__for_string__error_description_ (a_obj: UNSUPPORTED_TYPE; a_string: detachable NS_STRING; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_obj__item: POINTER
--			a_string__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_obj as a_obj_attached then
--				a_obj__item := a_obj_attached.item
--			end
--			if attached a_string as a_string_attached then
--				a_string__item := a_string_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_get_object_value__for_string__error_description_ (item, a_obj__item, a_string__item, a_error__item)
--		end

--	is_partial_string_valid__new_editing_string__error_description_ (a_partial_string: detachable NS_STRING; a_new_string: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_partial_string__item: POINTER
--			a_new_string__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_partial_string as a_partial_string_attached then
--				a_partial_string__item := a_partial_string_attached.item
--			end
--			if attached a_new_string as a_new_string_attached then
--				a_new_string__item := a_new_string_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_is_partial_string_valid__new_editing_string__error_description_ (item, a_partial_string__item, a_new_string__item, a_error__item)
--		end

--	is_partial_string_valid__proposed_selected_range__original_string__original_selected_range__error_description_ (a_partial_string_ptr: UNSUPPORTED_TYPE; a_proposed_sel_range_ptr: UNSUPPORTED_TYPE; a_orig_string: detachable NS_STRING; a_orig_sel_range: NS_RANGE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_partial_string_ptr__item: POINTER
--			a_proposed_sel_range_ptr__item: POINTER
--			a_orig_string__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_partial_string_ptr as a_partial_string_ptr_attached then
--				a_partial_string_ptr__item := a_partial_string_ptr_attached.item
--			end
--			if attached a_proposed_sel_range_ptr as a_proposed_sel_range_ptr_attached then
--				a_proposed_sel_range_ptr__item := a_proposed_sel_range_ptr_attached.item
--			end
--			if attached a_orig_string as a_orig_string_attached then
--				a_orig_string__item := a_orig_string_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			Result := objc_is_partial_string_valid__proposed_selected_range__original_string__original_selected_range__error_description_ (item, a_partial_string_ptr__item, a_proposed_sel_range_ptr__item, a_orig_string__item, a_orig_sel_range.item, a_error__item)
--		end

feature {NONE} -- NSFormatter Externals

	objc_string_for_object_value_ (an_item: POINTER; a_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormatter *)$an_item stringForObjectValue:$a_obj];
			 ]"
		end

	objc_attributed_string_for_object_value__with_default_attributes_ (an_item: POINTER; a_obj: POINTER; a_attrs: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormatter *)$an_item attributedStringForObjectValue:$a_obj withDefaultAttributes:$a_attrs];
			 ]"
		end

	objc_editing_string_for_object_value_ (an_item: POINTER; a_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFormatter *)$an_item editingStringForObjectValue:$a_obj];
			 ]"
		end

--	objc_get_object_value__for_string__error_description_ (an_item: POINTER; a_obj: UNSUPPORTED_TYPE; a_string: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFormatter *)$an_item getObjectValue: forString:$a_string errorDescription:];
--			 ]"
--		end

--	objc_is_partial_string_valid__new_editing_string__error_description_ (an_item: POINTER; a_partial_string: POINTER; a_new_string: UNSUPPORTED_TYPE; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFormatter *)$an_item isPartialStringValid:$a_partial_string newEditingString: errorDescription:];
--			 ]"
--		end

--	objc_is_partial_string_valid__proposed_selected_range__original_string__original_selected_range__error_description_ (an_item: POINTER; a_partial_string_ptr: UNSUPPORTED_TYPE; a_proposed_sel_range_ptr: UNSUPPORTED_TYPE; a_orig_string: POINTER; a_orig_sel_range: POINTER; a_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSFormatter *)$an_item isPartialStringValid: proposedSelectedRange: originalString:$a_orig_string originalSelectedRange:*((NSRange *)$a_orig_sel_range) errorDescription:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFormatter"
		end

end
