class
	MAIN_WINDOW

inherit
	WEL_MDI_FRAME_WINDOW
		redefine
			on_menu_command,
			class_icon
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
			make_top (Title, main_menu.popup_menu (2), 1000)
			set_menu (main_menu)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
		local
			child: CHILD_WINDOW
		do
			inspect
				menu_id

				-- FILE menu
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

				-- EDIT menu
			when Cmd_edit_undo then
				
			when Cmd_edit_redo then
				
			when Cmd_edit_cut then
				
			when Cmd_edit_copy then
				
			when Cmd_edit_paste then
				
			when Cmd_edit_indent then
				if has_active_window then
					child ?= active_window
					child.unindent_selection
				end

			when Cmd_edit_unindent then
				if has_active_window then
					child ?= active_window
					child.indent_selection
				end

			when Cmd_edit_comment then
				if has_active_window then
					child ?= active_window
					child.comment_selection
				end

			when Cmd_edit_uncomment then
				if has_active_window then
					child ?= active_window
					child.uncomment_selection
				end

			
				-- WINDOW menu
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
			Result.set_filter (<<"Eiffel files (*.e)", "All files (*.*)">>, <<"*.e", "*.*">>)
			Result.add_flag (ofn.Ofn_filemustexist)
		ensure
			result_not_void: Result /= Void
		end

	main_menu: WEL_MENU is
		once
			create Result.make_by_id (Id_menu_application)
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON is
		once
			create Result.make_by_id (Id_ico_application)
		end

	Title: STRING is "WEL Editor"
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
