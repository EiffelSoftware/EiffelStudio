indexing
	description:
		"Figures consisting of zero or more points."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, points"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_MULTI_POINTED
	
inherit
	EV_MODEL

feature -- Access

	i_th_point_x (i: INTEGER): INTEGER is
			-- `i'-th points x position.
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			Result := point_array.item (i - 1).x
		ensure
			correct_entry: Result = point_array.item (i - 1).x
		end
		
	i_th_point_y (i: INTEGER): INTEGER is
			-- `i'-th points y position.
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			Result := point_array.item (i - 1).y
		ensure
			correct_entry: Result = point_array.item (i - 1).y
		end
		
	i_th_point (i: INTEGER): EV_COORDINATE is
			-- `i'-th point of `Current'.
		obsolete
			"Use i_th_point_x or i_th_point_y."
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			Result := point_array.item (i - 1).twin
		ensure
			correct_entry: Result.x = point_array.item (i - 1).x and Result.y = point_array.item (i - 1).y
		end

feature -- Status setting

	set_i_th_point_x (i: INTEGER; a_x: INTEGER) is
			-- Assign `a_x' to `i'-ths point `x' position.
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			point_array.item (i - 1).set_x (a_x)
			center_invalidate
			invalidate
		ensure
			assigned: i_th_point_x (i) = a_x
		end
		
	set_i_th_point_y (i: INTEGER; a_y: INTEGER) is
			-- Assign `a_y' to `i'-ths point `y' position.
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			point_array.item (i - 1).set_y (a_y)
			center_invalidate
			invalidate
		ensure
			assigned: i_th_point_y (i) = a_y
		end
		
	set_i_th_point (i: INTEGER; a_point: EV_COORDINATE) is
			-- Set position of `i'-th point to position of `a_point'.
		obsolete
			"Use set_i_th_point_position."
		require
			i_within_bounds: i > 0 and then i <= point_count
			a_point_not_void: a_point /= Void
		do
			set_i_th_point_position (i, a_point.x, a_point.y)
		ensure
			assigned: i_th_point_x (i) = a_point.x and i_th_point_y (i) = a_point.y
		end
		
	set_i_th_point_position (i: INTEGER; ax, ay: INTEGER) is
			-- Set position of `i'-th point to (`ax', `ay').
		require
			i_within_bounds: i > 0 and then i <= point_count
		do
			point_array.item (i - 1).set (ax, ay)
			invalidate
			center_invalidate
		ensure
			assigned: i_th_point_x (i) = ax and i_th_point_y (i) = ay
		end

	set_point_count (a_count: INTEGER) is
			-- Assign `a_count' to `point_count'.
		require
			a_count_non_negative: a_count >= 0
		local
			old_count, i, nb: INTEGER
			new_array: like point_array
		do
			old_count := point_array.count
			if a_count > old_count then
				point_array := point_array.resized_area (a_count)
				from
					i := old_count
					nb := a_count - 1
				until
					i > nb
				loop
					point_array.put (create {EV_COORDINATE}, i)
					i := i + 1
				end
			elseif a_count < point_count then
				create new_array.make (a_count)
				from
					i := 0
					nb := a_count - 1
				until
					i > nb
				loop
					new_array.put (point_array.item (i), i)
					i := i + 1
				end
				point_array := new_array
			end
			center_invalidate
			invalidate
		ensure
			point_count_assigned: point_count = a_count
		end

	extend_point (a_point: EV_COORDINATE) is
			-- Add a twin of `a_point' to end of `Current'.
		require
			a_point_not_void: a_point /= Void
		do
			point_array := point_array.resized_area (point_array.count + 1)
			point_array.put (a_point.twin, point_array.count - 1)
			center_invalidate
			invalidate
		ensure
			incremented: point_array.count = old point_array.count + 1
		end

feature {NONE} -- Implementation
		
	set_center is
			-- Set `x' and `y' to the center of the figure.
		local
			l_point_array: SPECIAL [EV_COORDINATE]
			i, nb: INTEGER
			min_x, min_y, max_x, max_y, val: DOUBLE
			l_item: EV_COORDINATE
		do
			if point_count = 0 then
				center.set (0, 0)
			else
				l_point_array := point_array
				l_item := l_point_array.item (0)
				min_x := l_item.x_precise
				max_x := min_x
				min_y := l_item.y_precise
				max_y := min_y
				from
					i := 1
					nb := l_point_array.count - 1
				until
					i > nb
				loop
					l_item := l_point_array.item (i)
					val := l_item.x_precise
					max_x := max_x.max (val)
					min_x := min_x.min (val)
					val := l_item.y_precise
					max_y := max_y.max (val)
					min_y := min_y.min (val)
					i := i + 1
				end
				
				center.set_precise ((max_x + min_x) / 2, (max_y + min_y) / 2)
			end
			is_center_valid := True
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




end -- class EV_MODEL_MULTI_POINTED

