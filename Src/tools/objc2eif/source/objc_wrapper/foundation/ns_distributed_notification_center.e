note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_DISTRIBUTED_NOTIFICATION_CENTER

inherit
	NS_NOTIFICATION_CENTER
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSDistributedNotificationCenter

	add_observer__selector__name__object__suspension_behavior_ (a_observer: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; a_name: detachable NS_STRING; a_object: detachable NS_STRING; a_suspension_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_observer__item: POINTER
			a_selector__item: POINTER
			a_name__item: POINTER
			a_object__item: POINTER
		do
			if attached a_observer as a_observer_attached then
				a_observer__item := a_observer_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			objc_add_observer__selector__name__object__suspension_behavior_ (item, a_observer__item, a_selector__item, a_name__item, a_object__item, a_suspension_behavior)
		end

	post_notification_name__object__user_info__deliver_immediately_ (a_name: detachable NS_STRING; a_object: detachable NS_STRING; a_user_info: detachable NS_DICTIONARY; a_deliver_immediately: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
			a_object__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			objc_post_notification_name__object__user_info__deliver_immediately_ (item, a_name__item, a_object__item, a_user_info__item, a_deliver_immediately)
		end

	post_notification_name__object__user_info__options_ (a_name: detachable NS_STRING; a_object: detachable NS_STRING; a_user_info: detachable NS_DICTIONARY; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
			a_object__item: POINTER
			a_user_info__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			if attached a_user_info as a_user_info_attached then
				a_user_info__item := a_user_info_attached.item
			end
			objc_post_notification_name__object__user_info__options_ (item, a_name__item, a_object__item, a_user_info__item, a_options)
		end

	set_suspended_ (a_suspended: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_suspended_ (item, a_suspended)
		end

	suspended: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_suspended (item)
		end

feature {NONE} -- NSDistributedNotificationCenter Externals

	objc_add_observer__selector__name__object__suspension_behavior_ (an_item: POINTER; a_observer: POINTER; a_selector: POINTER; a_name: POINTER; a_object: POINTER; a_suspension_behavior: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistributedNotificationCenter *)$an_item addObserver:$a_observer selector:$a_selector name:$a_name object:$a_object suspensionBehavior:$a_suspension_behavior];
			 ]"
		end

	objc_post_notification_name__object__user_info__deliver_immediately_ (an_item: POINTER; a_name: POINTER; a_object: POINTER; a_user_info: POINTER; a_deliver_immediately: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistributedNotificationCenter *)$an_item postNotificationName:$a_name object:$a_object userInfo:$a_user_info deliverImmediately:$a_deliver_immediately];
			 ]"
		end

	objc_post_notification_name__object__user_info__options_ (an_item: POINTER; a_name: POINTER; a_object: POINTER; a_user_info: POINTER; a_options: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistributedNotificationCenter *)$an_item postNotificationName:$a_name object:$a_object userInfo:$a_user_info options:$a_options];
			 ]"
		end

	objc_set_suspended_ (an_item: POINTER; a_suspended: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSDistributedNotificationCenter *)$an_item setSuspended:$a_suspended];
			 ]"
		end

	objc_suspended (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSDistributedNotificationCenter *)$an_item suspended];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSDistributedNotificationCenter"
		end

end
