indexing
	description:
		"Figure that is a line segment between 2 points."
	status: "See notice at end of class"
	keywords: "figure, line, segment, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_LINE

inherit
	EV_ATOMIC_FIGURE
		redefine
			set_line_width,
			bounding_box
		end

	EV_DOUBLE_POINTED_FIGURE
		undefine
			default_create
		end

	EV_ARROWED_FIGURE
		rename
			start_point as point_a,
			end_point as point_b,
			start_ref_point as point_b,
			end_ref_point as point_a
		undefine
			default_create
		end

create
	default_create,
	make_with_points,
	make_with_positions

feature {NONE} -- Initialization

	make_with_positions (x1, y1, x2, y2: INTEGER) is
			-- Create on (x1, y1)-(x2, y2).
		do
			default_create
			point_a.set_position (x1, y1)
			point_b.set_position (x2, y2)
		ensure
			point_a_x_assigned: point_a.x = x1
			point_a_y_assigned: point_a.y = y1
			point_b_x_assigned: point_b.x = x2
			point_b_y_assigned: point_b.y = y2
		end

feature -- Element change

	set_line_width (width: INTEGER) is
			-- Set line-width to `width'.
		do
			Precursor (width)
			update_arrows
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			Result := point_on_segment (x, y,
				point_a.x_abs, point_a.y_abs,
				point_b.x_abs, point_b.y_abs, line_width.max (6))
		end

feature {NONE} -- Implementation

	bounding_box: EV_RECTANGLE is
		local
			p: EV_RELATIVE_POINT
		do
			Result := Precursor
			if is_end_arrow then
				p := end_arrow.i_th_point (1)
				Result.include (p.x_abs, p.y_abs)
				p := end_arrow.i_th_point (3)
				Result.include (p.x_abs, p.y_abs)
			end
			if is_start_arrow then
				p := start_arrow.i_th_point (1)
				Result.include (p.x_abs, p.y_abs)
				p := start_arrow.i_th_point (3)
				Result.include (p.x_abs, p.y_abs)
			end
		end

end -- class EV_FIGURE_LINE

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
