indexing
	description: "A basic editor for EiffelStudio"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR

inherit
	SELECTABLE_TEXT_PANEL
		undefine
			font,
			line_height,
			font_width
		redefine
			text_displayed, make,
			build_editor_area, handle_extended_key,
			handle_extended_ctrled_key,
			reset, clear_window,
			draw_cursor, on_line_removed, on_line_inserted,
			on_line_modified,
			on_block_removed,
			on_text_loaded,
			normal_background_color,
			quadruple_click_enabled,
			show_vertical_scrollbar,
			maximum_top_line_index,
			process_left_click,
			on_mouse_button_up,
			on_mouse_move,
			ignore_keyboard_input,
			lose_focus,
			set_first_line_displayed,
			scroll_only,
			set_offset,
			on_key_down
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_RECYCLABLE
		export
			{EB_RECYCLER} all
		end

	EB_SHARED_EDITOR_FONT
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	 make is
			-- Initialize the editor.
		do
			{SELECTABLE_TEXT_PANEL} Precursor

			if Editor_preferences.smart_identation then
				text_displayed.enable_smart_indentation
			else
				text_displayed.disable_smart_indentation
			end

				-- Set default mode
			overwrite_mode := False

			clipboard := ev_application.clipboard
		end

	build_editor_area is
			-- Initialize variables and objects related to display.
		do
			{SELECTABLE_TEXT_PANEL} Precursor
			editor_area.key_press_string_actions.extend (~on_char)
			editor_area.key_release_actions.extend (~on_key_up)
			basic_pointer := editor_area.pointer_style
		end

feature -- Access

	reference_window: EV_WINDOW is
			-- Window which error dialogs will be shown relative to.
		do
			if internal_reference_window = Void then
				Result := Window_manager.last_focused_window.window
			else
				Result := internal_reference_window
			end
		end

	not_editable_warning_message: STRING
			-- Warning message indicating text is not editable.
			-- If Void, default message will be used.

feature -- Content change

	load_eiffel_file (a_file_name: FILE_NAME) is
			-- Display class file named `a_file_name'.
		do
			text_displayed.load_as_eiffel_text
			load_file (a_file_name)
		end

	load_basic_file (a_file_name: FILE_NAME) is
			-- Display class text named `a_file_name'.
		do
			text_displayed.load_as_basic_text
			load_file (a_file_name)
		end

	reload is
			-- Reload the edited file from disk.
		do
			if file_name /= Void and then not file_name.is_empty then
				load_file (file_name)
			end
		end

	clear_window is
			-- Wipe out the text area.
		do
			disable_editable
			{SELECTABLE_TEXT_PANEL} Precursor
		end
		
	display_message (message: STRING) is
			-- Display `message' in the editor.
		do
			load_basic_text (message)
			disable_editable
		end

feature -- Text status report

	undo_is_possible: BOOLEAN is
			-- Is there any operation to undo?
		do
			Result := text_displayed.undo_is_possible
		end

	redo_is_possible: BOOLEAN is
			-- Is there any operation to redo?
		do
			Result := text_displayed.redo_is_possible
		end

	changed: BOOLEAN is
			-- Has the content of the editor changed since it was
			-- loaded or saved?
		do
			Result := text_displayed.changed
		end

	is_editable: BOOLEAN is
			-- Is the text editable?
		do
			Result := 	allow_edition and then
					not text_displayed.text_being_processed and then
					not open_backup
		end

	cursor_x_position: INTEGER is
			-- Current column number.
		require
			not_empty: not is_empty
		do
			Result := text_displayed.cursor.x_in_characters
		end

	cursor_y_position: INTEGER is
			-- Current line number (in the whole text).
		require
			not_empty: not is_empty
		do
			Result := text_displayed.cursor.y_in_lines
		end

feature -- Status setting

	enable_editable is
			-- Allow text edition.
		do
			allow_edition := True
		end

	disable_editable is
			-- Forbid text edition.
		do
			allow_edition := False
		end

	set_changed (val: BOOLEAN) is
			-- Assign `val' to `changed'.
		require
			text_exists: not is_empty
		do
			text_displayed.set_changed (val, True)
		end

feature -- Element Change

	set_reference_window (a_window: EV_WINDOW) is
			-- Set `a_window' as the window which error dialogs
			-- will be shown relative to
			-- if Void, `error_window' will be last focused development window.
		do
			internal_reference_window := a_window
		end

	set_not_editable_warning_message (message: STRING) is
			-- Assign `message' to `not_editable_warning_message'
		do
			not_editable_warning_message := message
		end

feature -- File access status report

	open_backup: BOOLEAN
			-- If a backup file is present, should it be opened or not?

	load_file_error: BOOLEAN
			-- Did an error occur during last file loading?

	is_unix_file: BOOLEAN
			-- is current file a unix file?
			-- (i.e. is "%N" line separator?)

	file_is_up_to_date: BOOLEAN is
			-- is the edited file up to date ?
		local
			file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				Result := True
				if file_name /= Void then
					create file.make (file_name)
					if file /= Void and then file.exists and then date_of_file_when_loaded /= 0 then
						Result := date_of_file_when_loaded = file.date
					end
				end
			else
				Result := True
			end
		rescue
			retried := True
			retry
		end

	file_date_already_checked: BOOLEAN is
			-- have we already checked the date ?
		local
			file: RAW_FILE
		do
			Result := True
			if file_name /= Void then
				create file.make (file_name)
				Result := file.date = date_when_checked
				date_when_checked := file.date
			end
		end

feature -- File properties

	file_name: FILE_NAME
			-- Name of the current edited file.

	date_when_checked: INTEGER
			-- date of the edited file when checked for the latest time

feature -- Indirect observer / manager pattern.

	add_selection_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for selection changes.
		do
			text_displayed.add_selection_observer (txt_observer)
		end

	add_edition_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for global content changes.
		do
			text_displayed.add_edition_observer (txt_observer)
		end
	
	add_cursor_observer (txt_observer: TEXT_OBSERVER) is
			-- Add observer of `text_displayed' for cursor position changes.
		do
			text_displayed.add_cursor_observer (txt_observer)
		end
	
	remove_observer (txt_observer: TEXT_OBSERVER) is
			-- Remove observer of `text_displayed'.
		do
			text_displayed.remove_observer (txt_observer)
		end

	add_history_observer (history_observer: EB_UNDO_REDO_OBSERVER) is
			-- Add observer of `history'.
		do
			text_displayed.history.add_observer (history_observer)
		end

	remove_history_observer (history_observer: EB_UNDO_REDO_OBSERVER) is
			-- Remove observer of `history'.
		do
			text_displayed.history.remove_observer (history_observer)
		end

feature -- Warning messages display

	show_warning_message (a_message: STRING) is
			-- show `a_message' in a dialog window
		require
			message_is_not_void: a_message /= Void
		local
			wd: EV_WARNING_DIALOG
		do
			create wd.make_with_text (a_message)
			wd.pointer_button_release_actions.force_extend (agent wd.destroy)
			wd.key_press_actions.force_extend (agent wd.destroy)
			wd.show_modal_to_window (reference_window)
		end

	display_not_editable_warning_message is
				-- display warning message : text is not editable...
		local
			wm: STRING
			w: EB_TEXT_LOADING_WARNING_DIALOG
		do
			if text_displayed /= Void then
				if open_backup then
					show_warning_message (Warning_messages.w_Backup_file_not_editable)
				elseif not allow_edition then
					if not_editable_warning_message = Void or else not_editable_warning_message.is_empty then
						wm := Warning_messages.w_Text_not_editable
					else
						wm := not_editable_warning_message
					end	
					show_warning_message (wm)
				else
					create w.make
					w.show_modal_to_window (reference_window)
				end
			end
		end	 

feature {NONE} -- Private Status

	allow_edition: BOOLEAN
			-- Can we edit the text if it is not the backup?

	overwrite_mode: BOOLEAN
			-- Do inserted characters overwrite existing ones?

feature {EB_COMMAND, EB_SEARCH_PERFORMER, EB_DEVELOPMENT_WINDOW}

	text_displayed: EDITABLE_TEXT
			-- Text displayed in the editor.

feature {NONE} -- Process Vision2 events

 	on_char (character_string: STRING) is
   			-- Process displayable character key press event.
   		local
   			c: CHARACTER
   		do
			if not ignore_keyboard_input then
				if not character_string.is_empty then
		   			c := character_string @ 1
					if not ((ctrled_key xor alt_key) or else unwanted_characters.has (c)) then
							-- Ignoring ctrled keys and other special keys (Esc, Tab, Enter, Backspace)
						handle_character (c)
					end
				end
			end
 		end

feature {NONE} -- Handle keystokes

 	handle_character (c: CHARACTER) is
 			-- Process push on a character key corresponding to `c'.
		local
			had_selection: BOOLEAN
 		do
			if is_editable then
				check_position (text_displayed.cursor)
				had_selection := text_displayed.has_selection
				if overwrite_mode then
					text_displayed.replace_char (c)
				else
					text_displayed.insert_char (c)
				end
				if had_selection then
					refresh_now
				else
					invalidate_cursor_rect (True)
				end
			else
				display_not_editable_warning_message
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			l_num: INTEGER
			scroll_to_cursor: BOOLEAN
		do
			scroll_to_cursor := True
			inspect
				ev_key.code
			when Key_x then
					-- Ctrl-X (cut)
				run_if_editable (~cut_selection)

			when Key_c then
					-- Ctrl-C (copy)
				copy_selection

			when Key_v then
					-- Ctrl-V (paste)
				run_if_editable (~paste)

			when Key_u then
					-- Ctrl-U
				run_if_editable (~set_selection_case(shifted_key))

				-- Undo / redo now use accelerator.
--			when Key_z then
--					-- Ctrl-Z (undo)
--				if undo_is_possible then
--					run_if_editable (~undo)
--				end
--
--			when Key_y then
--					-- Ctrl-Y (redo)
--				if redo_is_possible then
--					run_if_editable (~redo)
--				end
		
			when Key_a then
					-- Ctrl-A (select all)
				select_all
				scroll_to_cursor := False

			when Key_k then
				if shifted_key then
						-- Ctrl+Shift+K uncomment selection
					run_if_editable (~uncomment_selection)
				else
						-- Ctrl+K
					run_if_editable (~comment_selection)
				end

			when Key_insert then
					-- Ctrl  ins = Ctrl C
				copy_selection

			when Key_delete then
					-- delete action
				if is_editable then
					l_num := number_of_lines
					text_displayed.delete_word (False)
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position
				else
					display_not_editable_warning_message
				end

			when Key_back_space then
					-- delete action
				if is_editable then
					l_num := number_of_lines
					text_displayed.delete_word (True)
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position
				else
					display_not_editable_warning_message
				end
			else
				Precursor (ev_key)
			end
			if not meta_key_codes.has (ev_key.code) and then scroll_to_cursor then
				check_cursor_position
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			l_num: INTEGER
		do
			inspect
				ev_key.code

			when Key_delete then
				if is_editable then
					if Shifted_key then
						cut_selection
					else
							-- Delete key action
						l_num := number_of_lines
						text_displayed.delete_char
						if l_num /= number_of_lines then
							refresh_now
						else
							invalidate_cursor_rect (True)
						end
						check_cursor_position
					end
				else
					display_not_editable_warning_message
				end

			when Key_back_space then
					-- Backspace key action
				if is_editable then
					l_num := number_of_lines
					text_displayed.back_delete_char
					if l_num = number_of_lines then
						invalidate_cursor_rect (True)
					else
						refresh_now
					end
					check_cursor_position
				else
					display_not_editable_warning_message
				end

			when Key_enter then
					-- Return/Enter key action
				if is_editable then
					text_displayed.insert_eol
					refresh_now
					check_cursor_position
				else
					display_not_editable_warning_message
				end

			when Key_insert then
				if Shifted_key and then is_editable then
					paste
				else
					if is_editable then
							-- Insert key action
						overwrite_mode := not overwrite_mode
						invalidate_cursor_rect (True)
					else
						display_not_editable_warning_message
					end
				end

			when Key_tab then
				if is_editable then
						-- Tab key action
					if shifted_key then
							-- Shift + Tab = Unindent selection
						unindent_selection
					elseif has_selection and then text_displayed.selected_string.has ('%N') then
							-- Tab = indent selection
						indent_selection
					else
							-- normal behavior --> we insert a %T character
						handle_character ('%T')
					end
				else
					display_not_editable_warning_message
				end
			else
				Precursor (ev_key)
			end
		end

feature {EDITOR_CURSOR} -- Handle text modifications

	on_line_modified (line_number: INTEGER) is
			-- Update `Current' when line number `line_number' has been modified.
		local
			wdth: INTEGER 
		do
			wdth := text_displayed.line (line_number).width + left_margin_width + 50
			if editor_width < wdth then
				set_editor_width (wdth)
			end
		end

	on_line_removed (line_number: INTEGER) is
			-- Update `Current' when line number `line_number' has been removed.
		do
			if not text_displayed.is_removing_block then
				set_first_line_displayed (first_line_displayed.min (maximum_top_line_index), True)
				update_vertical_scrollbar
			end
		end
		
	on_block_removed is
			-- Update current when a block of text has been removed
		do
			set_first_line_displayed (first_line_displayed.min (maximum_top_line_index), True)
			update_vertical_scrollbar
		end
		
	on_line_inserted (line_number: INTEGER) is
			-- Update `Current' when line number `line_number' has been inserted.
		do
			update_vertical_scrollbar
		end

feature {EB_COMMAND, EB_SEARCH_PERFORMER, EB_DEVELOPMENT_WINDOW} -- Edition Operations on text

	cut_selection is
			-- Copy current selection to clipboard and remove it.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			if has_selection then
				if not text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
					copy_selection
					text_displayed.delete_selection
					refresh_now
				end
			end
		end

	copy_selection is
			-- Copy current selection to clipboard.
		require
			text_is_not_empty: number_of_lines /= 0
		local
			copied_text: STRING
		do
			if has_selection then
				if not text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
					copied_text := text_displayed.selected_string
					if not copied_text.is_empty then
						clipboard.set_text (copied_text)
					end
				end
			end
		end

	paste is
			-- Paste clipboard at cursor position.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			if clipboard.text /= Void and then not clipboard.text.is_empty then
				text_displayed.insert_string (clipboard.text)
				refresh_now
			end
		end

	set_selection_case (lower: BOOLEAN) is
		do
			if not text_displayed.is_empty then
				text_displayed.set_selection_case (lower)
				refresh_now
			end
		end

	undo is
			-- Undo last command.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
			undo_possible: text_displayed.undo_is_possible
		do
			text_displayed.undo
			check_cursor_position
			refresh_now
		end
	
	redo is
			-- Redo last command.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
			redo_possible: text_displayed.redo_is_possible
		do
			text_displayed.redo
			check_cursor_position
			refresh_now
		end


	comment_selection is
			-- Comment selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.comment_selection
			refresh_now
		end

	uncomment_selection is
			-- Uncomment selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.uncomment_selection
			refresh_now
		end

	indent_selection is
			-- Indent selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.indent_selection
			refresh_now
		end

	unindent_selection is
			-- Unindent selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.unindent_selection
			refresh_now
		end

	run_if_editable (command: PROCEDURE[like Current, TUPLE]) is
			-- Apply `command' if the current text is editable.
			-- Otherwise, display a message which warns the user
			-- that the text cannot be modified.
		do
			if is_editable then
				command.apply
			else
				display_not_editable_warning_message
			end
		end

	replace_selection (word: STRING) is
			-- Replace currently selected text with `word'.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.replace_selection (word)
			refresh
		end

feature {NONE} -- Mouse copy cut

	process_left_click (x_pos, y_pos: INTEGER; a_screen_x, a_screen_y: INTEGER) is
		do
			if is_editable and then position_is_in_selection (x_pos, y_pos, False) and then click_count = 0 then
				if not editor_area.has_capture then
					editor_area.enable_capture
				end			
				former_y := y_pos
				former_mouse_y := a_screen_y
				mouse_copy_cut := True
				mouse_left_button_down := True
				if ctrled_key then
					editor_area.set_pointer_style (Cursors.Cur_copy_selection)
				else
					editor_area.set_pointer_style (Cursors.Cur_cut_selection)
				end
			else
				mouse_copy_cut := False
				Precursor (x_pos, y_pos, a_screen_x, a_screen_y)
			end
		end

	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER) is
		local
			cur: TEXT_CURSOR
			perform_changes: BOOLEAN
			x_cur, y_cur: INTEGER
		do
			if mouse_copy_cut then
				if button = 1 then
					mouse_copy_cut := False
					editor_area.set_pointer_style (basic_pointer)
					x_cur := x_pos + offset - left_margin_width
					x_cur := x_cur.max (1)
					perform_changes := 
						is_in_editor_panel (a_screen_x, a_screen_y)
							and then
						not position_is_in_selection (x_cur, y_pos, True)
					if perform_changes then
						create cur.make_from_integer (1, text_displayed)
						position_cursor (cur, x_cur, y_pos)
						if ctrled_key then
							text_displayed.copy_selection_to_pos (cur.pos_in_text)
						else
							text_displayed.move_selection_to_pos (cur.pos_in_text)
						end
						refresh_now
					else
						disable_selection
						y_cur := text_displayed.current_line_number
						position_cursor (text_displayed.cursor, x_cur, y_pos)
						invalidate_line (y_cur, True)
					end
				elseif button = 3 then
					cancel_mouse_copy_cut
				end
			end
			if button = 1 then
				forget_mouse_moves := False
			end
			Precursor (x_pos, y_pos, button, unused1,unused2,unused3, a_screen_x, a_screen_y)
		end

	on_mouse_move (abs_x_pos, abs_y_pos: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER) is
		local
			x_cur, y_cur: INTEGER
			tok: EDITOR_TOKEN
			copy_cut_cursor: TEXT_CURSOR		
		do
			if mouse_left_button_down and then mouse_copy_cut then
				x_cur := (a_screen_x - editor_x + offset - left_margin_width).min (editor_width).max (1)
				y_cur := (a_screen_y - editor_y).min (editor_area.height).max (1)
				create copy_cut_cursor.make_from_integer (1, text_displayed)
				position_cursor (copy_cut_cursor, x_cur, y_cur)
				Precursor (abs_x_pos, abs_y_pos, unused1,unused2,unused3, a_screen_x, a_screen_y)
				if not cursor_is_in_selection (copy_cut_cursor) then
					tok := copy_cut_cursor.token
					x_cur := tok.position + tok.get_substring_width (copy_cut_cursor.pos_in_token - 1) +left_margin_width
					y_cur := copy_cut_cursor.y_in_lines
					if prev_x_cur /= x_cur or else prev_y_cur /= y_cur then
						if prev_x_cur /= 0 or else prev_y_cur /= 0 then
							if position_is_displayed (prev_x_cur, prev_y_cur) then
								wipe_cursor_out
							end
							prev_x_cur := 0
							prev_y_cur := 0
						end
						if position_is_displayed (x_cur, y_cur) then
							prev_x_cur := x_cur
							prev_y_cur := y_cur
							draw_cursor (editor_area, x_cur - offset, (y_cur - first_line_displayed) * line_height, cursor_width, line_height, False)
						end
					end
				elseif prev_x_cur /= 0 or else prev_y_cur /= 0 then
					if position_is_displayed (prev_x_cur, prev_y_cur) then
						wipe_cursor_out
					end
					prev_x_cur := 0
					prev_y_cur := 0				
				end
			elseif not forget_mouse_moves then
				Precursor (abs_x_pos, abs_y_pos, unused1,unused2,unused3, a_screen_x, a_screen_y)
			end
		end
	
	cancel_mouse_copy_cut is
			-- stop mouse copy/cut.
		do
			mouse_copy_cut := False
			editor_area.set_pointer_style (basic_pointer)
			forget_mouse_moves := True
			if autoscroll.interval /= 0 then
				autoscroll.set_interval (0)
			end
			check_cursor_position
			wipe_cursor_out
		end

	lose_focus is
			-- Update when focus is lost.
		do
			Precursor
			if mouse_copy_cut then
				editor_area.disable_capture
				mouse_left_button_down := False
			end
		end		
		
	ignore_keyboard_input: BOOLEAN is
			-- Should key event be ignored?
		do
			Result := Precursor or else mouse_copy_cut
		end

	is_in_editor_panel (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Is point at absolute coordinates (`a_screen_x', `a_screeny') in
			-- the editor?
		do
			Result := 
						a_screen_x > editor_x
							and then
						a_screen_x < editor_x + editor_area.width
							and then
						a_screen_y > editor_y
							and then
						a_screen_y < editor_y + editor_area.height
		end

	basic_pointer: EV_CURSOR
			-- Normal shape of the mouse pointer.

	mouse_copy_cut: BOOLEAN
			-- Is the user trying to copy/paste with the mouse?

	prev_x_cur: INTEGER
			-- Coordinate where the copy/paste cursor was last drawn.

	prev_y_cur: INTEGER
			-- Coordinate where the copy/paste cursor was last drawn.

	forget_mouse_moves: BOOLEAN
			-- Should mouse pointer moves be ignored?

	set_first_line_displayed (fld: INTEGER; refresh_if_necessary: BOOLEAN) is
		do
			if prev_x_cur /= 0 or else prev_y_cur /= 0 then
				if position_is_displayed (prev_x_cur, prev_y_cur) and then prev_y_cur < first_line_displayed + number_of_lines_displayed then
					wipe_cursor_out
				end
				prev_x_cur := 0
				prev_y_cur := 0
			end
			Precursor (fld, refresh_if_necessary)
		end

	set_offset (an_offset: INTEGER) is
			-- 
		do
			if prev_x_cur /= 0 or else prev_y_cur /= 0 then
				if position_is_displayed (prev_x_cur, prev_y_cur) and then prev_y_cur < first_line_displayed + number_of_lines_displayed then
					wipe_cursor_out
				end
				prev_x_cur := 0
				prev_y_cur := 0
			end
			Precursor (an_offset)
		end
		
	wipe_cursor_out is
			-- Wipe copy cut cursor out from then editor.
		local
			zone: EV_RECTANGLE
			x_p, y_p: INTEGER
		do
			y_p := (prev_y_cur - first_line_displayed) * line_height
			if y_p >= 0 and then y_p < editor_area.height then
					-- wipe the cursor out if it is at a position that is still on screen.
				x_p := prev_x_cur - offset
				create zone.make (x_p - left_margin_width + offset, y_p, cursor_width, line_height) --x_p + cursor_width - left_margin_width, y_p + line_height)
				editor_area.draw_sub_pixmap (x_p, y_p, buffered_screen, zone)
				editor_area.flush
			end
		end
		
	on_key_down (ev_key: EV_KEY)is
		do
			if mouse_copy_cut and then ev_key /= Void then
				if ev_key.code = Key_Ctrl then
					editor_area.set_pointer_style (Cursors.Cur_copy_selection)
				elseif ev_key.code = Key_escape then
					cancel_mouse_copy_cut
				end
			end
			Precursor (ev_key)
		end

	on_key_up (ev_key: EV_KEY)is
		do
			if mouse_copy_cut and then ev_key /= Void and then ev_key.code = Key_Ctrl then
					editor_area.set_pointer_style (Cursors.Cur_cut_selection)
			end
		end		

	scroll_only: BOOLEAN is
		do
			Result := mouse_copy_cut
		end

	position_is_displayed (x_pos, y_pos: INTEGER): BOOLEAN is
			-- Is point with coordinates `x_pos', `y_pos' visible?
		do
			Result := 
					x_pos > offset
						and then
					x_pos < editor_width + offset
						and then
					y_pos >= first_line_displayed
						and then
					y_pos <= first_line_displayed + number_of_lines_displayed
		end

	position_is_in_selection (x_pos, y_pos: INTEGER; include_selection_end: BOOLEAN): BOOLEAN is
			-- Is point with coordinates `x_pos', `y_pos' in the selection?
		local
			cur: TEXT_CURSOR
		do
			create cur.make_from_integer (1, text_displayed)
			position_cursor (cur, x_pos, y_pos)
			Result := cursor_is_in_selection (cur)
--			if include_selection_end then
--				Result := Result or else cur.is_equal (text_displayed.selection_end)
--			end
		end

	cursor_is_in_selection (cur: TEXT_CURSOR): BOOLEAN is
			-- Is `cursor' in the selection?
		require
			cursor_is_not_void: cur /= Void
		do
			Result := has_selection and then (cur >= text_displayed.selection_start and then cur < text_displayed.selection_end)
		end
		
feature {NONE} -- Text Loading

	load_file (a_file_name: FILE_NAME) is
			-- Load file named `a_file_name' in the editor.
		local
			test_file, test_file_2: RAW_FILE
		do
				-- Reset the editor state
			reset

			load_file_error := False
			create file_name.make_from_string (a_file_name)
			create test_file.make (a_file_name)
			file_name.add_extension ("swp")
			create test_file_2.make (file_name)
			if 	test_file_2.exists 
					and then
				test_file_2.is_readable
					and then
				((not test_file.exists) or else test_file.date < test_file_2.date)
			then
				ask_if_opens_backup
				if not open_backup then
					test_file_2.delete
					file_name := a_file_name
				end
				load_chosen_file
			else
				file_name := a_file_name
				create test_file.make (file_name)
				if test_file.exists and then test_file.is_readable then
					load_chosen_file
				else
					load_file_error := True
				end
			end
		end

	load_chosen_file is
			-- Load file named `file_name' in the editor.
		local
			retried: BOOLEAN
			text_to_load: STRING
			fl: RAW_FILE
		do
			if retried then
				load_file_error := True
			else
				editor_area.disable_sensitive

					-- read the file
				create fl.make_open_read (file_name)
				date_of_file_when_loaded := fl.date
				fl.read_stream (fl.count)
				text_to_load := fl.last_string
				fl.close

				is_unix_file := text_to_load.substring_index ("%R%N", 1) = 0
				if not is_unix_file then
					text_to_load.replace_substring_all ("%R%N", "%N")
				end

				file_loading_setup

					-- Read and parse the file.
				text_displayed.set_first_read_block_size (number_of_lines_displayed)
				text_displayed.load_string (text_to_load)
	
					-- Setup the editor (scrollbar, ...)
				setup_editor
				editor_area.enable_sensitive

			end
		rescue
			retried := True
			retry
		end

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
			{SELECTABLE_TEXT_PANEL} Precursor		
			date_of_file_when_loaded := 0
			open_backup := False
			file_name := Void
		end

	on_text_loaded is
			-- Finish editor setup as the entire text has been loaded.
		do
			{SELECTABLE_TEXT_PANEL} Precursor
			if open_backup then
				text_observer_manager.set_changed (True, True)
			end
		end

feature {NONE} -- retrieving backup

	ask_if_opens_backup is
			-- Display a dialog asking the user whether he wants to open
			-- the original file or the backup one, and set `open_backup' accordingly.
		local
			dial: EV_WARNING_DIALOG
		do
			create dial.make_with_text (Warning_messages.w_Found_backup)
			dial.set_buttons_and_actions (<<	Interface_names.b_Open_backup, Interface_names.b_Open_original>>, <<~open_backup_selected, ~open_normal_selected>>)
			dial.set_default_push_button (dial.button (Interface_names.b_Open_backup))
			dial.set_default_cancel_button (dial.button (Interface_names.b_Open_original))
			dial.set_title (Interface_names.t_Open_backup)
			dial.show_modal_to_window (reference_window)
		end

	open_normal_selected is
			-- The open normal button was pushed.
		do
			open_backup := False
		end

	open_backup_selected is
			-- The open backup button was pushed.
		do
			open_backup := True
		end

feature {NONE} -- Implementation

	maximum_top_line_index: INTEGER is
			-- Number of the last possible line that can be displayed
			-- at the top of the editor window.
		do
			if allow_edition then
				Result := (text_displayed.number_of_lines - (number_of_lines_displayed // 2)).max (1)
			else
				Result := {SELECTABLE_TEXT_PANEL} Precursor
			end
		end

	show_vertical_scrollbar: BOOLEAN is
			-- Is it necessary to show the vertical scroll bar ?
		do
			if allow_edition then
				Result := text_displayed /= Void and then (number_of_lines_displayed < 2 * (text_displayed.number_of_lines - 1))
			else
				Result := {SELECTABLE_TEXT_PANEL} Precursor
			end
		end 

	file_loading_setup is
			-- Setup the editor just before file loading begins.
		do
		end

	normal_background_color: EV_COLOR is
			-- Default color for editor background.
		do
			Result := Editor_preferences.normal_background_color
		end

	quadruple_click_enabled: BOOLEAN is
			-- Should a quadruple click result in the selection of the entire text?
		do
			Result := Editor_preferences.quadruple_click_enabled
		end

	date_of_file_when_loaded: INTEGER
			-- Date of currently edited file when it was loaded

	internal_reference_window: EV_WINDOW
			-- Window which dialogs will be shown relative to.

	draw_cursor (media: EV_DRAWABLE; x, y, character_width, ln_height: INTEGER; in_black: BOOLEAN) is
			-- Draw the cursor bloc on `media'
		do
				if overwrite_mode then
					Precursor (media, x, y, character_width, ln_height, in_black)
				else
					Precursor (media, x, y, cursor_width, ln_height, in_black)
				end
		end

feature {EB_DEVELOPMENT_WINDOW} -- Clipboard

	clipboard: EV_CLIPBOARD
			-- Clipboard.

feature {NONE} -- Private Constants

	unwanted_characters: ARRAY [CHARACTER] is
			-- Unwanted characters: backspace, tabulation, carriage return and escape. 
		once
			Result := <<'%/8/','%/9/','%/13/','%/27/'>>
		end

	meta_key_codes: ARRAY [INTEGER] is
			-- Codes of meta keys. 
		once
			Result := <<Key_ctrl, Key_caps_lock, Key_right_meta, Key_left_meta, Key_scroll_lock, Key_num_lock, Key_shift>>
		end

end -- class EDITOR
