indexing
	description: "Window's client area device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIENT_DC

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
			-- Window associated with the device context

feature -- Basic operations

	get is
			-- Get the device context
		do
			check
				window_not_void: window /= Void
				window_exist: window.exists
			end
			item := cwin_get_dc (hwindow)
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

feature {NONE} -- Removal

	destroy_item is
			-- Delete the current device context.
		local
			a_default_pointer: POINTER	-- Default_pointer
		do
				-- Protect the call to DeleteDC, because `destroy_item' can 
				-- be called by the GC so without assertions.
			if item /= a_default_pointer then
				unselect_all
				cwin_release_dc (hwindow, item)
				item := a_default_pointer
			end
		end

end -- class WEL_CLIENT_DC

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

