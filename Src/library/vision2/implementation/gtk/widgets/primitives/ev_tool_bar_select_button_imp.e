indexing
        description: "Eiffel Vision radio button. GTK+ implementation."
        status: "See notice at end of class"
        date: "$Date$"
        revision: "$Revision$"
        
deferred class
	EV_TOOL_BAR_SELECT_BUTTON_IMP
        
inherit
	EV_TOOL_BAR_SELECT_BUTTON_I
		redefine
			interface
		end
	
	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

feature -- Initialization

	make (an_interface: like interface) is
		-- Create the tool-bar toggle button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
		end

feature -- Implementation

	is_selected: BOOLEAN is
		do
			Result := C.gtk_toggle_button_get_active (c_object)
		end

	enable_select is
		do
			C.gtk_toggle_button_set_active (c_object, True)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SELECT_BUTTON

end -- class EV_TOOL_BAR_SELECT_BUTTON_IMP

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

