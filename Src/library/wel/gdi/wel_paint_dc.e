indexing
	description: "Device context used during a Wm_paint message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PAINT_DC

inherit
	WEL_DISPLAY_DC
		rename
			make_by_pointer as simple_make_by_pointer
		redefine
			destroy_item
		end

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_window: WEL_WINDOW) is
			-- Makes a DC associated with `a_window'
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			window := a_window
			hwindow := a_window.item
			create paint_struct.make
		ensure
			window_set: window = a_window
		end

	make_by_pointer (a_window: WEL_WINDOW; a_pointer: POINTER) is
			-- Makes a DC associated with `a_pointer' and `a_window'
		do
			window := a_window
			hwindow := a_window.item
			simple_make_by_pointer (a_pointer)
			create paint_struct.make
		ensure
			window_set: window = a_window
		end

feature -- Access

	window: WEL_WINDOW
			-- Window associated to the paint dc

	paint_struct: WEL_PAINT_STRUCT
			-- Information about the Wm_paint message

feature -- Basic operations

	get is
			-- Get the device context
		do
			item := cwin_begin_paint (hwindow, paint_struct.item)
		end

	release, quick_release is
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			cwin_end_paint (hwindow, paint_struct.item)
			item := a_default_pointer
		end

feature {NONE} -- Implementation

	hwindow: POINTER
			-- Window handle associated with the device context

feature {NONE} -- Removal

	destroy_item is
			-- Delete the current device context.
		local
			a_default_pointer: POINTER
		do
				-- Protect the call to DeleteDC, because `destroy_item' can 
				-- be called by the GC so without assertions.
			if item /= a_default_pointer then
				unselect_all
				cwin_end_paint (hwindow, paint_struct.item)
				item := a_default_pointer
			end
		end

feature {NONE} -- Externals

	cwin_begin_paint (hwnd, a_paint_struct: POINTER): POINTER is
			-- SDK BeginPaint
		external
			"C [macro <wel.h>] (HWND, PAINTSTRUCT *): EIF_POINTER"
		alias
			"BeginPaint"
		end

	cwin_end_paint (hwnd, a_paint_struct: POINTER) is
			-- SDK EndPaint
		external
			"C [macro <wel.h>] (HWND, PAINTSTRUCT *)"
		alias
			"EndPaint"
		end

end -- class WEL_PAINT_DC

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

