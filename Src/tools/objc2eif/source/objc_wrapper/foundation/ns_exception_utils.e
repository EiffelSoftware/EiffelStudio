note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EXCEPTION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSException

	exception_with_name__reason__user_info_ (a_name: detachable NS_STRING; a_reason: detachable NS_STRING; a_user_info: detachable NS_DICTIONARY): detachable NS_EXCEPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			a_reason__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_reason as a_reason_attached then
				a_reason__item := a_reason_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_exception_with_name__reason__user_info_ (l_objc_class.item, a_name__item, a_reason__item, a_user_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like exception_with_name__reason__user_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like exception_with_name__reason__user_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSException Externals

	objc_exception_with_name__reason__user_info_ (a_class_object: POINTER; a_name: POINTER; a_reason: POINTER; a_user_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object exceptionWithName:$a_name reason:$a_reason userInfo:$a_user_info];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSException"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
