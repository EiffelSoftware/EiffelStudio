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
		undefine
			set_foreground_color
		end

	EV_BUTTON_IMP
		rename
			add_click_command as add_popup_command
		export {NONE}
			box,
			initialize,
			create_text_label,
			make_with_text
		undefine
			set_center_alignment,
			set_left_alignment, 
			set_right_alignment,
			set_text
		redefine
			make,
			add_popup_command,
			text,
			set_foreground_color			
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
			if (menu /= Void) then
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
					-- If we are here this means, the selected item
					-- is the menu.
					Result := Void
				end
			else
				-- there is no menu.
				Result := void
			end
		end

	text: STRING is
			-- Text shown on the option button if 
			-- an item has been selected.
		do
			if ( menu /= Void) then
				if (selected_item /= Void) then
					Result := selected_item.text
				else
					Result := menu.text
				end
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
			-- Create a menu item with the label set to `text' of `menu_imp':
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
			menu := menu_imp
		end
	
	remove_menu (menu_imp: EV_MENU_IMP) is
			-- Remove menu from option button. 
		do
			gtk_option_menu_remove_menu (widget)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'.
		do
			c_gtk_widget_set_fg_color (widget, color.red, color.green, color.blue)
		end

feature -- Event - command association

	add_popup_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- just before the popup is shown.
		do
			add_button_press_command (1, cmd, arg)
		end

feature -- Implementation

	menu: EV_MENU_IMP
		-- The menu contained in the option button.

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
