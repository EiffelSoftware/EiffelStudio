class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_set_cursor
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	WEL_HT_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window
		do
			create cursor.make_by_predefined_id (Idc_arrow)
			make_top (Title)
			set_menu (main_menu)
			resize (300, 200)
		end

feature -- Access

	cursor: WEL_CURSOR
			-- Current cursor

feature {NONE} -- Behaviors

	on_menu_command (id_menu: INTEGER) is
		do
			inspect
				id_menu
			when Cmd_cursor_arrow then
				create cursor.make_by_predefined_id (Idc_arrow)
			when Cmd_cursor_cross then
				create cursor.make_by_predefined_id (Idc_cross)
			when Cmd_cursor_ibeam then
				create cursor.make_by_predefined_id (Idc_ibeam)
			when Cmd_cursor_size then
				create cursor.make_by_predefined_id (Idc_sizeall)
			when Cmd_cursor_sieznesw then
				create cursor.make_by_predefined_id (Idc_sizenesw)
			when Cmd_cursor_sizens then
				create cursor.make_by_predefined_id (Idc_sizens)
			when Cmd_cursor_sizeswne then
				create cursor.make_by_predefined_id (Idc_sizenwse)
			when Cmd_cursor_sizewe then
				create cursor.make_by_predefined_id (Idc_sizewe)
			when Cmd_cursor_uparrow then
				create cursor.make_by_predefined_id (Idc_uparrow)
			when Cmd_cursor_wait then
				create cursor.make_by_predefined_id (Idc_wait)
			when Cmd_cursor_custom then
				create cursor.make_by_id (Id_cur_custom)
			end
		end

	on_set_cursor (hit_test: INTEGER) is
			-- Set the cursor only in the client area.
		do
			if hit_test = Htclient then
				cursor.set
				disable_default_processing
			end
		end

feature {NONE} -- Implementation

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
		once
			create Result.make_by_id (Id_menu_application)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Cursors"
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

