indexing
	description: "EiffelVision segment."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SEGMENT

inherit
	EV_LINE
		redefine
			make,
			contains
		end

	EV_ENDED_FIGURE

creation
	make
	
feature {NONE} -- Initialization

	make is
			-- Create current segment.
		do
			init_fig (Void)
			{EV_LINE} Precursor
			!! p1.make
			!! p2.make
			p2.set_x (1)
		end

feature -- Access

	center: EV_POINT is
			-- Middle of the segment.
		do
			Result := p1 + (p2 - p1)  //  2
		end

	contains (p: EV_POINT): BOOLEAN is
			-- Is `p' on segment?
		local
			t, rsq, dx, dy, dpx, dpy: REAL
		do
			dx := (p2.x - p1.x) // 2
			dy := (p2.y - p1.y) // 2
			dpx := center.x - p.x
			dpy := center.y - p.y
			Result := Precursor (p) and (dpx * dpx <= dx * dx) and (dpy * dpy <= dy * dy)
		end

feature -- Element change

	set (o1, o2: like p1) is
			-- Set the two end points of the line.
		require else
			o1_exists: o1 /= Void
			o2_exists: o2 /= Void
		do
			p1 := o1
			p2 := o2
			set_modified
		ensure then
			p1 = o1
			p2 = o2
		end

	set_p1 (p: like p1) is
			-- Set the first point.
		require else
			p_exists: p /= Void
		do
			p1 := p
			set_modified
		ensure then
			p1 = p
		end

	set_p2 (p: like p2) is
			-- Set the second point.
		require else
			p_exists: p /= Void
		do
			p2 := p
			set_modified
		ensure then
			p2 = p
		end

feature -- Output

	draw is
			-- Draw the segment.
		local
			lpath: EV_PATH
		do
			if drawing.is_drawable then
				create lpath.make
				lpath.get_drawing_attributes (drawing)
--				drawing.set_cap_style (cap_style)
				set_drawing_attributes (drawing)
				drawing.draw_segment (p1, p2)
				lpath.set_drawing_attributes (drawing)
			end
		end

feature -- Status report

	is_null: BOOLEAN is
			-- Is the segment null ?
		do
			Result := p1.is_superimposable (p2)
		end

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the line superimposable to `other' ?
		require else
			other_exists: other /= Void
		do
			Result := (p1.is_superimposable (other.p1) and 
				p2.is_superimposable (other.p2)) or else 
				(p1.is_superimposable (other.p2) and
				p2.is_superimposable (other.p1))
		end

end -- class EV_SEGMENT

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

