note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_CENTER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSNotificationCenter

	add_observer__selector__name__object_ (a_observer: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; a_name: detachable NS_STRING; an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_observer__item: POINTER
			a_selector__item: POINTER
			a_name__item: POINTER
			an_object__item: POINTER
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
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_add_observer__selector__name__object_ (item, a_observer__item, a_selector__item, a_name__item, an_object__item)
		end

	post_notification_ (a_notification: detachable NS_NOTIFICATION)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_post_notification_ (item, a_notification__item)
		end

	post_notification_name__object_ (a_name: detachable NS_STRING; an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_name__item: POINTER
			an_object__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_post_notification_name__object_ (item, a_name__item, an_object__item)
		end

	post_notification_name__object__user_info_ (a_name: detachable NS_STRING; an_object: detachable NS_OBJECT; a_user_info: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
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
			objc_post_notification_name__object__user_info_ (item, a_name__item, an_object__item, a_user_info__item)
		end

	remove_observer_ (a_observer: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_observer__item: POINTER
		do
			if attached a_observer as a_observer_attached then
				a_observer__item := a_observer_attached.item
			end
			objc_remove_observer_ (item, a_observer__item)
		end

	remove_observer__name__object_ (a_observer: detachable NS_OBJECT; a_name: detachable NS_STRING; an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_observer__item: POINTER
			a_name__item: POINTER
			an_object__item: POINTER
		do
			if attached a_observer as a_observer_attached then
				a_observer__item := a_observer_attached.item
			end
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_remove_observer__name__object_ (item, a_observer__item, a_name__item, an_object__item)
		end

--	add_observer_for_name__object__queue__using_block_ (a_name: detachable NS_STRING; a_obj: detachable NS_OBJECT; a_queue: detachable NS_OPERATION_QUEUE; a_block: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_name__item: POINTER
--			a_obj__item: POINTER
--			a_queue__item: POINTER
--		do
--			if attached a_name as a_name_attached then
--				a_name__item := a_name_attached.item
--			end
--			if attached a_obj as a_obj_attached then
--				a_obj__item := a_obj_attached.item
--			end
--			if attached a_queue as a_queue_attached then
--				a_queue__item := a_queue_attached.item
--			end
--			result_pointer := objc_add_observer_for_name__object__queue__using_block_ (item, a_name__item, a_obj__item, a_queue__item, )
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like add_observer_for_name__object__queue__using_block_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like add_observer_for_name__object__queue__using_block_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSNotificationCenter Externals

	objc_add_observer__selector__name__object_ (an_item: POINTER; a_observer: POINTER; a_selector: POINTER; a_name: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationCenter *)$an_item addObserver:$a_observer selector:$a_selector name:$a_name object:$an_object];
			 ]"
		end

	objc_post_notification_ (an_item: POINTER; a_notification: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationCenter *)$an_item postNotification:$a_notification];
			 ]"
		end

	objc_post_notification_name__object_ (an_item: POINTER; a_name: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationCenter *)$an_item postNotificationName:$a_name object:$an_object];
			 ]"
		end

	objc_post_notification_name__object__user_info_ (an_item: POINTER; a_name: POINTER; an_object: POINTER; a_user_info: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationCenter *)$an_item postNotificationName:$a_name object:$an_object userInfo:$a_user_info];
			 ]"
		end

	objc_remove_observer_ (an_item: POINTER; a_observer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationCenter *)$an_item removeObserver:$a_observer];
			 ]"
		end

	objc_remove_observer__name__object_ (an_item: POINTER; a_observer: POINTER; a_name: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationCenter *)$an_item removeObserver:$a_observer name:$a_name object:$an_object];
			 ]"
		end

--	objc_add_observer_for_name__object__queue__using_block_ (an_item: POINTER; a_name: POINTER; a_obj: POINTER; a_queue: POINTER; a_block: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSNotificationCenter *)$an_item addObserverForName:$a_name object:$a_obj queue:$a_queue usingBlock:];
--			 ]"
--		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNotificationCenter"
		end

end
