indexing
	description: "A figure that is a pixel or a dot."
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
			--| Kind of brute force right now, but we just want to get it to work, first.
		do
			Result := distance (x, y, point.x_abs, point.y_abs) < (line_width + 1) // 2
		end

feature {EV_PROJECTION} -- Implementation

	coordinates: EV_COORDINATES is
			-- get this dot's point in the form of EV_COORDINATES.
		do
			create Result.set (point.x_abs, point.y_abs)
		end

end -- class EV_FIGURE_DOT
