note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ACCESSIBILITY_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSAccessibility

	accessibility_attribute_names (a_ns_object: NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessibility_attribute_names (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_attribute_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_attribute_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_attribute_value_ (a_ns_object: NS_OBJECT; a_attribute: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_attribute__item: POINTER
		do
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			result_pointer := objc_accessibility_attribute_value_ (a_ns_object.item, a_attribute__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_attribute_value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_attribute_value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_is_attribute_settable_ (a_ns_object: NS_OBJECT; a_attribute: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_attribute__item: POINTER
		do
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			Result := objc_accessibility_is_attribute_settable_ (a_ns_object.item, a_attribute__item)
		end

	accessibility_set_value__for_attribute_ (a_ns_object: NS_OBJECT; a_value: detachable NS_OBJECT; a_attribute: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_attribute__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			objc_accessibility_set_value__for_attribute_ (a_ns_object.item, a_value__item, a_attribute__item)
		end

	accessibility_parameterized_attribute_names (a_ns_object: NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessibility_parameterized_attribute_names (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_parameterized_attribute_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_parameterized_attribute_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_attribute_value__for_parameter_ (a_ns_object: NS_OBJECT; a_attribute: detachable NS_STRING; a_parameter: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_attribute__item: POINTER
			a_parameter__item: POINTER
		do
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			if attached a_parameter as a_parameter_attached then
				a_parameter__item := a_parameter_attached.item
			end
			result_pointer := objc_accessibility_attribute_value__for_parameter_ (a_ns_object.item, a_attribute__item, a_parameter__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_attribute_value__for_parameter_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_attribute_value__for_parameter_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_action_names (a_ns_object: NS_OBJECT): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessibility_action_names (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_action_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_action_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_action_description_ (a_ns_object: NS_OBJECT; a_action: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_action__item: POINTER
		do
			if attached a_action as a_action_attached then
				a_action__item := a_action_attached.item
			end
			result_pointer := objc_accessibility_action_description_ (a_ns_object.item, a_action__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_action_description_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_action_description_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_perform_action_ (a_ns_object: NS_OBJECT; a_action: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_action__item: POINTER
		do
			if attached a_action as a_action_attached then
				a_action__item := a_action_attached.item
			end
			objc_accessibility_perform_action_ (a_ns_object.item, a_action__item)
		end

	accessibility_is_ignored (a_ns_object: NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_accessibility_is_ignored (a_ns_object.item)
		end

	accessibility_hit_test_ (a_ns_object: NS_OBJECT; a_point: NS_POINT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessibility_hit_test_ (a_ns_object.item, a_point.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_hit_test_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_hit_test_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_focused_ui_element (a_ns_object: NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_accessibility_focused_ui_element (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_focused_ui_element} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_focused_ui_element} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	accessibility_index_of_child_ (a_ns_object: NS_OBJECT; a_child: detachable NS_OBJECT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			Result := objc_accessibility_index_of_child_ (a_ns_object.item, a_child__item)
		end

	accessibility_array_attribute_count_ (a_ns_object: NS_OBJECT; a_attribute: detachable NS_STRING): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_attribute__item: POINTER
		do
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			Result := objc_accessibility_array_attribute_count_ (a_ns_object.item, a_attribute__item)
		end

	accessibility_array_attribute_values__index__max_count_ (a_ns_object: NS_OBJECT; a_attribute: detachable NS_STRING; a_index: NATURAL_64; a_max_count: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_attribute__item: POINTER
		do
			if attached a_attribute as a_attribute_attached then
				a_attribute__item := a_attribute_attached.item
			end
			result_pointer := objc_accessibility_array_attribute_values__index__max_count_ (a_ns_object.item, a_attribute__item, a_index, a_max_count)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like accessibility_array_attribute_values__index__max_count_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like accessibility_array_attribute_values__index__max_count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSAccessibility Externals

	objc_accessibility_attribute_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityAttributeNames];
			 ]"
		end

	objc_accessibility_attribute_value_ (an_item: POINTER; a_attribute: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityAttributeValue:$a_attribute];
			 ]"
		end

	objc_accessibility_is_attribute_settable_ (an_item: POINTER; a_attribute: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item accessibilityIsAttributeSettable:$a_attribute];
			 ]"
		end

	objc_accessibility_set_value__for_attribute_ (an_item: POINTER; a_value: POINTER; a_attribute: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item accessibilitySetValue:$a_value forAttribute:$a_attribute];
			 ]"
		end

	objc_accessibility_parameterized_attribute_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityParameterizedAttributeNames];
			 ]"
		end

	objc_accessibility_attribute_value__for_parameter_ (an_item: POINTER; a_attribute: POINTER; a_parameter: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityAttributeValue:$a_attribute forParameter:$a_parameter];
			 ]"
		end

	objc_accessibility_action_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityActionNames];
			 ]"
		end

	objc_accessibility_action_description_ (an_item: POINTER; a_action: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityActionDescription:$a_action];
			 ]"
		end

	objc_accessibility_perform_action_ (an_item: POINTER; a_action: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item accessibilityPerformAction:$a_action];
			 ]"
		end

	objc_accessibility_is_ignored (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item accessibilityIsIgnored];
			 ]"
		end

	objc_accessibility_hit_test_ (an_item: POINTER; a_point: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityHitTest:*((NSPoint *)$a_point)];
			 ]"
		end

	objc_accessibility_focused_ui_element (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityFocusedUIElement];
			 ]"
		end

	objc_accessibility_index_of_child_ (an_item: POINTER; a_child: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item accessibilityIndexOfChild:$a_child];
			 ]"
		end

	objc_accessibility_array_attribute_count_ (an_item: POINTER; a_attribute: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item accessibilityArrayAttributeCount:$a_attribute];
			 ]"
		end

	objc_accessibility_array_attribute_values__index__max_count_ (an_item: POINTER; a_attribute: POINTER; a_index: NATURAL_64; a_max_count: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item accessibilityArrayAttributeValues:$a_attribute index:$a_index maxCount:$a_max_count];
			 ]"
		end

end
