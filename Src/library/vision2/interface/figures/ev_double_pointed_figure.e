indexing
	description:
		"Figures consisting of two points."
	status: "See notive at end of class"
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

end -- class EV_DOUBLE_POINTED_FIGURE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------
