indexing
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

	EV_TAB_CONTROLLABLE_I
		redefine
			interface
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_I

feature -- Drawing operations

	redraw is
			-- Redraw the window without clearing it.
		deferred
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw the rectangle described.
		deferred
		end

	clear_and_redraw is
			-- Redraw the window after clearing it.
		deferred
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear and Redraw the rectangle described.
		deferred
		end

	flush is
			-- Update immediately the screen if needed
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA;
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

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




end -- class EV_DRAWING_AREA_I

