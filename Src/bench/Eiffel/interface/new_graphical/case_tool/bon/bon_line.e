indexing
	description: "Figure that is a line segment used by diagram links,%N%
				%aggregate or not"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_LINE

inherit
	EV_FIGURE_LINE
		redefine
			update_arrows,
			bounding_box
		end

create
	default_create,
	make_with_points,
	make_with_positions

feature -- Access

	is_cut_figure: BOOLEAN is
			-- Is `Current' cut by a segment?
		do
			Result := cut_figure /= Void
		end

	cut_figure_point: EV_RELATIVE_POINT
			-- Origin of `cut_figure'.

	midpoint: LINK_MIDPOINT
			-- Midpoint located in `point_b'.

feature -- Status setting

	enable_cut_figure is
			-- Set `is_cut' `True'.
		do
			if cut_figure = Void then
				build_cut_figure
			end
		end

	disable_cut_figure is
			-- Set `is_cut_figure' `False'.
		do
			cut_figure := Void
		end

feature {LINK_MIDPOINT} -- Status setting

	set_midpoint (mp: LINK_MIDPOINT) is
			-- Assign `mp' to `midpoint'.
		require
			mp_not_void: mp /= Void
		do
			midpoint := mp
		ensure
			mp_assigned: midpoint = mp
		end

feature {EV_FIGURE_DRAWER, EV_FIGURE} -- Implementation

	cut_figure: EV_FIGURE_POLYGON
			-- Segment cutting `Current' near `point_b'.

	cut_figure_point_a, cut_figure_point_b: EV_RELATIVE_POINT
			-- Ends of `cut_figure'.

	update_arrows is
			-- Call after `line_width' changed.
		local
			s: INTEGER
		do
			Precursor
			s := Arrow_size + line_width
			if cut_figure /= Void then
					--| FIXME remove magic numbers.
				cut_figure_point_a.set_position (20, -s // 2)
				cut_figure_point_b.set_position (20, s // 2)
			end
		end

	build_cut_figure is
			-- Create `cut_figure'.
		do
			create cut_figure
			create cut_figure_point
			cut_figure.set_point_count (2)
			cut_figure_point.set_origin (point_b)
			cut_figure_point_a := cut_figure.i_th_point (1)
			cut_figure_point_b := cut_figure.i_th_point (2)
			cut_figure_point_b.set_origin (cut_figure_point)
			cut_figure_point_a.set_origin (cut_figure_point)
			update_arrows
		end

feature {NONE} -- Implementation

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		local
			p: EV_RELATIVE_POINT
		do
			Result := Precursor
			if is_cut_figure then
				p := cut_figure_point_a
				Result.include (p.x_abs, p.y_abs)
				p := cut_figure_point_b
				Result.include (p.x_abs, p.y_abs)
			end
			if midpoint /= Void then
				Result.merge (midpoint.bounding_box)
			end
		end

end -- class BON_LINE
