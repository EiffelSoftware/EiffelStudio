indexing
	description: "Test of dialogs."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STANDARD_DIALOGS

inherit
	EV_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', initialize and launch.
		do
			default_create
			build_interface	
			launch
		end

	build_interface is
			-- Build GUI interface.
		local
			menu_bar: EV_MENU_BAR
			menu: EV_MENU
			menu_item: EV_MENU_ITEM		
		do
			create menu_bar
			first_window.set_menu_bar (menu_bar)
			create menu.make_with_text ("File")
			menu_bar.extend (menu)
			create menu_item.make_with_text ("Exit")
			menu.extend (menu_item)
				-- When "Exit is selected, end application.
			menu_item.select_actions.extend (agent destroy)
			create menu.make_with_text ("Standard dialogs")
			menu_bar.extend (menu)
			create menu_item.make_with_text ("EV_COLOR_DIALOG")
			menu.extend (menu_item)
			menu_item.select_actions.extend (agent Color_dialog.show_modal_to_window (first_window))
			create menu_item.make_with_text ("EV_DIRECTORY_DIALOG")
			menu.extend (menu_item)
			menu_item.select_actions.extend (agent Directory_dialog.show_modal_to_window (first_window))
			create menu_item.make_with_text ("EV_FILE_OPEN_DIALOG")
			menu.extend (menu_item)
			menu_item.select_actions.extend (agent File_open_dialog.show_modal_to_window (first_window))
			create menu_item.make_with_text ("EV_FILE_SAVE_DIALOG")
			menu.extend (menu_item)
			menu_item.select_actions.extend (agent File_save_dialog.show_modal_to_window (first_window))
			create menu_item.make_with_text ("EV_FONT_DIALOG")
			menu.extend (menu_item)
			menu_item.select_actions.extend (agent Font_dialog.show_modal_to_window (first_window))
			create menu_item.make_with_text ("EV_PRINT_DIALOG")
			menu.extend (menu_item)
			menu_item.select_actions.extend (agent Print_dialog.show_modal_to_window (first_window))
			
				-- If the user clicks on the cross of `first_window', end application.
			first_window.close_request_actions.extend (agent destroy)
			first_window.show
		end
		
		Color_dialog: EV_COLOR_DIALOG is
				-- 	EV_COLOR_DIALOG for test.
			once
				create Result	
			end
			
		Directory_dialog: EV_DIRECTORY_DIALOG is
				-- 	EV_DIRECTORY_DIALOG for test.
			once
				create Result	
			end
			
		File_open_dialog: EV_FILE_OPEN_DIALOG is
				-- 	EV_FILE_OPEN_DIALOG for test.
			once
				create Result	
			end
			
		File_save_dialog: EV_FILE_SAVE_DIALOG is
				-- 	EV_FILE_SAVE_DIALOG for test.
			once
				create Result	
			end
			
		Font_dialog: EV_FONT_DIALOG is
				-- 	EV_FONT_DIALOG for test.
			once
				create Result	
			end
			
		Print_dialog: EV_PRINT_DIALOG is
				-- 	EV_PRINT_DIALOG for test.
			once
				create Result	
			end

feature {NONE} -- Implementation

	first_window: EV_TITLED_WINDOW is
			-- The window for the sample.
		once
			create Result
			Result.set_title ("Main window")
			Result.set_size (300, 300)
		end

end -- class DIALOG_TEST

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

