note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_right_button_down,
			closeable,
			background_brush
		end

create
	make

feature {NONE} -- Initialization

	make
		local
			label: WEL_STATIC
		do
			make_top (Title)
			resize (400, 250)
			set_menu (main_menu)
			create label.make (Current, 
				"Right-click in this window to get a track popup menu.",
				1, 10, 350, 20, 1)
			label.set_font(gui_font)
		end

feature -- Access

	background_brush: WEL_BRUSH
			-- Dialog boxes background color is the same than
			-- button color.
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature {NONE} -- Implementation

	closeable: BOOLEAN
			-- When the user can close the window?
		local
			msg_box: WEL_MSG_BOX
		do
			if file_menu.item_checked (Confirmation_id) then
				create msg_box.make
				msg_box.question_message_box (Current, 
							"Do you want to exit?", "Exit")
				Result := msg_box.message_box_result = Idyes
			else
				Result := True
			end
		end

	on_menu_command (menu_id: INTEGER)
			-- `menu_id' has been selected
		local
				msg_box: WEL_MSG_BOX
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
				create msg_box.make
				msg_box.information_message_box (Current, "Option `Open' selected.", "Open")
			when Save_id then
				create msg_box.make
				msg_box.information_message_box (Current, "Option `Save' selected.", "Save")
			when Delete_id then
				create msg_box.make
				msg_box.information_message_box (Current, "Option `Delete' selected.", "Delete")
			else
			end
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER)
			-- Right button pressed
		local
			point: WEL_POINT
		do
			create point.make (x_pos, y_pos)
			point.client_to_screen (Current)
			track.show_track (point.x, point.y, Current)
		end

	main_menu: WEL_MENU
			-- The main menu
		once
			create Result.make
			Result.append_popup (file_menu, "&File")
		ensure
			result_not_void: Result /= Void
		end

	file_menu: WEL_MENU
			-- The file menu
		once
			create Result.make
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

	track: WEL_MENU
			-- The track menu
		once
			create Result.make_track			
			Result.append_popup (file_menu, "File")
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (1)
		end

	Open_id, Save_id, Delete_id,
		Confirmation_id, Exit_id: INTEGER = unique

	Title: STRING = "WEL Menus";
			-- Window's title

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_WINDOW

