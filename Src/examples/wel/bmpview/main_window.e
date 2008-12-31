note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
		do
			make_top (Title, main_menu.popup_menu (1), 1000)
			set_menu (main_menu)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER)
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
						-- Add `Child' to `All_children'.
					All_children.extend (child)
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

	open_file_dialog: WEL_OPEN_FILE_DIALOG
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

	main_menu: WEL_MENU
			-- Window's menu
		once
				-- create the menu from the resource file.
			create Result.make_by_id (Id_menu_application)
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON
		once
			create Result.make_by_id (Id_ico_application)
		end

	Title: STRING = "WEL Bitmap Viewer"
			-- Window's title

	All_children: LINKED_LIST [WEL_MDI_CHILD_WINDOW]
			-- A list of all the child windows to avoid the strong
			-- possibility that they will be garbage collected.
		once
			create Result.make
		end

feature {CHILD_WINDOW} -- Implementation

	remove_child_reference (a_child: WEL_MDI_CHILD_WINDOW)
			-- Remove `a_child' from `All_children'.
		local
			found: BOOLEAN
		do
			from
				All_children.start
			until
				All_children.off or found
			loop
					-- We must check the childs `item' as just checking
					-- the object is not enough.
				if All_children.item.item = a_child.item then
					found := True
					All_children.remove
				else
					All_children.forth
				end
			end
		end

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

