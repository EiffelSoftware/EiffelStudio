indexing

	description: 
		"EiffelVision pixmap container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_PIXMAPABLE_IMP
	
inherit
	
	EV_PIXMAPABLE_I

	EV_CONTAINER_IMP
		redefine
			set_foreground_color
		end
	
feature -- Initialization

	create_pixmap_place is
			-- prepare the place for the pixmap in the `box'.
			-- For that, we add a pixmap with a default gdk pixmap
			-- in the `box'.
		require
			pixmap_widget_null: pixmap_widget_is_default_pointer
			box_already_created: box /= default_pointer
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			-- create the pixmap with a default xpm.
			pixmap_widget := c_gtk_pixmap_create_empty (box)

			-- Set the pixmap in the `box'.
			gtk_box_pack_start (GTK_BOX (box), pixmap_widget, False, False, 0)

			-- show the pixmap now that it has a parent.
			gtk_widget_show (pixmap_widget)
		end			
		

feature -- Access

	box: POINTER is
			-- The box that will receive the pixmaps
		deferred
		end

	pixmap: EV_PIXMAP
			-- Implementation of the pixmap contained 

	
feature {EV_CONTAINER} -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Add a pixmap in the container
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pix.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end

			-- Was there a pixmap in the `box'?
			if (pixmap = Void) then
				-- No pixmap in the `box', so create the place
				-- for it.
				create_pixmap_place
			end

			-- We replace the former gdk_pixmap of the gtk_pixmap (in pixmap_widget)
			-- by the new one (in pix_widget).
			c_gtk_pixmap_set_from_pixmap (pixmap_widget, pixmap_imp.widget) 

			-- updating status
			pixmap := pix
		end

	unset_pixmap is
			-- Remove the pixmap location from the `box'.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pixmap.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end

			-- Remove the pixmap_widget from the box. The gtk object
			-- `pixmap_widget' will be detroyed.
			gtk_container_remove (GTK_CONTAINER (box), pixmap_widget)

			-- updating status
			pixmap := Void
			set_pixmap_widget (default_pointer)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'.
			-- Redefined because the text is in a gtk_label.
		do
			c_gtk_widget_set_fg_color (widget, color.red, color.green, color.blue)
			c_gtk_widget_set_fg_color (label_widget, color.red, color.green, color.blue)
		end

feature -- Implementation

	pixmap_widget_is_default_pointer: BOOLEAN is
			-- Is `pixmap_widget' a default_pointer
		do
			Result := (pixmap_widget = default_pointer)
		end
	
feature {NONE} -- Implementation
		-- We defined this here because the label must be added
		-- by EV in case we want to add a pixmap.

	set_label_widget (new_label_widget: POINTER) is
			-- Sets `label_widget' to `new_label_widget'.
		do
			label_widget := new_label_widget
		end        
	
        label_widget: POINTER 
                        -- gtk widget of the label inside the `box'.

	set_pixmap_widget (new_pixmap_widget: POINTER) is
			-- Sets `pixmap_widget' to `new_pixmap_widget'.
		do
			pixmap_widget := new_pixmap_widget
		end        

	pixmap_widget: POINTER 
			-- gtk widget of the pixmap inside the `box'.

end -- EV_PIXMAPABLE_IMP

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
