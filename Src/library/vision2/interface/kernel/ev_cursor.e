indexing
	description:
		"Apearance of a screen pointer cursor, typically moved by a mouse."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CURSOR

inherit
	EV_PIXMAP
		redefine
			copy
		end

create
	default_create,
	make_with_size,
	make_with_pixmap

feature {NONE} -- Initialization

	make_with_pixmap (a_pixmap: EV_PIXMAP; a_x_hotspot, 
	a_y_hotspot: INTEGER) is
			-- Create a cursor initialized with `a_pixmap' as
			-- pixmap and `a_x_hotspot' & `a_y_hotspot' as 
			-- hotspot coordinates
		do
			default_create
			implementation.copy_pixmap (a_pixmap)
			set_x_hotspot (a_x_hotspot)
			set_y_hotspot (a_y_hotspot)
		end

feature -- Access

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot. 

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot. 

feature -- Status setting

	set_x_hotspot (a_x_hotspot: INTEGER) is
			-- Set `x_hotspot' to `a_x_hotspot'.
		require
			not_destroyed: not is_destroyed
			valid_x_hotspot: a_x_hotspot >= 0 and a_x_hotspot < width
		do
			x_hotspot := a_x_hotspot
		ensure
			x_hotspot_set: x_hotspot = a_x_hotspot
		end

	set_y_hotspot (a_y_hotspot: INTEGER) is
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

	copy (other: EV_PIXMAP) is 
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

end -- class EV_CURSOR

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

