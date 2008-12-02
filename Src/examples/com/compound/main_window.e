indexing
	description: "Main window for compound file viewer"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
		
	WEL_OFN_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create main window.
		do
			make_top (Title, main_menu.popup_menu (1), 1000)
			set_menu (main_menu)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
			-- Process menu commands.
		local
			child: CHILD_WINDOW
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
			-- Dialog to open compound files.
		once
			create Result.make
			Result.set_filter (<<"All file (*.*)">>,
					<<"*.*">>)
			Result.add_flag (Ofn_filemustexist)
		ensure
			result_not_void: Result /= Void
		end

	main_menu: WEL_MENU is
			-- Main window's menu
		once
			create Result.make_by_id (Id_menu_application)
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON is
			-- Main window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	Title: STRING is "Compound Files Viewer";
			-- Main window's title

indexing
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

