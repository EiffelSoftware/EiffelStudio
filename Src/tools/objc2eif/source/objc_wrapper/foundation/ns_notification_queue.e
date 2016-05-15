note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_QUEUE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_notification_center_,
	make

feature {NONE} -- Initialization

	make_with_notification_center_ (a_notification_center: detachable NS_NOTIFICATION_CENTER)
			-- Initialize `Current'.
		local
			a_notification_center__item: POINTER
		do
			if attached a_notification_center as a_notification_center_attached then
				a_notification_center__item := a_notification_center_attached.item
			end
			make_with_pointer (objc_init_with_notification_center_(allocate_object, a_notification_center__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSNotificationQueue Externals

	objc_init_with_notification_center_ (an_item: POINTER; a_notification_center: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSNotificationQueue *)$an_item initWithNotificationCenter:$a_notification_center];
			 ]"
		end

	objc_enqueue_notification__posting_style_ (an_item: POINTER; a_notification: POINTER; a_posting_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationQueue *)$an_item enqueueNotification:$a_notification postingStyle:$a_posting_style];
			 ]"
		end

	objc_enqueue_notification__posting_style__coalesce_mask__for_modes_ (an_item: POINTER; a_notification: POINTER; a_posting_style: NATURAL_64; a_coalesce_mask: NATURAL_64; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationQueue *)$an_item enqueueNotification:$a_notification postingStyle:$a_posting_style coalesceMask:$a_coalesce_mask forModes:$a_modes];
			 ]"
		end

	objc_dequeue_notifications_matching__coalesce_mask_ (an_item: POINTER; a_notification: POINTER; a_coalesce_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSNotificationQueue *)$an_item dequeueNotificationsMatching:$a_notification coalesceMask:$a_coalesce_mask];
			 ]"
		end

feature -- NSNotificationQueue

	enqueue_notification__posting_style_ (a_notification: detachable NS_NOTIFICATION; a_posting_style: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_enqueue_notification__posting_style_ (item, a_notification__item, a_posting_style)
		end

	enqueue_notification__posting_style__coalesce_mask__for_modes_ (a_notification: detachable NS_NOTIFICATION; a_posting_style: NATURAL_64; a_coalesce_mask: NATURAL_64; a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
			a_modes__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_enqueue_notification__posting_style__coalesce_mask__for_modes_ (item, a_notification__item, a_posting_style, a_coalesce_mask, a_modes__item)
		end

	dequeue_notifications_matching__coalesce_mask_ (a_notification: detachable NS_NOTIFICATION; a_coalesce_mask: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_notification__item: POINTER
		do
			if attached a_notification as a_notification_attached then
				a_notification__item := a_notification_attached.item
			end
			objc_dequeue_notifications_matching__coalesce_mask_ (item, a_notification__item, a_coalesce_mask)
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSNotificationQueue"
		end

end
