indexing 
	description: "EiffelVision vertical separator, implementation interface."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_VERTICAL_SEPARATOR_I

inherit
	EV_SEPARATOR_I
		redefine
			set_default_options
		end

feature {NONE} -- Initialization

	set_default_options is
			-- Common initializations for Gtk and Windows.
		do
			{EV_SEPARATOR_I} Precursor
			set_horizontal_resize (False)
			set_vertical_resize (True)
		end

end -- class EV_VERTICAL_SEPARATOR_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
