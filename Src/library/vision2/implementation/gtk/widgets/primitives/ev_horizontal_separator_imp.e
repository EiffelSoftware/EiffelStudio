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
			set_c_object (C.gtk_event_box_new)
			p := C.gtk_hseparator_new
			C.gtk_widget_show (p)
			C.gtk_container_add (c_object, p)
                end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_SEPARATOR

end -- class EV_HORIZONTAL_SEPARATOR_IMP

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

