
feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)

	build_standard_menu_bar is
			-- Create and populate `standard_menu_bar'.
		require
			menu_bar_not_yet_created: standard_menu_bar = Void 
		do
				-- Create the menu bar.
			create standard_menu_bar

				-- Add the "File" menu
			build_file_menu
			standard_menu_bar.extend (file_menu)

				-- Add the "Help" menu
			build_help_menu
			standard_menu_bar.extend (help_menu)
		ensure
			menu_bar_created: 
				standard_menu_bar /= Void and then 
				not standard_menu_bar.is_empty
		end

	build_file_menu is
			-- Create and populate `file_menu'.
		require
			file_menu_not_yet_created: file_menu = Void
		local
			menu_item: EV_MENU_ITEM
		do
			create file_menu.make_with_text (Menu_file_item)

			create menu_item.make_with_text (Menu_file_new_item)
				--| TODO: Add the action associated with "New" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_open_item)
				--| TODO: Add the action associated with "Open" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_save_item)
				--| TODO: Add the action associated with "Save" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_saveas_item)
				--| TODO: Add the action associated with "Save As..." here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_close_item)
				--| TODO: Add the action associated with "Close" here.
			file_menu.extend (menu_item)

			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Create the File/Exit menu item and make it call
				-- `request_close_window' when it is selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_close_window)
			file_menu.extend (menu_item)
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

	build_help_menu is
			-- Create and populate `help_menu'.
		require
			help_menu_not_yet_created: help_menu = Void
		local
			menu_item: EV_MENU_ITEM
		do
			create help_menu.make_with_text (Menu_help_item)
			
			create menu_item.make_with_text (Menu_help_contents_item)
				--| TODO: Add the action associated with "Contents and Index" here.
			help_menu.extend (menu_item)<FL_HELP_ABOUT_ADD>
		ensure
			help_menu_created: help_menu /= Void and then not help_menu.is_empty
		end
