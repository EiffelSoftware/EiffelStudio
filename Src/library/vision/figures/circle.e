indexing

	description: "Description of circle";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	CIRCLE

inherit

	CLOSED_FIG
	redefine
				contains, conf_recompute
			end;

	ANGLE_ROUT
			export
				{NONE} all
			end

creation

	make

feature -- Initialization

	make is
			-- Create a circle.
		do
			init_fig (Void);
			!! center;
			!! path.make ;
			!! interior.make ;
			interior.set_no_op_mode;
			radius := 1;
		end;

feature -- Access

	center: COORD_XY_FIG;
			-- Center of the circle.

	contains (p: COORD_XY_FIG): BOOLEAN is
			-- Is 'p' in the current circle ?
		local
			distance: INTEGER
		do
			distance := center.distance (p);
			Result := distance <= radius
		end;

	origin: COORD_XY_FIG is
			-- Origin of circle
		do
			inspect
				origin_user_type
			when 1 then
				Result := origin_user
			when 2 then
				Result := center
			end
		end;

	radius: INTEGER;
			-- Radius of the circle who contains all the point of the
			-- polygon

feature -- Element change

	set_center (a_point: like center) is
			-- Set `center' to `a_point'.
		require
			a_point_exits: a_point /= Void
		do
			center := a_point;
			set_conf_modified
		ensure
			center = a_point
		end;

	set_origin_to_center is
	   		-- Set origin to `center'.
		do
	   		origin_user_type := 2;
		ensure then
	   		origin.is_superimposable (center)
		end;

	set_radius (new_radius: like radius) is
			-- Set `radius' to `new_radius', change `size_of_side'.
		require
			size_positive: new_radius > 0
		do
			radius := new_radius;
			set_conf_modified
		ensure
	   		radius = new_radius
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
   			-- Rotate figure by `a' relative to (`px', `py').
	   		-- Angle `a' is measured in degrees.
		do
	   		center.xyrotate (a, px, py);		
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			radius := (f*radius).truncated_to_integer;
			center.xyscale (f, px, py);
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			center.xytranslate (vx, vy);
			set_conf_modified
		end;

feature -- Output

	draw is
			-- Draw the circle.
		do
			if drawing.is_drawable then
				if interior /= Void then
					interior.set_drawing_attributes (drawing);
					drawing.fill_arc (center, radius, radius, 0, 360, 0, 0)
				end;
				if path /= Void then
					path.set_drawing_attributes (drawing);
					drawing.draw_arc (center, radius, radius, 0, 360, 0, -1)
				end
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current circle superimposable to `other' ?
			--| not finished
		do
			Result := center.is_superimposable (other.center) and 
				(radius = other.radius)
		end;

feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute  is
		local
			diameter: INTEGER;
		do
			diameter := radius + radius;
			surround_box.set (center.x-radius , center.y-radius , diameter, diameter);
			unset_conf_modified
		end;

invariant

	origin_user_type_constraint: origin_user_type <= 2;
	meaningful_radius: radius >= 0;
	center_exists: center /= Void

end -- class CIRCLE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

