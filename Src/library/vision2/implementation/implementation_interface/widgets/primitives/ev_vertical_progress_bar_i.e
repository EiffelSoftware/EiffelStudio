indexing 
	description: "EiffelVision vertical Progress bar, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_VERTICAL_PROGRESS_BAR_I

inherit
	EV_PROGRESS_BAR_I
		redefine
			set_default_options
		end

feature -- Status setting

	set_default_options is
			-- Initialize the options of the widget.
		do
			set_vertical_resize (True)
			set_horizontal_resize (False)
		end

end -- class EV_VERTICAL_PROGRESS_BAR_I

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
