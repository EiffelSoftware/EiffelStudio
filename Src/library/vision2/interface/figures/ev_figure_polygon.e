indexing
	description: "EiffelVision2 polygon."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POLYGON

inherit
	EV_CLOSED_FIGURE
		redefine
			default_create,
			list_has_correct_size
		end

creation
	default_create,
	make_with_point_list

feature {NONE}-- Initialization

	default_create is
			-- Initialize without points
		do
			Precursor
		end

feature -- Status report

	point_count: INTEGER is
			-- Number of points in polyline. Since this is not a fixed number
			-- it returns the current number of points in the line.
			--| default_create of EV_FIGURE reads this function to initialize
			--| The points-list. Solution: If points is Void returns 0.
		do
			if points /= Void then
				Result := points.count
			end
		end

	side_count: INTEGER is
			-- Returns the number of sides this polyline has.
		do
			if points.count <= 1 then
				Result := 0
			elseif points.count = 2 then
				Result := 1
			else
				Result := points.count - 1
			end
		ensure
			Result_not_bigger_than_point_count: Result <= points.count
		end

feature -- Status setting

	add_point (point: EV_RELATIVE_POINT) is
			-- Increment the size of the point-list and insert `p'.
		require
			point_exists: point /= Void
			point_relative_to_group_point:
				group /= Void implies point.valid_group_point (group.point)
			point_not_in_other_figure: point.figure = Void
		do
			points.extend (point)
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point (`x', `y') contained in this figure?
		do
			Result := point_on_polygon (x, y, point_array)
		end

	dummy (x, y: INTEGER):BOOLEAN is
		local
			hits, y_save, n, i, j, dx, dy, rx, ry: INTEGER
			s: REAL
		do
			-- Find a vertex that is not on the halfline
			from
				i := 0
			until
				not (i < points.count and then get_point_by_index (i + 1).y_abs = y)
			loop
				i := i + 1
			end

			-- Walk the edges of the polygon
			from
				n := 0
			until
				n >= points.count
			loop
				j := (i + 1) \\ points.count

				dx := get_point_by_index (j + 1).x_abs - get_point_by_index (i + 1).x_abs
				dy := get_point_by_index (j + 1).y_abs - get_point_by_index (i + 1).y_abs

				-- Ignore horizontal edges completely
				if dy /= 0 then
					-- Check to see if the edge intersects the
					-- horizontal halfline through (x, y)
					rx := x - get_point_by_index (i + 1).x_abs
					ry := y - get_point_by_index (i + 1).y_abs

					-- Deal with edges starting or ending the halfline
					if get_point_by_index (j + 1).y_abs = y and then get_point_by_index (j + 1).x_abs >= x then
						y_save := get_point_by_index (i + 1).y_abs
					end

					if get_point_by_index (i + 1).y_abs = y and then get_point_by_index (i + 1).x_abs >= x then
						if (y_save > y) /= (get_point_by_index (j + 1).y_abs > y) then
							hits := hits - 1
						end
					end

					-- Tally intersections with halfline
					s := ry / dy
					if s >= 0.0 and then s <= 1.0 and then (s * dx) >= rx then
						hits := hits + 1
					end
				end
				i := j
				n := n + 1
			end

			-- Inside if number of intersections odd
			Result := (hits \\ 2) /= 0
		end

feature -- Contract support

	list_has_correct_size (list: like points): BOOLEAN is
			-- Does `list' have the correct number of items?
			--| Any list has the correct number of points.
		do
			Result := True
		end

end -- class EV_FIGURE_POLYGON
