class
	CHILD_WINDOW

inherit
	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make
		redefine
			on_paint, on_size, class_icon, default_style,
			on_vertical_scroll, on_key_down, on_key_up,
			on_char, on_left_button_down, on_left_button_up,
			on_mouse_move, on_erase_background, class_background
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EDITOR_PREFERENCES

creation
	make

feature -- Initialization

	initialize is
			-- Perform all static initialisations.
		local
			dc			: WEL_MEMORY_DC
			space_size	: WEL_SIZE
		do
			if not initialized then
					-- Initialisation done.
				initialized := True

					-- Compute Font related constants
				create dc.make
				dc.select_font (font)
				space_size := dc.string_size (" ")
				line_height := space_size.height
				line_increment := line_height
				dc.unselect_font

					-- First display the first line...
				first_line_displayed := 1
			end
		end

	class_background: WEL_BRUSH is
			-- Set the class background to NULL in order
			-- to have full control on the WM_ERASEBKG event
			-- (on_erase_background)
		once
			create Result.make_by_pointer(Default_pointer)
		end

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: STRING) is
		do
				-- Create the window.
			mdi_child_window_make (a_parent, a_name)

				-- Retrieve user preferences (syntax highligting, tabulation width, ...).
			editor_preferences.set_tabulation_spaces(4)
			editor_preferences.show_invisible_symbols

				-- Read and parse the file.
			read_and_analyse_file (a_name)

				-- Load the font & Compute Font related constants.
			Initialize
			number_of_lines_displayed := height // line_increment

				-- Setup the scroll bars.
			set_vertical_range (1, vertical_range_max)

				-- Initialize history
			create history.make (Current)

				-- Initialize the cursor
			create cursor.make_from_absolute_pos (0, 1, Current)

				--| this is just for selection_start not to be Void.
			selection_start := cursor
				-- Get the focus
			set_focus
		end

	read_and_analyse_file (a_name: STRING) is
			-- Read the file named `a_name' and perform a lexical analysis
		local
			file: PLAIN_TEXT_FILE
			line_item: EDITOR_LINE
			curr_string: STRING
			fake_text: EDITOR_TOKEN_TEXT
			fake_list: EDITOR_LINE
		do
				-- read the file
			create file.make_open_read (a_name)
			create text_displayed.make
			
			from
				file.start
			until
				file.after
			loop
				file.read_line
				curr_string := clone (file.last_string)
				text_displayed.lexer.execute (curr_string)
				create line_item.make_from_lexer (text_displayed.lexer)
				text_displayed.extend (line_item)
			end
		end

feature -- Access

	insert_mode: BOOLEAN
			-- Are we in insert mode?

	first_line_displayed: INTEGER
			-- First line currently displayed on the screen.

	number_of_lines_displayed: INTEGER
			-- Number of lines currently displayed on the screen.

	text_displayed: STRUCTURED_TEXT
			-- text currently displayed on the screen.

	cursor: TEXT_CURSOR
			-- Current cursor.

	history: UNDO_REDO_STACK
			-- List of undo and redo commands

	has_selection: BOOLEAN
			-- Is there a selection ?

feature -- Selection

	set_selection_start (c: TEXT_CURSOR) is
			-- Set the selection to be from `c' to `cursor'.
			-- Allows empty selections. Be careful about this.
		do
			has_selection := True
			selection_start := clone (c)
		end

	forget_selection is
			-- Unselect all.
		do
			has_selection := False
		end

feature -- Process Windows Messages

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw the screen.
		do
			update_buffered_screen (paint_dc, invalid_rect.top, invalid_rect.bottom)
		end

   	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
   			-- Process Wm_erasebkgnd message.
   			-- `invalid_rect' defines the invalid rectangle of the client area that
   			-- needs to be repainted.
   		do
   			-- do nothing.
			disable_default_processing
 			set_message_return_value (1)
   		end


	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- The size of the screen has changed (this feature can be
			-- called before the creation of the window)
		do
			Initialize

				-- Recompute the number of displayed lines.
			number_of_lines_displayed := height // line_increment

				-- Setup the scroll bars.
			set_vertical_range (1, vertical_range_max)

				-- Compute the first line to be displayed [ = max (0, min (vpos, vmax)) ]
			first_line_displayed := (first_line_displayed.min (vertical_range_max)).max (1)
			set_vertical_position (first_line_displayed)
		end

	on_vertical_scroll (scroll_code, position: INTEGER) is
			-- Vertical scroll is received with a
			-- `scroll_code' type. See class WEL_SB_CONSTANTS for
			-- `scroll_code' values. `position' is the new
			-- scrollbox position.
		local
			vscroll_pos: INTEGER
			vscroll_inc: INTEGER
		do
			vscroll_pos := first_line_displayed

			if scroll_code = Sb_lineup then
				vscroll_pos := vscroll_pos - 1

			elseif scroll_code = Sb_linedown then
				vscroll_pos := vscroll_pos + 1

			elseif scroll_code = Sb_pageup then
				vscroll_pos := vscroll_pos - number_of_lines_displayed
		
			elseif scroll_code = Sb_pagedown then
				vscroll_pos := vscroll_pos + number_of_lines_displayed
		
			elseif scroll_code = Sb_thumbposition then
				vscroll_pos := position
			else
				-- Do nothing.
			end

				-- Compute the first line to be displayed [ = max (0, min (vpos, vmax)) ]
			vscroll_inc := (vscroll_pos.min (vertical_range_max)).max (1) - first_line_displayed
			first_line_displayed := first_line_displayed + vscroll_inc

				-- Update the screen (if needed).
			if vscroll_inc /= 0 then

					-- Setup the new vertical position.
				scroll (0, -line_increment * vscroll_inc)
				set_vertical_position (first_line_displayed)

					-- Ask window to repaint our window.
				update
			end
		end

	on_key_down (virtual_key: INTEGER; key_data: INTEGER) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if ctrled_key then
				handle_extended_ctrled_key(virtual_key, key_data)
			else
				handle_extended_key(virtual_key, key_data)
			end

				-- Handle state key.			
			if virtual_key = Vk_Shift then
					-- Shift key action
				shifted_key := True

			elseif virtual_key = Vk_Control then
					-- Ctrl key action
				ctrled_key := True
			else
				-- Key not handled, do nothing
			end
		end

	on_key_up (virtual_key: INTEGER; key_data: INTEGER) is
			-- Process Wm_keyup message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if virtual_key = Vk_Shift then
					-- Notice that all shift key are released.
				shifted_key := False

			elseif virtual_key = Vk_control then
					-- Ctrl key action
				ctrled_key := False
			end
		end

 	on_char (character_code, key_data: INTEGER) is
   			-- Process Wm_char message
   			-- See class WEL_VK_CONSTANTS for `character_code' value.
   		do
			if (character_code >= 32) then
					-- Ignoring special characters
				handle_character(character_code.ascii_char)
			end
 		end

	on_left_button_down (mouse_key, x_pos, y_pos: INTEGER) is
			-- Process the left button of the mouse (when pushed)
		local
			l_number: INTEGER
			old_cursor: TEXT_CURSOR
			xline : EDITOR_LINE
		do
				-- Change the state of our flag.
			mouse_left_button_down := True
			
			if shifted_key and then (not has_selection) then
					-- No selection? We have to start one.
				has_selection := True
				selection_start := clone (cursor)
			end

				-- Compute the line number pointed by the mouse cursor
				-- and asdjust it if its over the number of lines in the text.
			l_number := (y_pos // line_increment) + first_line_displayed
			if l_number > number_of_lines then
				xline := text_displayed.last_line
				cursor.make_from_relative_pos (xline, xline.eol_token, 1, Current)
			else
				cursor.make_from_absolute_pos (x_pos, l_number, Current)
			end

			if has_selection then
					-- Look if we have preform a deselection.
				if not shifted_key or else cursor.is_equal (selection_start) then
						-- The selection has to be forgotten.
					has_selection := False
				end
			else
				-- There is no selection, so we don't need to do anything.
			end

				-- Record move in history.
			history.record_move
			invalidate
			update
		end

	on_mouse_move (mouse_key, x_pos, y_pos: INTEGER) is
			-- Wm_mousemove message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			l_number	: INTEGER
			xline		: EDITOR_LINE
		do
			if mouse_left_button_down then

					-- Save cursor position.
				if not has_selection then
						-- There is no selection, so we start a selection.
					has_selection := True
					selection_start := clone (cursor)
				end

					-- Compute the line number pointed by the mouse cursor
					-- and asdjust it if its over the number of lines in the text.
				l_number := (y_pos // line_increment) + first_line_displayed
				if l_number > number_of_lines then
					xline := text_displayed.last_line
					cursor.make_from_relative_pos (xline, xline.eol_token, 1, Current)
				else
					cursor.make_from_absolute_pos (x_pos, l_number, Current)
				end

				if cursor.is_equal (selection_start) then
						-- Forget selection if nothing is selected.
					has_selection := False
				end
					-- Record in the history.
				history.record_move
				invalidate
				update
			end
		end

	on_left_button_up (mouse_key, x_pos, y_pos: INTEGER) is
			-- Process the left button of the mouse (when released).
		do
				-- Change the state of our flag
			mouse_left_button_down := False
		end

feature -- Actions

	undo is
			-- undo last command
		do
			history.undo
			invalidate
			update
		end
	
	redo is
			-- redo last command
		do
			history.redo
			invalidate
			update
		end

	cut_selection is
			-- Cut current selection into clipboard
		do
			if has_selection then
				copy_selection
				delete_selection
				invalidate
				update
			end
		end

	copy_selection is
			-- Copy current selection into clipboard
		do
			if has_selection then
				clipboard := text_displayed.string_selected (begin_selection, end_selection)
			end
		end

	paste_selection is
			-- Paste clipboard.
		do
			if has_selection then
				delete_selection
			end
			if clipboard /= Void and then not clipboard.empty then
				history.record_paste (clipboard)
				cursor.insert_string (clipboard)
				invalidate
				update
			end
		end

	delete_selection is
			-- delete text being in selection.
		local
			begin: TEXT_CURSOR
			aux: STRING
		do
			if (cursor < selection_start) then
				begin := cursor
				aux := text_displayed.string_selected (cursor, selection_start)
				text_displayed.delete_selection (cursor, selection_start)
			else
				begin := selection_start
				aux := text_displayed.string_selected (selection_start, cursor)
				text_displayed.delete_selection (selection_start, cursor)
			end
			cursor.make_from_absolute_pos (begin.x_in_pixels, begin.y_in_lines, Current)
			history.record_delete_selection (aux)
			has_selection := False
		end

	indent_selection is
			-- Ident the selected lines.
		do
			if has_selection then
				text_displayed.indent_selection(begin_selection, end_selection)
				history.wipe_out
				invalidate
				update
			end
		end

	unindent_selection is
			-- Unident the selected lines.
		do
			if has_selection then
				text_displayed.unindent_selection(begin_selection, end_selection)
				history.wipe_out
				invalidate
				update
			end
		end

	comment_selection is
			-- Comment the selected lines.
		do
			if has_selection then
				text_displayed.comment_selection(begin_selection, end_selection)
				history.wipe_out
				invalidate
				update
			end
		end

	uncomment_selection is
			-- Uncomment the selected lines.
		do
			if has_selection then
				text_displayed.uncomment_selection(begin_selection, end_selection)
				history.wipe_out
				invalidate
				update
			end
		end

	search_string(searched_string: STRING) is
			-- Search `searched_string' in the current text.
		local
			end_searched_string: TEXT_CURSOR
		do
			text_displayed.search_string(searched_string)
			if text_displayed.successful_search then
				cursor.make_from_character_pos(
					text_displayed.found_string_character_position,
					text_displayed.found_string_line,
					Current)
				create end_searched_string.make_from_character_pos(
					text_displayed.found_string_character_position + searched_string.count,
					text_displayed.found_string_line,
					Current)

				set_selection_start(end_searched_string)

				invalidate_cursor_rect(True)
			end
		end

feature {NONE} -- Handle keystokes
	
	basic_cursor_move(action: PROCEDURE[TEXT_CURSOR,TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char
		do
			if shifted_key then
					-- We want to create or modify a selection.
				if not has_selection then
						-- No selection? We have to start one.
					has_selection := True
					selection_start := clone (cursor)
				end
				invalidate_cursor_rect (False)
				action.call([])
				if selection_start.is_equal (cursor) then
						-- If nothing is selected, we forget the selection.
					has_selection := False
				end
				invalidate_cursor_rect (True)
			elseif has_selection then
					-- There was a selection, but we destroy it.
				action.call([])
				has_selection := False
				history.record_move

					-- we have to redraw the entire screen
					--| FIXME ARNAUD: we only need to redraw the old selected part.
				invalidate
				update
			else
					-- There is no selection. Normal move.
				invalidate_cursor_rect (False)
				action.call([])
				invalidate_cursor_rect (True)
			end
		end

	handle_extended_ctrled_key (virtual_key: INTEGER; key_data: INTEGER) is
		do
			if virtual_key = Vk_x then
					-- Ctrl-X (cut)
				cut_selection

			elseif virtual_key = Vk_c then
					-- Ctrl-C (copy)
				copy_selection

			elseif virtual_key = Vk_v then
					-- Ctrl-V (paste)
				paste_selection

			elseif virtual_key = Vk_z then
					-- Ctrl-Z (undo)
				undo

			elseif virtual_key = Vk_r then
					-- Ctrl-R (redo)
				redo

			elseif virtual_key = Vk_f then
					-- Ctrl-F (find)
				search_string(clipboard)
			end
		end

	handle_extended_key (virtual_key: INTEGER; key_data: INTEGER) is
		do
			if virtual_key = Vk_left then
					-- Left arrow action
				basic_cursor_move(cursor~go_left_char)

			elseif  virtual_key = Vk_right then
					-- Right arrow action
				basic_cursor_move(cursor~go_right_char)

			elseif  virtual_key = Vk_up then
					-- Up arrow action
				basic_cursor_move(cursor~go_up_line)

			elseif  virtual_key = Vk_down then
					-- Down arrow action
				basic_cursor_move(cursor~go_down_line)

			elseif  virtual_key = Vk_home then
					-- Home key action
				basic_cursor_move(cursor~go_start_line)

			elseif  virtual_key = Vk_end then
					-- End key action
				basic_cursor_move(cursor~go_end_line)

			elseif  virtual_key = Vk_delete then
					-- Delete key action
				if has_selection then
					delete_selection
				else
					history.record_delete (cursor.item)
					cursor.delete_char
				end
				invalidate
				update

			elseif  virtual_key = Vk_back then
					-- Backspace key action
				if has_selection then
					delete_selection
				else
					cursor.delete_previous
				end
				invalidate
				update

			elseif virtual_key = Vk_return then
					-- Return/Enter key action
				if has_selection then
					delete_selection
				end
				history.record_insert_eol
				cursor.insert_eol
				invalidate
				update

			elseif  virtual_key = Vk_Insert then
					-- Insert key action
				insert_mode := not insert_mode
				invalidate
				update

			elseif  virtual_key = Vk_Tab then
					-- Tab key action
				if has_selection then
					if shifted_key then
							-- Shift + Tab = Unindent selection
						unindent_selection
					else
							-- Tab = indent selection
						indent_selection
					end
				else
					-- No selection --> we insert a %T character
					handle_character('%T')
				end

				invalidate
				update
			end
		end

 	handle_character (c: CHARACTER) is
 			-- Process the push on a character key.
 		do
			if has_selection then
				delete_selection
				if insert_mode then
					history.record_replace ('%N', c)
						--| This is a trick to consider
						--| the insertion as a replace.
				else
					history.record_insert (c)
				end
				cursor.insert_char (c)
				invalidate
				update
			else
				invalidate_cursor_rect (False)

				if insert_mode then
					history.record_replace (cursor.item, c)
					cursor.replace_char (c)
				else
					history.record_insert (c)
					cursor.insert_char (c)
				end

				invalidate_cursor_rect (True)
			end
		end

feature {NONE} -- Display functions
	
	update_buffered_screen (dc: WEL_DC; top: INTEGER; bottom: INTEGER) is
			-- Update the device context `dc'. Redraw the text.
		local
			curr_line			: INTEGER
			first_line_to_draw	: INTEGER
			last_line_to_draw	: INTEGER
			curr_y				: INTEGER
			wel_rect			: WEL_RECT
		do
				-- Draw all lines
			first_line_to_draw := (first_line_displayed + top // line_increment - 1).max (1)
			last_line_to_draw := (first_line_displayed + bottom // line_increment).min (number_of_lines)
			curr_y := top

			if first_line_to_draw <= last_line_to_draw then
				text_displayed.go_i_th (first_line_to_draw)
				from
					curr_line := first_line_to_draw
				until
					curr_line > last_line_to_draw + 2 or else
					text_displayed.after
				loop
					display_line (curr_line, text_displayed.item, dc)
					curr_line := curr_line + 1
					text_displayed.forth
				end

				curr_y := (curr_line - first_line_displayed) * line_increment
			end

			if curr_y < bottom then
				-- The file is too small for the screen, so we fill in the
				-- last portion of the screen.
				create wel_rect.make(0, curr_y, width, bottom)
				dc.fill_rect(wel_rect, normal_background_brush)
			end
		end

	display_line (a_line: INTEGER; line: EDITOR_LINE; dc: WEL_DC) is
			-- Display `line' at the coordinates (`d_x', `d_y') on the
			-- device context `dc'.
		local
			curr_y					: INTEGER
			cursor_line 			: BOOLEAN -- Is the cursor present in the current line?
			curr_token				: EDITOR_TOKEN
			width_cursor			: INTEGER
			start_cursor			: INTEGER
			selected_line			: BOOLEAN -- Is the entire line selected?
			not_selected_line		: BOOLEAN -- Is the entire line NOT selected?
			token_selection			: INTEGER
			token_begin_selection	: INTEGER
			token_end_selection		: INTEGER
			local_begin_selection 	: TEXT_CURSOR -- cache of the value of begin_selection
			local_end_selection		: TEXT_CURSOR -- cache of the value of end_selection
		do
			curr_y := (a_line - first_line_displayed) * line_increment
			cursor_line := (a_line = cursor.y_in_lines)

			if has_selection then
					-- Compute optimisations
				local_begin_selection := begin_selection
				local_end_selection := end_selection

				if (a_line > local_begin_selection.y_in_lines) and (a_line < local_end_selection.y_in_lines) then
					selected_line := True
				end
				if (a_line < local_begin_selection.y_in_lines) or (a_line > local_end_selection.y_in_lines) then
					not_selected_line := True
				end
			end

			from
				line.start
				curr_token := line.item
			until
				line.after or else curr_token = line.eol_token
			loop
				if has_selection then
					-- The text contains a selection, we may have to display this token
					-- in its selected state.

						-- Initialise the token state.
					token_selection := Token_not_selected

						-- Entire line selected
					if selected_line then
						token_selection := Token_selected

						-- No token in the line are selected
					elseif not_selected_line then
						token_selection := Token_not_selected

						-- Some tokens in the line are selected, and the selection starts and ends on the same line
					elseif (a_line = local_begin_selection.y_in_lines) and then (a_line = local_end_selection.y_in_lines) then
						if (curr_token.position > local_begin_selection.token.position) and then (curr_token.position < local_end_selection.token.position) then
							token_selection := Token_selected
						elseif (curr_token.position < local_begin_selection.token.position) or else (curr_token.position > local_end_selection.token.position) then
							token_selection := Token_not_selected
						else
							token_begin_selection := 1
							token_end_selection := curr_token.length + 1
							if (curr_token.position = local_begin_selection.token.position) then
								token_selection := Token_half_selected
								token_begin_selection := local_begin_selection.pos_in_token
							end
							if (curr_token.position = local_end_selection.token.position) then
								token_selection := Token_half_selected
								token_end_selection := local_end_selection.pos_in_token
							end
						end

						-- Some tokens in the line are selected (first selected line)
					elseif (a_line = local_begin_selection.y_in_lines) then
						if (curr_token.position > local_begin_selection.token.position) then
							token_selection := Token_selected
						elseif (curr_token.position = local_begin_selection.token.position) then
							token_selection := Token_half_selected
							token_begin_selection := local_begin_selection.pos_in_token
							token_end_selection := curr_token.length + 1
						end

						-- Some tokens in the line are selected (last selected line)
					elseif (a_line = local_end_selection.y_in_lines) then
						if (curr_token.position < local_end_selection.token.position) then
							token_selection := Token_selected
						elseif (curr_token.position = local_end_selection.token.position) then
							token_selection := Token_half_selected
							token_begin_selection := 1
							token_end_selection := local_end_selection.pos_in_token
						end

					end
				end

				inspect token_selection
				when Token_not_selected then
						-- Normally Display the token.
					curr_token.display (curr_y, dc)
				when Token_selected then
					curr_token.display_selected (curr_y, dc)
				when Token_half_selected then
					curr_token.display_half_selected (curr_y, token_begin_selection, token_end_selection, dc)
				else
					-- Unexpected value, do nothing
				end

					-- Display the cursor (if needed).
				if cursor_line and then cursor.token = curr_token then
						-- Compute the start pixel of the cursor.
					start_cursor := curr_token.position + curr_token.get_substring_width(cursor.pos_in_token - 1)
						-- Compute the width of the pixel depending whether we are
						-- in Insertion mode or not (small or plain cursor)
					if insert_mode then
						width_cursor := curr_token.get_substring_width (cursor.pos_in_token) - curr_token.get_substring_width (cursor.pos_in_token - 1)
						width_cursor := width_cursor.max (2)
					else
						width_cursor := 2
					end
						-- Draw the cursor
					dc.pat_blt (start_cursor, curr_y, width_cursor, line_height, Dstinvert)
				end

					-- prepare next iteration
				line.forth
				curr_token := line.item
			end

				-- Display the end token
			curr_token := line.eol_token
			if has_selection and then (local_begin_selection.y_in_lines /= local_end_selection.y_in_lines) and then 
			   (selected_line or else (a_line = local_begin_selection.y_in_lines)) then 
				line.eol_token.display_end_token_selected(curr_y, dc, width)
			else
				line.eol_token.display_end_token_normal(curr_y, dc, width)
			end

				-- Display the cursor (if its on the current end of line).
			if cursor_line and then cursor.token = curr_token then
					-- Compute the start pixel of the cursor.
				start_cursor := curr_token.position + curr_token.get_substring_width(cursor.pos_in_token - 1)
				width_cursor := 2
					-- Draw the cursor
				dc.pat_blt(start_cursor, curr_y, width_cursor, line_height, Dstinvert)
			end
		end

	invalidate_cursor_rect (redraw: BOOLEAN) is
			-- Set the line where the cursor is situated to be redrawn
			-- Redraw immediately if `redraw' is set.
		local
			wel_rect: WEL_RECT
			cursor_up: INTEGER
		do
   				-- Invalidate old cursor location.
   			cursor_up := (cursor.y_in_lines-first_line_displayed) * line_increment
   			create wel_rect.make (0, cursor_up, width, cursor_up + line_increment)
			invalidate_rect (wel_rect,true)
			if redraw then
				update
			end
		end

feature {NONE} -- Status Report
	
	number_of_lines: INTEGER is
			-- Whole number of lines.
		do
			Result := text_displayed.count
		end

	vertical_range_max: INTEGER is
		do
			Result := number_of_lines - number_of_lines_displayed + 2
			Result := Result.max (1)
		end

feature {NONE} -- Constants & Text Attributes

	Left_margin_width: INTEGER is 5
		-- Width in pixel of the margin on the left
		-- of the screen.

	Top_margin_width: INTEGER is 5
		-- Height in pixel of the margin on the top
		-- of the screen.

	line_increment: INTEGER
		-- Height in pixel of a line + an interline.

	line_height: INTEGER
		-- Height in pixel of a line.

feature {NONE} -- Implementation

	current_font: WEL_FONT
		-- Current font used to display the text.

	normal_background_brush: WEL_BRUSH is
		do
			Result := editor_preferences.normal_background_brush
		end

	initialized: BOOLEAN
		-- Has initialisations been performed?

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_child_window)
		end

	default_style: INTEGER is
			-- Default style for this window.
		do
			Result := ws_overlappedwindow + ws_vscroll
		end

	font: WEL_FONT is
			-- Current text font.
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make (editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect (log_font)
		end

feature {NONE} -- Private Characteristics of the window

	shifted_key: BOOLEAN
			-- Is any of the shift key pushed?

	ctrled_key: BOOLEAN
			-- Is any of the ctrl key pushed?

	mouse_left_button_down: BOOLEAN
			-- Is the left button of the mouse down?

	clipboard: STRING
			-- Clipboard string.

	selection_start: TEXT_CURSOR
			-- Position where the user has started to select
			-- the text. This position can be below the current
			-- cursor (and therefore represent the end of the
			-- selection)

	begin_selection: TEXT_CURSOR is
			-- Beggining of the selection (always < than
			-- `end_selection').
		require
			has_selection
		do
			if cursor > selection_start then
				Result := selection_start
			else
				Result := cursor
			end
		end

	end_selection: TEXT_CURSOR is
			-- End of the selection (always > than
			-- `begin_selection').
		require
			has_selection
		do
			if cursor > selection_start then
				Result := cursor
			else
				Result := selection_start
			end
		end

feature {NONE} -- Private Constants

	Token_not_selected	: INTEGER is 0
	Token_selected		: INTEGER is 1
	Token_half_selected	: INTEGER is 4

end -- class CHILD_WINDOW

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
