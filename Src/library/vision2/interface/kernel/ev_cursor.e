note
	description:
		"Appearance of a screen pointer cursor, typically moved by a mouse."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR

obsolete
	"Use EV_POINTER_STYLE instead"

inherit
	EV_PIXMAP
		redefine
			make_with_pointer_style,
			copy
		end
		
create
	default_create,
	make_with_size,
	make_with_pixmap,
	make_with_pointer_style

convert
	make_with_pointer_style ({EV_POINTER_STYLE})

feature {NONE} -- Initialization

	make_with_pixmap (a_pixmap: EV_PIXMAP; a_x_hotspot, a_y_hotspot: INTEGER)
			-- Create a cursor initialized with `a_pixmap' as
			-- pixmap and `a_x_hotspot' & `a_y_hotspot' as
			-- hotspot coordinates
		do
			default_create
			implementation.copy_pixmap (a_pixmap)
			set_x_hotspot (a_x_hotspot)
			set_y_hotspot (a_y_hotspot)
		end

	make_with_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Create from `a_pointer_style'
		local
			l_temp: EV_POINTER_STYLE
		do
			default_create
			l_temp := a_pointer_style
			if l_temp = Void then
				create l_temp
			end
			implementation.init_from_pointer_style (l_temp)

			set_x_hotspot (l_temp.x_hotspot)
			set_y_hotspot (l_temp.y_hotspot)
		end

feature -- Access

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.

feature -- Status setting

	set_x_hotspot (a_x_hotspot: INTEGER)
			-- Set `x_hotspot' to `a_x_hotspot'.
		require
			not_destroyed: not is_destroyed
			valid_x_hotspot: a_x_hotspot >= 0 and a_x_hotspot < width
		do
			x_hotspot := a_x_hotspot
		ensure
			x_hotspot_set: x_hotspot = a_x_hotspot
		end

	set_y_hotspot (a_y_hotspot: INTEGER)
			-- Set `y_hotspot' to `a_y_hotspot'.
		require
			not_destroyed: not is_destroyed
			valid_y_hotspot: a_y_hotspot >= 0 and a_y_hotspot < height
		do
			y_hotspot := a_y_hotspot
		ensure
			y_hotspot_set: y_hotspot = a_y_hotspot
		end

feature -- Duplication

	copy (other: like current)
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_cursor: EV_CURSOR
		do
			check
				not_destroyed: not is_destroyed
			end
			if implementation = Void then
				default_create
			end
				-- Copy the "pixmap part"
			implementation.copy_pixmap(other)

				-- Copy the "cursor part"
			other_cursor ?= other
			if other_cursor /= Void then
					-- Retrieve the hotspot coordinates of `other'
				set_x_hotspot (other_cursor.x_hotspot)
				set_y_hotspot (other_cursor.y_hotspot)
			else
					-- Reset the hotspot coordinates to (0,0)
				set_x_hotspot (0)
				set_y_hotspot (0)
			end
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




end -- class EV_CURSOR

