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
			set_c_object ({EV_GTK_EXTERNALS}.gtk_toggle_button_new)
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			if not is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, True)
			end
		end

	disable_select is
				-- Set `is_selected' `False'.
		do
			if is_selected then
				{EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (visual_widget, False)
			end	
		end

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (visual_widget)
		end 

feature {EV_ANY_I}

	interface: EV_TOGGLE_BUTTON

end -- class EV_TOGGLE_BUTTON_IMP

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

