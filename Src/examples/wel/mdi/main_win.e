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
			make_top (Title, main_menu.popup_menu (1), 1000)
			set_menu (main_menu)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
		local
			child: WEL_MDI_CHILD_WINDOW
			s: STRING
		do
			inspect
				menu_id
			when Cmd_file_new then
				child_no := child_no + 1
				s := "Child window "
				s.append_integer (child_no)
				create child.make (Current, s)
			when Cmd_file_close then
				if has_active_window then
					active_window.destroy
				end
			when Cmd_file_exit then
				if closeable then
					destroy
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

	child_no: INTEGER

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

	Title: STRING is "WEL Multiple Document Interface"
			-- Window's title

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

