indexing

	description: 
		"EiffelVision menu item, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_MENU_ITEM_IMP
	
inherit
	
	EV_MENU_ITEM_I

	EV_ITEM_IMP
		undefine
			set_label_widget,
			label_widget
		end

	EV_PIXMAP_CONTAINER_IMP
		rename
			make as old_make,
			interface as widget_interface,
			set_interface as set_widget_interface
		undefine
			pixmap_size_ok
		redefine
			add_pixmap
		end
	
creation
	make_with_text

feature {NONE} -- Initialization
	
	make_with_text (par: EV_MENU_ITEM_CONTAINER; txt: STRING) is
			-- Create menu item
		do
			widget := gtk_menu_item_new
			initialize
			create_text_label (txt)
			gtk_misc_set_alignment (label_widget, 0.0, 0.5)
			gtk_misc_set_padding (label_widget, 21, 0)
			show
		end		

	initialize is
			-- Common initialization for buttons
		do
			box := gtk_hbox_new (False, 5)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end

feature {NONE} -- Implementation

	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pixmap.implementation
			check
				imp_not_void: pixmap_imp /= Void
			end
			add_child (pixmap_imp)
			gtk_misc_set_padding (label_widget, 0, 0)
			gtk_box_pack_start (GTK_BOX(box), pixmap_imp.widget, False, False, 0)
			child.show
		end

end -- class EV_MENU_ITEM_IMP

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
