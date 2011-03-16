note
	description: "Contains information about the size and position of a %
		%window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_POS

inherit
	WEL_STRUCTURE

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make,
	make_by_pointer

feature -- Access

	window: detachable WEL_WINDOW
			-- Identifies the window
		do
			Result := window_of_item (cwel_windowpos_get_hwnd (item))
		end

	window_insert_after: detachable WEL_WINDOW
			-- Position of the window in Z order (front-to-back
			-- position). This window can be the window behind
			-- which this window is placed.
		local
			window_pointer: POINTER
		do
			window_pointer := cwel_windowpos_get_hwndinsertafter (item)
			if is_window (window_pointer) then
				Result := window_of_item (window_pointer)
			end
		end

	hwnd: POINTER
			-- Identifies the window
		do
			Result := cwel_windowpos_get_hwnd (item)
		end

	hwindow_insert_after: POINTER
			-- Position of the window in Z order (front-to-back
			-- position). This window can be the window behind
			-- which this window is placed.
		do
			Result := cwel_windowpos_get_hwndinsertafter (item)
		end

	x: INTEGER
			-- Position of the left edge of the window
		do
			Result := cwel_windowpos_get_x (item)
		end

	y: INTEGER
			-- Position of the top edge of the window
		do
			Result := cwel_windowpos_get_y (item)
		end

	width: INTEGER
			-- Window width
		do
			Result := cwel_windowpos_get_width (item)
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER
			-- Window height
		do
			Result := cwel_windowpos_get_height (item)
		ensure
			positive_result: Result >= 0
		end

	flags: INTEGER
			-- Window position flags
			-- See class WEL_SWP_CONSTANTS for values
		do
			Result := cwel_windowpos_get_flags (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Element change

	set_x (a_x: INTEGER)
			-- Set `x' with `a_x'.
		do
			cwel_windowpos_set_x (item, a_x)
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER)
			-- Set `y' with `a_y'.
		do
			cwel_windowpos_set_y (item, a_y)
		ensure
			y_set: y = a_y
		end

	set_width (a_width: INTEGER)
			-- Set `width' with `a_width'.
		do
			cwel_windowpos_set_width (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER)
			-- Set `height' with `a_height'.
		do
			cwel_windowpos_set_height (item, a_height)
		ensure
			height_set: height = a_height
		end

	set_flags (a_flags: INTEGER)
			-- Set `flags' with `a_flags'.
			-- See class WEL_SWP_CONSTANTS for `a_flags' values.
		do
			cwel_windowpos_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	set_hwnd (a_hwnd: POINTER)
			-- Set `hwnd' with `a_hwnd'.
		do
			cwel_windowpos_set_hwnd (item, a_hwnd)
		ensure
			hwnd_set: hwnd = a_hwnd
		end

	set_window (a_window: WEL_WINDOW)
			-- Set `window' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_windowpos_set_hwnd (item, a_window.item)
		ensure
			window_set: window = a_window
		end

	set_window_insert_after (a_window: WEL_WINDOW)
			-- Set `window_insert_after' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_windowpos_set_hwndinsertafter (item, a_window.item)
		ensure
			window_insert_after_set: window_insert_after = a_window
		end

	set_hwindow_insert_after (a_window: POINTER)
			-- Set `window_insert_after' with `a_window'.
		do
			cwel_windowpos_set_hwndinsertafter (item, a_window)
		end

	set_top
			-- Place the window at the top of the Z order.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_top)
		end

	set_bottom
			-- Place the window at the bottom of the Z order.
			-- If `window' identifies a topmost window, the window
			-- loses its topmost status and is placed at the bottom
			-- of all other windows.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_bottom)
		end

	set_topmost
			-- Places the window above all non-topmost windows.
			-- The window maintains its topmost position even when
			-- it is deactivated.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_topmost)
		end

	set_no_topmost
			-- Places the window above all non-topmost windows
			-- (that is, behind all topmost windows). No effect
			-- if the window is already a non-topmost window.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_notopmost)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_windowpos
		end

feature {NONE} -- Externals

	c_size_of_windowpos: INTEGER
		external
			"C [macro <winpos.h>]"
		alias
			"sizeof (WINDOWPOS)"
		end

	cwel_windowpos_set_hwnd (ptr: POINTER; value: POINTER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, HWND)"
		end

	cwel_windowpos_set_hwndinsertafter (ptr: POINTER; value: POINTER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, HWND)"
		end

	cwel_windowpos_set_x (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_y (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_width (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_height (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_flags (ptr: POINTER; value: INTEGER)
		external
			"C [macro <winpos.h>] (WINDOWPOS*, UINT)"
		end

	cwel_windowpos_get_hwnd (ptr: POINTER): POINTER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_POINTER"
		end

	cwel_windowpos_get_hwndinsertafter (ptr: POINTER): POINTER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_POINTER"
		end

	cwel_windowpos_get_x (ptr: POINTER): INTEGER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_y (ptr: POINTER): INTEGER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_width (ptr: POINTER): INTEGER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_height (ptr: POINTER): INTEGER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_flags (ptr: POINTER): INTEGER
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
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
