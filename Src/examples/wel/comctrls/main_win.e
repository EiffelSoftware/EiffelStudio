class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_control_id_command,
			on_size,
			on_menu_select,
			on_notify,
			background_brush
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_TTF_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_IDB_CONSTANTS
		export
			{NONE} all
		end

	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		local
			bitmap_index1, bitmap_index2: INTEGER
		do
			make_top (Title)
			set_menu (main_menu)
			resize (450, 400)
			create static.make (Current,
				"To see tooltip controls, move the mouse on %
				%the track bar, the progress bar or the toolbar %
				%buttons.", 200, 50, 200, 70, -1)

			-- Create a track bar
			create track_bar.make_horizontal (Current, 10, 40, 110, 40, -1)
			track_bar.set_range (0, 100)

			-- Create a progress bar
			create progress_bar.make (Current, 10, 110, 110, 20, -1)

			-- Create a status window
			create status_window.make (Current, -1)
			status_window.set_multiple_mode
			status_window.set_parts (<<300, 350, -1>>)

			-- Create a rich edit control
			create rich_edit.make (Current, "", 5, 150, 200, 150, -1)
			create char_format.make
			char_format.set_face_name ("Arial")
			char_format.set_height (12)
			char_format.unset_bold
			rich_edit.set_character_format_all (char_format)
			rich_edit.set_text ("Rich edit control")

			-- Create a toolbar and buttons
			create tool_bar.make (Current, -1)

			create tool_bar_bitmap.make (Bmp_toolbar)
			create standard_tool_bar_bitmap.make_by_predefined_id (Idb_std_small_color)

			tool_bar.add_bitmaps (standard_tool_bar_bitmap, 1)
			bitmap_index1 := tool_bar.last_bitmap_index

			tool_bar.add_bitmaps (tool_bar_bitmap, 1)
			bitmap_index2 := tool_bar.last_bitmap_index

			create tool_bar_button4.make_check (bitmap_index2 + 0, Cmd_bold)
			create tool_bar_button5.make_check (bitmap_index2 + 1, Cmd_italic)
			create tool_bar_button6.make_separator
			create tool_bar_button7.make_button (bitmap_index2 + 2, Cmd_progress_bar)
			create tool_bar_button8.make_button (bitmap_index2 + 3, Cmd_exit)

			tool_bar.add_buttons (<<
				tool_bar_button4,
				tool_bar_button5,
				tool_bar_button6,
				tool_bar_button7,
				tool_bar_button8>>)

			-- Create a tooltip
			create tooltip.make (Current, -1)

			create tool_info1.make
			tool_info1.set_window (track_bar)
			tool_info1.set_flags (Ttf_subclass)
			tool_info1.set_rect (track_bar.client_rect)
			tool_info1.set_text_id (Str_tooltip) -- Use a string resource id
			tooltip.add_tool (tool_info1)

			create tool_info2.make
			tool_info2.set_window (progress_bar)
			tool_info2.set_flags (Ttf_subclass)
			tool_info2.set_rect (progress_bar.client_rect)
			tool_info2.set_text ("This a tooltip for the progress bar") -- Use a string
			tooltip.add_tool (tool_info2)
		end

feature -- Access

	static: WEL_STATIC

	progress_bar: WEL_PROGRESS_BAR

	track_bar: WEL_TRACK_BAR

	status_window: WEL_STATUS_WINDOW

	tool_bar: WEL_TOOL_BAR

	tooltip: WEL_TOOLTIP

	tool_info1, tool_info2: WEL_TOOL_INFO

	tool_bar_bitmap, standard_tool_bar_bitmap: WEL_TOOL_BAR_BITMAP

	tool_bar_button4,
	tool_bar_button5,
	tool_bar_button6,
	tool_bar_button7,
	tool_bar_button8: WEL_TOOL_BAR_BUTTON

	rich_edit: WEL_RICH_EDIT

	char_format: WEL_CHARACTER_FORMAT

	background_brush: WEL_BRUSH is
			-- Dialog boxes background color is the same than
			-- button color.
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature {NONE} -- Implementation

	on_notify (control_id: INTEGER; info: WEL_NMHDR) is
			-- Draw the tooltips.
		local
			tt: WEL_TOOLTIP_TEXT
		do
			if info.code = Ttn_needtext then
				create tt.make_by_nmhdr (info)
				-- Set resource string id.
				tt.set_text_id (tt.hdr.id_from)
			end
		end

	on_control_id_command (control_id: INTEGER) is
		do
			on_menu_command (control_id)
		end

	on_menu_command (menu_id: INTEGER) is
			-- Execute the command identified by `menu_id'.
		local
			i: INTEGER
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_progress_bar then
				from
					i := 0
				until
					i = 100
				loop
					progress_bar.step_it
					i := i + 10
				end
			when Cmd_bold then
				create char_format.make
				if tool_bar.button_checked (Cmd_bold) then
					char_format.set_bold

				else
					char_format.unset_bold
				end
				rich_edit.set_character_format_selection (char_format)
			when Cmd_italic then
				create char_format.make
				if tool_bar.button_checked (Cmd_italic) then
					char_format.set_italic
				else
					char_format.unset_italic
				end
				rich_edit.set_character_format_selection (char_format)
			else
			end
		end

	on_menu_select (menu_item: INTEGER; flags: INTEGER; a_menu: WEL_MENU) is
			-- Display a message in the status window corresponding
			-- to the selected menu_item.
		do
			status_window.set_text_part (0,
				resource_string_id (menu_item))
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Reposition the status window and the tool bar when
			-- the window has been resized.
		do
			if status_window /= Void then
				status_window.reposition
			end
			if tool_bar /= Void then
				tool_bar.reposition
			end
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Common controls"
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

