note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DISTRIBUTED_NOTIFICATION_CENTER_UTILS

inherit
	NS_NOTIFICATION_CENTER_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSDistributedNotificationCenter

	notification_center_for_type_ (a_notification_center_type: detachable NS_STRING): detachable NS_DISTRIBUTED_NOTIFICATION_CENTER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
			a_notification_center_type__item: POINTER
		do
			if attached a_notification_center_type as a_notification_center_type_attached then
				a_notification_center_type__item := a_notification_center_type_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_notification_center_for_type_ (l_objc_class.item, a_notification_center_type__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like notification_center_for_type_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like notification_center_for_type_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDistributedNotificationCenter Externals

	objc_notification_center_for_type_ (a_class_object: POINTER; a_notification_center_type: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object notificationCenterForType:$a_notification_center_type];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDistributedNotificationCenter"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end
