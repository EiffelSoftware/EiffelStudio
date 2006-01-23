indexing
	description:
		"Abstract class for figure projection routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "projector, events, routines"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_PROJECTION_ROUTINES

inherit
	EV_MODEL_DRAWING_ROUTINES

feature -- Basic operations

	register_figure (a_figure: EV_MODEL;
		a_routine: PROCEDURE [ANY, TUPLE [EV_MODEL]]) is
			-- Assign `a_routine' for drawing of `a_figure'.
		require
			a_figure_exists: a_figure /= Void
			a_routine_exists: a_routine /= Void
		do
			draw_routines.force (a_routine, a_figure.draw_id)
		ensure
			draw_routines.item (a_figure.draw_id) = a_routine
		end

	is_projecting: BOOLEAN
			-- Is a project currently being performed?
			-- Then, do not start a new one.

	project is
			-- Make standard projection of world on device.
		deferred
		end

feature {NONE} -- Implementation

	project_figure_group (group: EV_MODEL_GROUP; r: EV_RECTANGLE) is
			-- Draw all figures in `group' inside `r' to device.
		require
			r_not_void: r /= Void
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
			g: EV_MODEL_GROUP
			dr: PROCEDURE [ANY, TUPLE [EV_MODEL]]
			i, nb: INTEGER
		do
			from
				i := 1
				nb := group.count
			until
				i > nb
			loop
				draw_item := group.i_th (i)
				if draw_item.is_show_requested then
					g ?= draw_item
					if draw_routines.valid_index (draw_item.draw_id) then
						dr := draw_routines.item (draw_item.draw_id)
					else
						dr := Void
					end
					if g /= Void and then dr = Void then
						project_figure_group (g, r)
					else	
						project_figure (draw_item, r)
					end
				end
				i := i + 1
			end
		end

	project_figure (f: EV_MODEL; rect: EV_RECTANGLE) is
			-- Project `f' to device if `rect' intersects with `f'.
			-- If you get a precondition violidation here you most
			-- likely made a class that does inherit from EV_FIGURE
			-- but not from EV_FIGURE_GROUP without register a drawer
			-- for that class. Use `register_figure' to register a
			-- drawer.
		require
			rect_not_void: rect /= Void
			f_not_void: f /= Void
			in_draw_routines: draw_routines.valid_index (f.draw_id)
			draw_routines_has: draw_routines.item (f.draw_id) /= Void
			f_show_requested: f.is_show_requested
		local
			bbox: EV_RECTANGLE
		do
			if f.valid or else f.last_update_rectangle = Void then
				bbox := f.bounding_box
			else
				bbox := f.last_update_rectangle
			end
			if bbox.intersects (rect) then
				draw_routines.item (f.draw_id).call ([f])
				-- If we paint f we have to add it
				-- to the invalidate rectangle. That way
				-- all figures on top of f are
				-- drawn if they intersect with f.
				--	This holds because:
				--		1. If other figure is on top of f
				--			it is not yet processed (see project_figure_group).
				--		2. If other figure intersects with f
				--			it will be drawn since bounding_box of
				--			f is now element of rect.
				rect.merge (bbox)
			end
		end
		
	project_figure_group_full (group: EV_MODEL_GROUP) is
			-- Draw all figures in `group'.
		require
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
			g: EV_MODEL_GROUP
			i, nb: INTEGER
			dr: PROCEDURE [ANY, TUPLE [EV_MODEL]]
		do
			from
				i := 1
				nb := group.count
			until
				i > nb
			loop
				draw_item := group.i_th (i)
				if draw_item.is_show_requested then
					g ?= draw_item
					if draw_routines.valid_index (draw_item.draw_id) then
						dr := draw_routines.item (draw_item.draw_id)
					else
						dr := Void
					end
					if g /= Void and then dr = Void then
						project_figure_group_full (g)
					else	
						project_figure_full (draw_item)
					end
				end
				i := i + 1
			end
		end

	project_figure_full (f: EV_MODEL) is
			-- Project `f' to device.
			-- (See `project_figure')
		require
			f_not_void: f /= Void
			in_draw_routines: draw_routines.valid_index (f.draw_id)
			draw_routines_has: draw_routines.item (f.draw_id) /= Void
			f_show_requested: f.is_show_requested
		do
			draw_routines.item (f.draw_id).call ([f])
		end

feature {NONE} -- Implementation

	draw_routines: ARRAY [PROCEDURE [ANY, TUPLE [EV_MODEL]]]
			-- Routine registration.

	register_basic_figures is
			-- Register EiffelVision figures.
		do
			register_figure (create {EV_MODEL_ARC}, agent draw_figure_arc)
			register_figure (create {EV_MODEL_DOT}, agent draw_figure_dot)
			register_figure (create {EV_MODEL_ELLIPSE}, agent draw_figure_ellipse)
			register_figure (create {EV_MODEL_EQUILATERAL},
				agent draw_figure_equilateral)
			register_figure (create {EV_MODEL_LINE}, agent draw_figure_line)
			register_figure (create {EV_MODEL_PICTURE}, agent draw_figure_picture)
			register_figure (create {EV_MODEL_PIE_SLICE},
				agent draw_figure_pie_slice)
			register_figure (create {EV_MODEL_POLYGON}, agent draw_figure_polygon)
			register_figure (create {EV_MODEL_POLYLINE}, agent draw_figure_polyline)
			register_figure (create {EV_MODEL_PARALLELOGRAM}, agent draw_figure_parallelogram )
			register_figure (create {EV_MODEL_RECTANGLE}, agent draw_figure_rectangle )
			register_figure (create {EV_MODEL_ROUNDED_RECTANGLE},
				agent draw_figure_rounded_rectangle)
			register_figure (create {EV_MODEL_ROUNDED_PARALLELOGRAM},
				agent draw_figure_rounded_parallelogram)
			register_figure (create {EV_MODEL_STAR}, agent draw_figure_star)
			register_figure (create {EV_MODEL_TEXT}, agent draw_figure_text)
			register_figure (create {EV_MODEL_ROTATED_ELLIPSE}, agent draw_figure_rotated_ellipse)
			register_figure (create {EV_MODEL_ROTATED_ARC}, agent draw_figure_rotated_arc)
			register_figure (create {EV_MODEL_ROTATED_PIE_SLICE}, agent draw_figure_rotated_pie_slice)
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




end -- class EV_MODEL_PROJECTION_ROUTINES

