indexing 
	description: "EiffelVision color selection dialog %
		%implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COLOR_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `color'.
		require
			a_color_not_void: a_color /= Void
		deferred
		end

end -- class EV_COLOR_DIALOG_I

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

