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

