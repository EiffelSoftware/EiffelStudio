indexing 
	description: "EiffelVision Progress bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

feature -- Status setting

	set_segmented is
			-- Set the bar in segmented mode.
		require
			exist: not destroyed
		do
			implementation.set_segmented (True)
		end

	set_continuous is
			-- Set the bar in continuous mode.
			-- Make the bar continuous.
		require
			exist: not destroyed
		do
			implementation.set_segmented (False)
		end

	set_percentage (value: INTEGER) is
			-- Make `value' the new percentage filled by the
			-- progress bar.
		require
			exists: not destroyed
			valid_value: value >= 0 and value <= 100
		do
			implementation.set_percentage (value)
		end

feature -- Implementation

	implementation: EV_PROGRESS_BAR_I

end -- class EV_PROGRESS_BAR

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

