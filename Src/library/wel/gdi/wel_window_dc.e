indexing
	description: "Window's area device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_DC

inherit
	WEL_DISPLAY_DC
		redefine
			destroy_item
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_window: WEL_WINDOW) is
			-- Makes a DC associated with `a_window'
		require
			a_window_not_void: a_window /= Void
			a_window_exists: a_window.exists
		do
			hwindow := a_window.item
			window := a_window
		ensure
			window_set: window = a_window
		end

feature -- Access

	window: WEL_WINDOW
			-- Window associated with the dc

feature -- Basic operations

	get is
			-- Get the device context
		do
			check
				window_not_void: window /= Void
				window_exist: window.exists
			end
			item := cwin_get_window_dc (hwindow)
		end

	release is
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			check
				window_not_void: window /= Void
				window_exist: window.exists
			end
			unselect_all
			cwin_release_dc (hwindow, item)
			item := a_default_pointer
		end

	quick_release is
			-- Release the device context
			-- Call this feature only if you are sure
			-- that no object is selected in the device
			-- context. Otherwise, use `release' instead.
		local
			a_default_pointer: POINTER
		do
			check
				window_not_void: window /= Void
				window_exist: window.exists
			end
			cwin_release_dc (hwindow, item)
			item := a_default_pointer
		end

feature {NONE} -- Implementation

	hwindow: POINTER
			-- Window handle associated with the device context

	destroy_item is
		local
			a_default_pointer: POINTER
		do
			unselect_all
			cwin_release_dc (a_default_pointer, item)
			item := a_default_pointer
		end

feature {NONE} -- Externals

	cwin_get_window_dc (hwnd: POINTER): POINTER is
			-- SDK GetWindowDC
		external
			"C [macro <wel.h>] (HWND): EIF_POINTER"
		alias
			"GetWindowDC"
		end

end -- class WEL_WINDOW_DC

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

