note

	description: "Description of segments (implementation for X)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	SEGMENT 

inherit

	LINE
		rename
			make as line_make
		redefine
			contains
		end;

	ENDED

create

	make
	
feature -- Initialization

	make
			-- Create current segment.
		do
			init_fig (Void);
			line_make ;
			create p1;
			create p2;
			p2.set_x (1);
		end;

feature -- Access

	contains (p: COORD_XY_FIG): BOOLEAN
			-- Is `p' on segment?
		require else
			point_exists: p /= Void
		local
			t, rsq, dx, dy, dpx, dpy: REAL;
		do
			if p1.x /= p2.x or p1.y /= p2.y then
				dx  := p2.x - p1.x;
				dy  := p2.y - p1.y;
				dpx := p1.x - p.x;
				dpy := p1.y - p.y;
				t   := - (dpx*dx + dpy*dy) / (dx*dx + dy*dy);
				dpx := dpx + t*dx;
				dpy := dpy + t*dy;
				rsq := dpx*dpx + dpy*dpy;
				Result := rsq <= line_width*line_width/4.0
			else
				Result := p.x = p1.x and p.y = p1.y
			end
		end;

feature -- Element change

	set (o1, o2: like p1)
			-- Set the two end points of the line.
		require else
			o1_exists: o1 /= Void;
			o2_exists: o2 /= Void
		do
			p1 := o1;
			p2 := o2;
			set_conf_modified
		ensure then
			p1 = o1;
			p2 = o2
		end;

	set_p1 (p: like p1)
			-- Set the first point.
		require else
			p_exists: p /= Void
		do
			p1 := p;
			set_conf_modified
		ensure then
			p1 = p
		end;

	set_p2 (p: like p2)
			-- Set the second point.
		require else
			p_exists: p /= Void
		do
			p2 := p;
			set_conf_modified
		ensure then
			p2 = p
		end;

feature -- Output

	draw
			-- Draw the segment.
		do
			if drawing.is_drawable then
				drawing.set_cap_style (cap_style);
				set_drawing_attributes (drawing);
				drawing.draw_segment (p1, p2)
			end
		end;

feature -- Status report

	is_null: BOOLEAN
			-- Is the segment null ?
		do
			Result := p1.is_superimposable (p2)
		end;

	is_superimposable (other: like Current): BOOLEAN
			-- Is the line superimposable to `other' ?
		require else
			other_exists: other /= Void
		do
			Result := (p1.is_superimposable (other.p1) and 
				p2.is_superimposable (other.p2)) or else 
				(p1.is_superimposable (other.p2) and
				p2.is_superimposable (other.p1))
		end;

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




end -- class SEGMENT

