note
	description:
		"[
			Displays a single widget that may be larger that the container.
			Scroll bars allow the user to select the area displayed.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			---------------
			|           |^|
			|   `item'  | |
			|___________|v|
			|<_________>|_|
		]"
	status: "See notice at end of class."
	keywords: "container, scroll, scrollbar, viewport"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA

inherit
	EV_VIEWPORT 
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

create
	default_create

feature -- Access

	horizontal_step: INTEGER
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on horizontal scroll bar.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.horizontal_step
		ensure
			bridge_ok: Result = implementation.horizontal_step
		end

	vertical_step: INTEGER
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on vertical scroll bar.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.vertical_step
		ensure
			bridge_ok: Result = implementation.vertical_step
		end

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_horizontal_scroll_bar_visible
		ensure
			bridge_ok: Result = implementation.is_horizontal_scroll_bar_visible
		end

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scroll bar be displayed?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_vertical_scroll_bar_visible
		ensure
			bridge_ok: Result = implementation.is_vertical_scroll_bar_visible
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER)
			-- Assign `a_step' to `horizontal_step'.
		require
			not_destroyed: not is_destroyed
			a_step_positive: a_step > 0
		do
			implementation.set_horizontal_step (a_step)
		ensure
			assigned: horizontal_step = a_step
		end

	set_vertical_step (a_step: INTEGER)
			-- Assign `a_step' to `vertical_step'.
		require
			not_destroyed: not is_destroyed
			a_step_positive: a_step > 0
		do
			implementation.set_vertical_step (a_step)
		ensure
			assigned: vertical_step = a_step
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_horizontal_scroll_bar
		ensure
			shown: is_horizontal_scroll_bar_visible
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_horizontal_scroll_bar
		ensure
			hidden: not is_horizontal_scroll_bar_visible
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_vertical_scroll_bar
		ensure
			shown: is_vertical_scroll_bar_visible
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_vertical_scroll_bar
		ensure
			hidden: not is_vertical_scroll_bar_visible
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_VIEWPORT} and horizontal_step = 10 and
				vertical_step = 10
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SCROLLABLE_AREA_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SCROLLABLE_AREA_IMP} implementation.make (Current)
		end

invariant
	horizontal_step_positive: is_usable implies horizontal_step > 0
	vertical_step_positive: is_usable implies vertical_step > 0

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




end -- class EV_SCROLLABLE_AREA

