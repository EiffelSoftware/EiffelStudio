--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision option button, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_OPTION_BUTTON_IMP

inherit
	EV_OPTION_BUTTON_I
		redefine
			interface
		end

	EV_MENU_HOLDER_IMP
		undefine
			add_menu_ok,
			set_foreground_color,
			set_background_color
		redefine
			interface
		end

	EV_BUTTON_IMP
		rename
	--		add_click_command as add_popup_command
		export {NONE}
			initialize
		undefine
			--set_text,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			make,
	--		add_popup_command,
			text,
			set_foreground_color,
			set_background_color
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is         
			-- Create a menu widget with `par' as parent.
			-- We can't use `widget_make' here, because a menu
			-- is not a child, otherwise, you couldn't put more
			-- than a menu in a window. A menu is an option of a
			-- window
		do
			base_make (an_interface)
			set_c_object (C.gtk_option_menu_new)

			-- Creating the array containing the menu_items.
			create menu_items_array.make (0)

			-- initializing status
			menu := Void
		end	

feature -- Status setting

	clear_selection is
		do
			C.gtk_option_menu_set_history (c_object, 0)
			--| FIXME VB 19991122
			--| I think it should look something like this:
		--|	if menu.text /= Void then
		--|		set_text (menu.text)
		--|	else
		--|		set_text (item 0)
		--|	end
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
				selected_item_p := C.c_gtk_option_button_selected_menu_item (c_object)
				from
					items_array := menu_items_array
					menu_item_found := False
					items_array.start
				until
					items_array.after or menu_item_found
				loop
					local_menu_item := items_array.item
					if local_menu_item.c_object = selected_item_p then
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
			if (menu /= Void) then
				--| FIXME VB 19991122 Do not call selected_item twice.
				if (selected_item /= Void) then
					Result := selected_item.text
				else
					Result := menu.text
				end
			else
				Result := Void
			end
		end

	menu: EV_MENU
			-- The menu contained in the option button.

feature {EV_MENU_ITEM_HOLDER} -- Element change	
	
	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'.
			-- Redefined because the text is in a gtk_label.
		local
			list: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= menu.implementation
			real_set_foreground_color (c_object, color)
			if C.gtk_bin_struct_child (c_object) /= Default_pointer then
				real_set_foreground_color (C.gtk_bin_struct_child (c_object), color)
			end

			-- Color for the menu.
			if menu /= Void then
				real_set_foreground_color (menu_imp.c_object, color)
			end

			-- Color for the menu items.
			if menu_title_widget /= default_pointer then
				real_set_foreground_color (menu_title_widget, color)
			end
			from
				list := menu_items_array
				list.start
			until
				list.after
			loop
				real_set_foreground_color (list.item.c_object, color)
				list.forth
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Assign `color' as new `foreground_color'.
			-- Redefined because the text is in a gtk_label.
		local
			list: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= menu.implementation
			C.c_gtk_option_button_set_bg_color (c_object, color.red_16_bit, color.green_16_bit, color.blue_16_bit)

			-- Color for the menu.
			if menu /= Void then
				real_set_background_color (menu_imp.c_object, color)
			end

			-- Color for the menu items.
			if menu_title_widget /= default_pointer then
				real_set_background_color (menu_title_widget, color)
			end
			from
				list := menu_items_array
				list.start
			until
				list.after
			loop
				real_set_background_color (list.item.c_object, color)
				list.forth
			end
		end

	add_menu (a_menu: EV_MENU) is
			-- Set menu for menu item
		local
			wid: POINTER
			a: ANY
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= a_menu.implementation
			check
				menu_imp_not_void: menu_imp /= Void
			end
			-- Create a menu item with the label set to `text' of `menu_imp':
			-- This menu_item is not put in the menu_items_array.
			-- It is only used when the user want to have a title
			-- for the option button.
			if ((menu_imp.text /= Void) and then (menu_title_widget = default_pointer)) then
				a := menu_imp.text.to_c
				menu_title_widget := C.gtk_menu_item_new_with_label ($a)
				C.gtk_widget_show (menu_title_widget)
				-- Append it so it is the first item.
				C.gtk_menu_prepend (menu_imp.c_object, menu_title_widget)
			end

			-- Add the menu to the option button.
			C.gtk_option_menu_set_menu (c_object, menu_imp.c_object)

			-- Set the menu colors to the same ones as the option button's.
			real_set_foreground_color (menu_imp.c_object, foreground_color)
			real_set_background_color (menu_imp.c_object, background_color)

			-- Status setting.
			menu := menu_imp.interface
		end
	
	remove_menu (a_menu: EV_MENU) is
			-- Remove menu from option button.
		local
			default_colors: EV_DEFAULT_COLORS
				-- Needed to reset the menu's colors to
				-- the default colors.
			menu_imp: EV_MENU_IMP
		do
			menu_imp ?= a_menu.implementation
			check
				menu_imp_not_void: menu_imp /= Void
			end
			-- Remove the menu_item added for the menu title.
			C.gtk_container_remove (menu_imp.c_object, menu_title_widget)

			-- Remove the gtk_menu from the gtk_option_menu.
			C.gtk_option_menu_remove_menu (c_object)

			-- Set the menu colors to the default colors. We set it to those colors
			-- because for now, the user can not set colors on EV_MENU.
			real_set_foreground_color (menu_imp.c_object, default_colors.default_foreground_color)
			real_set_background_color (menu_imp.c_object, default_colors.default_background_color)

			-- Status setting.
			menu := Void
			menu_items_array := Void
			menu_title_widget := default_pointer
		end

feature -- Event - command association

--	add_popup_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
--			-- Add 'cmd' to the list of commands to be executed
--			-- just before the popup is shown.
--		do
--			--add_button_press_command (1, cmd, arg)
--		end

feature -- Implementation

	menu_title_widget: POINTER
			-- A gtk_menu_item:
			-- When the menu has a title (`text' not null)
			-- we create a menu_item with a text set to `text'
			-- and we append it to the menu (see `add_item').

	set_menu_title_widget (p: POINTER) is
			-- Assign `p' to `menu_title_widget'.
		do
			menu_title_widget := p
		end

	interface: EV_OPTION_BUTTON

end -- class EV_OPTION_BUTTON_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.15  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.4.1.2.6  2000/02/08 09:32:41  oconnor
--| removed reference to ev_children
--|
--| Revision 1.14.4.1.2.5  2000/02/04 07:56:40  oconnor
--| removed old command features
--|
--| Revision 1.14.4.1.2.4  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.14.4.1.2.3  2000/02/02 00:05:39  oconnor
--| modifed for new menu classes
--|
--| Revision 1.14.4.1.2.2  2000/01/27 19:29:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.4.1.2.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.5  1999/11/18 03:40:42  oconnor
--| rewrote press command handling to use action sequence
--|
--| Revision 1.14.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.14.2.3  1999/11/04 23:10:31  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.14.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
