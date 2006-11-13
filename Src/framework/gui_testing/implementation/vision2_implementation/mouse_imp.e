indexing
	description:
		"Implementation for a mouse interface which sends event via Vision2's EV_SCREEN"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE_IMP

inherit
	MOUSE_I

feature -- Pressing

	press_button (a_mouse_button: INTEGER) is
			-- Press `a_mouse_button'.
		do
			screen.fake_pointer_button_press (a_mouse_button)
		end

	release_button (a_mouse_button: INTEGER) is
			-- Release `a_mouse_button'.
		do
			screen.fake_pointer_button_release (a_mouse_button)
		end

feature -- Moving

	move_to_absolute_position (an_x, a_y: INTEGER) is
			-- Move mouse to absolute coordinates `an_x' `a_y'.
		do
			screen.set_pointer_position (an_x, a_y)
		end

feature -- Scrolling

	scroll_up is
			-- Scroll mouse wheel up.
		do
			screen.fake_pointer_wheel_up
		end

	scroll_down is
			-- Scroll mouse wheel down.
		do
			screen.fake_pointer_wheel_down
		end

feature {NONE} -- Implementation

	screen: EV_SCREEN
			-- Screen
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
