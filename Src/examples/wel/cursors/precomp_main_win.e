class
	PRECOMP_MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
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
		local
			msg_box: WEL_MSG_BOX
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
				create msg_box.make
				msg_box.information_message_box(Current, "Feature not available in the precompiled version.","not available...")
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

	main_menu: WEL_MENU is
		local
			cursor_menu: WEL_MENU
		once
				-- build the popup menu "Cursor"
			create cursor_menu.make
			cursor_menu.append_string("Arrow", Cmd_cursor_arrow)
			cursor_menu.append_string("Cross", Cmd_cursor_cross)
			cursor_menu.append_string("Ibeam", Cmd_cursor_ibeam)
			cursor_menu.append_string("Size", Cmd_cursor_size)
			cursor_menu.append_string("Sieznesw", Cmd_cursor_sieznesw)
			cursor_menu.append_string("Sizens", Cmd_cursor_sizens)
			cursor_menu.append_string("Sizenwse", Cmd_cursor_sizeswne)
			cursor_menu.append_string("Sizewe", Cmd_cursor_sizewe)
			cursor_menu.append_string("Uparrow", Cmd_cursor_uparrow)
			cursor_menu.append_string("Wait", Cmd_cursor_wait)
			cursor_menu.append_separator
			cursor_menu.append_string("Custom", Cmd_cursor_custom)

				-- build the menu bar
			create Result.make
			Result.append_popup(cursor_menu,"Cursors")
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Cursors"
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
