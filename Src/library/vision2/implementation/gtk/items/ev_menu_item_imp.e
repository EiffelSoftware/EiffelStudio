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
			pixmap_size_ok
		redefine
			make,
			make_with_text,
			add_activate_command,
			set_pixmap
		end

	EV_MENU_ITEM_HOLDER_IMP
		rename
			parent_imp as widget_parent_imp,
			parent_set as widget_parent_set
		undefine
			has_parent
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an item with an empty name.
		do
			widget := gtk_menu_item_new
			initialize
			create_text_label ("")
			gtk_misc_set_alignment (label_widget, 0.0, 0.5)
			gtk_misc_set_padding (label_widget, 21, 0)
		end
	
	make_with_text (txt: STRING) is
			-- Create an item with `txt' as label.
		do
			widget := gtk_menu_item_new
			initialize
			create_text_label (txt)
			gtk_misc_set_alignment (label_widget, 0.0, 0.5)
			gtk_misc_set_padding (label_widget, 21, 0)
		end

	initialize is
			-- Common initialization for buttons
		do
			gtk_object_ref (widget)
			box := gtk_hbox_new (False, 5)
			gtk_widget_show (box)
			gtk_container_add (GTK_CONTAINER (widget), box)
		end

feature -- Status setting

	set_selected is
   			-- Set current item as the selected one.
			-- We use this function only when the parent
			-- of the parent (the menu) is an option button.
		local
			pos: INTEGER
   		do
			pos := c_gtk_option_button_index_of_menu_item (parent_imp.parent_imp.widget, widget)
			gtk_option_menu_set_history (parent_imp.parent_imp.widget, pos)
   		end

feature -- Element change

	set_parent (par: EV_MENU_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_MENU_ITEM_HOLDER_IMP
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp := par_imp
				par_imp.add_item (Current)
				show
				gtk_object_unref (widget)
			end
		end

feature -- Assertion

	grand_parent_is_option_button: BOOLEAN is
			-- Is true if the grand parent is an option button.
			-- False otherwise.
		local
			gd_par: EV_OPTION_BUTTON
		do
			gd_par ?= parent_imp.parent_imp.interface
			Result := (gd_par /= Void)
		end

	is_selected: BOOLEAN is
			-- True if the current item is selected.
			-- False otherwise.
			-- Works only when the parent is an option button.
		local
			selected_item_p: POINTER
		do
			-- Pointer to the menu_item which is currently selected:
			selected_item_p := c_gtk_option_button_selected_menu_item (parent_imp.parent_imp.widget)
			if widget = selected_item_p then
				Result := True
			else
				Result := False
			end
		end

feature -- Event : command association

	add_activate_command ( command: EV_COMMAND; 
			       arguments: EV_ARGUMENT) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
			-- The toggle event doesn't work on gtk, then
			-- we add both event command.
		do
			add_command (widget, "activate", command, arguments)
		end

feature {NONE} -- Implementation

	add_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Add an item to the current item. The current
			-- item become then a sub-menu
		local
			submenu: POINTER
		do
			if C_GTK_MENU_ITEM_SUBMENU(widget) = default_pointer then
				submenu := gtk_menu_new () 
				gtk_menu_item_set_submenu (GTK_MENU_ITEM (widget), submenu)
			end
			gtk_menu_append (C_GTK_MENU_ITEM_SUBMENU(widget), item_imp.widget)
		end		

	remove_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		do
			gtk_container_remove (GTK_CONTAINER (C_GTK_MENU_ITEM_SUBMENU(widget)), item_imp.widget)
		end

	set_pixmap (pix: EV_PIXMAP) is
			-- Add a pixmap in the container
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pix.implementation
			check
				imp_not_void: pixmap_imp /= Void
			end
			add_child (pixmap_imp)
			gtk_misc_set_padding (label_widget, 0, 0)
			gtk_box_pack_start (GTK_BOX(box), pixmap_imp.widget, False, False, 0)
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
