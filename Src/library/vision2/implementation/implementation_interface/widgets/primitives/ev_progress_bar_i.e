indexing 
	description: "Eiffel Vision progress bar. Implementation interface." 
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_I

inherit
	EV_GAUGE_I

feature -- Access

	proportion: REAL is
			-- Proportion of bar filled. Range: [0,1].
		deferred
		end

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		deferred
		end

feature -- Status setting

	enable_segmentation is
			-- Display bar divided into segments.
		deferred
		ensure
			is_segmented: is_segmented
		end

	disable_segmentation is
			-- Display bar without segments.
		deferred
		ensure
			not_is_segmented: not is_segmented
		end

	set_proportion (a_proportion: REAL) is
			-- Display bar with `a_proportion' filled.
		require
			a_proportion_within_range: a_proportion >= 0 and a_proportion <= 1
		deferred
		ensure
			assigned: (proportion - a_proportion).abs < step / (maximum - minimum)
		end

end -- class EV_PROGRESSBAR_I

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.6  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.5.6.4  2000/01/31 21:31:34  brendel
--| Changed to comply with revised interface.
--|
--| Revision 1.5.6.3  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/17 19:08:01  oconnor
--| changed percentage to proportion
--|
--| Revision 1.5.6.1  1999/11/24 17:30:13  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
