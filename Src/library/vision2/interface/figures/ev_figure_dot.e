indexing
	description:
		"A figure that is a pixel or a dot."
	status: "See notive at end of class"
	keywords: "figure, dot, point, pixel"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_DOT

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_point,
	make_for_test

feature -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor
		end

	make_with_point (pos: EV_RELATIVE_POINT) is
			-- Create with position `pos'.
		require
			pos_exists: pos /= Void
		do
			default_create
			set_point (pos)
		end

feature -- Access

	point_count: INTEGER is
			-- A dot consists of only one point.
		once
			Result := 1
		end

	point: EV_RELATIVE_POINT is
			-- The position of this pixel or dot.
		do
			Result := get_point_by_index (1)
		end

feature -- Status setting

	set_point (pos: EV_RELATIVE_POINT) is
			-- Change the reference of `point' with `pos'.
		require
			pos_exists: pos /= Void
		do
			set_point_by_index (1, pos)
		ensure
			point_assigned: point = pos
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
			--| Kind of brute force right now, but we just want to get it to
			--| work, first.
		do
			Result := distance (x, y, point.x_abs, point.y_abs) < (line_width
				+ 1) // 2
		end

feature {EV_PROJECTION} -- Implementation

	coordinates: EV_COORDINATES is
			-- get this dot's point in the form of EV_COORDINATES.
		do
			create Result.set (point.x_abs, point.y_abs)
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/04/27 19:10:50  brendel
--| Centralized testing code.
--|
--| Revision 1.6  2000/04/26 15:56:34  brendel
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
