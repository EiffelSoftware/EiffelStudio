indexing
	description: "Eiffel Vision vertical scroll bar. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR_IMP

inherit
	EV_VERTICAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the horizontal scroll bar.
		local
			vs: POINTER
		do
			base_make (an_interface)
			adjustment := feature {EV_GTK_EXTERNALS}.gtk_adjustment_new (0, 0, 100 + 10, 1, 10, 10)
			vs := feature {EV_GTK_EXTERNALS}.gtk_vscrollbar_new (adjustment)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (vs)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_event_box_new)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, vs)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SCROLL_BAR

end -- class EV_VERTICAL_SCROLL_BAR_IMP

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

