indexing
	description:
		"EiffelVision horizontal separator, gtk implementation";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
				-- Create a horizontal gtk separator.
		local
			p: POINTER
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
			p := {EV_GTK_EXTERNALS}.gtk_hseparator_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (p)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, p)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, -1, 1)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SEPARATOR

end -- class EV_HORIZONTAL_SEPARATOR_IMP

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

