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
		redefine
			add_activate_command
		end

	EV_MENU_ITEM_CONTAINER_IMP
		rename
			make as old_make,
			interface as widget_interface,
			set_interface as set_widget_interface
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
			show
			initialize
			create_text_label (txt)
			gtk_misc_set_alignment (label_widget, 0.0, 0.5)
			gtk_misc_set_padding (label_widget, 21, 0)
		end		

	initialize is
			-- Common initialization for buttons
		do
			box := gtk_hbox_new (False, 5)
			gtk_widget_show (box)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end

feature -- Event : command association

	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command ("activate", command, arguments)
		end

feature {NONE} -- Implementation

	add_item (item: EV_MENU_ITEM) is
			-- Add an item to the current item. The current
			-- item become then a sub-menu
		local
			item_imp: EV_MENU_ITEM_IMP
			submenu: POINTER
		do
			item_imp ?= item.implementation
			check
				correct_imp: item_imp /= void
			end
			if C_GTK_MENU_ITEM_SUBMENU(widget) = default_pointer then
				submenu := gtk_menu_new () 
				gtk_menu_item_set_submenu (GTK_MENU_ITEM (widget), submenu)
			end
			gtk_menu_append (C_GTK_MENU_ITEM_SUBMENU(widget), item_imp.widget)
		end		

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
