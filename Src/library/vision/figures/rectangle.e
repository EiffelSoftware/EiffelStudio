indexing

	description: "Description of a rectangle";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	RECTANGLE 

inherit

	CLOSED_FIG
		redefine
			conf_recompute
		end;

	JOINABLE;

	ANGLE_ROUT
		export
			{NONE} all
		end

creation

	make, make_from_closure

feature -- Initialization

	make is
			-- Create a rectangle.
		do
			init_fig (Void);
			!! upper_left;
			!! path.make ;
			!! interior.make ;
			interior.set_no_op_mode;
			width := 1;
			height := 1;
			orientation := 0;
		end; 

	make_from_closure (cl: CLOSURE) is
			-- Create a rectangle containing `cl`
		local
			w,h : INTEGER;
		do
			make;
			if not cl.empty then
				upper_left := deep_clone (cl.up_left);
				w := cl.down_right.x - cl.up_left.x;
				h := cl.down_right.y - cl.up_left.y;
				width := w;
				height := h
			end
		end;

feature -- Access 

	center: COORD_XY_FIG is
			-- Center of the rectangle.
		local
			v_cos, v_sin: REAL;
			half_width, half_height: INTEGER
		do
			v_cos := cos (orientation);
			v_sin := sin (orientation);
			half_width := width // 2;
			half_height := height // 2;
			!! Result;
			Result.set (
				upper_left.x+(half_width*v_cos+half_height*v_sin).truncated_to_integer,
				upper_left.y-(half_width*v_sin-half_height*v_cos).truncated_to_integer)
		end;

	height: INTEGER;
			-- Height of rectangle

	upper_left: COORD_XY_FIG;
			-- Upper left coin of the rectangle

	width: INTEGER;
			-- Width of rectangle

	origin: COORD_XY_FIG is
			-- Origin of rectangle
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := upper_left
			when 3 then
				Result := center
			end
		end;

feature -- Element change 

	set_height (new_height: like height) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height;
			set_conf_modified
		ensure
			height = new_height
		end;

	set_orientation (new_orientation: like orientation) is
			-- Set `orientation' to `new_orientation'.
		require
			orientation_positive: new_orientation >= 0;
			orientation_smaller_than_360: new_orientation < 360
		do
			orientation := new_orientation;
			set_conf_modified
		ensure
			orientation = new_orientation
		end;

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 3;
		ensure then
			origin.is_superimposable (center)
		end;

	set_origin_to_upper_left is
			-- Set origin to upper left coiner.
		do
			origin_user_type := 2;
		ensure
			origin.is_superimposable (upper_left)
		end;

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			upper_left := a_point;
			set_conf_modified
		ensure
			upper_left = a_point
		end;

	set_width (new_width: like width) is
			-- Set `width' to `new_width'
		require
			new_width_positive: new_width >= 0
		do
			width := new_width;
			set_conf_modified
		ensure
			width = new_width
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			orientation := orientation+a;
			if orientation >= 360 then
				orientation := orientation-360
			end;
			if orientation < 0 then
				orientation := orientation+360
			end;
			upper_left.xyrotate (a, px, py);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			width := (f*width).truncated_to_integer;
			height := (f*height).truncated_to_integer;
			upper_left.xyscale (f, px, py);
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy);
			set_conf_modified
		end 

feature -- Output

	draw is
			-- Draw the rectangle.
		do
			if drawing.is_drawable then
				drawing.set_join_style (join_style);
				if interior /= Void then
					interior.set_drawing_attributes (drawing);
					drawing.fill_rectangle (center, width, height, orientation)
				end;
				if path /= Void then
					path.set_drawing_attributes (drawing);
					drawing.draw_rectangle (center, width, height, orientation)
				end
			end
		end;

feature -- Status report
	
	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current rectangle superimposable to `other' ?
		require else
			other_exists: other /= Void
		do
			Result := upper_left.is_superimposable (other.upper_left) and 
				(width = other.width) and (height = other.height)
		end;

feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute is
		local
			v_max, v_maxdiv2: INTEGER;
			cent: COORD_XY_FIG;
		do
			cent := center;
			if height > width then
				v_max := height;
			else
				v_max := width;
			end;
			v_max := v_max * 1415 // 1000;
			v_maxdiv2 := v_max // 2;
			surround_box. set (cent.x-v_maxdiv2, cent.y-v_maxdiv2 , v_max, v_max);
			unset_conf_modified
		end

feature {NONE} -- Access

	orientation: REAL;
			-- Orientation in degree of the rectangle

invariant

	origin_user_type_constraint: origin_user_type <= 3;
	orientation_small_enough: orientation < 360;
	orientation_large_enough: orientation >= 0;
	non_negative_width: width >= 0;
	non_negative_height: height >= 0;
	upper_left_exists: upper_left /= Void

end -- class RECTANGLE



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

