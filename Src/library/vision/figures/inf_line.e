--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- INF_LINE: Description of infinited lines (implementation for X).

class INF_LINE 

inherit

	LINE
		rename
			make as line_make
		end

creation

	make

feature {NONE}

	CapProjecting: INTEGER is 3;
            -- Code to define projecting cap

feature 

	make is
			-- Create current line.
		do
			line_make;
			!!p1;
			!!p2;
			p2.set_x (1)
		end;

	draw is
			-- Draw the line.
		require else
			drawing_attached: not (drawing = Void)
		do
			if drawing.is_drawable then
				drawing.set_cap_style (CapProjecting);
				set_drawing_attributes (drawing);
				drawing.draw_inf_line (p1, p2)
			end
		end;

	is_null: BOOLEAN is
			-- Is the line null ?
		do
			Result := false
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the line surimposable to `other' ?
		require else
			other_exists: not (other = Void)
		do
			Result := 0 = ((p2.y-p1.y)*(other.p2.x-other.p1.x)-(p2.x-p1.x)*(other.p2.y-other.p1.y))
		end;

	set (o1, o2: like p1) is
			-- Set the two end points of the line.
		require else
			o1_exists: not (o1 = Void);
			o2_exists: not (o2 = Void);
			not o1.is_surimposable (o2)
		do
			p1 := o1;
			p2 := o2
		ensure then
			p1 = o1;
			p2 = o2
		end;

	set_p2 (p: like p2) is
			-- Set the second point.
		require else
			p_exists: not (p = Void);
			not p1.is_surimposable (p)
		do
			p2 := p
		ensure then
			p2 = p
		end;

	set_p1 (p: like p1) is
			-- Set the first point.
		require else
			p_exists: not (p = Void);
			not p2.is_surimposable (p)
		do
			p1 := p
		ensure then
			p1 = p
		end;

invariant

	not p1.is_surimposable (p2)

end
