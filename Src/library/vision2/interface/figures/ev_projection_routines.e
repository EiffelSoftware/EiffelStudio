indexing
	description:
		"Abstract class for figure projection routines."
	status: "See notice at end of class"
	keywords: "projector, events, routines"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROJECTION_ROUTINES

inherit
	EV_FIGURE_DRAWING_ROUTINES

feature -- Basic operations

	register_figure (a_figure: EV_FIGURE;
		a_routine: PROCEDURE [ANY, TUPLE [EV_FIGURE]]) is
			-- Assign `a_routine' for drawing of `a_figure'.
		do
			draw_routines.force (a_routine, a_figure.draw_id)
		end

	is_projecting: BOOLEAN
			-- Is a project currently being performed?
			-- Then, do not start a new one.

	project is
			-- Make standard projection of world on device.
		deferred
		end

feature {NONE} -- Implementation

	project_figure_group (group: EV_FIGURE_GROUP; r: EV_RECTANGLE) is
			-- Draw all figures in `group' inside `r' to device.
		require
			r_not_void: r /= Void
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		do
			from
				group.start
			until
				group.after
			loop
				project_figure (group.item, r)
				group.forth
			end
		end

	project_figure (f: EV_FIGURE; rect: EV_RECTANGLE) is
			-- Project `f' to device if within `r'.
		require
			rect_not_void: rect /= Void
			f_not_void: f /= Void
		local
			g: EV_FIGURE_GROUP
			r: PROCEDURE [ANY, TUPLE [EV_FIGURE]]
		do
			if f.is_show_requested then
				if draw_routines.valid_index (f.draw_id) then
					r := draw_routines.item (f.draw_id)
				end
				if r /= Void then
					if f.intersects (rect) then
						r.call ([f])
					end
				else
					g ?= f
					if g /= Void then
						project_figure_group (g, rect)
					else
						io.put_string (generating_type +
							": no drawing routine for " +
							f.generating_type + "%N"
						)
					end
				end
			end
		end

feature {NONE} -- Implementation

	draw_routines: ARRAY [PROCEDURE [ANY, TUPLE [EV_FIGURE]]]
			-- Routine registration.

	register_basic_figures is
			-- Register EiffelVision figures.
		do
			register_figure (create {EV_FIGURE_ARC}, ~draw_figure_arc)
			register_figure (create {EV_FIGURE_DOT}, ~draw_figure_dot)
			register_figure (create {EV_FIGURE_ELLIPSE}, ~draw_figure_ellipse)
			register_figure (create {EV_FIGURE_EQUILATERAL},
				~draw_figure_equilateral)
			register_figure (create {EV_FIGURE_LINE}, ~draw_figure_line)
			register_figure (create {EV_FIGURE_PICTURE}, ~draw_figure_picture)
			register_figure (create {EV_FIGURE_PIE_SLICE},
				~draw_figure_pie_slice)
			register_figure (create {EV_FIGURE_POLYGON}, ~draw_figure_polygon)
			register_figure (create {EV_FIGURE_POLYLINE}, ~draw_figure_polyline)
			register_figure (create {EV_FIGURE_RECTANGLE},
				~draw_figure_rectangle)
			register_figure (create {EV_FIGURE_ROUNDED_RECTANGLE},
				~draw_figure_rounded_rectangle)
			register_figure (create {EV_FIGURE_STAR}, ~draw_figure_star)
			register_figure (create {EV_FIGURE_TEXT}, ~draw_figure_text)
		end

	Default_colors: EV_STOCK_COLORS is
			-- Once access to `EV_STOCK_COLORS'.
		once
			create Result
		end

	Default_pixmaps: EV_STOCK_PIXMAPS is
			-- Once access to `EV_STOCK_PIXMAPS'.
		once
			create Result
		end

end -- class EV_PROJECTION_ROUTINES

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

