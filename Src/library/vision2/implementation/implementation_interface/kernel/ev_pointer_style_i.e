note
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

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x_hotspot, a_y_hotspot: INTEGER)
			-- Initialize from `a_pixel_buffer'
		deferred
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y:INTEGER)
			-- Initalize from `a_pixmap'
		deferred
		end

	init_from_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'
		deferred
		end

	init_predefined (a_constant: INTEGER)
			-- Initialize a predefined cursor from `a_constant'
		require
			valid: (create {EV_POINTER_STYLE_CONSTANTS}).is_valid (a_constant)
		deferred
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER)
			-- Set `x_hotspot' to `a_x'.
		deferred
		end

	set_y_hotspot (a_y: INTEGER)
			-- Set `y_hotspot' to `a_y'.
		deferred
		end

feature -- Query

	width: INTEGER
			-- Width
		deferred
		end

	height: INTEGER
			-- Height
		deferred
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.
		deferred
		end

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.
		deferred
		end

feature -- Duplication

	copy_from_pointer_style (a_pointer_style: like interface)
			-- Copy attributes of `a_pointer_style' to `Current.
		require
			a_pointer_style_not_void: a_pointer_style /= Void
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_POINTER_STYLE note option: stable attribute end;
			-- Interface
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
