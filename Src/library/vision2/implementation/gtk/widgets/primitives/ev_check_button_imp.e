indexing
	description: "EiffelVision check button, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end
	
	EV_TOGGLE_BUTTON_IMP
		redefine
			make, set_text, interface, button_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk check button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			button_widget := C.gtk_check_button_new
			C.gtk_widget_show (button_widget)
			C.gtk_container_add (c_object, button_widget)
		end

	button_widget: POINTER 
			-- Pointer to gtkbutton widget as c_object is event box.
			

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
			-- Redefined because we want the text to be left-aligned.
		do
			{EV_TOGGLE_BUTTON_IMP} Precursor (txt)

			-- We left-align and vertical_center-position the text
			C.gtk_misc_set_alignment (text_label, 0.0, 0.5)

			if gtk_pixmap /= NULL then
				C.gtk_misc_set_alignment (pixmap_box, 0.0, 0.5)
			end				
		end

feature {EV_ANY_I}

	interface: EV_CHECK_BUTTON
	
end -- class EV_CHECK_BUTTON_IMP

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

