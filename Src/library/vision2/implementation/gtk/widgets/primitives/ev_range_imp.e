indexing 
	description: "Eiffel Vision range. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_IMP

inherit
	EV_RANGE_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			maximum,
			set_maximum,
			set_range,
			reset_with_range
		end

feature -- Access

	maximum: INTEGER is
			-- Highest value of the scroll bar.
		do
			Result := Precursor - leap
		end

	set_maximum (a_maximum: INTEGER) is
			-- Set `maximum' to `a_maximum'.
			--| We cannot call precursor because it has wrong postconditions.
		do
			if maximum /= a_maximum then
				C.set_gtk_adjustment_struct_upper (adjustment, a_maximum + leap)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	set_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
		do
			if minimum /= a_range.lower or else maximum /= a_range.upper then
				C.set_gtk_adjustment_struct_lower (adjustment, a_range.lower)
				C.set_gtk_adjustment_struct_upper (adjustment, a_range.upper + leap)
				C.gtk_adjustment_changed (adjustment)
			end
		end

	reset_with_range (a_range: INTEGER_INTERVAL) is
			-- Set `range' to `a_range'.
			-- Set `value' to `a_range.lower'.
		do
			C.set_gtk_adjustment_struct_lower (adjustment, a_range.lower)
			C.set_gtk_adjustment_struct_upper (adjustment, a_range.upper + leap)
			C.gtk_adjustment_set_value (adjustment, a_range.lower)
			C.gtk_adjustment_value_changed (adjustment)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RANGE

end -- class EV_RANGE_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/14 22:53:27  brendel
--| Corrected small errors occured while copying & pasting.
--|
--| Revision 1.6  2000/02/14 22:19:51  brendel
--| Changed range instead of taking two integers to take an INTEGER_INTERVAL.
--| This is to take advantage of the newly introduced operator |..|.
--|
--| Revision 1.5  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.4  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.4.6.3  2000/02/02 01:03:20  brendel
--| Fixed small bug in maximum, where the widget could only reach maximum - leap,
--| where it now can reach maximum.
--|
--| Revision 1.4.6.2  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
