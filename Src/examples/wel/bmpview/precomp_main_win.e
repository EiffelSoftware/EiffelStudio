-- Main Window for precompiled version (no ressource file needed)
class
	PRECOMP_MAIN_WINDOW

inherit
	WEL_MDI_FRAME_WINDOW
		redefine
			on_menu_command
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title, main_menu.popup_menu (1), 1000)
			set_menu (main_menu)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
		local
			child: PRECOMP_CHILD_WINDOW
		do
			inspect
				menu_id
			when Cmd_file_exit then
				if closeable then
					destroy
				end
			when Cmd_file_open then
				open_file_dialog.activate (Current)
				if open_file_dialog.selected then
					create child.make (Current, open_file_dialog.file_name)
				end
			when Cmd_file_close then
				if has_active_window then
					active_window.destroy
				end
			when Cmd_window_tile_vertical then
				tile_children_vertical
			when Cmd_window_tile_horizontal then
				tile_children_horizontal
			when Cmd_window_cascade then
				cascade_children
			when Cmd_window_arrange then
				arrange_icons
			else
			end
		end

	open_file_dialog: WEL_OPEN_FILE_DIALOG is
		local
			ofn: WEL_OFN_CONSTANTS
		once
			create ofn
			create Result.make
			Result.set_filter (<<"Bitmap file (*.bmp)", "All file (*.*)">>,
					<<"*.bmp", "*.*">>)
			Result.add_flag (ofn.Ofn_filemustexist)
		ensure
			result_not_void: Result /= Void
		end

	main_menu: WEL_MENU is
			-- Window's menu
		local 
			file_menu: WEL_MENU
			window_menu: WEL_MENU
		once 
				-- Build File menu.
			create file_menu.make
			file_menu.append_string ("&Open...", Cmd_file_open)
			file_menu.append_string ("&Close...", Cmd_file_close)
			file_menu.append_separator
			file_menu.append_string ("E&xit", Cmd_file_exit)

				-- Build Window menu.
			create window_menu.make
			window_menu.append_string("Tile &vertical", Cmd_window_tile_vertical)
			window_menu.append_string("Tile &horizontal", Cmd_window_tile_horizontal)
			window_menu.append_string("&Cascade", Cmd_window_cascade)
			window_menu.append_string("&Arrange icons", Cmd_window_arrange)

				-- Build main menu.
			create Result.make
			Result.append_popup (file_menu, "&File")
			Result.append_popup (window_menu, "&Window")
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Bitmap Viewer"
			-- Window's title

end -- class PRECOMP_MAIN_WINDOW

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
