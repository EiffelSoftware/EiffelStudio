indexing
	description:
		"Eiffel Vision vertical separator. GTK+ implementation"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
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
			-- Create a GTK vertical seperator in an event box.
		local
			p: POINTER
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			p := C.gtk_vseparator_new
			C.gtk_widget_show (p)
			C.gtk_container_add (c_object, p)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SEPARATOR

end -- class EV_VERTICAL_SEPARATOR_IMP

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

