note
	description: "Wrapper for NSScreen."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SCREEN

inherit
	NS_OBJECT

create {NS_OBJECT, NS_ENVIRONEMENT}
	make_from_pointer,
	share_from_pointer

feature {NONE} -- Getting NSScreen Objects

	-- See NS_ENVIRONEMENT

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
			create Result.make_from_pointer ({NS_SCREEN_API}.device_description (item))
		end


end
