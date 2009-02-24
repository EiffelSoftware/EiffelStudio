note
	description: "Defines the x and y coordinates of a point."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_POINT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		export
			{ANY} is_equal
		redefine
			is_equal
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

create
	make,
	make_by_pointer,
	make_by_cursor_position

feature {NONE} -- Initialization

	make (a_x, a_y: INTEGER)
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

	make_by_cursor_position
			-- Make a point and set `x' and `y' with
			-- the current cursor position.
		do
			structure_make
			set_cursor_position
		end

feature -- Access

	x: INTEGER
			-- x position
		do
			Result := cwel_point_get_x (item)
		end

	y: INTEGER
			-- y position
		do
			Result := cwel_point_get_y (item)
		end

feature -- Element change

	set_x_y (a_x, a_y: INTEGER)
			-- Set `x' with `a_x' and `y' with `a_y'.
		do
			cwel_point_set_x (item, a_x)
			cwel_point_set_y (item, a_y)
		ensure
			x_set: x = a_x
			y_set: y = a_y
		end

	set_x (a_x: INTEGER)
			-- Set `x' with `a_x'
		do
			cwel_point_set_x (item, a_x)
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER)
			-- Set `y' with `a_y'
		do
			cwel_point_set_y (item, a_y)
		ensure
			y_set: y = a_y
		end

	set_cursor_position
			-- Set `x' and `y' to the current cursor position.
		do
			cwin_get_cursor_position (item)
		end

feature -- Status report

	window_at: detachable WEL_WINDOW
			-- Window containing current point
		local
			ptr, null: POINTER
		do
			ptr := cwin_window_from_point (item)
			if ptr /= null then
				Result := window_of_item (ptr)
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `Current' equal to `other'?
		do
			Result := x = other.x and then y = other.y
		end

feature -- Conversion

	client_to_screen (window: WEL_WINDOW)
			-- Converts `Current' to screen relative position
			-- `window' is the client area to be used for
			-- the conversion
		require
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_client_to_screen (window.item, item)
		end

	screen_to_client (window: WEL_WINDOW)
			-- Converts `Current' to client relative position
			-- `window' is the client area to be used for
			-- the conversion
		require
			window_not_void: window /= Void
			window_exists: window.exists
		do
			cwin_screen_to_client (window.item, item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_point
		end

feature {NONE} -- Externals

	c_size_of_point: INTEGER
		external
			"C [macro <point.h>]"
		alias
			"sizeof (POINT)"
		end

	cwel_point_set_x (ptr: POINTER; value: INTEGER)
		external
			"C [struct <point.h>] (POINT, LONG)"
		alias
			"x"
		end

	cwel_point_set_y (ptr: POINTER; value: INTEGER)
		external
			"C [struct <point.h>] (POINT, LONG)"
		alias
			"y"
		end

	cwel_point_get_x (ptr: POINTER): INTEGER
		external
			"C [struct <point.h>] (POINT): EIF_INTEGER"
		alias
			"x"
		end

	cwel_point_get_y (ptr: POINTER): INTEGER
		external
			"C [struct <point.h>] (POINT): EIF_INTEGER"
		alias
			"y"
		end

	cwin_window_from_point (ptr: POINTER): POINTER
			-- SDK WindowFromPoint
			--| Special case since the parameter is a POINT and not
			--| a POINT *. So a macro is used.
		external
			"C [macro <point.h>] (POINT*): EIF_POINTER"
		end

	cwin_client_to_screen (hwnd, ptr: POINTER)
			-- SDK ClientToScreen
		external
			"C [macro <wel.h>] (HWND, POINT *)"
		alias
			"ClientToScreen"
		end

	cwin_screen_to_client (hwnd, ptr: POINTER)
			-- SDK ScreenToClient
		external
			"C [macro <wel.h>] (HWND, POINT *)"
		alias
			"ScreenToClient"
		end

	cwin_get_cursor_position (point: POINTER)
			-- SDK GetCursorPos
		external
			"C [macro <wel.h>] (POINT *)"
		alias
			"GetCursorPos"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
