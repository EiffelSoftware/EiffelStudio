indexing
	description: "A figure that is a pixel or a dot."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_DOT

inherit
	EV_ATOMIC_FIGURE
		rename
			set_point as fig_set_point
		redefine
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor
		end

	make (pos: EV_RELATIVE_POINT) is
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
			Result := get_point (1)
		end

feature -- Status setting

	set_point (pos: EV_RELATIVE_POINT) is
			-- Change the reference of `point' with `pos'.
		require
			pos_exists: pos /= Void
		do
			fig_set_point (1, pos)
		ensure
			point_assigned: point = pos
		end

feature {EV_PROJECTION} -- Implementation

	coordinates: EV_COORDINATES is
			-- get this dot's point in the form of EV_COORDINATES.
		do
			create Result.set (point.x_abs, point.y_abs)
		end

end -- class EV_FIGURE_DOT
