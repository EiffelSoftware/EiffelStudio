note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_HTTPURL_RESPONSE_UTILS

inherit
	NS_URL_RESPONSE_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSHTTPURLResponse

	localized_string_for_status_code_ (a_status_code: INTEGER_64): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_localized_string_for_status_code_ (l_objc_class.item, a_status_code)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_string_for_status_code_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_string_for_status_code_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSHTTPURLResponse Externals

	objc_localized_string_for_status_code_ (a_class_object: POINTER; a_status_code: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object localizedStringForStatusCode:$a_status_code];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSHTTPURLResponse"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
