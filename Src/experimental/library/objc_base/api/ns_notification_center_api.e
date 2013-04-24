note
	description: "Summary description for {NS_NOTIFICATION_CENTER_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_CENTER_API

feature -- Getting the Notification Center

	frozen default_center: POINTER
			-- + (id)defaultCenter
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSNotificationCenter defaultCenter];"
		end

feature -- Managing Notification Observers

	frozen add_observer_selector_name_object (target: POINTER; a_notification_observer: POINTER;
								a_notification_selector: POINTER; a_notification_name: POINTER; a_notification_sender: POINTER)
			-- - (void)addObserver:(id)notificationObserver selector:(SEL)notificationSelector name:(NSString *)notificationName object:(id)notificationSender
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSNotificationCenter*)$target addObserver: $a_notification_observer selector: $a_notification_selector name: $a_notification_name object: $a_notification_sender];"
		end

	frozen remove_observer (target: POINTER; a_notification_observer: POINTER)
			-- - (void)removeObserver:(id)notificationObserver
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSNotificationCenter*)$target removeObserver: $a_notification_observer];"
		end

feature -- Posting Notifications

end
