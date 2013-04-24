note
	description:
		"Abstract class for figure projection routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "projector, events, routines"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROJECTION_ROUTINES

inherit
	EV_FIGURE_DRAWING_ROUTINES

feature -- Basic operations

	register_figure (a_figure: EV_FIGURE; a_routine: PROCEDURE [ANY, TUPLE [EV_FIGURE]])
			-- Assign `a_routine' for drawing of `a_figure'.
		do
			draw_routines.force (a_routine, a_figure.draw_id)
		end

	is_projecting: BOOLEAN
			-- Is a project currently being performed?
			-- Then, do not start a new one.

	project
			-- Make standard projection of world on device.
		deferred
		end

feature {NONE} -- Implementation

	project_figure_group (group: EV_FIGURE_GROUP; r: EV_RECTANGLE)
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

	project_figure (f: EV_FIGURE; rect: EV_RECTANGLE)
			-- Project `f' to device if within `r'.
		require
			rect_not_void: rect /= Void
			f_not_void: f /= Void
		local
			g: detachable EV_FIGURE_GROUP
			r: detachable PROCEDURE [ANY, TUPLE [EV_FIGURE]]
			t: TUPLE [EV_FIGURE]
		do
			if f.is_show_requested then
				if draw_routines.valid_index (f.draw_id) then
					r := draw_routines.item (f.draw_id)
				end
				if r /= Void then
					if f.intersects (rect) then
						t := r.empty_operands
						check
							t.valid_index (1)
							t.valid_type_for_index (f, 1)
						end
						t.put (f, 1)
						r.call (t)
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

	draw_routines: ARRAY [detachable PROCEDURE [ANY, TUPLE [EV_FIGURE]]]
			-- Routine registration.

	register_basic_figures
			-- Register EiffelVision figures.
		do
			register_figure (create {EV_FIGURE_ARC}, agent draw_figure_arc)
			register_figure (create {EV_FIGURE_DOT}, agent draw_figure_dot)
			register_figure (create {EV_FIGURE_ELLIPSE}, agent draw_figure_ellipse)
			register_figure (create {EV_FIGURE_EQUILATERAL},
				agent draw_figure_equilateral)
			register_figure (create {EV_FIGURE_LINE}, agent draw_figure_line)
			register_figure (create {EV_FIGURE_PICTURE}, agent draw_figure_picture)
			register_figure (create {EV_FIGURE_PIE_SLICE},
				agent draw_figure_pie_slice)
			register_figure (create {EV_FIGURE_POLYGON}, agent draw_figure_polygon)
			register_figure (create {EV_FIGURE_POLYLINE}, agent draw_figure_polyline)
			register_figure (create {EV_FIGURE_RECTANGLE},
				agent draw_figure_rectangle)
			register_figure (create {EV_FIGURE_ROUNDED_RECTANGLE},
				agent draw_figure_rounded_rectangle)
			register_figure (create {EV_FIGURE_STAR}, agent draw_figure_star)
			register_figure (create {EV_FIGURE_TEXT}, agent draw_figure_text)
		end

	Default_colors: EV_STOCK_COLORS
			-- Once access to `EV_STOCK_COLORS'.
		once
			create Result
		end

	Default_pixmaps: EV_STOCK_PIXMAPS
			-- Once access to `EV_STOCK_PIXMAPS'.
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PROJECTION_ROUTINES





