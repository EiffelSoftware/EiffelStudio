indexing
	description: "Desktop device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DESKTOP_DC

inherit
	WEL_DISPLAY_DC
		undefine
			destroy_item
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Makes a DC associated with the Desktop Window
		do
			hwindow := cwin_get_desktop_window
		end

feature -- Basic operations

	get is
			-- Get the device context
		do
			item := cwin_get_dc (hwindow)
		end

	release is
			-- Release the device context
		do
			unselect_all
			cwin_release_dc (hwindow, item)
			item := default_pointer
		end

	quick_release is
		do
			cwin_release_dc (hwindow, item)
			item := default_pointer
		end

feature {NONE} -- Implementation

	hwindow: POINTER
			-- Window handle associated with the device context

feature {NONE} -- Removal

	destroy_item is
		do
			unselect_all
			cwin_release_dc (hwindow, item)
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_get_desktop_window: POINTER is
			-- SDK GetDesktopWindow
		external
			"C [macro <wel.h>]: EIF_POINTER"
		alias
			"GetDesktopWindow ()"
		end

end -- class WEL_DESKTOP_DC

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

