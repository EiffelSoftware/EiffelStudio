note
	description: "Wrapper for delegate methods of NSWindow."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_WINDOW_DELEGATE

inherit
	NS_OBJECT
		redefine
			default_create
		end

create
	default_create

feature -- Creation

	default_create
		do
			item := window_delegate_class.create_instance.item
			create window_did_resize_actions
			create window_did_move_actions
			callback_marshal.register_object (Current)
		end

feature -- Delegate Methods

	window_did_resize (a_notification: NS_NOTIFICATION)
			-- Sent by the default notification center immediately after an NSWindow object has been moved.
		do
			window_did_resize_actions.call ([a_notification])
		end

	window_did_move (a_notification: NS_NOTIFICATION)
		do
			window_did_move_actions.call([a_notification])
		end

feature -- Actions

	window_did_resize_actions: ACTION_SEQUENCE[TUPLE[NS_NOTIFICATION]]

	window_did_move_actions: ACTION_SEQUENCE[TUPLE[NS_NOTIFICATION]]

feature {NS_OBJECT} -- Implementation

	window_delegate_class: OBJC_CLASS
			-- An Objective-C class which has the selectors of the delegate
		once
			create Result.make_with_name ("EiffelWrapperWindowDelegate")
			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
			Result.add_method ("windowDidResize:", agent window_did_resize)
			Result.add_method ("windowDidMove:", agent window_did_move)
			-- windowDidBecomeKey:
			-- windowDidResignKey:
			-- windowShouldClose: / windowWillClose:
			Result.register
		end

end
