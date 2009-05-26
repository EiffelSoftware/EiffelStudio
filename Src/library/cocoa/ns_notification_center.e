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

feature -- Getting the Notification Center

	default_center
		do
			make_shared (notification_center_default_center)
		end

feature {NONE} -- Objective-C interface

	frozen notification_center_default_center: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSNotificationCenter defaultCenter];"
		end

--	frozen notification_center_add_observer_selector_name_object (a_notification_center: POINTER; ): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSNotificationCenter*)$a_notification_center addObserver: selector: name: object:];"
--		end

end
