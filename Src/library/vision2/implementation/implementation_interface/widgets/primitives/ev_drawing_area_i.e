note
	description: "Eiffel Vision drawing area. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWING_AREA_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_TAB_CONTROLABLE_I
		redefine
			interface
		end

	EV_DRAWABLE_ACTION_SEQUENCES_I

feature -- Drawing operations

	redraw
			-- Redraw the window without clearing it.
		deferred
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw the rectangle described.
		require
			a_width >= 0 and a_height >= 0
		deferred
		end

	clear_and_redraw
			-- Redraw the window after clearing it.
		deferred
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Clear and Redraw the rectangle described.
		require
			a_width >= 0 and a_height >= 0
		deferred
		end

	flush
			-- Update immediately the screen if needed
		deferred
		end

	enable_focus_on_press
			-- Enable focus on press handling.
		do
			focus_on_press_disabled := False
		end

	disable_focus_on_press
			-- Disable default focus handling when mouse button is pressed on drawing area.
		do
			focus_on_press_disabled := True
		end

	focus_on_press_disabled: BOOLEAN
			-- Is focus on mouse press default handling disabled?

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DRAWING_AREA note option: stable attribute end;
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_DRAWING_AREA_I









