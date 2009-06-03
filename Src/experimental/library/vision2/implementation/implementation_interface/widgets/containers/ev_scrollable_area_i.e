note
	description: "EiffelVision scrollable area. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SCROLLABLE_AREA_I
	
inherit
	EV_VIEWPORT_I

feature -- Access

	horizontal_step: INTEGER
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scroll bar.
		deferred
		end

	vertical_step: INTEGER
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scroll bar.
		deferred
		end

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?
		deferred
		end

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scroll bar be displayed?
		deferred
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER)
			-- Set `horizontal_step' to `a_step'.
		require
			a_step_positive: a_step > 0
		deferred
		ensure
			assigned: horizontal_step = a_step
		end

	set_vertical_step (a_step: INTEGER)
			-- Set `vertical_step' to `a_step'.
		require
			a_step_positive: a_step > 0
		deferred
		ensure
			assigned: vertical_step = a_step
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		deferred
		ensure
			shown: is_horizontal_scroll_bar_visible
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		deferred
		ensure
			hidden: not is_horizontal_scroll_bar_visible
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		deferred
		ensure
			shown: is_vertical_scroll_bar_visible
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		deferred
		ensure
			hidden: not is_vertical_scroll_bar_visible
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SCROLLABLE_AREA_I

