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
				create Result.share_from_pointer (l_event)
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

feature -- Accessing the Main Menu

	set_main_menu (a_menu: NS_MENU)
			-- Makes the given menu the receiver's main menu.
		do
			{NS_APPLICATION_API}.set_main_menu (item, a_menu.item)
		ensure
			main_menu_set: a_menu.is_equal (main_menu)
		end

	main_menu: NS_MENU
			-- Returns the receiver's main menu (the application's menu bar).
		do
			create Result.share_from_pointer ({NS_APPLICATION_API}.main_menu (item))
		end


	set_application_icon_image (a_image: NS_IMAGE)
		do
			{NS_APPLICATION_API}.set_application_icon_image (item, a_image.item)
		end

	terminate
		do
			{NS_APPLICATION_API}.terminate (item, item)
		end

	stop
			-- Stops the main event loop.
		do
			{NS_APPLICATION_API}.stop (item, item)
		end

feature -- Managing Panels

	order_front_standard_about_panel
		do
			{NS_APPLICATION_API}.order_front_standard_about_panel (item, item)
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

	default_application_menu: NS_MENU_ITEM
		local
			l_menu: NS_MENU
			l_menu_item: NS_MENU_ITEM
			apple_icon_char: CHARACTER_32
			name: NS_STRING
		do
			-- A little hack is needed to set the apple menu:
			-- see http://lists.apple.com/archives/cocoa-dev/2006/Sep/msg00011.html
			apple_icon_char := (0xF8FF).to_character_32
			create name.make_from_pointer ({NS_STRING_API}.string_with_characters ($apple_icon_char, 1))

			create l_menu.make
			l_menu.set_title (name)

			create l_menu_item.make
			l_menu_item.set_submenu (l_menu)

			Result := l_menu_item

			create l_menu_item.make_with_title (create {NS_STRING}.make_with_string ("About #{appname}"), void)
			l_menu_item.set_action (agent order_front_standard_about_panel)
			l_menu.add_item (l_menu_item)

			create l_menu_item.separator_item
			l_menu.add_item (l_menu_item)

			create l_menu_item.make_with_title (create {NS_STRING}.make_with_string ("Services"), void)
			l_menu.add_item (l_menu_item)

			create l_menu_item.separator_item
			l_menu.add_item (l_menu_item)

			create l_menu_item.make_with_title (create {NS_STRING}.make_with_string ("Hide #{appname}"), void)
			l_menu.add_item (l_menu_item)

			create l_menu_item.make_with_title (create {NS_STRING}.make_with_string ("Hide Others"), void)
			l_menu.add_item (l_menu_item)

			create l_menu_item.make_with_title (create {NS_STRING}.make_with_string ("Show All"), void)
			l_menu.add_item (l_menu_item)

			create l_menu_item.separator_item
			l_menu.add_item (l_menu_item)

			create l_menu_item.make_with_title (create {NS_STRING}.make_with_string ("Quit #{appname}"), void)
			l_menu_item.set_key_equivalent ("q")
			l_menu_item.set_action (agent terminate)
			l_menu.add_item (l_menu_item)
		end

end
