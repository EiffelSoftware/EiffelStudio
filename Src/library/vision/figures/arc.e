indexing

	description: "Arc figure";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	ARC

inherit

	OPEN_FIG
			redefine
				conf_recompute
			end;

	PATH
			rename
				make as path_make
			end;

	ENDED;

	ANGLE_ROUT
			export
				{NONE} all
			end;

creation

	make

feature -- Initialization

	make is
			-- Create current arc.
		do
			init_fig (Void);
			path_make;
			!! center;
			angle1 := 0;
			angle2 := 360;
   		end;

feature -- Access

	angle1: REAL;
			-- Angle which specifies start position of
			-- current arc relative to the orientation

	angle2: REAL;
			-- Angle which specifies end position of
			-- current arc relative to the start of
			-- current arc

	center: COORD_XY_FIG;
			-- Center of the arc

	orientation: REAL;
			-- Angle which specifies the position of the first ray
			-- (length `radius1') relative to the three-o'clock position
			-- from the center

	origin: COORD_XY_FIG is
			-- Origin of line
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
			-- First radius of the arc

	radius2: INTEGER;
			-- Second radius of the arc

feature -- Element change

	set_angle1 (an_angle: like angle1) is
			-- Set angle1 to `an_angle'.
		require
	   		angle1_smaller_than_360: an_angle < 360;
	   		angle1_positive: an_angle >= 0
		do
	   		angle1 := an_angle;
				set_conf_modified
		ensure
	   		angle1 = an_angle
		end;

	set_angle2 (an_angle: like angle2) is
   			-- Set angle2 to `an_angle'.
		require
	   		angle2_smaller_than_360: an_angle <= 360;
	   		angle2_positive: an_angle >= 0
		do
	   		angle2 := an_angle;
				set_conf_modified
		ensure
	   		angle2 = an_angle
		end;

	set_center (a_center: like center) is
   			-- Set `center' to `an_center'.
		require
	   		a_center_exists: a_center /= Void
		do
	   		center := a_center;
			set_conf_modified
		ensure
	   		center = a_center
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
		ensure
   			origin.is_superimposable (center)
		end;

	set_radius1 (a_radius: like radius1) is
	   		-- Set `radius1' to `a_radius'.
		require
	   		a_radius_positive: a_radius >= 0
		do
	   		radius1 := a_radius;
				set_conf_modified
		ensure
   			radius1 = a_radius
		end;

	set_radius2 (a_radius: like radius2) is
   			-- Set `radius2' to `a_radius'.
		require
	   		a_radius_positive: a_radius >= 0
		do
	   		radius2 := a_radius;
			set_conf_modified
		ensure
	   		radius2 = a_radius
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0
		do
			center.xyrotate (a, px, py);
			orientation := mod360 (orientation+a);
			set_conf_modified
		end;

	xyscale (f: REAL; px, py: INTEGER) is
		-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			center.xyscale (f, px, py);
			radius1 := (radius1*f).truncated_to_integer;
			radius2 := (radius2*f).truncated_to_integer;
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
			-- draw the arc.
		do
			if drawing.is_drawable then
				drawing.set_cap_style (cap_style);
				set_drawing_attributes (drawing);
				drawing.draw_arc (center, radius1, radius2, angle1, angle2,
					orientation, -1)
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is `other' superimposable to current arc ?
			--| not done
		do
		end;

feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute is
			-- Recompute.
		local
			diameter: INTEGER;
			radius: INTEGER;
		do
			if radius1 > radius2 then
				radius := radius1;
			else
				radius := radius2;
			end;
			diameter := radius + radius;
			surround_box.set (center.x - radius, center.y - radius, diameter, diameter);
			unset_conf_modified
		end;

invariant

	center_exists: center /= Void;
	origin_type_constraint: origin_user_type <= 2;
	meaningful_radius1: radius1 >= 0;
	meaningful_radius2: radius2 >= 0;
	orientation_small_enough: orientation < 360;
	orientation_large_enough: orientation >= 0;
	angle1_small_enough: angle1 < 360;
	angle1_large_enough: angle1 >= 0;
	angle2_small_enough: angle2 <= 360;
	angles2_large_enough: angle2 >= 0

end -- class ARC


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

