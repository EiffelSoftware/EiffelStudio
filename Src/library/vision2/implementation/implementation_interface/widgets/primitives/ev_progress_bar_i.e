indexing 
	description: "EiffelVision Progress bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_I

inherit
	EV_PRIMITIVE_I

feature -- Status setting

	set_percentage (value: INTEGER) is
			-- Make `value' the new percentage filled by the
			-- progress bar.
		require
			exists: not destroyed
			valid_value: value >= 0 and value <= 100
		deferred
		end

	set_segmented (flag: BOOLEAN) is
			-- Set the bar in segmented mode if True and in
			-- continuous mode otherwise.
		require
			exist: not destroyed
		deferred
		end

end -- class EV_PROGRESSBAR_I

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
