indexing

	description: "Description of ellipse";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	ELLIPSE

inherit

	CLOSED_FIG
		redefine
			conf_recompute
		end;

	ANGLE_ROUT
		export
			{NONE} all
		end

creation

	make

feature -- Initialization

	make is
			-- Create a ellipse.
		do
			init_fig (Void);
			!! center;
			!! path.make ;
			!! interior.make ;
			interior.set_no_op_mode;
			radius1 := 1;
			radius2 := 1;
			orientation := 0.0;
		end;

feature -- Access

	center: COORD_XY_FIG;
			-- Center of the ellipse.

	orientation: REAL;
			-- Angle which specifies the position of the first ray
			-- (length `radius1') relative to the three-o'clock position
			-- from the center

	origin: COORD_XY_FIG is
			-- Origin of ellipse
		do
			inspect
				origin_user_type
			when 1 then
				Result := origin_user
			when 2 then
				Result := center
			end
		end;

	radius1: INTEGER;
			-- First radius of the ellipse

	radius2: INTEGER;
			-- Second radius of the ellipse

feature -- Element change

	set_center (a_point: like center) is
			-- Set `center' to `a_point'.
		require
			a_point_exits: a_point /= Void
		do
			center := a_point;
			set_conf_modified
		ensure
			center_set: center = a_point
		end;

	set_orientation (an_orientation: like orientation) is
			-- Set `orientation' to `an_orientation'.
		require
			orientation_smaller_than_360: an_orientation < 360;
			orientation_positive: an_orientation >= 0
		do
			orientation := an_orientation;
			set_conf_modified
		ensure
			orientation = an_orientation
		end;

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 2;
		ensure then
			origin.is_superimposable (center)
		end;

	set_radius1 (new_radius1: like radius1) is
			-- Set `radius1' to `new_radius1', change `size_of_side'.
		require
			size_positive: new_radius1 > 0
		do
			radius1 := new_radius1;
			set_conf_modified
		ensure
			radius1 = new_radius1
		end;

	set_radius2 (new_radius2: like radius2) is
			-- Set `radius1' to `new_radius2', change `size_of_side'.
		require
			size_positive: new_radius2 > 0
		do
			radius2 := new_radius2;
			set_conf_modified
		ensure
			radius2 = new_radius2
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		do
			center.xyrotate (a, px, py);
			orientation := mod360 (orientation+a);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			radius1 := (f*radius1).truncated_to_integer;
			radius2 := (f*radius2).truncated_to_integer;
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
			-- Draw the ellipse.
		do
			if drawing.is_drawable then
				if interior /= Void then
					interior.set_drawing_attributes (drawing);
					drawing.fill_arc (center, radius1, radius2, 0, 360, orientation, 0)
				end;
				if path /= Void then
					path.set_drawing_attributes (drawing);
					drawing.draw_arc (center, radius1, radius2, 0, 360, orientation, -1)
				end
			end
		end;

feature -- Updating

	conf_recompute is
		local
			diameter: INTEGER;
		do
			if radius1 > radius2 then
				diameter := radius1 + radius1;
				surround_box.set (center.x-radius1, center.y-radius1, diameter, diameter);
			else
				diameter := radius2 + radius2;
				surround_box.set (center.x-radius2, center.y-radius2, diameter, diameter);
			end;
			unset_conf_modified
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current ellipse superimposable to `other' ?
			--| not finished
		do
			Result := center.is_superimposable (other.center) and
				(radius1 = other.radius1) and (radius2 = other.radius2)
				and (orientation = other.orientation)
		end;

invariant

	origin_user_type_constraint: origin_user_type <= 2;
	meaningful_radius1: radius1 >= 0;
	meaningful_radius2: radius2 >= 0;
	orientation_small_enough: orientation < 360;
	orientation_large_enough: orientation >= 0;
	center_exists: center /= Void

end -- class ELLIPSE


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

