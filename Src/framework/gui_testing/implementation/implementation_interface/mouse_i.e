note
	description:
		"Interface for a mouse implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MOUSE_I

inherit
	BUTTONS
		export
			{NONE} all
			{ANY} is_valid_button
		end

feature -- Pressing

	press_button (a_mouse_button: INTEGER)
			-- Press `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		deferred
		end

	release_button (a_mouse_button: INTEGER)
			-- Release `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		deferred
		end

feature -- Moving

	move_to_absolute_position (an_x, a_y: INTEGER)
			-- Move mouse to absolute coordinates `an_x' `a_y'.
		deferred
		end

feature -- Scrolling

	scroll_up
			-- Scroll mouse wheel up.
		deferred
		end

	scroll_down
			-- Scroll mouse wheel down.
		deferred
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

end
