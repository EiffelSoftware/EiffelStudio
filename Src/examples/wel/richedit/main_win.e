class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_control_id_command,
			on_size,
			default_process_message
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

	WEL_CF_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			set_menu (main_menu)
			resize (450, 400)

			-- Create a rich edit control
			!! rich_edit.make (Current, "", 0, 35, 0, 0, -1)
			!! char_format.make
			char_format.set_face_name ("Arial")
			char_format.set_height (12 * 20)
			char_format.unset_bold
			rich_edit.set_character_format_selection (char_format)
			rich_edit.set_text ("Rich edit control")

			-- Create a toolbar and buttons
			!! tool_bar.make (Current, -1)

			!! tool_bar_button1.make_check (0, Cmd_bold)
			!! tool_bar_button2.make_check (1, Cmd_italic)
			!! tool_bar_button3.make_check (2, Cmd_underline)
			!! tool_bar_button4.make_separator
			!! tool_bar_button5.make_button (3, Cmd_font)
			!! tool_bar_button6.make_button (4, Cmd_color)
			!! tool_bar_button7.make_separator
			!! tool_bar_button8.make_check_group (5, Cmd_left)
			!! tool_bar_button9.make_check_group (6, Cmd_center)
			!! tool_bar_button10.make_check_group (7, Cmd_right)
			!! tool_bar_button11.make_separator
			!! tool_bar_button12.make_check (8, Cmd_bullet)

			!! tool_bar_bitmap.make (Bmp_toolbar)
			tool_bar.add_bitmaps (tool_bar_bitmap, 8)
			tool_bar.add_buttons (<<
				tool_bar_button1,
				tool_bar_button2,
				tool_bar_button3,
				tool_bar_button4,
				tool_bar_button5,
				tool_bar_button6,
				tool_bar_button7,
				tool_bar_button8,
				tool_bar_button9,
				tool_bar_button10,
				tool_bar_button11,
				tool_bar_button12>>)
		end

feature -- Access

	tool_bar: WEL_TOOL_BAR

	tool_bar_bitmap: WEL_TOOL_BAR_BITMAP

	tool_bar_button1,
	tool_bar_button2,
	tool_bar_button3,
	tool_bar_button4,
	tool_bar_button5,
	tool_bar_button6,
	tool_bar_button7,
	tool_bar_button8,
	tool_bar_button9,
	tool_bar_button10,
	tool_bar_button11,
	tool_bar_button12: WEL_TOOL_BAR_BUTTON

	rich_edit: WEL_RICH_EDIT

	char_format: WEL_CHARACTER_FORMAT

	para_format: WEL_PARAGRAPH_FORMAT

feature {NONE} -- Implementation

	default_process_message (msg, wparam, lparam: INTEGER) is
		local
			tt: WEL_TOOLTIP_TEXT
		do
			if msg = Wm_notify then
				!! tt.make_by_pointer (cwel_integer_to_pointer (lparam))
				if tt.hdr.code = Ttn_needtext then
					-- Set resource string id.
					tt.set_text_id (tt.hdr.id_from)
				end
			end
		end

	on_control_id_command (control_id: INTEGER) is
		do
			on_menu_command (control_id)
		end

	on_menu_command (menu_id: INTEGER) is
		local
			i: INTEGER
		do
			inspect
				menu_id
			when Cmd_open then
				warning_message_box ("Feature not implemented.", "Open")
			when Cmd_save then
				warning_message_box ("Feature not implemented.", "Save")
			when Cmd_print then
				warning_message_box ("Feature not implemented.", "Print")
			when Cmd_exit then
				destroy
			when Cmd_bold then
				!! char_format.make
				if tool_bar.button_checked (Cmd_bold) then
					char_format.set_bold

				else
					char_format.unset_bold
				end
				rich_edit.set_character_format_selection (char_format)
			when Cmd_italic then
				!! char_format.make
				if tool_bar.button_checked (Cmd_italic) then
					char_format.set_italic
				else
					char_format.unset_italic
				end
				rich_edit.set_character_format_selection (char_format)
			when Cmd_underline then
				!! char_format.make
				if tool_bar.button_checked (Cmd_underline) then
					char_format.set_underline
				else
					char_format.unset_underline
				end
				rich_edit.set_character_format_selection (char_format)
			when Cmd_font then
				choose_font.activate (Current)
				choose_font.add_flag (Cf_ttonly)
				if choose_font.selected then
					!! char_format.make
					char_format.set_face_name (choose_font.log_font.face_name)
					char_format.set_height (choose_font.log_font.height * -20)
					char_format.set_char_set (choose_font.log_font.char_set)
					char_format.set_pitch_and_family (choose_font.log_font.pitch_and_family)
					rich_edit.set_character_format_selection (char_format)
				end
			when Cmd_color then
				choose_color.activate (Current)
				if choose_color.selected then
					!! char_format.make
					char_format.set_text_color (choose_color.rgb_result)
					rich_edit.set_character_format_selection (char_format)
				end
			when Cmd_left then
				!! para_format.make
				para_format.set_left_alignment
				rich_edit.set_paragraph_format (para_format)
			when Cmd_center then
				!! para_format.make
				para_format.set_center_alignment
				rich_edit.set_paragraph_format (para_format)
			when Cmd_right then
				!! para_format.make
				para_format.set_right_alignment
				rich_edit.set_paragraph_format (para_format)
			when Cmd_bullet then
				!! para_format.make
				if tool_bar.button_checked (Cmd_bullet) then
					para_format.bullet_numbering
				else
					para_format.no_numbering
				end
				rich_edit.set_paragraph_format (para_format)
			else
			end
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Reposition the status window and the tool bar when
			-- the window has been resized.
		do
			if tool_bar /= Void then
				tool_bar.reposition
			end
			if rich_edit /= Void then
				rich_edit.resize (a_width, a_height - 40)
			end
		end

	choose_color: WEL_CHOOSE_COLOR_DIALOG is
			-- Dialog box to choose a text color.
		once
			!! Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_font: WEL_CHOOSE_FONT_DIALOG is
			-- Dialog box to choose a text font.
		once
			!! Result.make
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			!! Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Rich edit"
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
