indexing
	description:
		"Eiffel Vision positioned, implementation interface.%N%
		%See bridge pattern notes in ev_any.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POSITIONED_I 

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Measurement
	
	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		deferred
		end
	
	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		deferred
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		deferred
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		deferred
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		deferred
		end

	height: INTEGER is
			-- Vertical size in pixels.
		deferred
		end
	
	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
		deferred
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_POSITIONED
		-- Provides a common user interface to platform dependent functionality
		-- implemented by `Current'.
		-- (See bridge pattern notes in ev_any.e)

invariant
	minimum_width_positive_or_zero: is_usable implies minimum_width >= 0
	minimum_height_positive_or_zero: is_usable implies minimum_height >= 0

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




end -- class EV_POSITIONED_I

