note
	description:
		"Abstraction for objects that have geometric position."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "position, width, height"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POSITIONED

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.x_position
		ensure
			bridge_ok: Result = implementation.x_position
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.y_position
		ensure
			bridge_ok: Result = implementation.y_position
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.screen_x
		ensure
			bridge_ok: Result = implementation.screen_x
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.screen_y
		ensure
			bridge_ok: Result = implementation.screen_y
		end

	width: INTEGER
			-- Horizontal size in pixels.
			-- Same as `minimum_width' when not displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.width
		ensure
			bridge_ok: Result = implementation.width
		end

	height: INTEGER
			-- Vertical size in pixels.
			-- Same as `minimum_height' when not displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.height
		ensure
			bridge_ok: Result = implementation.height
		end

	minimum_width: INTEGER
			-- Lower bound on `width' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_width
		ensure
			bridge_ok: Result = implementation.minimum_width
			positive_or_zero: Result >= 0
		end

	minimum_height: INTEGER
			-- Lower bound on `height' in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.minimum_height
		ensure
			bridge_ok: Result = implementation.minimum_height
			positive_or_zero: Result >= 0
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_POSITIONED_I
			-- Responsible for interaction with native graphics toolkit.

invariant
	width_not_negative: is_usable implies width >= 0
	height_not_negative: is_usable implies height >= 0
	minimum_width_not_negative: is_usable implies minimum_width >= 0
	minimum_height_not_negative: is_usable implies minimum_height >= 0

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




end -- class EV_POSITIONED

