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
	
feature -- Access

	box: POINTER is
			-- The box that will receive the pixmaps
		deferred
		end

	pixmap: EV_PIXMAP is
			-- Implementation of the pixmap contained 
		do
		end

	
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
			add_child (pixmap_imp)
		 	gtk_widget_show (pixmap_imp.widget)
			gtk_box_pack_start (GTK_BOX(box), pixmap_imp.widget, False, False, 2)
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		do
		end

feature {NONE} -- Implementation
		-- We defined this here because the label must be added
		-- by EV in case we want to add a pixmap.

	set_label_widget (new_label_widget: POINTER) is
		do
			label_widget := new_label_widget
		end        
	
        label_widget: POINTER 
                        -- gtk widget of the label inside the button

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
