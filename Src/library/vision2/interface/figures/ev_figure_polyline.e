indexing
	description:
		"Sequences of lines through `points'."
	status: "See notice at end of class"
	keywords: "figure, polyline, line"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POLYLINE

inherit
	EV_ATOMIC_FIGURE

	EV_MULTI_POINTED_FIGURE
		undefine
			default_create
		end

	EV_ARROWED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_coordinates

feature {NONE} -- Initialization

	make_with_coordinates (coords: ARRAY [EV_COORDINATE]) is
			-- Initialize with points in `coords'.
		require
			coords_exist: coords /= Void
		local
			new_point: EV_RELATIVE_POINT
			i: INTEGER
		do
			default_create
			from
				i := coords.lower
			until
				i > coords.upper
			loop
				create new_point.make_with_position (
					coords.item (i).x,
					coords.item (i).y)
				extend_point (new_point)
				i := i + 1
			end
		end

feature -- Access

	is_closed: BOOLEAN
			-- Should this polyline be closed?
			-- i.e. should first and last point be connected?

feature -- Status report

	line_count: INTEGER is
			-- Returns number of lines this polyline has.
		do
			if points.count <= 1 then
				Result := 0
			elseif points.count = 2 then
				Result := 1
			elseif is_closed then
				Result := points.count
			else
				Result := points.count - 1
			end
		ensure
			Result_not_bigger_than_point_count: Result <= points.count
		end

	extract_line (index: INTEGER): EV_FIGURE_LINE is
			-- Create a line-object for line with `index'.
		require
			index_within_bounds: index > 0 and then index <= line_count
		do
			if is_closed and index = line_count then
				create Result.make_with_points (start_point, end_point)
			else
				create Result.make_with_points (
					points.i_th (index),
					points.i_th (index + 1))
			end
		ensure
			Result_exists: Result /= Void
		end

feature -- Status setting

	enable_closed is
			-- Set `is_closed' `True'.
		do
			is_closed := True
			invalidate
		ensure
			is_closed: is_closed
		end

	disable_closed is
			-- Set `is_closed' `False'.
		do
			is_closed := False
			invalidate
		ensure
			is_open: not is_closed
		end

feature {EV_FIGURE_DRAWER} -- Implementation

	start_point: EV_RELATIVE_POINT is
			-- Point where `start_arrow' is drawn.
		do
			Result := points.i_th (1)
		end

	start_ref_point: EV_RELATIVE_POINT is
			-- Point that determines angle for `start_point'.
		do
			Result := points.i_th (2)
		end

	end_point: EV_RELATIVE_POINT is
			-- Point where `end_arrow' is drawn.
		do
			Result := points.i_th (points.count)
		end

	end_ref_point: EV_RELATIVE_POINT is
			-- Point that determines angle for `end_point'.
		do
			Result := points.i_th (points.count - 1)
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure? i.e. is it
			-- on any of lines of this polyline?
		local
			pa, pb: EV_RELATIVE_POINT
		do
			if points.count <= 1 then
				Result := False
			else
				from
					points.start
					pa := points.item
					points.forth
					pb := points.item
				until
					Result or else points.after
				loop
					Result := point_on_segment (x, y,
						pa.x_abs, pa.y_abs,
						pb.x_abs, pb.y_abs, line_width.max (6))
					pa := pb
					points.forth
					if not points.after then
						pb := points.item
					end				
				end
				if points.count > 2 and then is_closed then
					Result := Result or point_on_segment (x, y,
						start_point.x_abs, start_point.y_abs,
						end_point.x_abs, end_point.y_abs, line_width.max (6))
				end
			end
		end

end -- class EV_FIGURE_POLYLINE

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
