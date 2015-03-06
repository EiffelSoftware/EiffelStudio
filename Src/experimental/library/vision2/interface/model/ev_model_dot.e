note
	description:
		"Pixels on `point' with size `line_width'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, dot, point, pixel"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_DOT

inherit
	EV_MODEL_ATOMIC
		undefine
			point_count
		redefine
			bounding_box,
			default_create
		end

	EV_MODEL_SINGLE_POINTED
		undefine
			default_create
		end

create
	default_create,
	make_with_position,
	make_with_point

feature {NONE} -- Initialization

	default_create
			-- Create a dot at (0,0)
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make_empty (1)
			point_array.extend (create {EV_COORDINATE}.make (0, 0))
		end

feature -- Access

	angle: DOUBLE = 0.0
			-- A point is allways upright.

	point_x: INTEGER
			-- x position of `point'.
		do
			Result := point_array.item (0).x
		end

	point_y: INTEGER
			-- y position of `point'.
		do
			Result := point_array.item (0).y
		end

feature -- Status

	is_scalable: BOOLEAN = True
			-- Is scalable? Yes, but a dot has no dimension and will therfore not grow.

	is_rotatable: BOOLEAN = True
			-- Is roatatble?

	is_transformable: BOOLEAN = True
			-- Is transformable?

feature -- Element change

	set_point_position (ax, ay: INTEGER)
			-- Set center to `a_point' position.
		do
			point_array.item (0).set (ax, ay)
			invalidate
			center_invalidate
		end

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			a_projector.draw_figure_dot (Current)
		end

feature -- Events

	position_on_figure (ax, ay: INTEGER): BOOLEAN
			-- Is (`ax', `ay') on this figure?
		local
			p: EV_COORDINATE
			lw: DOUBLE
		do
			p := point_array.item (0)
			lw := line_width / 2
			Result := point_on_ellipse (ax, ay, p.x_precise, p.y_precise, lw, lw)
		end


feature {NONE} -- Implementation

	bounding_box: EV_RECTANGLE
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			lw2, lw: INTEGER
			p: EV_COORDINATE
		do
			if attached internal_bounding_box as l_internal_bounding_box and then l_internal_bounding_box.has_area then
				Result := l_internal_bounding_box.twin
			else
				lw := line_width
				lw2 := as_integer (lw / 2)
				p := point_array.item (0)
				create Result.make (p.x - lw2, p.y - lw2, lw, lw)
				internal_bounding_box := Result.twin
			end
		end

feature {NONE} -- Implementation

	set_center
			-- Set the position of the center
		local
			p:EV_COORDINATE
		do
			p := point_array.item (0)
			center.set_precise (p.x_precise, p.y_precise)
			is_center_valid := True
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




end -- class EV_MODEL_DOT






