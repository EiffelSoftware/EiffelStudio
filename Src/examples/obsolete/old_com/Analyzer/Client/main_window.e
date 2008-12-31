note
	description: "Analyzer client main window"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_control_id_command,
			on_size,
			on_destroy,
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

	EOLE_COM
		rename
			make as co_make
		export
			{NONE} all
		end
		
	EOLE_ERROR_CODE
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Automation and client window.
		local
			bitmap_index1, bitmap_index2: INTEGER
		do
			if co_initialize = S_ok then
				create analyzer
				analyzer.initialize (Clsctx_local_server)
				analyzer.show
				make_top (Title)
				set_menu (main_menu)
				resize (350, 400)
				set_x (0)
				set_y (100)

				-- Create a rich edit control
				create rich_edit.make (Current, "", 0, 28, 200, 200, -1)

				-- Create a toolbar and buttons
				create tool_bar.make (Current, -1)

				create tool_bar_bitmap.make (Bmp_toolbar)
				create standard_tool_bar_bitmap.make_by_predefined_id (Idb_std_small_color)

				tool_bar.add_bitmaps (standard_tool_bar_bitmap, 1)
				bitmap_index1 := tool_bar.last_bitmap_index

				tool_bar.add_bitmaps (tool_bar_bitmap, 1)
				bitmap_index2 := tool_bar.last_bitmap_index

				create tool_bar_button1.make_button (bitmap_index1 + Std_filenew, Cmd_new)
				create tool_bar_button2.make_button (bitmap_index1 + Std_fileopen, Cmd_open)
				create tool_bar_button3.make_button (bitmap_index1 + Std_filesave, Cmd_save)
				create tool_bar_button4.make_separator
				create tool_bar_button5.make_button (bitmap_index1 + Std_print, Cmd_print)
				create tool_bar_button6.make_separator
				create tool_bar_button7.make_check (bitmap_index2 + 0, Cmd_bold)
				create tool_bar_button8.make_check (bitmap_index2 + 1, Cmd_italic)
				create tool_bar_button9.make_check (bitmap_index2 + 2, Cmd_underline)
				create tool_bar_button10.make_separator
				create tool_bar_button11.make_button (bitmap_index2 + 3, Cmd_font)
				create tool_bar_button12.make_button (bitmap_index2 + 4, Cmd_color)
				create tool_bar_button13.make_separator
				create tool_bar_button14.make_check_group (bitmap_index2 + 5, Cmd_left)
				create tool_bar_button15.make_check_group (bitmap_index2 + 6, Cmd_center)
				create tool_bar_button16.make_check_group (bitmap_index2 + 7, Cmd_right)
				create tool_bar_button17.make_separator
				create tool_bar_button18.make_check (bitmap_index2 + 8, Cmd_bullet)

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
					tool_bar_button12,
					tool_bar_button13,
					tool_bar_button14,
					tool_bar_button15,
					tool_bar_button16,
					tool_bar_button17,
					tool_bar_button18>>)
				on_menu_command (Cmd_new)
			end
		end

feature -- Access

	analyzer: ANALYZER_CLIENT
			-- Automation analyzer
			
	file_name: STRING
			-- File name of the active document

	tool_bar: WEL_TOOL_BAR
			-- Window's tool bar

	tool_bar_bitmap, 
	standard_tool_bar_bitmap: WEL_TOOL_BAR_BITMAP
			-- Tool bar Bitmaps

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
	tool_bar_button12,
	tool_bar_button13,
	tool_bar_button14,
	tool_bar_button15,
	tool_bar_button16,
	tool_bar_button17,
	tool_bar_button18: WEL_TOOL_BAR_BUTTON
			-- Tool bar buttons

	rich_edit: WEL_RICH_EDIT
			-- Rich edit control

	char_format: WEL_CHARACTER_FORMAT
			-- Structure to format characters

	para_format: WEL_PARAGRAPH_FORMAT
			-- Structure to format paragraphs
			
feature {NONE} -- Implementation

	enter_text: STRING
			-- Text entered by user
		local
			dialog: TEXT_DIALOG
		do
			create dialog.make (Current)
			dialog.activate
			Result := dialog.user_text
		end
		
	default_process_message (msg, wparam, lparam: INTEGER)
			-- Draw the tooltips.
		local
			tt: WEL_TOOLTIP_TEXT
		do
			if msg = Wm_notify then
				create tt.make_by_pointer (cwel_integer_to_pointer (lparam))
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
			msg: WEL_MSG_BOX
			txt, entered_text: STRING
		do
			inspect
				menu_id
			when Cmd_exit then
				on_destroy
				destroy
			when Cmd_new then
				rich_edit.clear
				file_name := Void
				set_window_title
				create char_format.make
				char_format.set_face_name ("Arial")
				char_format.set_height (10 * 20)
				char_format.unset_bold
				rich_edit.set_character_format_selection (char_format)
			when Cmd_open then
				open_file_dialog.activate (Current)
				if open_file_dialog.selected then
					file_name := clone (open_file_dialog.file_name)
					create file.make_open_read (file_name)
					if file_name.substring_index ("txt", 1) > 0 then
						rich_edit.load_text_file (file)
					else
						rich_edit.load_rtf_file (file)
					end
					set_window_title
					rich_edit.set_text_limit ((rich_edit.text_length * 2).max (32000))
				end
			when Cmd_save then
				if file_name /= Void then
					create file.make_create_read_write (file_name)
					if file_name.substring_index ("txt", 1) > 0 then
						rich_edit.save_text_file (file)
					else
						rich_edit.save_rtf_file (file)
					end
				else
					on_menu_command (Cmd_save_as)
				end
			when Cmd_save_as then
				save_file_dialog.activate (Current)
				if save_file_dialog.selected then
					file_name := save_file_dialog.file_name
					set_window_title
					create file.make_create_read_write (file_name)
					if file_name.substring_index ("txt", 1) > 0 then
						rich_edit.save_text_file (file)
					else
						rich_edit.save_rtf_file (file)
					end
				end
			when Cmd_print then
				print_dialog.activate (Current)
				if print_dialog.selected then
					rich_edit.print_all (print_dialog.dc, file_name)
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
			when Cmd_underline then
				create char_format.make
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
					create char_format.make
					char_format.set_face_name (choose_font.log_font.face_name)
					char_format.set_height (choose_font.log_font.height * -20)
					char_format.set_char_set (choose_font.log_font.char_set)
					char_format.set_pitch_and_family (choose_font.log_font.pitch_and_family)
					rich_edit.set_character_format_selection (char_format)
				end
			when Cmd_color then
				choose_color.activate (Current)
				if choose_color.selected then
					create char_format.make
					char_format.set_text_color (choose_color.rgb_result)
					rich_edit.set_character_format_selection (char_format)
				end
			when Cmd_left then
				create para_format.make
				para_format.set_left_alignment
				rich_edit.set_paragraph_format (para_format)
			when Cmd_center then
				create para_format.make
				para_format.set_center_alignment
				rich_edit.set_paragraph_format (para_format)
			when Cmd_right then
				create para_format.make
				para_format.set_right_alignment
				rich_edit.set_paragraph_format (para_format)
			when Cmd_bullet then
				create para_format.make
				if tool_bar.button_checked (Cmd_bullet) then
					para_format.bullet_numbering
				else
					para_format.no_numbering
				end
				rich_edit.set_paragraph_format (para_format)
			when Cmd_word_count then
				if rich_edit.modified then
					analyzer.set_text (rich_edit.text)
				end
				create txt.make (40)
				create msg.make
				txt.append ("Word count: ")
				txt.append_integer (analyzer.word_count)
				msg.information_message_box (Current, txt, "Analyzer")
			when Cmd_line_count then
				if rich_edit.modified then
					analyzer.set_text (rich_edit.text)
				end
				create txt.make (40)
				create msg.make
				txt.append ("Line count: ")
				txt.append_integer (analyzer.line_count)
				msg.information_message_box (Current, txt, "Analyzer")
			when Cmd_sentence_count then
				if rich_edit.modified then
					analyzer.set_text (rich_edit.text)
				end
				create txt.make (40)
				create msg.make
				txt.append ("Sentence count: ")
				txt.append_integer (analyzer.sentence_count)
				msg.information_message_box (Current, txt, "Analyzer")
			when Cmd_occurrences then
				if rich_edit.modified then
					analyzer.set_text (rich_edit.text)
				end
				create txt.make (100)
				create msg.make
				entered_text := enter_text
				txt.append ("Number of occurrences of ")
				txt.append (entered_text)
				txt.append (": ")
				txt.append_integer (analyzer.occurrences (entered_text))
				msg.information_message_box (Current, txt, "Analyzer")				
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
			if tool_bar /= Void then
				tool_bar.reposition
			end
			if rich_edit /= Void then
				rich_edit.resize (a_width, a_height - 28)
			end
		end
		
	on_destroy
			-- End server first.
		do
			analyzer.terminate_server
			analyzer.terminate
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
			s := clone (Title)
			s.append (" - ")
			if file_name /= Void then
				s.append (file_name)
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

	Title: STRING = "Analyzer Client";
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

