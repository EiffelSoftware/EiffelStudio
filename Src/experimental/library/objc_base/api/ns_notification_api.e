note
	description: "Summary description for {NS_NOTIFICATION_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_NOTIFICATION_API

feature -- Creating Notifications

	frozen notification_with_name_object (a_name: POINTER; a_an_object: POINTER): POINTER
			-- + (id)notificationWithName: (NSString *) aName object: (NSString *) anObject
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSNotification notificationWithName: $a_name object: *(id*)$a_an_object];"
		end

	frozen notification_with_name_object_user_info (a_name: POINTER; a_an_object: POINTER; a_user_info: POINTER): POINTER
			-- + (id)notificationWithName: (NSString *) aName object: (NSString *) anObject userInfo: (NSString *) aUserInfo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSNotification notificationWithName: $a_name object: *(id*)$a_an_object userInfo: $a_user_info];"
		end

feature -- Getting Notification Information

	frozen name (a_ns_notification: POINTER): POINTER
			-- - (NSString *)name
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSNotification*)$a_ns_notification name];"
		end

	frozen object (a_ns_notification: POINTER): POINTER
			-- - (id)object
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSNotification*)$a_ns_notification object];"
		end

	frozen user_info (a_ns_notification: POINTER): POINTER
			-- - (NSDictionary *)userInfo
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSNotification*)$a_ns_notification userInfo];"
		end
end
