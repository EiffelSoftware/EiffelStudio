indexing
	description: "Defines the x and y coordinates of a point."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_POINT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_x, a_y: INTEGER) is
			-- Make a point and set
			-- `x', `y' with `a_x', `a_y'
		do
			structure_make
			set_x (a_x)
			set_y (a_y)
		ensure
			x_set: x = a_x
			y_set: y = a_y
		end

feature -- Access

	x: INTEGER is
		require
			exists: exists
		do
			Result := cwel_point_get_x (item)
		end

	y: INTEGER is
		require
			exists: exists
		do
			Result := cwel_point_get_y (item)
		end

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'
		require
			exists: exists
		do
			cwel_point_set_x (item, a_x)
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'
		require
			exists: exists
		do
			cwel_point_set_y (item, a_y)
		ensure
			y_set: y = a_y
		end

	set_cursor_position is
			-- Set `x' and `y' to the current cursor position.
		require
			exists: exists
		do
			cwin_get_cursor_position (item)
		end

feature -- Conversion

	client_to_screen (window: WEL_WINDOW) is
			-- Converts `Current' to screen relative position
			-- `window' is the client area to be used for
			-- the conversion
		require
			exists: exists
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_client_to_screen (window.item, item)
		end

	screen_to_client (window: WEL_WINDOW) is
			-- Converts `Current' to client relative position
			-- `window' is the client area to be used for
			-- the conversion
		require
			exists: exists
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_screen_to_client (window.item, item)
		end

feature {WEL_STRUCTURE} -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_point
		end

feature {NONE} -- Externals

	c_size_of_point: INTEGER is
		external
			"C [macro <point.h>]"
		alias
			"sizeof (POINT)"
		end

	cwel_point_set_x (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <point.h>]"
		end

	cwel_point_set_y (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <point.h>]"
		end

	cwel_point_get_x (ptr: POINTER): INTEGER is
		external
			"C [macro <point.h>]"
		end

	cwel_point_get_y (ptr: POINTER): INTEGER is
		external
			"C [macro <point.h>]"
		end

	cwin_client_to_screen (hwnd, ptr: POINTER) is
			-- SDK ClientToScreen
		external
			"C [macro <wel.h>] (HWND, POINT *)"
		alias
			"ClientToScreen"
		end

	cwin_screen_to_client (hwnd, ptr: POINTER) is
			-- SDK ScreenToClient
		external
			"C [macro <wel.h>] (HWND, POINT *)"
		alias
			"ScreenToClient"
		end

	cwin_get_cursor_position (point: POINTER) is
			-- SDK GetCursorPos
		external
			"C [macro <wel.h>] (POINT *)"
		alias
			"GetCursorPos"
		end

end -- class WEL_POINT

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
