indexing
	description: "EiffelVision regular polygon (triangle, square, pentagon...)."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_REGULAR_POLYGON

inherit
	EV_CLOSED_FIGURE
		redefine
			recompute
		end

--	EV_JOINABLE

	EV_ANGLE_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make  is
			-- Create a reg_polygon.
		do
			init_fig (Void)
			!! center.make
			!! path.make 
			!! interior.make 
			interior.set_no_op_mode
			radius := 0
			number_of_sides := 3
			orientation := 0
		end

feature -- Access 

	center: EV_POINT
			-- Center of the reg_polygon.

	number_of_sides: INTEGER
			-- Number of sides

	orientation: REAL
			-- Orientation in degree of the reg_polygon

	origin: EV_POINT is
			-- Origin of reg_polygon
		do
			inspect origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := center
			end
		end

	radius: INTEGER
			-- Radius of the circle who contains all the point of the polygon

	size_of_side: INTEGER is
			-- Size of a side
		do
			Result := (2 * radius / (cos(180.0 / number_of_sides))).truncated_to_integer
		end

feature -- Element change

	set_center (a_point: like center) is
			-- Set `center' to `a_point'.
		require
			a_point_exits: a_point /= Void
		do
			center := a_point
			set_modified
		ensure
			center = a_point
		end

	set_number_of_sides (new_number_of_sides: like number_of_sides) is
			-- Set `number_of_sides' to `new_number_of_sides'.
		require
			at_least_three_sides: new_number_of_sides >= 3
		do
			number_of_sides := new_number_of_sides
			set_modified
		ensure
			number_of_sides = new_number_of_sides
		end

	set_orientation (new_orientation: like orientation) is
			-- Set `orientation' to `new_orientation'.
		require
			orientation_positive: new_orientation >= 0
			orientation_smaller_than_360: new_orientation < 360
		do
			orientation := new_orientation
			set_modified
		ensure
			orientation = new_orientation
		end

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 2
		ensure then
			origin.is_superimposable (center)
		end 

	set_radius (new_radius: like radius) is
			-- Set `radius' to `new_radius', change `size_of_side'.
		require
			size_positive: new_radius >= 0
		do
			radius := new_radius
			set_modified
		ensure
			radius = new_radius
		end

	set_size_of_side (a_size: INTEGER) is
			-- Set `size_of_side' to `a_size', change `radius'.
		require
			a_size_positive: a_size >= 0
		do
			radius := (a_size*cos (180.0/number_of_sides)/2).truncated_to_integer
			set_modified
		ensure
			--rounding_error_allowance: a_size - 1 <= size_of_side and size_of_side <= a_size + 1
		end

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		do
			orientation := mod360 (orientation+a)
			center.xyrotate (a, px, py)
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			radius := (f*radius).truncated_to_integer
			center.xyscale (f, px, py)
			set_modified
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			center.xytranslate (vx, vy)
			set_modified
		end

feature -- Output

	draw is
			-- Draw the reg_polygon.
		local
			polygon: EV_POLYGON
			a_point: EV_POINT
			i: INTEGER
			angle: INTEGER
		do
			if drawing.is_drawable then
				!! polygon.make 
				polygon.set_not_notify
				from
					i := 0
				until
					i >= number_of_sides
				loop
					angle := (i * (360 // number_of_sides) + orientation.truncated_to_integer) \\ 360
					!! a_point.set (center.x + (radius *
										cos (angle)).truncated_to_integer,
									center.y + (radius *
										sin(angle)).truncated_to_integer)
					if polygon.off then
						polygon.add (a_point)
					else
						polygon.put_left (a_point)
					end
					i := i+1
				end
				polygon.attach_drawing (drawing)
--				drawing.set_join_style (join_style)
				if interior /= Void then
					interior.set_drawing_attributes (drawing)
					drawing.fill_polygon (polygon.to_array)
				end
				if path /= Void then
					path.set_drawing_attributes (drawing)
					drawing.draw_polyline (polygon.to_array, true)
				end
			end
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current reg_polygon superimposable to `other' ?
			--| not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and 
				(number_of_sides = other.number_of_sides) and 
				(radius = other.radius) and (orientation = other.orientation)
		end

feature {EV_GEOMETRICAL} -- Updating

	recompute is
		local
			diameter: INTEGER
		do
			diameter := radius + radius
			surround_box.set (center.x -radius, center.y -radius, diameter, diameter)
			unset_modified
		end

invariant
	origin_user_type_constraint: origin_user_type <= 2
	non_negative_radius: radius >= 0
	side_size_meaningful: size_of_side >= 0
	side_count_constraint: number_of_sides >= 3
	orientation_small_enough: orientation < 360
	orientation_large_enough: orientation >= 0
	center_exists: center /= Void

end -- class EV_REGULAR_POLYGON

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

