indexing
	description: "EiffelVision rectangle."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RECTANGLE

inherit
	EV_CLOSED_FIGURE
		redefine
			recompute
		end

	EV_ANGLE_ROUTINES
		export
			{NONE} all
		end

create
	make, make_from_closure

feature {NONE} -- Initialization

	make is
			-- Create a rectangle.
		do
			init_fig (Void)
			create upper_left.make
			create path.make 
			create interior.make 
			interior.set_no_op_mode
			width := 1
			height := 1
			create orientation.make_radians (0)
		end 

	make_from_closure (cl: EV_CLOSURE) is
			-- Create a rectangle containing `cl`
		local
			w,h : INTEGER
		do
			make
			if not cl.empty then
				upper_left := deep_clone (cl.up_left)
				w := cl.down_right.x - cl.up_left.x
				h := cl.down_right.y - cl.up_left.y
				width := w
				height := h
			end
		end

feature -- Access

	center: EV_POINT is
			-- Center of the rectangle.
		local
			v_cos, v_sin: REAL
			half_width, half_height: INTEGER
		do
			v_cos := orientation.cosine
			v_sin := orientation.sine
			half_width := width // 2
			half_height := height // 2
			create Result.set (upper_left.x + (half_width *
				v_cos + half_height * v_sin).truncated_to_integer,
					 upper_left.y - (half_width *
				v_sin - half_height * v_cos).truncated_to_integer)
		end

	height: INTEGER
			-- Height of rectangle

	upper_left: EV_POINT
			-- Upper left coin of the rectangle

	width: INTEGER
			-- Width of rectangle

	origin: EV_POINT is
			-- Origin of rectangle
		do
			inspect origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := upper_left
			when 3 then
				Result := center
			end
		end

feature -- Element change 

	set_height (new_height: like height) is
			-- Set `height' to `new_height'.
		require
			new_height_positive: new_height >= 0
		do
			height := new_height
			set_modified
		ensure
			height = new_height
		end

	set_orientation (new_orientation: like orientation) is
			-- Set `orientation' to `new_orientation'.
		do
			orientation := new_orientation
			set_modified
		ensure
			orientation = new_orientation
		end

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 3
		ensure then
			origin.is_superimposable (center)
		end

	set_origin_to_upper_left is
			-- Set origin to upper left coiner.
		do
			origin_user_type := 2
		ensure
			origin.is_superimposable (upper_left)
		end

	set_upper_left (a_point: like upper_left) is
			-- Set `upper_left' to `a_point'.
		require
			a_point_exists: a_point /= Void
		do
			upper_left := a_point
			set_modified
		ensure
			upper_left = a_point
		end

	set_width (new_width: like width) is
			-- Set `width' to `new_width'
		require
			new_width_positive: new_width >= 0
		do
			width := new_width
			set_modified
		ensure
			width = new_width
		end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in radians.
		do
			orientation := orientation + a
			upper_left.xyrotate (a, px, py)
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			width := (f*width).truncated_to_integer
			height := (f*height).truncated_to_integer
			upper_left.xyscale (f, px, py)
			set_modified
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			upper_left.xytranslate (vx, vy)
			set_modified
		end 

feature -- Output

	draw is
			-- Draw the rectangle.
		local
			lint: EV_INTERIOR
			lpath: EV_PATH
		do
			if drawing.is_drawable then
--				drawing.set_join_style (join_style)
				if interior /= Void then
					create lint.make
					lint.get_drawing_attributes (drawing)
					interior.set_drawing_attributes (drawing)
					drawing.fill_rectangle (center, width, height, orientation)
					lint.set_drawing_attributes (drawing)
				end
				if path /= Void then
					create lpath.make
					lpath.get_drawing_attributes (drawing)
					path.set_drawing_attributes (drawing)
					drawing.draw_rectangle (center, width, height, orientation)
					lpath.set_drawing_attributes (drawing)
				end
			end
		end

feature -- Status report
	
	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current rectangle superimposable to `other' ?
		require else
			other_exists: other /= Void
		do
			Result := upper_left.is_superimposable (other.upper_left) and 
				(width = other.width) and (height = other.height)
		end

feature {CONFIGURE_NOTIFY} -- Updating

	recompute is
		local
			v_max, v_maxdiv2: INTEGER
			cent: EV_POINT
		do
			cent := center
			if height > width then
				v_max := height
			else
				v_max := width
			end
			v_max := v_max * 1415 // 1000
			v_maxdiv2 := v_max // 2
			surround_box. set (cent.x-v_maxdiv2, cent.y-v_maxdiv2 , v_max, v_max)
			unset_modified
		end

feature {NONE} -- Access

	orientation: EV_ANGLE
			-- Orientation in radians of the rectangle

invariant
	origin_user_type_constraint: origin_user_type <= 3
	non_negative_width: width >= 0
	non_negative_height: height >= 0
	upper_left_exists: upper_left /= Void

end -- class EV_RECTANGLE

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

