note
	description: "Wrapper for NSNotificationCenter."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_CENTER

inherit
	NS_OBJECT

create
	default_center

feature {NONE} -- Getting the Notification Center

	default_center
			-- fixme: should be a singleton
		do
			make_from_pointer (notification_center_default_center)
		end

feature -- Managing Notification Observers

	add_observer (a_callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]]; a_notification_name: detachable NS_STRING; a_notification_sender: detachable NS_OBJECT)
			-- Adds an entry to the receiver's dispatch table with an observer, a notification selector and optional criteria: notification name and sender.
			-- `a_notification_name' is the name of the notification for which to register the observer; that is, only notifications with this
			-- name are delivered to the observer. When `Void', the notification center doesn't use a notification's name
			-- to decide whether to deliver it to the observer.
		local
			l_class: OBJC_CLASS
			l_callback_object: NS_OBJECT
			l_sender: POINTER
		do
			if attached a_notification_sender then
				l_sender := a_notification_sender.item
			end
			-- Create a new Objective-C object with one method and use this as a callback.
			create l_class.make_with_name (generate_name)
			l_class.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
			l_class.add_method ("callbackMethod:", agent call_observer (a_callback, ?))
			l_class.register
			l_callback_object := l_class.create_instance
			notification_center_add_observer_selector_name_object (item, l_callback_object.item,
					{NS_OBJC_RUNTIME}.sel_register_name ((create {C_STRING}.make ("callbackMethod:")).item),
					{NS_VIEW}.view_frame_did_change_notification, l_sender)
		end

feature {NONE} -- Implementation

	call_observer (a_callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]]; a_ptr: POINTER)
		do
			a_callback.call ([create {NS_OBJECT}.make_from_pointer (a_ptr)])
		end

	counter: SPECIAL [INTEGER]
		once
			create Result.make_empty (1)
			Result.extend (0)
		end

	generate_name: STRING
		do
			Result := "NotificationCallback" + counter.item (0).out
			counter.put (counter.item (0) + 1, 0)
		end

feature {NONE} -- Objective-C interface

	frozen notification_center_default_center: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSNotificationCenter defaultCenter];"
		end

	frozen notification_center_add_observer_selector_name_object (target: POINTER; a_notification_observer: POINTER;
								a_notification_selector: POINTER; a_notification_name: POINTER; a_notification_sender: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSNotificationCenter*)$target addObserver: $a_notification_observer selector: $a_notification_selector name: $a_notification_name object: $a_notification_sender];"
		end

end
