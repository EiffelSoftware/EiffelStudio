class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_right_button_down,
			closeable
		end

creation
	make

feature {NONE} -- Initialization

	make is
		local
			label: WEL_STATIC
		do
			make_top (Title)
			resize (400, 250)
			set_menu (main_menu)
			!! label.make (Current, 
				"Right-click in this window to get a track popup menu.",
				1, 10, 350, 20, 1)
		end

feature {NONE} -- Implementation

	closeable: BOOLEAN is
			-- When the user can close the window?
		do
			if file_menu.item_checked (Confirmation_id) then
				Result := message_box ("Do you want to exit?",
					"Exit", Mb_yesno + Mb_iconquestion) = Idyes
			else
				Result := True
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- `menu_id' has been selected
		do
			inspect
				menu_id
			when Exit_id then
				if closeable then
					destroy
				end
			when Confirmation_id then
				if file_menu.item_checked (Confirmation_id) then
					file_menu.uncheck_item (Confirmation_id)
				else
					file_menu.check_item (Confirmation_id)
				end
			when Open_id then
				information_message_box ("Option `Open' selected.", "Open")
			when Save_id then
				information_message_box ("Option `Save' selected.", "Save")
			when Delete_id then
				information_message_box ("Option `Delete' selected.", "Delete")
			else
			end
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Right button pressed
		local
			point: WEL_POINT
		do
			!! point.make (x_pos, y_pos)
			point.client_to_screen (Current)
			track.show_track (point.x, point.y, Current)
		end

	main_menu: WEL_MENU is
			-- The main menu
		once
			!! Result.make
			Result.append_popup (file_menu, "&File")
		ensure
			result_not_void: Result /= Void
		end

	file_menu: WEL_MENU is
			-- The file menu
		once
			!! Result.make
			Result.append_string ("&Open", Open_id)
			Result.append_string ("&Save", Save_id)
			Result.append_string ("&Delete", Delete_id)
			Result.append_separator
			Result.append_string ("&Confirmation before exit", Confirmation_id)
			Result.append_string ("E&xit", Exit_id)
			Result.check_item (Confirmation_id)
		ensure
			result_not_void: Result /= Void
		end

	track: WEL_MENU is
			-- The track menu
		once
			!! Result.make_track			
			Result.append_popup (file_menu, "File")
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (1)
		end

	Open_id, Save_id, Delete_id,
		Confirmation_id, Exit_id: INTEGER is unique

	Title: STRING is "WEL Menus"
			-- Window's title

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
