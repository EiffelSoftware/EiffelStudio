note
	description: "An ellipse figure. See EV_FIGURE_ELLIPTIC"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, ellipse, circle"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_ELLIPSE

inherit
	EV_MODEL_CLOSED
		undefine
			point_count,
			default_create,
			bounding_box
		end

	EV_MODEL_ELLIPTIC

create
	default_create,
	make_with_positions,
	make_with_points

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			a_projector.draw_figure_ellipse (Current)
		end

feature -- Events

	position_on_figure (ax, ay: INTEGER): BOOLEAN
			-- Is (`ax', `ay') on this figure?
		local
			p0: EV_COORDINATE
			r1, r2, cx, cy, p0x, p0y: DOUBLE
		do
			p0 := point_array [0]
			p0x := p0.x_precise
			p0y := p0.y_precise
			cx := (p0x + point_array [1].x_precise) / 2
			cy := (p0y + point_array [1].y_precise) / 2

			r1 := (cx - p0x).abs
			r2 := (cy - p0y).abs

			Result := point_on_ellipse (ax, ay, cx, cy, r1, r2)
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_ELLIPSE

