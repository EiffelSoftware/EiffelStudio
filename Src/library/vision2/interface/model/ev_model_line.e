note
	description: "[
					Line from point_a to point_b.
					
							point_a ----center---- point_b

						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_LINE

inherit
	EV_MODEL_ATOMIC
		undefine
			point_count
		redefine
			default_create,
			bounding_box
		end

	EV_MODEL_ARROWED
		rename
			start_point as point_a,
			end_point as point_b
		undefine
			default_create
		end

	DEBUG_OUTPUT
		undefine
			default_create
		end

	EV_MODEL_DOUBLE_POINTED
		undefine
			default_create
		end

create
	make_with_positions,
	default_create,
	make_with_points

feature {NONE} -- Initialization

	default_create
			-- Create a line from (0,0) to (0,0)
		do
			Precursor {EV_MODEL_ATOMIC}
			create point_array.make_empty (2)
			point_array.extend (create {EV_COORDINATE}.make (0, 0))
			point_array.extend (create {EV_COORDINATE}.make (0, 0))
			disable_start_arrow
			disable_end_arrow
			is_center_valid := True
			set_arrow_size (10)
		end

feature -- Access

	angle: DOUBLE
			-- Since a line has only one dimension, we don't care
		do
			Result := 0
		end

	length: INTEGER
			-- Length of the line.
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)

			Result := as_integer (distance (p0.x_precise, p0.y_precise, p1.x_precise, p1.y_precise))
		end

	point_a_x: INTEGER
			-- `X' position of point_a point.
		do
			Result := point_array.item (0).x
		end

	point_a_y: INTEGER
			-- `Y' position of point_a point.
		do
			Result := point_array.item (0).y
		end

	point_b_x: INTEGER
			-- `X' position of point_b point.
		do
			Result := point_array.item (1).x
		end

	point_b_y: INTEGER
			-- `Y' position of point_b point.
		do
			Result := point_array.item (1).y
		end

feature -- Status report

	is_rotatable: BOOLEAN = True
			-- Line is rotatable.

	is_scalable: BOOLEAN = True
			-- Line is scalable.

	is_transformable: BOOLEAN = True
			-- Line is transformable.

feature -- Element Change

	set_point_a_position (ax, ay: INTEGER)
			-- Set position of `point_a' to (`ax', `ay').
		do
			point_array.item (0).set (ax, ay)
			center_invalidate
			invalidate
		end

	set_point_b_position (ax, ay: INTEGER)
			-- Set position of `point_b' to (`ax', `ay')
		do
			point_array.item (1).set (ax, ay)
			center_invalidate
			invalidate
		end

feature -- Visitor

	project (a_projector: EV_MODEL_DRAWING_ROUTINES)
			-- <Precursor>
		do
			a_projector.draw_figure_line (Current)
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
		local
			pa, pb: EV_COORDINATE
			l_point_array: like point_array
			l_start_arrow: like start_arrow
			l_end_arrow: like end_arrow
		do
			l_point_array := point_array
			pa := l_point_array.item (0)
			pb := l_point_array.item (1)

			Result := point_on_segment (a_x, a_y, pa.x_precise, pa.y_precise, pb.x_precise, pb.y_precise, line_width.max (6))
			if not Result then
				if is_start_arrow then
					l_start_arrow := start_arrow
					Result := l_start_arrow.position_on_figure (a_x, a_y)
				end
				if not Result and then is_end_arrow then
					l_end_arrow := end_arrow
					Result := l_end_arrow.position_on_figure (a_x, a_y)
				end
			end
		end

	bounding_box: EV_RECTANGLE
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			max_x, max_y, min_x, min_y, lw, pa_val, pb_val: INTEGER
			pa, pb: EV_COORDINATE
			l_point_array: like point_array
		do
			if attached internal_bounding_box as l_internal_bounding_box and then l_internal_bounding_box.has_area then
				Result := l_internal_bounding_box.twin
			else
				l_point_array := point_array
				pa := l_point_array.item (0)
				pb := l_point_array.item (1)
				lw := as_integer (line_width / 2)

				pa_val := pa.x
				pb_val := pb.x
				max_x := pa_val.max (pb_val) + lw + 1
				min_x := pa_val.min (pb_val) - lw

				pa_val := pa.y
				pb_val := pb.y
				max_y := pa_val.max (pb_val) + lw + 1
				min_y := pa_val.min (pb_val) - lw

				create Result.make (min_x, min_y, max_x - min_x, max_y - min_y)
				if is_start_arrow then
					Result.merge (start_arrow.bounding_box)
				end
				if is_end_arrow then
					Result.merge (end_arrow.bounding_box)
				end
				if attached internal_bounding_box as l_internal_bounding_box then
					l_internal_bounding_box.copy (Result)
				else
					internal_bounding_box := Result.twin
				end
			end
		end

feature -- Status report

	debug_output: STRING
			--
		do
			Result := "(" + point_a_x.out + "," + point_a_y.out + ") <-> (" + point_b_x.out + "," + point_b_y.out + ")"
		end

feature {NONE} -- Implementation

	set_center
			-- Set the center of the Line.
		local
			l_point_array: like point_array
			p0, p1: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := point_array.item (0)
			p1 := point_array.item (1)

			center.set_precise ((p0.x_precise + p1.x_precise) / 2, (p0.y_precise + p1.y_precise) / 2)
			is_center_valid := True
		end

invariant

	point_array_has_three_points: point_array.count = 2
	second_point_is_point_a: point_array.item (0).x = point_a_x and point_array.item (0).y = point_a_y
	thrid_point_is_point_b: point_array.item (1).x = point_b_x and point_array.item (1).y = point_b_y

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




end -- class EV_MODEL_LINE






