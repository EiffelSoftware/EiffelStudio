indexing
	description: 
		"MENU_DEMO_WINDOW, demo window to test menu widget.%
		% Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MENU_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end

	EV_COMMAND

creation
	make

feature -- Access

	main_widget: EV_OPTION_BUTTON is
			-- The main widget of the demo
		once
			!! Result.make (Current)
			Result.set_minimum_size(300,100)
		end
	
	static: EV_STATIC_MENU_BAR
	menu: EV_MENU
	menu2: EV_MENU_ITEM
	menu_item: EV_MENU_ITEM
	menu_item5: EV_MENU_ITEM
	check_menu_item: EV_CHECK_MENU_ITEM
	menu_item2: EV_RADIO_MENU_ITEM
	menu_item3: EV_RADIO_MENU_ITEM
	menu_item4: EV_RADIO_MENU_ITEM

feature -- Status setting

	set_widgets is
			-- Set the widgets in the demo windows.
		do
			!! menu.make_with_text (main_widget, "Menu")
			!! menu_item.make_with_text (menu, "Item 1")
			!! menu_item.make_with_text (menu, "Item 2")
			menu_item.set_insensitive (True)
			!! menu_item.make_with_text (menu, "Item 3")
			!! menu2.make_with_text (menu, "Menu 2")
			!! menu_item.make_with_text (menu2, "Item 1")
			!! menu_item.make_with_text (menu2, "Item 2")
			!! menu_item.make_with_text (menu2, "Item 3")

			!! static.make (Current)
			!! menu.make_with_text (static, "File")
			!! menu_item.make_with_text (menu, "New")
			!! menu_item.make_with_text (menu, "Open")
			!! menu_item.make_with_text (menu, "Save")
			menu_item.set_insensitive (True)
			!! check_menu_item.make_with_text (menu, "Auto save")
			!! menu_item5.make_with_text (menu, "Quit")
			menu_item5.add_select_command (Current, Void)
						
			!! menu.make_with_text (static, "Edit")
			!! check_menu_item.make_with_text (menu, "Cut")
			!! check_menu_item.make_with_text (menu, "Copy")
			!! check_menu_item.make_with_text (menu, "Paste")
			
			!! menu.make_with_text (static, "Test")
			!! menu_item.make_with_text (menu, "Sub menu1")
			!! menu_item2.make_with_text (menu_item, "Selection 1")
			!! menu_item3.make_peer_with_text (menu_item, "Selection 2", menu_item2)
			!! menu_item4.make_peer_with_text (menu_item, "Selection 3", menu_item2)
			!! menu_item2.make_with_text (menu_item, "Selection 1")
			!! menu_item3.make_peer_with_text (menu_item, "Selection 2", menu_item2)
			!! menu_item4.make_peer_with_text (menu_item, "Selection 3", menu_item2)
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Menu demo")
		end

feature -- Command execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute command called when the event occurs.
		do
			destroy
			effective_button.toggle
		end

end -- class MENU_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

