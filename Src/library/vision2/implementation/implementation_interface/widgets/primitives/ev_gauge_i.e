indexing
	description: "Eiffel Vision gauge. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GAUGE_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_GAUGE_ACTION_SEQUENCES_I

feature -- Access

	value: INTEGER is
			-- Current value of the gauge.
		deferred
		end

	step: INTEGER is
			-- Value by which `value' is increased after `step_forward'.
		deferred
		end

	leap: INTEGER is
			-- Value by which `value' is increased after `leap_forward'.
		deferred
		end

	value_range: ACTIVE_INTEGER_INTERVAL
			-- Range of `value'.

feature -- Status report

	proportion: REAL is
			-- Relative position of `value' in `range'. Range: [0, 1].
		local
			u, l: INTEGER
		do
			u := value_range.upper
			l := value_range.lower
			if u /= l then
				Result := (value - l) / (u - l)
			else
				--| By definition:
				Result := 0.0
			end
		end

feature -- Status setting

	step_forward is
			-- Increment `value' by `step' if possible.
		deferred
		ensure
			incremented: value = old value + step
				or else value = value_range.upper
		end

	step_backward is
			-- Decrement `value' by `step' if possible.
		deferred
		ensure
			decremented: value = old value - step
				or else value = value_range.lower
		end

	leap_forward is
			-- Increment `value' by `leap' if possible.
		deferred
		ensure
			incremented: value = old value + leap
				or else value = value_range.upper
		end

	leap_backward is
			-- Decrement `value' by `leap' if possible.
		deferred
		ensure
			decremented: value = old value - leap
				or else value = value_range.lower
		end

feature -- Element change

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		require
			value_in_range: value_range.has (a_value)
		deferred
		ensure
			assigned: value = a_value
		end

	set_step (a_step: INTEGER) is
			-- Set `step' to `a_step'.
		require
			a_step_positive: a_step > 0
		deferred
		ensure
			assigned: step = a_step
		end

	set_leap (a_leap: INTEGER) is
			-- Set `leap' to `a_leap'.
		require
			a_leap_non_negative: a_leap > 0
		deferred
		ensure
			assigned: leap = a_leap
		end

feature -- Status setting

	set_proportion (a_proportion: REAL) is
			-- Move `value' to `a_proportion' within `range'.
		require
			a_proportion_within_range: a_proportion >= 0 and a_proportion <= 1
		local
			u, l: INTEGER
		do
			u := value_range.upper
			l := value_range.lower
			if u /= l then
				set_value (((u - l) * a_proportion).rounded + l)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GAUGE

invariant

	value_range_not_void: is_usable implies value_range /= Void

end -- class EV_GAUGE_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.6  2001/02/16 00:10:51  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.3.4.5  2000/09/13 17:17:28  oconnor
--| updated for modified EV_GAUGE
--|
--| Revision 1.3.4.4  2000/07/24 21:30:48  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.3.4.3  2000/06/20 17:51:14  rogers
--| Fixed proportion to use maximum_user_setting.
--|
--| Revision 1.3.4.2  2000/06/17 00:01:30  rogers
--| Fixed calculation of proportion.
--|
--| Revision 1.3.4.1  2000/05/03 19:09:06  oconnor
--| mergred from HEAD
--|
--| Revision 1.10  2000/04/20 00:37:48  rogers
--| Fixed formula used in proportion.
--|
--| Revision 1.9  2000/04/19 21:56:51  brendel
--| Corrected set_proportion.
--|
--| Revision 1.8  2000/04/13 18:02:44  brendel
--| Added proportion and set_proportion.
--|
--| Revision 1.7  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/15 16:44:11  brendel
--| Moved implementating of feature `range' to _IMP.
--|
--| Revision 1.5  2000/02/14 22:19:51  brendel
--| Changed range instead of taking two integers to take an INTEGER_INTERVAL.
--| This is to take advantage of the newly introduced operator |..|.
--|
--| Revision 1.4  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.8  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.3.6.7  2000/02/02 00:59:34  brendel
--| Revised to comply with revised interface.
--|
--| Revision 1.3.6.6  2000/01/30 20:58:59  brendel
--| Added `reset_with_range'. Fixed bug in `make_with_range'.
--|
--| Revision 1.3.6.5  2000/01/29 02:43:38  brendel
--| Changed to comply with new interface.
--|
--| Revision 1.3.6.4  2000/01/27 19:30:03  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  2000/01/06 20:41:57  rogers
--| fixed to work with major new vision2 changes. Make with range no longer
--| takes a parent. redefined interface.
--|
--| Revision 1.3.6.2  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.3.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:44  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
