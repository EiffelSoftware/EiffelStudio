note
	description: "Summary description for {NS_STRING_CONSTANTS}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING_CONSTANTS

feature -- Attributed Strings

	font_attribute_name: NS_STRING
		once
			create Result.make_weak_from_pointer (ns_font_attribute_name)
		end

	foreground_color_attribute_name: NS_STRING
		once
			create Result.make_weak_from_pointer (ns_foreground_color_attribute_name)
		end

feature -- NSView / Notifications

	view_frame_did_change_notification: NS_STRING
			-- Posted whenever the view's frame rectangle changes, if the view is configured using
			-- setPostsFrameChangedNotifications: to post such notifications.
		once
			create Result.make_weak_from_pointer (ns_view_frame_did_change_notification)
		end

feature -- Run Loop Modes

	default_tun_loop_mode: NS_STRING
		once
			create Result.make_weak_from_pointer (ns_default_tun_loop_mode)
		end


feature {NONE} -- Implementation

	frozen ns_font_attribute_name: POINTER
			-- NSFontAttributeName
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSFontAttributeName"
		end

	frozen ns_foreground_color_attribute_name: POINTER
			-- NSForegroundColorAttributeName
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSForegroundColorAttributeName"
		end


	frozen ns_view_frame_did_change_notification: POINTER
			-- NSViewFrameDidChangeNotification
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSViewFrameDidChangeNotification"
		end

	frozen ns_default_tun_loop_mode: POINTER
			-- NSDefaultRunLoopMode
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSDefaultRunLoopMode"
		end
end
