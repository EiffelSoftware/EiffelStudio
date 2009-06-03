note
	description: "Wrapper for NSApplication."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_APPLICATION

inherit
	NS_OBJECT

create
	make
create {NS_OBJECT}
	make_shared

feature {NONE} -- Creation

	make
		do
			{NS_APPLICATION_API}.init
			make_shared ({NS_APPLICATION_API}.get)
			{NS_APPLICATION_API}.finish_launching (item)
		end

feature -- Access

	next_event (a_matching_mask: INTEGER; a_until_date: POINTER; a_in_mode: INTEGER; a_dequeue: BOOLEAN): POINTER
		do
			Result := {NS_APPLICATION_API}.next_event (item, a_matching_mask, a_until_date, a_in_mode, a_dequeue)
		end

	update_windows
		do
			{NS_APPLICATION_API}.update_windows (item)
		end

	send_event (a_event: POINTER)
		do
			{NS_APPLICATION_API}.send_event (item, a_event)
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

	run_modal_for_window (a_window: NS_WINDOW): INTEGER
		do
			Result := {NS_APPLICATION_API}.run_modal_for_window (item, a_window.item)
		end

	fix_apple_menu
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
