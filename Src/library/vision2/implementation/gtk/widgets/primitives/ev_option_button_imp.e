indexing
	description:
		"EiffelVision option button, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_OPTION_BUTTON_IMP

inherit
	EV_OPTION_BUTTON_I

	EV_MENU_HOLDER_IMP

	EV_BUTTON_IMP
		undefine
			set_center_alignment,
			set_left_alignment, 
			set_right_alignment,
			set_text,
			add_click_command			
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make is         
			-- Create a menu widget with `par' as parent.
			-- We can't use `widget_make' here, because a menu
			-- is not a child, otherwise, you couldn't put more
			-- than a menu in a window. A menu is an option of a
			-- window
		do
			widget := gtk_option_menu_new ()
			gtk_object_ref (widget)

			-- Creating the array containing the menu_items.
			create menu_items_array.make (0)
		end	

feature -- Status setting

	clear_selection is
		do
			gtk_option_menu_set_history (widget, 0)
		end

feature {NONE} -- Status report

	selected_item: EV_MENU_ITEM is
			-- Current selected item. The one we see on the
			-- option button.
		local
			selected_item_p: POINTER
			local_menu_item: EV_MENU_ITEM_IMP
			items_array: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			menu_item_found: BOOLEAN
		do
			selected_item_p := c_gtk_option_button_selected_menu_item (widget)
			from
				items_array := menu_items_array
				menu_item_found := False
				items_array.start
			until
				items_array.after or menu_item_found
			loop
				local_menu_item := items_array.item
				if local_menu_item.widget = selected_item_p then
					menu_item_found := True
				end
				items_array.forth
			end
			if menu_item_found then
				Result ?= local_menu_item.interface
			else
				Result := Void
			end
		end

feature {EV_MENU_ITEM_HOLDER} -- Element change	
	
	add_menu (menu_imp: EV_MENU_IMP) is
			-- Set menu for menu item
		local
			wid: POINTER
			a: ANY
		do
			-- Create a menu item with the label `text':
			-- This menu_item is not put in the menu_items_array.
			-- It is only used when the user want to have a title
			-- for the option button.
			if (menu_imp.text /= Void) then
				a := menu_imp.text.to_c
				wid := gtk_menu_item_new_with_label ($a)
				gtk_widget_show (wid)
				gtk_menu_append (menu_imp.widget, wid)
			end

			-- Add the menu to the option button.
			gtk_option_menu_set_menu (widget, menu_imp.widget)
		end
	
	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove menu from option button. 
		do
			gtk_option_menu_remove_menu (widget)
		end

end -- class EV_OPTION_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision : library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
