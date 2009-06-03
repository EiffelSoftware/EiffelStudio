note
	description: "Wrapper for NSScreen."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCREEN

inherit
	NS_OBJECT

create
	main_screen
create {NS_OBJECT}
	make_shared

feature {NONE} -- Getting NSScreen Objects

	main_screen
			-- Returns the NS_SCREEN object containing the window with the keyboard focus.
			-- The main screen is not necessarily the same screen that contains the menu bar or has its origin at (0, 0).
			-- The main screen refers to the screen containing the window that is currently receiving keyboard events.
			-- It is the main screen because it is the one with which the user is most likely interacting.
			-- The screen containing the menu bar is always the first object (index 0) in the array returned by the screens method.
			-- FIXME: This should probably be a once method, maybe in an ...ENVIRONEMENT class
		do
			make_shared ({NS_SCREEN_API}.main_screen)
		end

feature -- Getting Screen Information

	frame: NS_RECT
			-- Returns the dimensions and location of the receiver.
			-- The full screen rectangle at the current resolution. This rectangle includes any space currently occupied by the menu bar and dock.
		do
			create Result.make
			{NS_SCREEN_API}.frame (item, Result.item)
		end

	device_description: NS_DICTIONARY
			-- Returns the device dictionary for the screen.
			-- In addition to the display device constants described in NSWindow Class Reference, you can also retrieve the CGDirectDisplayID value
			-- associated with the screen from this dictionary. To access this value, specify the Objective-C string @"NSScreenNumber" as the key
			-- when requesting the item from the dictionary. The value associated with this key is an NSNumber object containing the display ID value.
			-- This string is only valid when used as a key for the dictionary returned by this method.
		do
			create Result.make_shared ({NS_SCREEN_API}.device_description (item))
		end


end
