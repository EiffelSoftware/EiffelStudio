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

	WEL_IDB_CONSTANTS
		export
			{NONE} all
		end

	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		local
			bitmap_index1, bitmap_index2: INTEGER
			l_tool_bar_bitmap: like tool_bar_bitmap
			l_tool_bar: like tool_bar
		do
			create tool_bar_buttons.make (18)
			make_top (Title)
			set_menu (main_menu)
			resize (400, 350)

			-- Create a rich edit control
			create rich_edit.make (Current, "", 0, 35, 200, 200, -1)

			-- Create a toolbar and buttons
			create l_tool_bar.make (Current, -1)
			tool_bar := l_tool_bar

			create l_tool_bar_bitmap.make_by_predefined_id (Idb_std_small_color)
				-- For GC reference
			standard_tool_bar_bitmap := l_tool_bar_bitmap
			l_tool_bar.add_bitmaps (l_tool_bar_bitmap, 1)
			bitmap_index1 := l_tool_bar.last_bitmap_index

			create l_tool_bar_bitmap.make (Bmp_toolbar)
				-- For GC reference
			tool_bar_bitmap := l_tool_bar_bitmap
			l_tool_bar.add_bitmaps (l_tool_bar_bitmap, 1)
			bitmap_index2 := l_tool_bar.last_bitmap_index

			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_button (bitmap_index1 + Std_filenew, Cmd_new))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_button (bitmap_index1 + Std_fileopen, Cmd_open))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_button (bitmap_index1 + Std_filesave, Cmd_save))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_separator)
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_button (bitmap_index1 + Std_print, Cmd_print))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_separator)
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check (bitmap_index2 + 0, Cmd_bold))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check (bitmap_index2 + 1, Cmd_italic))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check (bitmap_index2 + 2, Cmd_underline))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_separator)
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_button (bitmap_index2 + 3, Cmd_font))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_button (bitmap_index2 + 4, Cmd_color))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_separator)
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check_group (bitmap_index2 + 5, Cmd_left))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check_group (bitmap_index2 + 6, Cmd_center))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check_group (bitmap_index2 + 7, Cmd_right))
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_separator)
			tool_bar_buttons.extend (create {WEL_TOOL_BAR_BUTTON}.make_check (bitmap_index2 + 8, Cmd_bullet))

			l_tool_bar.add_buttons (tool_bar_buttons)

			on_menu_command (Cmd_new)
		ensure
			tool_bar_attached: tool_bar /= Void
			rich_edit_attached: rich_edit /= Void
		end

feature -- Access

	file_name: ?STRING
			-- File name of the active document

	tool_bar: ?WEL_TOOL_BAR
			-- Window's tool bar

	tool_bar_bitmap,
	standard_tool_bar_bitmap: ?WEL_TOOL_BAR_BITMAP
			-- Tool bar Bitmaps

	tool_bar_buttons: ARRAYED_LIST [WEL_TOOL_BAR_BUTTON]
			-- Tool bar buttons

	rich_edit: ?WEL_RICH_EDIT
			-- Rich edit control

feature {NONE} -- Implementation

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Draw the tooltips.
		local
			tt: WEL_TOOLTIP_TEXT
		do
			if msg = Wm_notify then
				create tt.make_by_pointer (lparam)
				if tt.hdr.code = Ttn_needtext then
					-- Set resource string id.
					tt.set_text_id (tt.hdr.id_from)
				end
			end
		end

	on_menu_command (menu_id: INTEGER)
			-- Execute the command identified by `menu_id'.
		local
			file: RAW_FILE
			l_file_name: like file_name
			char_format: WEL_CHARACTER_FORMAT
			para_format: WEL_PARAGRAPH_FORMAT
			l_tool_bar: like tool_bar
			l_rich_edit: like rich_edit
		do
			l_tool_bar := tool_bar
			l_rich_edit := rich_edit
				-- Per creation procedure postcondition and the fact we never reset it to Void.
			check
				l_tool_bar_attached: l_tool_bar /= Void
				l_rich_edit_attached: l_rich_edit /= Void
			end
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_new then
				l_rich_edit.clear
				file_name := Void
				set_window_title
				create char_format.make
				char_format.set_face_name ("Arial")
				char_format.set_height_in_points (10)
				char_format.unset_bold
				l_rich_edit.set_character_format_selection (char_format)
			when Cmd_open then
				open_file_dialog.activate (Current)
				if open_file_dialog.selected then
					l_file_name := open_file_dialog.file_name.twin
					file_name := l_file_name
					create file.make_open_read (l_file_name)
					if l_file_name.substring_index ("txt", 1) > 0 then
						l_rich_edit.load_text_file (file)
					else
						l_rich_edit.load_rtf_file (file)
					end
					set_window_title
					l_rich_edit.set_text_limit ((l_rich_edit.text_length * 2).max (32000))
				end
			when Cmd_save then
				l_file_name := file_name
				if l_file_name /= Void then
					create file.make_create_read_write (l_file_name)
					if l_file_name.substring_index ("txt", 1) > 0 then
						l_rich_edit.save_text_file (file)
					else
						l_rich_edit.save_rtf_file (file)
					end
				else
					on_menu_command (Cmd_save_as)
				end
			when Cmd_save_as then
				save_file_dialog.activate (Current)
				if save_file_dialog.selected then
					l_file_name := save_file_dialog.file_name
					file_name := l_file_name
					set_window_title
					create file.make_create_read_write (l_file_name)
					if l_file_name.substring_index ("txt", 1) > 0 then
						l_rich_edit.save_text_file (file)
					else
						l_rich_edit.save_rtf_file (file)
					end
				end
			when Cmd_print then
				print_dialog.activate (Current)
				if print_dialog.selected then
					l_rich_edit.print_all (print_dialog.dc, "Rich edit example")
				end
			when Cmd_bold then
				create char_format.make
				if l_tool_bar.button_checked (Cmd_bold) then
					char_format.set_bold
				else
					char_format.unset_bold
				end
				l_rich_edit.set_character_format_selection (char_format)
			when Cmd_italic then
				create char_format.make
				if l_tool_bar.button_checked (Cmd_italic) then
					char_format.set_italic
				else
					char_format.unset_italic
				end
				l_rich_edit.set_character_format_selection (char_format)
			when Cmd_underline then
				create char_format.make
				if l_tool_bar.button_checked (Cmd_underline) then
					char_format.set_underline
				else
					char_format.unset_underline
				end
				l_rich_edit.set_character_format_selection (char_format)
			when Cmd_font then
				choose_font.activate (Current)
				choose_font.add_flag (Cf_ttonly)
				if choose_font.selected then
					create char_format.make
					char_format.set_face_name (choose_font.log_font.face_name)
					char_format.set_height_in_points (choose_font.log_font.height_in_points)
					char_format.set_char_set (choose_font.log_font.char_set)
					char_format.set_pitch_and_family (choose_font.log_font.pitch_and_family)
					char_format.set_text_color (choose_font.color)
					if choose_font.log_font.italic then
						char_format.set_italic
						l_tool_bar.check_button (Cmd_italic)
					else
						char_format.unset_italic
						l_tool_bar.uncheck_button (Cmd_italic)
					end
					if choose_font.log_font.weight > 500 then
						char_format.set_bold
						l_tool_bar.check_button (Cmd_bold)
					else
						char_format.unset_bold
						l_tool_bar.uncheck_button (Cmd_bold)
					end
					l_rich_edit.set_character_format_selection (char_format)
				end
			when Cmd_color then
				choose_color.activate (Current)
				if choose_color.selected then
					create char_format.make
					char_format.set_text_color (choose_color.rgb_result)
					l_rich_edit.set_character_format_selection (char_format)
				end
			when Cmd_left then
				create para_format.make
				para_format.set_left_alignment
				l_rich_edit.set_paragraph_format (para_format)
			when Cmd_center then
				create para_format.make
				para_format.set_center_alignment
				l_rich_edit.set_paragraph_format (para_format)
			when Cmd_right then
				create para_format.make
				para_format.set_right_alignment
				l_rich_edit.set_paragraph_format (para_format)
			when Cmd_bullet then
				create para_format.make
				if l_tool_bar.button_checked (Cmd_bullet) then
					para_format.bullet_numbering
				else
					para_format.no_numbering
				end
				l_rich_edit.set_paragraph_format (para_format)
			else
			end
		end

	on_control_id_command (control_id: INTEGER)
		do
			on_menu_command (control_id)
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Reposition the status window and the tool bar when
			-- the window has been resized.
		do
			if {l_tool_bar: like tool_bar} tool_bar then
				l_tool_bar.reposition
			end
			if {l_rich_edit: like rich_edit} rich_edit then
				l_rich_edit.resize (a_width, a_height - 40)
			end
		end

	choose_color: WEL_CHOOSE_COLOR_DIALOG
			-- Dialog box to choose a text color.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_font: WEL_CHOOSE_FONT_DIALOG
			-- Dialog box to choose a text font.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	open_file_dialog: WEL_OPEN_FILE_DIALOG
			-- Dialog box to open a file.
		local
			ofn: WEL_OFN_CONSTANTS
		once
			create ofn
			create Result.make
			Result.set_default_extension ("txt")
			Result.set_filter (<<"Rich Text file (*.rtf)",
				"Text file (*.txt)">>,
				<<"*.rtf", "*.txt">>)
			Result.add_flag (ofn.Ofn_filemustexist)
		ensure
			result_not_void: Result /= Void
		end

	save_file_dialog: WEL_SAVE_FILE_DIALOG
			-- Dialog box to save a file.
		once
			create Result.make
			Result.set_default_extension ("txt")
			Result.set_filter (<<"Rich Text file (*.rtf)",
				"Text file (*.txt)">>,
				<<"*.rtf", "*.txt">>)
		ensure
			result_not_void: Result /= Void
		end

	print_dialog: WEL_PRINT_DIALOG
			-- Dialog box to select the printer.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	set_window_title
			-- Set the window's title with `file_name'.
		local
			s: STRING
		do
			s := Title.twin
			s.append (" - ")
			if {l_file_name: like file_name} file_name then
				s.append (l_file_name)
			else
				s.append ("Untitled")
			end
			set_text (s)
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL Rich edit";
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

