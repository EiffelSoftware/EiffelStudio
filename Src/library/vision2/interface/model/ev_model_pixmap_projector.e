indexing
	description:
		"Projectors that make representations of `world' on EV_PIXMAP."
	status: "See notice at end of class"
	keywords: "figures, project, pointer, drawing, points"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_PIXMAP_PROJECTOR

inherit
	EV_MODEL_WIDGET_PROJECTOR
		redefine
			widget,
			project_rectangle
		end

create
	make,
	make_with_buffer

feature {NONE} -- Initialization

	make (a_world: EV_MODEL_WORLD; a_pixmap: EV_PIXMAP) is
			-- Create with `a_world' and `a_pixmap'.
		require
			a_world_not_void: a_world /= Void
			a_pixmap_not_void: a_pixmap /= Void
		do
			make_with_drawable_widget (a_world, a_pixmap, a_pixmap)
		end

	make_with_buffer (
		a_world: EV_MODEL_WORLD;
		a_buffer, a_pixmap: EV_PIXMAP) is
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

	project_rectangle (u: EV_RECTANGLE) is
			-- Project area under `u' and flush pixmap.
		do
			Precursor (u)
			widget.flush
		end

end -- class EV_MODEL_PIXMAP_PROJECTOR

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

