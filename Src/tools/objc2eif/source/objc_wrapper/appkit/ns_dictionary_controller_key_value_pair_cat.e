note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DICTIONARY_CONTROLLER_KEY_VALUE_PAIR_CAT

inherit
	NS_CATEGORY_COMMON

feature -- NSDictionaryControllerKeyValuePair

	set_localized_key_ (a_ns_object: NS_OBJECT; a_localized_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_localized_key__item: POINTER
		do
			if attached a_localized_key as a_localized_key_attached then
				a_localized_key__item := a_localized_key_attached.item
			end
			objc_set_localized_key_ (a_ns_object.item, a_localized_key__item)
		end

	localized_key (a_ns_object: NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_localized_key (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_key} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_key} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_key_ (a_ns_object: NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_key_ (a_ns_object.item, a_key__item)
		end

	key (a_ns_object: NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_key (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like key} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like key} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_value_ (a_ns_object: NS_OBJECT; a_value: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_set_value_ (a_ns_object.item, a_value__item)
		end

	value (a_ns_object: NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_value (a_ns_object.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_explicitly_included (a_ns_object: NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_explicitly_included (a_ns_object.item)
		end

feature {NONE} -- NSDictionaryControllerKeyValuePair Externals

	objc_set_localized_key_ (an_item: POINTER; a_localized_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item setLocalizedKey:$a_localized_key];
			 ]"
		end

	objc_localized_key (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item localizedKey];
			 ]"
		end

	objc_set_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item setKey:$a_key];
			 ]"
		end

	objc_key (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item key];
			 ]"
		end

	objc_set_value_ (an_item: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSObject *)$an_item setValue:$a_value];
			 ]"
		end

	objc_value (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item value];
			 ]"
		end

	objc_is_explicitly_included (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSObject *)$an_item isExplicitlyIncluded];
			 ]"
		end

end
