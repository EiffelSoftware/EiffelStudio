indexing
	description: "Eiffel Vision dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UNTITLED_DIALOG_IMP
	
inherit
	EV_DIALOG_IMP
		redefine
			make,
			interface,
			set_size,
			has_wm_decorations,
			initialize
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create empty dialog box.
		do
			base_make (an_interface)
			set_c_object (create_gtk_dialog)
				-- Cannot use popup window as Window manager cannot give focus to it.
		end
		
		initialize is
				-- Initialize `Current'
			do
				Precursor {EV_DIALOG_IMP}
				feature {EV_GTK_EXTERNALS}.gdk_window_set_decorations (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object), 0)
					-- We don't want any decorations at all
			end

feature -- Status setting	
		
	set_size (a_width, a_height: INTEGER) is
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			update_request_size
			default_width := a_width
			default_height := a_height
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, default_width.max (minimum_width), default_height.max (minimum_height))
		end

feature {NONE} -- Implementation

	has_wm_decorations: BOOLEAN is
			-- Does the current window object have window decorations.
		do
			Result := False
		end

	interface: EV_UNTITLED_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

