indexing
	description: "EiffelVision drawing area. Gtk implementation."
	note: "`box' is an unusefull attribute here, then, we merge%
		% it with widget."
	note2:"We use the gtk Pixmap and not the gtk drawing area, because%
		%gtk drawing area are used to draw on the screen and we%
		%only want to draw in a widget."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I

	EV_DRAWABLE_IMP

	EV_PRIMITIVE_IMP
		undefine
			background_color,
			foreground_color,
			set_background_color,
			set_foreground_color,
			set_default_options
		end

	EV_PIXMAPABLE_IMP
		rename
			box as widget
		undefine
			background_color,
			foreground_color,
			set_background_color,
			set_foreground_color,
			set_default_options,
			pixmap_drawable_ok
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty drawing area.
		local
			par_imp: EV_CONTAINER_IMP
		do
--			par_imp ?= par.implementation
--			check
--				parent_ok: par_imp /= Void
--			end
--			parent_imp := par_imp
--			widget := c_gtk_pixmap_create_empty (parent_imp.widget)
		end

feature {EV_CONTAINER} -- Element change

	add_pixmap (pix: EV_PIXMAP) is
			-- Add a pixmap in the container
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pix.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end
			gtk_widget_set_parent (pixmap_imp.widget, parent_imp.widget)
			widget := pixmap_imp.widget
		end

feature -- Event - command association

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of action to be executed when
			-- current area is resized.
			-- `arg' will be passed to `cmd' whenever it is
			-- invoked as a callback.
		do
		end

	add_paint_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget has to be redrawn.
		do
		end

feature -- Event - command removal

	remove_resize_commands is
			-- Remove the list of commands to be executed when
			-- current area is resized.
		do
		end

	remove_paint_commands is
			-- Empty the list of commands to be executed when
			-- the widget has to be redrawn.
		do
		end

end -- class EV_DRAWING_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
