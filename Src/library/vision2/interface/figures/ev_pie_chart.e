indexing
	description: "Objects that display a pie chart"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIE_CHART

inherit
	EV_CLOSED_FIGURE

	EV_ANGLE_ROUTINES
		export
			{NONE} all
		end
	
	--	rename
	--	export
	--	undefine
	--	redefine
	--	select
	--	end

create
	make

feature -- Initialization

	make is
			-- Initialize the pie chart.
		do
			init_fig (Void)
			create center.make
			create path.make
			create interior.make
			interior.set_no_op_mode
			--create orientation.make_radians (0.0)
			create orientation.make_degrees (45)
			create cumulative_angle.make_radians (0.0)
			create segments.make (1)
			set_origin_to_center
			radius := 100
		end

feature -- Access

	center: EV_POINT
		-- Center of the pie chart.

	orientation: EV_ANGLE
		-- Angle  which specifies the position of the first segment
		-- (length `radius1') relative to the three-o'clock position
		-- from the center.

	radius: INTEGER
		-- Radius of the ellipse.

	cumulative_angle: EV_ANGLE
		-- The cumulative angles of all the segments

	segments: ARRAYED_LIST[TUPLE[EV_ANGLE, EV_COLOR]]

feature -- Measurement

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current ellipse superimposable to `other' ?
			--! not finished
		do
--			Result := center.is_superimposable (other.center) and
--				(radius1 = other.radius1) and (radius2 = other.radius2)
--				and (orientation = other.orientation)
		end

feature -- Status setting

	add_angle (angle: EV_ANGLE; color: EV_COLOR) is
			-- Add a new segment to the pie chart.
		require
			angle_not_void: angle /= Void
			color_not_void: color /= Void
		local
			tuple: TUPLE[EV_ANGLE, EV_COLOR]
		do 
			cumulative_angle.set_radians (cumulative_angle.radians + angle.radians)
			create tuple.make
			tuple.force (angle, 0)
			tuple.force (color, 1)
			segments.extend (tuple)
		end

	set_center (a_point: like center) is
			-- Assign `a_point' to `center'.
		require
			a_point_exists: a_point /= Void
		local
			tuple: TUPLE [EV_ANGLE, EV_COLOR]
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

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 2
		ensure then
			origin.is_superimposable (center)
		end

	set_radius (new_radius: like radius) is
			-- Set `radius1' to `new_radius1', change `size_of_side'.
		require
			size_positive: new_radius > 0
		do
			radius := new_radius
			set_modified
		ensure
			radius = new_radius
		end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in radians.
		local
			tuple: TUPLE [EV_ANGLE, EV_COLOR]
			arc: EV_ARC
			angle: EV_ANGLE
		do
			center.xyrotate (a, px, py)
			orientation := orientation + a
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		local
			tuple: TUPLE [EV_ARC, EV_COLOR]
			arc: EV_ARC
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


feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	draw is
			-- Display the pie chart.
		local
			ang: EV_ANGLE
			tuple: TUPLE[EV_ANGLE, EV_COLOR]
			angle,tmp_angle: EV_ANGLE
			color: EV_COLOR
		do
			if drawing.is_drawable then
				from
					!! tmp_angle.make_radians(0.0)
					segments.start
				until
					segments.off
				loop
					tuple := segments.item
					angle ?= tuple.item (0)
					color ?= tuple.item (1)
					drawing.set_foreground_color (color)
					drawing.fill_arc (center, radius, radius, tmp_angle, angle, orientation, 1)
					tmp_angle := tmp_angle + angle
					segments.forth
				end
			end
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

--invariant
--	invariant_clause: -- Your invariant here

end -- class EV_PIE_CHART
