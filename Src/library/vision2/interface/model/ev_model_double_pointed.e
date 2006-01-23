indexing
	description:
		"Figures consisting of two points."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, points"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_DOUBLE_POINTED

inherit
	EV_MODEL_SINGLE_POINTED
		rename
			point as point_a,
			set_point as set_point_a,
			set_point_position as set_point_a_position,
			set_point_position_relative as set_point_a_position_relative,
			point_x as point_a_x,
			point_y as point_a_y,
			point_x_relative as point_a_x_relative,
			point_y_relative as point_a_y_relative
		redefine
			point_count
		end

feature {NONE} -- Initialization

	make_with_points (a_point_a, a_point_b: EV_COORDINATE) is
			-- Create on `a_point_a' and `a_point_b'.
		require
			a_point_a_not_void: a_point_a /= Void
			a_point_b_not_void: a_point_b /= Void
		do
			make_with_point (a_point_a)
			set_point_b_position (a_point_b.x, a_point_b.y)
		end
		
	make_with_positions (a_point_a_x, a_point_a_y, a_point_b_x, a_point_b_y: INTEGER) is
			-- Create on position (`a_point_a_x' `a_point_a_y') and (`a_point_b_x', `a_point_b_y')
		do
			make_with_position (a_point_a_x, a_point_a_y)
			set_point_b_position (a_point_b_x, a_point_b_y)
		end

feature -- Access

	point_count: INTEGER is
			-- `Current' has two points.
		do
			Result := 2
		end

	point_b: EV_COORDINATE is
			-- Second point of `Current'.
		do
			create Result.make (point_b_x, point_b_y)
		ensure
			Result_exists: Result /= Void
			Result_x_equal_point_b_x: Result.x = point_b_x
			Result_y_equal_point_b_y: Result.y = point_b_y
		end
		
	point_b_relative: EV_COORDINATE is
			-- `point_b' relative to `group'.`point'.
		do
			create Result.make (point_b_x_relative, point_b_y_relative)
		ensure
			Result_exists: Result /= Void
			Result_x_equal_point_b_x_relative: Result.x = point_b_x_relative
			Result_y_eqyal_point_b_y_relative: Result.y = point_b_y_relative
		end
		
	point_b_x: INTEGER is
			-- x position of `point_b'.
		deferred
		end
		
	point_b_x_relative: INTEGER is
			-- horizontal distance between `point_b_x' and `group'.`point_x'.
		do
			if group = Void then
				Result := point_b_x
			else
				Result := point_b_x - group.point_x
			end
		end
		
	point_b_y: INTEGER is
			-- y position of `point_b'.
		deferred
		end


	point_b_y_relative: INTEGER is
			-- vertical distance between `point_b_y' and `group'.`point_y'.
		do
			if group = Void then
				Result := point_b_y
			else
				Result := point_b_y - group.point_y
			end
		end

feature -- Status setting

	set_point_b (a_point: EV_COORDINATE) is
			-- Assign `a_point' to `point_b'.
		obsolete
			"Use set_point_b_position"
		require
			a_point_not_void: a_point /= Void
		do
			set_point_b_position (a_point.x, a_point.y)
		end
		
	set_point_b_position (ax, ay: INTEGER) is
			-- Set position of `point_b' to (`ax',`ay').
		deferred
		end
		
	set_point_b_position_relative (ax, ay: INTEGER) is
			-- Set position of `point_b_relative' to (`ax', `ay').
		do
			if group /= Void then
				set_point_b_position (group.point_x + ax, group.point_y + ay)
			else
				set_point_b_position (ax, ay)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_DOUBLE_POINTED

