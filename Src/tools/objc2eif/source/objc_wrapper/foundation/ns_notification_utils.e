note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSNotificationCreation

	notification_with_name__object_ (a_name: detachable NS_STRING; an_object: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			an_object__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_notification_with_name__object_ (l_objc_class.item, a_name__item, an_object__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like notification_with_name__object_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like notification_with_name__object_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	notification_with_name__object__user_info_ (a_name: detachable NS_STRING; an_object: detachable NS_OBJECT; a_user_info: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_name__item: POINTER
			an_object__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_notification_with_name__object__user_info_ (l_objc_class.item, a_name__item, an_object__item, a_user_info__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like notification_with_name__object__user_info_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like notification_with_name__object__user_info_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSNotificationCreation Externals

	objc_notification_with_name__object_ (a_class_object: POINTER; a_name: POINTER; a_an_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object notificationWithName:$a_name object:$a_an_object];
			 ]"
		end

	objc_notification_with_name__object__user_info_ (a_class_object: POINTER; a_name: POINTER; a_an_object: POINTER; a_user_info: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object notificationWithName:$a_name object:$a_an_object userInfo:$a_user_info];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNotification"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
