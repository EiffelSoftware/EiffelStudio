indexing
	description:
		"Figure consisting of any number of points. Lines are drawn between%N%
		%consecutive points."
	status: "See notice at end of file"
	keywords: "figure, polyline, line"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POLYLINE

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create,
			list_has_correct_size
		end

create
	default_create,
	make_with_point_list,
	make_for_test

feature {NONE}-- Initialization

	default_create is
			-- Initialize without points
		do
			Precursor
		end

	make_for_test is
			-- Create interesting to display.
		do
			default_create
			from until point_count = 5 loop
				add_point (create {EV_RELATIVE_POINT})
			end
			get_point_by_index (1).set_x (3)
			get_point_by_index (1).set_y (3)
			get_point_by_index (2).set_x (30)
			get_point_by_index (2).set_y (50)
			get_point_by_index (3).set_x (90)
			get_point_by_index (3).set_y (10)
			get_point_by_index (4).set_x (80)
			get_point_by_index (5).set_y (190)
			get_point_by_index (5).set_x (130)
			get_point_by_index (5).set_y (150)
			set_foreground_color (create {EV_COLOR}.make_with_rgb (
				0.5, 1.0, 0.5))
			set_line_width (2)
		end

feature -- Access

	closed: BOOLEAN
			-- Should this polyline be closed? That means should the first
			-- and the last point be connected?

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

	line_count: INTEGER is
			-- Returns the number of lines this polyline has.
		do
			if points.count <= 1 then
				Result := 0
			elseif points.count = 2 then
				Result := 1
			elseif closed then
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
			check
				to_be_implemented: False
			end
		ensure
			Result_exists: Result /= Void
		end

feature -- Status setting

	set_closed (flag: BOOLEAN) is
			-- Set closed to `flag'.
		do
			closed := flag
		ensure
			closed_assigned: closed = flag
		end

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
			-- Is the point on (`x', `y') on this figure? i.e. is it
			-- on any of the lines of this polyline?
		local
			n: INTEGER
		do
		--	from
		--		n := 1
		--	until
		--		Result or else n > line_count
		--	loop
		--		Result := extract_line (n).position_on_figure (x, y)
		--		n := n + 1
		--	end
		end

feature -- Contract support

	list_has_correct_size (list: like points): BOOLEAN is
			-- Does `list' have the correct number of items?
			--| Any list has the correct number of points.
		do
			Result := True
		end

end -- class EV_FIGURE_POLYLINE

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/04/26 15:56:34  brendel
--| Added CVS Log.
--| Added copyright notice.
--| Improved description.
--| Added keywords.
--| Formatted for 80 columns.
--| Added make_for_test.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
