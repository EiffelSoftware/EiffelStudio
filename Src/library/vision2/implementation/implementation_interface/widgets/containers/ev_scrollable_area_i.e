indexing
	description: "EiffelVision scrollable area. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SCROLLABLE_AREA_I
	
inherit
	EV_VIEWPORT_I

feature -- Access

	horizontal_step: INTEGER is
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scroll bar.
		deferred
		end

	vertical_step: INTEGER is
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scroll bar.
		deferred
		end

	is_horizontal_scroll_bar_visible: BOOLEAN is
			-- Should horizontal scroll bar be displayed?
		deferred
		end

	is_vertical_scroll_bar_visible: BOOLEAN is
			-- Should vertical scroll bar be displayed?
		deferred
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER) is
			-- Set `horizontal_step' to `a_step'.
		require
			a_step_positive: a_step > 0
		deferred
		ensure
			assigned: horizontal_step = a_step
		end

	set_vertical_step (a_step: INTEGER) is
			-- Set `vertical_step' to `a_step'.
		require
			a_step_positive: a_step > 0
		deferred
		ensure
			assigned: vertical_step = a_step
		end

	show_horizontal_scroll_bar is
			-- Display horizontal scroll bar.
		deferred
		ensure
			shown: is_horizontal_scroll_bar_visible
		end

	hide_horizontal_scroll_bar is
			-- Do not display horizontal scroll bar.
		deferred
		ensure
			hidden: not is_horizontal_scroll_bar_visible
		end

	show_vertical_scroll_bar is
			-- Display vertical scroll bar.
		deferred
		ensure
			shown: is_vertical_scroll_bar_visible
		end

	hide_vertical_scroll_bar is
			-- Do not display vertical scroll bar.
		deferred
		ensure
			hidden: not is_vertical_scroll_bar_visible
		end

end -- class EV_SCROLLABLE_AREA_I

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
--| Revision 1.8  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/21 23:07:58  brendel
--| scrollbar -> scroll_bar.
--|
--| Revision 1.6  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.5  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.4.6.4  2000/01/29 01:05:01  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.4.6.3  2000/01/28 19:30:14  brendel
--| Revision.
--| Now inherits from EV_VIEWPORT and adds the scrollbars to the viewable area.
--|
--| Revision 1.4.6.2  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.3  1999/11/04 23:10:42  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.4.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
