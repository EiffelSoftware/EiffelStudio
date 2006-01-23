indexing
	description:
		"Figures consisting of two points."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, points"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DOUBLE_POINTED_FIGURE

inherit
	EV_SINGLE_POINTED_FIGURE
		rename
			point as point_a,
			set_point as set_point_a
		redefine
			point_count
		end

feature {NONE} -- Initialization

	make_with_points (a_point_a, a_point_b: EV_RELATIVE_POINT) is
			-- Create on `a_point_a' and `a_point_b'.
		require
			a_point_a_not_void: a_point_a /= Void
			a_point_b_not_void: a_point_b /= Void
		do
			default_create
			set_point_a (a_point_a)
			set_point_b (a_point_b)
		end

feature -- Access

	point_count: INTEGER is
			-- `Current' has two points.
		do
			Result := 2
		end

	point_b: EV_RELATIVE_POINT is
			-- Second point of `Current'.
		do
			Result := points.i_th (2)
		end

feature -- Status setting

	set_point_b (a_point: EV_RELATIVE_POINT) is
			-- Assign `a_point' to `point_b'.
		require
			a_point_not_void: a_point /= Void
		do
			points.put_i_th (a_point, 2)
		ensure
			point_b_assigned: point_b = a_point
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




end -- class EV_DOUBLE_POINTED_FIGURE

