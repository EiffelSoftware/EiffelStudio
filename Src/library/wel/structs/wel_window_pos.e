indexing
	description: "Contains information about the size and position of a %
		%window."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_POS

inherit
	WEL_STRUCTURE

	WEL_WINDOW_MANAGER
		export
			{NONE} all
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_pointer

feature -- Access

	window: WEL_WINDOW is
			-- Identifies the window
		do
			Result := window_of_item (cwel_windowpos_get_hwnd (item))
		end

	window_insert_after: WEL_WINDOW is
			-- Position of the window in Z order (front-to-back
			-- position). This window can be the window behind
			-- which this window is placed.
		do
			Result := window_of_item (cwel_windowpos_get_hwndinsertafter (item))
		end

	hwindow_insert_after: POINTER is
			-- Position of the window in Z order (front-to-back
			-- position). This window can be the window behind
			-- which this window is placed.
		do
			Result := cwel_windowpos_get_hwndinsertafter (item)
		end

	x: INTEGER is
			-- Position of the left edge of the window
		do
			Result := cwel_windowpos_get_x (item)
		end

	y: INTEGER is
			-- Position of the top edge of the window
		do
			Result := cwel_windowpos_get_y (item)
		end

	width: INTEGER is
			-- Window width
		do
			Result := cwel_windowpos_get_width (item)
		ensure
			positive_result: Result >= 0
		end

	height: INTEGER is
			-- Window height
		do
			Result := cwel_windowpos_get_height (item)
		ensure
			positive_result: Result >= 0
		end

	flags: INTEGER is
			-- Window position flags
			-- See class WEL_SWP_CONSTANTS for values
		do
			Result := cwel_windowpos_get_flags (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'.
		do
			cwel_windowpos_set_x (item, a_x)
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'.
		do
			cwel_windowpos_set_y (item, a_y)
		ensure
			y_set: y = a_y
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'.
		do
			cwel_windowpos_set_width (item, a_width)
		ensure
			width_set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'.
		do
			cwel_windowpos_set_height (item, a_height)
		ensure
			height_set: height = a_height
		end

	set_flags (a_flags: INTEGER) is
			-- Set `flags' with `a_flags'.
			-- See class WEL_SWP_CONSTANTS for `a_flags' values.
		do
			cwel_windowpos_set_flags (item, a_flags)
		ensure
			flags_set: flags = a_flags
		end

	set_window (a_window: WEL_WINDOW) is
			-- Set `window' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_windowpos_set_hwnd (item, a_window.item)
		ensure
			window_set: window = a_window
		end

	set_window_insert_after (a_window: WEL_WINDOW) is
			-- Set `window_insert_after' with `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			cwel_windowpos_set_hwndinsertafter (item, a_window.item)
		ensure
			window_insert_after_set: window_insert_after = a_window
		end

	set_hwindow_insert_after (a_window: POINTER) is
			-- Set `window_insert_after' with `a_window'.
		do
			cwel_windowpos_set_hwndinsertafter (item, a_window)
		end

	set_top is
			-- Place the window at the top of the Z order.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_top)
		end

	set_bottom is
			-- Place the window at the bottom of the Z order.
			-- If `window' identifies a topmost window, the window
			-- loses its topmost status and is placed at the bottom
			-- of all other windows.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_bottom)
		end

	set_topmost is
			-- Places the window above all non-topmost windows.
			-- The window maintains its topmost position even when
			-- it is deactivated.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_topmost)
		end

	set_no_topmost is
			-- Places the window above all non-topmost windows
			-- (that is, behind all topmost windows). No effect
			-- if the window is already a non-topmost window.
		do
			cwel_windowpos_set_hwndinsertafter (item, Hwnd_notopmost)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_windowpos
		end

feature {NONE} -- Externals

	c_size_of_windowpos: INTEGER is
		external
			"C [macro <winpos.h>]"
		alias
			"sizeof (WINDOWPOS)"
		end

	cwel_windowpos_set_hwnd (ptr: POINTER; value: POINTER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, HWND)"
		end

	cwel_windowpos_set_hwndinsertafter (ptr: POINTER; value: POINTER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, HWND)"
		end

	cwel_windowpos_set_x (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_y (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_width (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_height (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, int)"
		end

	cwel_windowpos_set_flags (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <winpos.h>] (WINDOWPOS*, UINT)"
		end

	cwel_windowpos_get_hwnd (ptr: POINTER): POINTER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_POINTER"
		end

	cwel_windowpos_get_hwndinsertafter (ptr: POINTER): POINTER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_POINTER"
		end

	cwel_windowpos_get_x (ptr: POINTER): INTEGER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_y (ptr: POINTER): INTEGER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_width (ptr: POINTER): INTEGER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_height (ptr: POINTER): INTEGER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

	cwel_windowpos_get_flags (ptr: POINTER): INTEGER is
		external
			"C [macro <winpos.h>] (WINDOWPOS*): EIF_INTEGER"
		end

end -- class WEL_WINDOW_POS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

