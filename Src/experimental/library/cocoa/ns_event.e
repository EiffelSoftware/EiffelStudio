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
	make_from_pointer

feature -- Getting General Event Information

	location_in_window: NS_POINT
			-- Returns the receiver's location in the base coordinate system of the associated window.
		do
			create Result.make
			{NS_EVENT_API}.location_in_window (item, Result.item)
		ensure
			x_position_valid: 0 < Result.x
			y_position_valid: 0 < Result.y
		end

	type: INTEGER
		do
			Result := {NS_EVENT_API}.type (item)
		ensure
			valid_type: --
		end

	window: NS_WINDOW
			-- Returns the window object associated with the receiver.
			-- A periodic event, however, has no window.
		require
			type_not_periodic: type /= periodic
		do
			create Result.share_from_pointer ({NS_EVENT_API}.window (item))
		ensure
			result_not_void: Result /= void
		end

feature -- Getting Mouse Event Information

	button_number: INTEGER
			-- Returns the button number for the mouse button that generated an NSOtherMouse... event.
			-- This method is intended for use with the NSOtherMouseDown, NSOtherMouseUp, and NSOtherMouseDragged events, but will return values for NSLeftMouse... and NSRightMouse... events also.
		do
			Result := {NS_EVENT_API}.button_number (item)
		end

feature -- Contract Support

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

	frozen right_mouse_down: INTEGER
			-- NSRightMouseDown
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRightMouseDown"
		end

	frozen right_mouse_up: INTEGER
			-- NSRightMouseUp
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSRightMouseUp"
		end

	frozen other_mouse_down: INTEGER
			-- NSOtherMouseDown
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOtherMouseDown"
		end

	frozen other_mouse_up: INTEGER
			-- NSOtherMouseUp
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSOtherMouseUp"
		end

	frozen mouse_moved: INTEGER
			-- NSMouseMoved
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMouseMoved"
		end

	frozen mouse_entered: INTEGER
			-- NSMouseEntered
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMouseEntered"
		end

	frozen mouse_exited: INTEGER
			-- NSMouseExited
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSMouseExited"
		end

	frozen periodic: INTEGER
			-- NSPeriodic
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSPeriodic"
		end

end
