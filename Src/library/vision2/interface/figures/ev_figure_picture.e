indexing
	description: "EiffelVision2 pixmap figure. A pixmap is defined by one point, its%
		% top-left corner, and by a pixmap and font attribute."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_PICTURE

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_point,
	make_with_point_and_pixmap

feature -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor
			create pixmap
		end

	make_with_point (p: EV_RELATIVE_POINT) is
			-- Create on `p'.
		require
			p_exists: p /= Void
			p_not_in_figure: p.figure = Void
		do
			default_create
			set_point (p)
		end

	make_with_point_and_pixmap (p: EV_RELATIVE_POINT; a_pixmap: EV_PIXMAP) is
			-- Create with `a_pixmap' on `p'.
		require
			p_exists: p /= Void
			p_not_in_figure: p.figure = Void
		do
			default_create
			set_point (p)
			set_pixmap (a_pixmap)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- The pixmap that is displayed.

	point_count: INTEGER is
			-- A pixmap-figure consists of only one point.
		once
			Result := 1
		end

	point: EV_RELATIVE_POINT is
			-- The position of this picture.
		do
			Result := get_point_by_index (1)
		end

feature -- Status report

	width: INTEGER is
			-- The width of the pixmap.
		do
			Result := pixmap.width
		ensure
			assigned: Result = pixmap.width
		end

	height: INTEGER is
			-- The height of the pixmap.
		do
			Result := pixmap.height
		ensure
			assigned: Result = pixmap.height
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

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the pixmap to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			pixmap_assigned: pixmap = a_pixmap
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| FIXME Rotation and scaling!
			Result := point_on_rectangle (x, y, point.x_abs, point.y_abs,
				point.x_abs + width, point.y_abs + height)
		end

invariant
	pixmap_exists: pixmap /= Void

end -- class EV_FIGURE_PICTURE
