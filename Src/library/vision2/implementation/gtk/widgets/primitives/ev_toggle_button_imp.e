indexing
	description: "EiffelVision toggle button, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"
	
class
	EV_TOGGLE_BUTTON_IMP
	
inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end
	
	EV_BUTTON_IMP
		redefine
			make,
			interface
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk toggle button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			C.gtk_toggle_button_set_active (button_widget, True)
		end

	disable_select is
				-- Set `is_selected' `False'.
		do
			C.gtk_toggle_button_set_active (button_widget, False)
		end

	toggle is
			-- Change the state of the toggle button.
		do
			if is_selected then
				disable_select
			else
				enable_select
			end
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := C.gtk_toggle_button_get_active (button_widget)
		end 

feature {EV_ANY_I}

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

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

