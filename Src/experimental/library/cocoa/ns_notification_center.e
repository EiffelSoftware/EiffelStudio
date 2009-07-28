note
	description: "Wrapper for NSNotificationCenter."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_CENTER

inherit
	NS_OBJECT

create {NS_ENVIRONEMENT}
	make_from_pointer

feature -- Managing Notification Observers

	add_observer (a_callback: PROCEDURE [ANY, TUPLE[NS_OBJECT]]; a_notification_name: detachable NS_STRING; a_notification_sender: detachable NS_OBJECT)
			-- Adds an entry to the receiver's dispatch table with an observer, a notification selector and optional criteria: notification name and sender.
			-- `a_notification_name' is the name of the notification for which to register the observer; that is, only notifications with this
			-- name are delivered to the observer. When `Void', the notification center doesn't use a notification's name
			-- to decide whether to deliver it to the observer.
		local
			l_callback_object: NS_NOTIFICATION_CALLBACK
			l_sender: POINTER

		do
			if attached a_notification_sender then
				l_sender := a_notification_sender.item
			end
			create l_callback_object.make_with_agent (a_callback)
			observers.extend (l_callback_object)
			notification_center_add_observer_selector_name_object (item, l_callback_object.item,
					l_callback_object.selector,
					{NS_VIEW}.view_frame_did_change_notification, l_sender)
		end

feature {NONE} -- Internal

	observers: ARRAYED_LIST [NS_NOTIFICATION_CALLBACK]
		once
			create Result.make (100)
		end

feature {NS_ENVIRONEMENT} -- Objective-C interface

	frozen default_center: POINTER
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
