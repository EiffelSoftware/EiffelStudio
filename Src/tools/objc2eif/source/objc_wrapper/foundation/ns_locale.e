note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_LOCALE

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
	make_with_locale_identifier_,
	make

feature -- NSLocale

	object_for_key_ (a_key: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_object_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	display_name_for_key__value_ (a_key: detachable NS_OBJECT; a_value: detachable NS_OBJECT): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
			a_value__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			result_pointer := objc_display_name_for_key__value_ (item, a_key__item, a_value__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like display_name_for_key__value_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like display_name_for_key__value_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSLocale Externals

	objc_object_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLocale *)$an_item objectForKey:$a_key];
			 ]"
		end

	objc_display_name_for_key__value_ (an_item: POINTER; a_key: POINTER; a_value: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLocale *)$an_item displayNameForKey:$a_key value:$a_value];
			 ]"
		end

feature -- NSExtendedLocale

	locale_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_locale_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like locale_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like locale_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSExtendedLocale Externals

	objc_locale_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLocale *)$an_item localeIdentifier];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_locale_identifier_ (a_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			make_with_pointer (objc_init_with_locale_identifier_(allocate_object, a_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSLocaleCreation Externals

	objc_init_with_locale_identifier_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLocale *)$an_item initWithLocaleIdentifier:$a_string];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSLocale"
		end

end
