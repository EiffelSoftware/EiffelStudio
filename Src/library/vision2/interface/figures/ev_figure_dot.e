indexing
	description:
		"Pixels on `point' with size `line_width'."
	status: "See notive at end of class"
	keywords: "figure, dot, point, pixel"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_DOT

inherit
	EV_ATOMIC_FIGURE
		redefine
			bounding_box
		end

	EV_SINGLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_point

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			-- To be optimized.
			Result := point_on_ellipse (x, y, point.x_abs,
				point.y_abs, line_width // 2, line_width // 2)
		end

feature {EV_PROJECTOR} -- Implementation

	coordinates: EV_COORDINATE is
			-- Absolute center coordinates of `Current'.
		do
			Result := point.absolute_coordinates
		end

feature {NONE} -- Implementation

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			px, py, lw: INTEGER
		do
			px := point.x_abs
			py := point.y_abs
			lw := line_width // 2
			create Result.make (px - lw, py - lw, line_width, line_width)
		end

feature {EV_FIGURE_DRAWING_ROUTINES} -- Access

	metrics: TUPLE [INTEGER, INTEGER, INTEGER] is
			-- [`x', `y', `width']
		local
			p: EV_RELATIVE_POINT
			lw: INTEGER
		do
			p := point
			lw := line_width // 2
			Result := [p.x_abs - lw, p.y_abs - lw, line_width]
		end

end -- class EV_FIGURE_DOT

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
