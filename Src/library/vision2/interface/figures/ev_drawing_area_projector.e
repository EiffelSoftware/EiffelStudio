indexing
	description:
		"Projectors that make representations of `world' on%N%
		%EV_DRAWING_AREA."
	status: "See notice at end of class"
	keywords: "figures, project, pointer, drawing, points"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWING_AREA_PROJECTOR

inherit
	EV_WIDGET_PROJECTOR

create
	make,
	make_with_buffer

feature {NONE} -- Initialization

	make (a_world: EV_FIGURE_WORLD; a_drawing_area: EV_DRAWING_AREA) is
			-- Create with `a_world' and `a_drawing_area'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
		do
			make_with_drawable_widget (a_world, a_drawing_area, a_drawing_area)
			a_drawing_area.expose_actions.extend (~on_paint)
		end

	make_with_buffer (
		a_world: EV_FIGURE_WORLD;
		a_buffer: EV_PIXMAP;
		a_drawing_area: EV_DRAWING_AREA) is
			-- Create with `a_world', `a_drawing_area' and `a_buffer'.
		require
			a_world_not_void: a_world /= Void
			a_drawing_area_not_void: a_drawing_area /= Void
			a_buffer_not_void: a_buffer /= Void
		do
			make_with_drawable_widget_and_buffer (
				a_world,
				a_drawing_area,
				a_buffer,
				a_drawing_area)
			a_drawing_area.expose_actions.extend (~on_paint)
		end
		
feature {NONE} -- Implementation

	on_paint (x, y, w, h: INTEGER) is
		do
			if buffer_used then
				update_rectangle (create {EV_RECTANGLE}.make (x, y, w, h), x, y)
			else
				project_rectangle (create {EV_RECTANGLE}.make (x, y, w, h))
			end
		end

end -- class EV_DRAWING_AREA_PROJECTOR

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
