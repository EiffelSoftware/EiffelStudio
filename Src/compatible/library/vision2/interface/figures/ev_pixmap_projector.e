note
	description:
		"Projectors that make representations of `world' on EV_PIXMAP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, project, pointer, drawing, points"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_PROJECTOR

inherit
	EV_WIDGET_PROJECTOR
		redefine
			widget,
			project_rectangle
		end

create
	make,
	make_with_buffer

feature {NONE} -- Initialization

	make (a_world: EV_FIGURE_WORLD; a_pixmap: EV_PIXMAP)
			-- Create with `a_world' and `a_pixmap'.
		require
			a_world_not_void: a_world /= Void
			a_pixmap_not_void: a_pixmap /= Void
		do
			make_with_drawable_widget (a_world, a_pixmap, a_pixmap)
		end

	make_with_buffer (
		a_world: EV_FIGURE_WORLD;
		a_buffer, a_pixmap: EV_PIXMAP)
			-- Create with `a_world', `a_pixmap' and `a_buffer'.
		require
			a_world_not_void: a_world /= Void
			a_pixmap_not_void: a_pixmap /= Void
			a_buffer_not_void: a_buffer /= Void
		do
			make_with_drawable_widget_and_buffer (
				a_world,
				a_pixmap,
				a_buffer,
				a_pixmap)
		end
		
feature {NONE} -- Implementation

	widget: EV_PIXMAP
			-- Drawable widget to draw to.

	project_rectangle (u: EV_RECTANGLE)
			-- Project area under `u' and flush pixmap.
		do
			Precursor {EV_WIDGET_PROJECTOR} (u)
			widget.flush
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




end -- class EV_PIXMAP_PROJECTOR

