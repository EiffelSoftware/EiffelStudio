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

	EV_PIXMAP_CONTAINER_IMP
		rename
			box as widget
		redefine
			add_pixmap
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty drawing area.
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				parent_ok: par_imp /= Void
			end
			parent_imp := par_imp
			widget := c_gtk_pixmap_create_empty (parent_imp.widget)
		end

feature {EV_CONTAINER} -- Element change

	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pixmap.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end
			gtk_widget_set_parent (pixmap_imp.widget, parent_imp.widget)
			widget := pixmap_imp.widget
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
