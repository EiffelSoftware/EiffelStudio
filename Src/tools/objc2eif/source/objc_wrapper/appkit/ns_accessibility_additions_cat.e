note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ACCESSIBILITY_ADDITIONS_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSAccessibilityAdditions

	accessibility_set_override_value__for_attribute_ (a_ns_object: NS_OBJECT; a_value: detachable NS_OBJECT; a_attribute: detachable NS_STRING): BOOLEAN
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
			Result := objc_accessibility_set_override_value__for_attribute_ (a_ns_object.item, a_value__item, a_attribute__item)
		end

feature {NONE} -- NSAccessibilityAdditions Externals

	objc_accessibility_set_override_value__for_attribute_ (an_item: POINTER; a_value: POINTER; a_attribute: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item accessibilitySetOverrideValue:$a_value forAttribute:$a_attribute];
			 ]"
		end

end
