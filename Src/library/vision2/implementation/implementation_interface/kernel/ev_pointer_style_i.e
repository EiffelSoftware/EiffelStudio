indexing
	description: "Implementation interface for EV_POINTER_STYLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POINTER_STYLE_I

 inherit
	EV_ANY_I
		redefine
			interface
		end

feature {EV_POINTER_STYLE} -- Initlization

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x_hotspot, a_y_hotspot: INTEGER) is
			-- Initialize from `a_pixel_buffer'
		deferred
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y:INTEGER) is
			-- Initalize from `a_pixmap'
		deferred
		end

	init_from_cursor (a_cursor: EV_CURSOR) is
			-- Initialize from `a_cursor'
		deferred
		end

	init_predefined (a_constant: INTEGER) is
			-- Initialize a predefined cursor from `a_constant'
		require
			valid: (create {EV_POINTER_STYLE_CONSTANTS}).is_valid (a_constant)
		deferred
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER) is
			-- Set `x_hotspot' to `a_x'.
		deferred
		end

	set_y_hotspot (a_y: INTEGER) is
			-- Set `y_hotspot' to `a_y'.
		deferred
		end

feature -- Query

	width: INTEGER is
			-- Width
		deferred
		end

	height: INTEGER is
			-- Height
		deferred
		end

	x_hotspot: INTEGER is
			-- Specifies the x-coordinate of a cursor's hot spot.
		deferred
		end

	y_hotspot: INTEGER is
			-- Specifies the y-coordinate of a cursor's hot spot.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_POINTER_STYLE;
			-- Interface
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
