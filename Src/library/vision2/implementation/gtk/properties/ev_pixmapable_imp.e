indexing

	description: 
		"EiffelVision pixmap container, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_PIXMAP_CONTAINER_IMP
	
inherit
	
	EV_PIXMAP_CONTAINER_I

	EV_CONTAINER_IMP
		redefine
			add_child
		end
	
feature -- Access

	box: POINTER is
			-- The box that will receive the pixmaps
		deferred
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
			add_child (pixmap_imp)
			--gtk_box_pack_start (GTK_BOX(box), pixmap_imp.widget, True, False, 0)
		 	gtk_widget_show (pixmap_imp.widget)
			gtk_box_pack_start (GTK_BOX(box), pixmap_imp.widget, False, False, 2)
		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite.
			-- We just set the child for the postconditions.
		do
			child := child_imp
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

end -- EV_PIXMAP_CONTAINER_IMP

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
