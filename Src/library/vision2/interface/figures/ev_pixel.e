indexing
	description: "EiffelVision pixel. Graphical representation of a point."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXEL

inherit

	EV_OPEN_FIGURE
		redefine
			contains,
			recompute
		select
			notified
		end

	EV_INTERIOR
		redefine
			make
		end

	EV_POINT
		rename
			notified as old_notified
		undefine
			set_modified_with,
			set_modified,
			unset_modified
		redefine
			make,
			set,
			duplicate,
			contains,
			recompute
		end

creation
	make,
	set

feature {NONE} -- Initialization

	make is
			-- Create a point.
		do
			init_fig (Void)
			{EV_INTERIOR} Precursor 
			logical_function_mode := GXcopy
		end

	set (nx, ny: INTEGER) is
			-- Set position.
		do
			make
			{EV_POINT} Precursor (nx, ny)
		end

feature -- Access

	contains (p: EV_POINT): BOOLEAN is
			-- Is `p' the current pixel?
		do
			Result := p.x = x and p.y = y
		end

feature -- Duplication

	duplicate: like Current is
			-- Create a copy of current point.
		do
			Result ?= {EV_POINT} Precursor
			Result.set_foreground_color (foreground_color)
		ensure then
			Result.is_superimposable (Current)
			Result.foreground_color = foreground_color
		end

feature -- Output

	draw is
			-- Draw current point.
		do
			if drawing.is_drawable then
				set_drawing_attributes (drawing)
				drawing.draw_point (Current)
			end
		end

feature {EV_GEOMETRICAL} -- Updating

	recompute is
		do
			surround_box.set (x, y, 1, 1)
		end

invariant
	origin_user_type <= 2

end -- class EV_PIXEL

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

