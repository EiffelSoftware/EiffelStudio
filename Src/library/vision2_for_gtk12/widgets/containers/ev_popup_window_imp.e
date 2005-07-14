indexing
	description: "EiffelVision popup window, GTK+ implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_WINDOW_IMP

inherit
	EV_POPUP_WINDOW_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_WINDOW_IMP
		redefine
			interface,
			make,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_window_new ({EV_GTK_EXTERNALS}.gtk_window_toplevel_enum))
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_WINDOW_IMP}
			--{EV_GTK_EXTERNALS}.gtk_window_set_decorated (c_object , False)
			--{EV_GTK_EXTERNALS}.gtk_window_set_skip_pager_hint (c_object, True)
			--{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
			set_is_initialized (True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_POPUP_WINDOW
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_POPUP_WINDOW_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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
