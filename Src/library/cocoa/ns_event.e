note
	description: "Summary description for {NS_EVENT}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_EVENT

inherit
	NS_OBJECT

create {NS_OBJECT, ANY}
	make_shared

feature -- Access

	location_in_window: NS_POINT
			-- Returns the receiver's location in the base coordinate system of the associated window.
		do
			create Result.make
			{NS_EVENT_API}.location_in_window (item, Result.item)
		end

	type: INTEGER
		do
			Result := {NS_EVENT_API}.type (item)
		ensure
			valid_type: --
		end

feature -- NSEventType Constants

	frozen left_mouse_down: INTEGER
			-- NSLeftMouseDown
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLeftMouseDown"
		end

	frozen left_mouse_up: INTEGER
			-- NSLeftMouseUp
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSLeftMouseUp"
		end

end
