indexing
	description: "EiffelVision Ellipse figure."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ELLIPSE

inherit
	EV_CLOSED_FIGURE
		redefine
			contains, recompute
		end

	EV_ANGLE_ROUTINES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- Create a ellipse.
		do
			init_fig (Void)
			create center.make
			create path.make 
			create interior.make 
			interior.set_no_op_mode
			radius1 := 1
			radius2 := 1
			create orientation.make (0.0)
			set_origin_to_center
		end

feature -- Access

	center: EV_POINT
			-- Center of the ellipse.

	orientation: EV_ANGLE
			-- Angle which specifies the position of the first ray
			-- (length `radius1') relative to the three-o'clock position
			-- from the center

	origin: EV_POINT is
			-- Origin of ellipse
		do
			inspect origin_user_type
			when 1 then
				Result := origin_user
			when 2 then
				Result := center
			end
		end

	radius1: INTEGER
			-- First radius of the ellipse

	radius2: INTEGER
			-- Second radius of the ellipse

	contains (p: EV_POINT): BOOLEAN is
			-- Is `p' in the current ellipse ?
		do
			Result := ((p - center).x / radius1) ^ 2 + ((p - center).y / radius2) ^ 2 <= 1
		end

feature -- Status setting

	set_center (a_point: like center) is
			-- Set `center' to `a_point'.
		require
			a_point_exits: a_point /= Void
		do
			center := a_point
			set_modified
		ensure
			center_set: center = a_point
		end

	set_orientation (an_orientation: like orientation) is
			-- Set `orientation' to `an_orientation'.
		do
			orientation := an_orientation
			set_modified
		ensure
			orientation = an_orientation
		end

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 2
		ensure then
			origin.is_superimposable (center)
		end

	set_radius1 (new_radius1: like radius1) is
			-- Set `radius1' to `new_radius1', change `size_of_side'.
		require
			size_positive: new_radius1 > 0
		do
			radius1 := new_radius1
			set_modified
		ensure
			radius1 = new_radius1
		end

	set_radius2 (new_radius2: like radius2) is
			-- Set `radius1' to `new_radius2', change `size_of_side'.
		require
			size_positive: new_radius2 > 0
		do
			radius2 := new_radius2
			set_modified
		ensure
			radius2 = new_radius2
		end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in radians.
		do
			center.xyrotate (a, px, py)
			orientation := orientation + a
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			radius1 := (f*radius1).truncated_to_integer
			radius2 := (f*radius2).truncated_to_integer
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
			-- Draw the ellipse.
		local
			lint: EV_INTERIOR
			lpath: EV_PATH
			angle1,angle2: EV_ANGLE
		do
			if drawing.is_drawable then
				create angle1.make (0.0)
				create angle2.make (Pi * 2)
				if interior /= Void then
					create lint.make
					lint.get_drawing_attributes (drawing)
					interior.set_drawing_attributes (drawing)
					drawing.fill_arc (center, radius1, radius2, angle1, angle2, orientation, 0)
					lint.set_drawing_attributes (drawing)
				end
				if path /= Void then
					create lpath.make
					lpath.get_drawing_attributes (drawing)
					path.set_drawing_attributes (drawing)
					drawing.draw_arc (center, radius1, radius2, angle1, angle2, orientation, -1)
					lpath.set_drawing_attributes (drawing)
				end
			end
		end

feature -- Updating

	recompute is
		local
			diameter: INTEGER
		do
			if radius1 > radius2 then
				diameter := radius1 + radius1
				surround_box.set (center.x-radius1, center.y-radius1, diameter, diameter)
			else
				diameter := radius2 + radius2
				surround_box.set (center.x-radius2, center.y-radius2, diameter, diameter)
			end
			unset_modified
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current ellipse superimposable to `other' ?
			--! not finished
		do
			Result := center.is_superimposable (other.center) and
				(radius1 = other.radius1) and (radius2 = other.radius2)
				and (orientation = other.orientation)
		end

invariant
	origin_user_type_constraint: origin_user_type <= 2
	meaningful_radius1: radius1 >= 0
	meaningful_radius2: radius2 >= 0
	center_exists: center /= Void

end -- class EV_ELLIPSE

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

