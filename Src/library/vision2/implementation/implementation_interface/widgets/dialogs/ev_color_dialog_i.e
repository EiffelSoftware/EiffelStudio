indexing 
	description: "EiffelVision color selection dialog, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLOR_SELECTION_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	color: EV_COLOR is
			-- Current selected color
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	select_color (a_color: EV_COLOR) is
			-- Select `a_color'.
		require
			exists: not destroyed
			valid_color: is_valid (color)
		deferred
		end

end -- class EV_COLOR_SELECTION_DIALOG_I

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
