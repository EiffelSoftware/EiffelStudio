note
	description: "Wrapper for NSApplication."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLICATION

inherit
	NS_OBJECT
		redefine
			make_from_pointer
		end

create
	make
create {NS_OBJECT}
	make_from_pointer

feature {NONE} -- Creation

	make
		do
			create pool.make
			{NS_APPLICATION_API}.init
			make_from_pointer ({NS_APPLICATION_API}.get)
			{NS_APPLICATION_API}.finish_launching (item)
		end

	make_from_pointer (a_ptr: POINTER)
		do
			Precursor {NS_OBJECT} (a_ptr)
			create pool.make
		end

feature -- Eiffel Extensions

	launch
			-- Run the event loop
		local
			l_event: detachable NS_EVENT
		do
			from
				l_event := next_event (0, default_pointer, 0, true)
			until
				l_event = void
			loop
				pool.release
				create pool.make
				send_event (l_event)
				update_windows
				l_event := next_event(0, default_pointer, 0, true)
			end
			pool.release
		end

	pool: NS_AUTORELEASE_POOL

feature -- Access

	next_event (a_matching_mask: INTEGER; a_until_date: POINTER; a_in_mode: INTEGER; a_dequeue: BOOLEAN): detachable NS_EVENT
			-- Returns the next event matching a given mask, or `Void' if no such event is found before a specified expiration date.
			-- You can use this method to short circuit normal event dispatching and get your own events. For example, you may want
			-- to do this in response to a mouse-down event in order to track the mouse while its button is down. (In such an example,
			-- you would pass the appropriate event types for mouse-dragged and mouse-up events to the mask parameter and specify the
			-- NSEventTrackingRunLoopMode run loop mode.) Events that do not match one of the specified event types are left in the queue.
		local
			l_event: POINTER
		do
			l_event := {NS_APPLICATION_API}.next_event (item, a_matching_mask, a_until_date, a_in_mode, a_dequeue)
			if l_event /= default_pointer then
				create Result.make_from_pointer (l_event)
			end
		end

	update_windows
		do
			{NS_APPLICATION_API}.update_windows (item)
		end

	send_event (a_event: NS_EVENT)
			-- Dispatches an event to other objects.
			-- You rarely invoke sendEvent: directly, although you might want to override this method to perform some action on every event.
			-- sendEvent: messages are sent from the main event loop (the run method). sendEvent: is the method that dispatches events to the
			-- appropriate responders-NSApp handles application events, the NSWindow object indicated in the event record handles window-related
			-- events, and mouse and key events are forwarded to the appropriate NSWindow object for further dispatching.
		do
			{NS_APPLICATION_API}.send_event (item, a_event.item)
		end

	set_main_menu (a_menu: NS_MENU)
		do
			{NS_APPLICATION_API}.set_main_menu (item, a_menu.item)
		end

	set_application_icon_image (a_image: NS_IMAGE)
		do
			{NS_APPLICATION_API}.set_application_icon_image (item, a_image.item)
		end

	terminate
		do
			{NS_APPLICATION_API}.terminate (item, item)
		end

feature -- Managing the Event Loop

	run_modal_for_window (a_window: NS_WINDOW): INTEGER
			-- Starts a modal event loop for a given window.
		do
			Result := {NS_APPLICATION_API}.run_modal_for_window (item, a_window.item)
		end

	abort_modal
		do
			{NS_APPLICATION_API}.abort_modal (item)
		end

feature -- Other

	fix_apple_menu
			-- Doesn't seem to work yet
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSMenu* menu = [NSMenu new];
					[menu setValue:@"NSAppleMenu" forKey:@"name"];
					[NSApp performSelector:@selector(setAppleMenu:) withObject:menu];
				}
			]"
		end

end
