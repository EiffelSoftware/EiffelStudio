indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	OPTION_WINDOW

inherit
	EV_OPTION_BUTTON
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		do
			{EV_OPTION_BUTTON} Precursor (par)
			set_vertical_resize (False)
			set_horizontal_resize (False)

			!! menu.make_with_text (Current, "Menu")
			!! menu_item.make_with_text (menu, "Item 1")
			!! menu_item.make_with_text (menu, "Item 2")
			menu_item.set_insensitive (True)
			!! menu_item.make_with_text (menu, "Item 3")
			!! menu2.make_with_text (menu, "Menu 2")
			!! menu_item.make_with_text (menu2, "Item 1")
			!! menu_item.make_with_text (menu2, "Item 2")
			!! menu_item.make_with_text (menu2, "Item 3")

--			!! static.make (Current)
--			!! menu.make_with_text (static, "File")
--			!! menu_item.make_with_text (menu, "New")
--			!! menu_item.make_with_text (menu, "Open")
--			!! menu_item.make_with_text (menu, "Save")
--			menu_item.set_insensitive (True)
--			!! check_menu_item.make_with_text (menu, "Auto save")
--			!! menu_item5.make_with_text (menu, "Quit")
--			menu_item5.add_activate_command (Current, Void)
--						
--			!! menu.make_with_text (static, "Edit")
--			!! check_menu_item.make_with_text (menu, "Cut")
--			!! check_menu_item.make_with_text (menu, "Copy")
--			!! check_menu_item.make_with_text (menu, "Paste")
--			
--			!! menu.make_with_text (static, "Test")
--			!! menu_item.make_with_text (menu, "Sub menu1")
--			!! menu_item2.make_with_text (menu_item, "Selection 1")
--			!! menu_item3.make_peer_with_text (menu_item, "Selection 2", menu_item2)
--			!! menu_item4.make_peer_with_text (menu_item, "Selection 3", menu_item2)
--			!! menu_item2.make_with_text (menu_item, "Selection 1")
--			!! menu_item3.make_peer_with_text (menu_item, "Selection 2", menu_item2)
--			!! menu_item4.make_peer_with_text (menu_item, "Selection 3", menu_item2)
		end

feature -- Access

	menu: EV_MENU
	menu2: EV_MENU_ITEM
	menu_item: EV_MENU_ITEM
	menu_item5: EV_MENU_ITEM
	check_menu_item: EV_CHECK_MENU_ITEM
	menu_item2: EV_RADIO_MENU_ITEM
	menu_item3: EV_RADIO_MENU_ITEM
	menu_item4: EV_RADIO_MENU_ITEM

end -- class OPTION_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
