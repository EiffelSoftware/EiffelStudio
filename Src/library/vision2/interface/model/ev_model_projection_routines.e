note
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

	register_figure (a_figure: EV_MODEL; a_routine: PROCEDURE [EV_MODEL])
			-- Assign `a_routine' for drawing of `a_figure'.
		obsolete
			"Redefine `project' from your EV_MODEL descendant to perform the projection. [2017-05-31]"
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

	project
			-- Make standard projection of world on device.
		deferred
		end

feature {NONE} -- Implementation

	project_figure_group (group: EV_MODEL_GROUP; r: EV_RECTANGLE)
			-- Draw all figures in `group' inside `r' to device.
		require
			r_not_void: r /= Void
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
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
					project_figure_in_rect (draw_item, r)
				end
				i := i + 1
			end
		end

	project_figure_group_full (group: EV_MODEL_GROUP)
			-- Draw all figures in `group'.
		require
			group_not_void: group /= Void
			group_show_requested: group.is_show_requested
		local
			draw_item: EV_MODEL
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
					project_figure_full (draw_item)
				end
				i := i + 1
			end
		end

	project_figure_in_rect (f: EV_MODEL; rect: EV_RECTANGLE)
			-- Project `f' to device if `rect' intersects with `f'.
		require
			rect_not_void: rect /= Void
			f_not_void: f /= Void
		local
			bbox: detachable EV_RECTANGLE
		do
			if f.valid or else f.last_update_rectangle = Void or else (attached f.last_update_rectangle as l_rect and then not l_rect.has_area) then
				bbox := f.bounding_box
			else
				bbox := f.last_update_rectangle
			end
			check bbox /= Void then end
			if bbox.has_area and then bbox.intersects (rect) then
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
				project_figure_full (f)
				rect.merge (bbox)
			end
		end

	project_figure_full (f: EV_MODEL)
			-- Project `f' to device.
			-- (See `project_figure')
		require
			f_not_void: f /= Void
			f_show_requested: f.is_show_requested
		local
			l_tuple: TUPLE [model: EV_MODEL]
		do
				-- If figures are registered via `register_figure' we proceed the old fashion way.
			if draw_routines.valid_index (f.draw_id) and then attached draw_routines.item (f.draw_id) as l_draw_routine then
				l_tuple := [f]
				if l_draw_routine.valid_operands (l_tuple) then
					l_draw_routine.flexible_call (l_tuple)
				end
			else
					-- New way of projecting via double-dispatch.
				f.project (Current)
			end
		end

feature {NONE} -- Implementation

	draw_routines: ARRAY [detachable PROCEDURE [EV_MODEL]]
			-- Routine registration.

	register_basic_figures
			-- Register EiffelVision figures.
		obsolete
			"Not needed anymore. Basic figures are now handled via {EV_MODEL}.project. [2017-05-31]"
		do
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
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_MODEL_PROJECTION_ROUTINES





