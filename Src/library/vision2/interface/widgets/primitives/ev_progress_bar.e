indexing 
	description:
		"Base class for bar graph gauges that display progress of a process.%N%
		%See EV_HORIZONTAL_PROGRESS_BAR and EV_VERTICAL_PROGRESS_BAR"
	note: "Default step is 10."
	--| FIXME this not is not inforced, need to add `is_in_default_state'.
	status: "See notice at end of class"
	keywords: "status, progress, bar"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR

inherit
	EV_GAUGE
		redefine
			implementation
		end

feature -- Access

	proportion: REAL is
			-- Proportion of bar filled. Range: [0,1].
		do
			Result := implementation.proportion
		ensure
			bridge_ok: Result = implementation.proportion
		end

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		do
			Result := implementation.is_segmented
		ensure
			bridge_ok: Result = implementation.is_segmented
		end

feature -- Status setting

	enable_segmentation is
			-- Divide display of bar into segments.
		do
			implementation.enable_segmentation
		ensure
			is_segmented: is_segmented
		end

	disable_segmentation is
			-- Display continuous bar.
		do
			implementation.disable_segmentation
		ensure
			not_is_segmented: not is_segmented
		end

	set_proportion (a_proportion: REAL) is
			-- Assign `a_proportion' to `proportion'.
		require
			a_proportion_within_range: a_proportion >= 0 and a_proportion <= 1
		do
			implementation.set_proportion (a_proportion)
		ensure
			a_proportion_assigned:
				(proportion - a_proportion).abs < step / (maximum - minimum)
		end

feature {NONE} -- Implementation

	implementation: EV_PROGRESS_BAR_I
			-- Responsible for interaction with the native graphics toolkit.

invariant
	proportion_within_range: proportion >= 0 and proportion <= 1
	proportion_definition: maximum = minimum implies proportion = 1.0

end -- class EV_PROGRESS_BAR

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
--| Revision 1.10  2000/03/21 19:10:39  oconnor
--| comments, formatting
--|
--| Revision 1.9  2000/02/29 18:09:10  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.8  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/16 03:53:07  brendel
--| Added invariant for proportion, which states that whenever maximum
--| = minimum, proportion should be 0.0.
--|
--| Revision 1.6  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.5  2000/01/31 21:30:50  brendel
--| Revised.
--|
--| Revision 1.5.6.4  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.5.6.3  2000/01/27 19:30:56  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/17 19:08:49  oconnor
--| changed percentage to proportion, set_segmented to enable_segmentation
--|
--| Revision 1.5.6.1  1999/11/24 17:30:55  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.5.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
