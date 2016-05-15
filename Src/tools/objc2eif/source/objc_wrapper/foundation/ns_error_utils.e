note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ERROR_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSError

	error_with_domain__code__user_info_ (a_domain: detachable NS_STRING; a_code: INTEGER_64; a_dict: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_domain__item: POINTER
			a_dict__item: POINTER
		do
			if attached a_domain as a_domain_attached then
				a_domain__item := a_domain_attached.item
			end
			if attached a_dict as a_dict_attached then
				a_dict__item := a_dict_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_error_with_domain__code__user_info_ (l_objc_class.item, a_domain__item, a_code, a_dict__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like error_with_domain__code__user_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like error_with_domain__code__user_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSError Externals

	objc_error_with_domain__code__user_info_ (a_class_object: POINTER; a_domain: POINTER; a_code: INTEGER_64; a_dict: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object errorWithDomain:$a_domain code:$a_code userInfo:$a_dict];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSError"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
