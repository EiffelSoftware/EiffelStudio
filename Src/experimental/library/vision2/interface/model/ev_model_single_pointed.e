note
	description:
		"Figures consisting of one point."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, point"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_SINGLE_POINTED

feature {NONE} -- Initialization

	make_with_point (a_point: EV_COORDINATE)
			-- Create on `a_point'.
		require
			a_point_not_void: a_point /= Void
		do
			default_create
			set_point_position (a_point.x, a_point.y)
		end

	make_with_position (a_point_x, a_point_y: INTEGER)
			-- Create on (`a_point_x', `a_point_y')
		do
			default_create
			set_point_position (a_point_x, a_point_y)
		end

feature -- Access

	point_count: INTEGER
			-- `Current' has one point.
		do
			Result := 1
		end

	point: EV_COORDINATE
			-- First point of `Current'.
		do
			create Result.make (point_x, point_y)
		ensure
			Result_exists: Result /= Void
			Result_x_equal_point_x: Result.x = point_x
			Result_y_eqyal_point_y: Result.y = point_y
		end

	point_relative: EV_COORDINATE
			-- `point' relative to `group'.`point'.
		do
			create Result.make (point_x_relative, point_y_relative)
		ensure
			Result_exists: Result /= Void
			Result_x_equal_point_x_relative: Result.x = point_x_relative
			Result_y_eqyal_point_y_relative: Result.y = point_y_relative
		end

	point_x: INTEGER
			-- x position of `point'.
		deferred
		end

	point_x_relative: INTEGER
			-- horizontal distance between `point_x' and `group'.`point_x'.
		do
			if attached group as l_group then
				Result := point_x - l_group.point_x
			else
				Result := point_x
			end
		end

	point_y: INTEGER
			-- y position of `point'.
		deferred
		end

	point_y_relative: INTEGER
			-- vertical distance between `point_y' and `group'.`point_y'.
		do
			if attached group as l_group then
				Result := point_y - l_group.point_y
			else
				Result := point_y
			end
		end

feature -- Status setting

	set_point (a_point: EV_COORDINATE)
			-- Set position of `point' to position of `a_point'.
		obsolete
			"Use set_point_position"
		require
			a_point_not_void: a_point /= Void
		do
			set_point_position (a_point.x, a_point.y)
		end

	set_point_position (ax, ay: INTEGER)
			-- Set position of `point' to (`ax', `ay').
		deferred
		end

	set_point_position_relative (ax, ay: INTEGER)
			-- Set position of `point_relative' to (`ax', `ay').
		do
			if attached group as l_group then
				set_point_position (l_group.point_x + ax, l_group.point_y + ay)
			else
				set_point_position (ax, ay)
			end
		end

feature {NONE} -- Implementation

	point_array: SPECIAL [EV_COORDINATE]
			-- Relative points `Current' consists of.
		deferred
		end

	group: detachable EV_MODEL_GROUP
			-- Group `Current' is part of
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_SINGLE_POINTED





