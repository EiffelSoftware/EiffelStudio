indexing
	description	: "Root class for the Vision2 version of the editor."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_WINDOW

inherit
	EV_APPLICATION

	EV_DRAWABLE_CONSTANTS
		undefine
			default_create
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EV_KEY_CONSTANTS
		undefine
			default_create
		end

	SHARED_EDITOR_PREFERENCES
		undefine
			default_create
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			basic_interval: INTEGER_INTERVAL
			a_menu_bar: EV_MENU_BAR
			a_menu: EV_MENU
			a_menu_item: EV_MENU_ITEM
		do
			----------------------------
			-- Vision2 initialisation --
			----------------------------
			create my_device

			first_window.key_press_actions.extend(~on_key_down)
			first_window.key_release_actions.extend(~on_key_up)
			first_window.key_press_string_actions.extend(~on_char)
			first_window.pointer_button_press_actions.extend(~on_mouse_button_down)
			first_window.pointer_button_release_actions.extend(~on_mouse_button_up)
--			my_device.key_press_actions.extend(~on_key_down)
--			my_device.key_release_actions.extend(~on_key_up)
--			my_device.key_press_string_actions.extend(~on_char)
			my_device.pointer_button_press_actions.extend(~on_mouse_button_down)
			my_device.pointer_button_release_actions.extend(~on_mouse_button_up)
			my_device.expose_actions.extend (~on_repaint)
			my_device.pointer_motion_actions.extend (~on_mouse_move)
			my_device.resize_actions.extend(~on_size)

				-- create the scrollbar
			create my_scrollbar
			my_scrollbar.set_step(1)
			create basic_interval.make(1,1)
			my_scrollbar.reset_with_range(basic_interval)
			my_scrollbar.change_actions.extend (~on_vertical_scroll)

			create my_container

				-- Add widgets to our window
			my_container.extend (my_device)
			my_container.extend (my_scrollbar)
			my_container.disable_item_expand (my_scrollbar)
			first_window.extend(my_container)

				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("File")

			create a_menu_item.make_with_text ("Load")
			a_menu_item.select_actions.extend (~on_menu_file_load)
			a_menu.extend (a_menu_item)

			create a_menu_item.make_with_text ("Close")
			a_menu_item.select_actions.extend (~on_menu_file_close)
			a_menu.extend (a_menu_item)

			a_menu_bar.extend (a_menu)
			first_window.set_menu_bar (a_menu_bar)

			----------------------------
			-- General initialisation --
			----------------------------

				-- Retrieve user preferences (syntax highligting, tabulation width, ...).
			editor_preferences.set_tabulation_spaces(4)
			editor_preferences.show_invisible_symbols
			editor_preferences.enable_smart_ident
			insert_mode := False

				-- Compute Font related constants
			line_height := font.height
			line_increment := line_height

				-- First display the first line...
			first_line_displayed := 1

				-- Load the font & Compute Font related constants.
			number_of_lines_displayed := my_device.height // line_increment

				-- Setup the scroll bars.
			my_scrollbar.set_maximum (vertical_range_max)

				-- Set up the screen.
			create buffered_screen.make_with_size(my_device.width, my_device.height)
			buffered_screen.set_background_color(editor_preferences.normal_background_color)
			my_device.set_background_color(editor_preferences.normal_background_color)
			my_device.disable_sensitive
			my_scrollbar.disable_sensitive

			initialized := True
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 Editor test")
			Result.set_size (500, 500)
		end


feature {NONE} -- Graphical interface

	my_device: EV_DRAWING_AREA
			-- Part of the screen where the text is displayed.

	buffered_screen: EDITOR_BUFFERED_SCREEN
			-- Buffer containing the current displayed screen.

	my_scrollbar: EV_VERTICAL_SCROLL_BAR
			-- Scroll bar associated to the drawing area

	my_container: EV_HORIZONTAL_BOX
			-- Container that groups the drawing area and
			-- the vertical scrollbar.

feature -- Access

	insert_mode: BOOLEAN
			-- Are we in insert mode?

	first_line_displayed: INTEGER
			-- First line currently displayed on the screen.

	number_of_lines_displayed: INTEGER
			-- Number of lines currently displayed on the screen.

	text_displayed: EDITOR_CONTENT
			-- text currently displayed on the screen.

	cursor: EDITOR_CURSOR
			-- Current cursor.

	history: UNDO_REDO_STACK
			-- List of undo and redo commands

	has_selection: BOOLEAN
			-- Is there a selection ?

feature -- Selection

	set_selection_start (c: EDITOR_CURSOR) is
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

feature -- Process Vision2 events

	on_menu_file_load is
			-- Feature executed when the user select file/load
			-- in the menu. Open the dialog box and let the
			-- user choose its file to load.
		local
			ofd: EV_FILE_OPEN_DIALOG
		do
			create ofd
			ofd.ok_actions.extend (~effective_load_file (ofd))
			ofd.show_modal
		end
	
	on_menu_file_close is
			-- Feature executed when the user select file/load
			-- in the menu. Open the dialog box and let the
			-- user choose its file to load.
		do
			text_displayed := Void

				-- Setup the scroll bars.
			my_scrollbar.set_maximum (vertical_range_max)

				-- Reset cursor, history, ...
			history := Void
			cursor := Void 
			selection_start := Void

				-- reset the displayed thing.
			my_device.clear_and_redraw
			my_device.disable_sensitive
			my_scrollbar.disable_sensitive
		end
	
	on_repaint (x, y, width, height: INTEGER) is
			-- Paint the window
		do
			update_buffered_screen (y, y+height)
			my_device.draw_pixmap(0,0,buffered_screen)
		end

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER) is
			-- The size of the screen has changed (this feature can be
			-- called before the creation of the window)
		do
				-- Resize & redraw the buffered screen.
			if buffered_screen /= Void then
				buffered_screen.set_size(a_width, a_height)
				update_buffered_screen(0, a_height)
			end

			if Initialized then
					-- Recompute the number of displayed lines.
				number_of_lines_displayed := a_height // line_increment

					-- Setup the scroll bars.
				my_scrollbar.set_maximum (vertical_range_max)
	
					-- Compute the first line to be displayed [ = max (0, min (vpos, vmax)) ]
				first_line_displayed := (first_line_displayed.min (vertical_range_max)).max (1)
				my_scrollbar.set_value (first_line_displayed)
			end
		end

 	on_vertical_scroll is
 			-- Vertical scroll event. `my_scrollbar.value' has changed.
 		local
 			vscroll_pos: INTEGER
 			vscroll_inc: INTEGER
 		do
			vscroll_pos := my_scrollbar.value
 
 				-- Compute the first line to be displayed [ = max (0, min (vpos, vmax)) ]
 			vscroll_inc := (vscroll_pos.min (vertical_range_max)).max (1) - first_line_displayed
 			first_line_displayed := first_line_displayed + vscroll_inc
 
 				-- Update the screen (if needed).
 			if vscroll_inc /= 0 then
 
 					-- Setup the new vertical position.
 				--scroll (0, -line_increment * vscroll_inc)
 				my_scrollbar.set_value (first_line_displayed)
 
 					-- Ask window to repaint our window.
 				my_device.redraw
 			end
 		end

	on_key_down (ev_key: EV_KEY) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if ctrled_key then
				handle_extended_ctrled_key(ev_key)
			else
				handle_extended_key(ev_key)
			end

				-- Handle state key.			
			inspect
				ev_key.code
			when Key_shift then
					-- Shift key action
				shifted_key := True

			when Key_ctrl then
					-- Ctrl key action
				ctrled_key := True
			else
				-- Key not handled, do nothing
			end
		end

	on_key_up (ev_key: EV_KEY) is
			-- Process Wm_keyup message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			inspect
				ev_key.code
			when Key_shift then
					-- Notice that all shift key are released.
				shifted_key := False
			when Key_ctrl then
					-- Ctrl key action
				ctrled_key := False
			else
				-- Key not handled, do nothing
			end
		end

 	on_char (character_string: STRING) is
   			-- Process Wm_char message
   		local
   			c: CHARACTER
   		do
   			c := character_string @ 1
			if (c.code >= 32) then
					-- Ignoring special characters
				handle_character(c)
			end
 		end

	on_mouse_button_down (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- Process the left button of the mouse (when pushed)
		local
			l_number: INTEGER
			old_cursor: EDITOR_CURSOR
			xline : EDITOR_LINE
		do
			if button = 1 then
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
				my_device.redraw
				my_device.flush
			end
		end

	on_mouse_move (x_pos, y_pos: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- Wm_mousemove message
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
				my_device.redraw
				my_device.flush
			end
		end

	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- Process the left button of the mouse (when released).
		do
			if button = 1 then
					-- Change the state of our flag
				mouse_left_button_down := False
			end
		end

feature -- Actions

	undo is
			-- undo last command
		do
			history.undo
			my_device.redraw
			my_device.flush
		end
	
	redo is
			-- redo last command
		do
			history.redo
			my_device.redraw
			my_device.flush
		end

	cut_selection is
			-- Cut current selection into clipboard
		do
			if has_selection then
				copy_selection
				delete_selection
				my_device.redraw
				my_device.flush
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
				my_device.redraw
				my_device.flush
			end
		end

	delete_selection is
			-- delete text being in selection.
		local
			begin: EDITOR_CURSOR
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
				my_device.redraw
				my_device.flush
			end
		end

	unindent_selection is
			-- Unident the selected lines.
		do
			if has_selection then
				text_displayed.unindent_selection(begin_selection, end_selection)
				history.wipe_out
				my_device.redraw
				my_device.flush
			end
		end

	comment_selection is
			-- Comment the selected lines.
		do
			if has_selection then
				text_displayed.comment_selection(begin_selection, end_selection)
				history.wipe_out
				my_device.redraw
				my_device.flush
			end
		end

	uncomment_selection is
			-- Uncomment the selected lines.
		do
			if has_selection then
				text_displayed.uncomment_selection(begin_selection, end_selection)
				history.wipe_out
				my_device.redraw
				my_device.flush
			end
		end

	search_string(searched_string: STRING) is
			-- Search `searched_string' in the current text.
		local
			end_searched_string: EDITOR_CURSOR
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
	
	basic_cursor_move(action: PROCEDURE[EDITOR_CURSOR,TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char
		local
			old_line, new_line: INTEGER
		do
			if shifted_key then
					-- We want to create or modify a selection.
				if not has_selection then
						-- No selection? We have to start one.
					has_selection := True
					selection_start := clone (cursor)
				end
				old_line := cursor.y_in_lines
				action.call([])
				if selection_start.is_equal (cursor) then
						-- If nothing is selected, we forget the selection.
					has_selection := False
				end
				new_line := cursor.y_in_lines
				if old_line /= new_line then
					invalidate_line (old_line, False)
				end
				invalidate_line (new_line, True)
			elseif has_selection then
					-- There was a selection, but we destroy it.
				action.call([])
				has_selection := False
				history.record_move

					-- we have to redraw the entire screen
					--| FIXME ARNAUD: we only need to redraw the old selected part.
				my_device.redraw
			else
					-- There is no selection. Normal move.
				old_line := cursor.y_in_lines
				action.call([])
				new_line := cursor.y_in_lines
				if old_line /= new_line then
					invalidate_line (old_line, False)
				end
				invalidate_line (new_line, True)
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
		do
			inspect
				ev_key.code
			when Key_x then
					-- Ctrl-X (cut)
				cut_selection

			when Key_c then
					-- Ctrl-C (copy)
				copy_selection

			when Key_v then
					-- Ctrl-V (paste)
				paste_selection

			when Key_z then
					-- Ctrl-Z (undo)
				undo

			when Key_r then
					-- Ctrl-R (redo)
				redo

			when Key_f then
					-- Ctrl-F (find)
				search_string(clipboard)
			else
				-- Key not handled, do nothing			
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
		do
			inspect
				ev_key.code
			when Key_left then
					-- Left arrow action
				basic_cursor_move(cursor~go_left_char)

			when Key_right then
					-- Right arrow action
				basic_cursor_move(cursor~go_right_char)

			when Key_up then
					-- Up arrow action
				basic_cursor_move(cursor~go_up_line)

			when Key_down then
					-- Down arrow action
				basic_cursor_move(cursor~go_down_line)

			when Key_home then
					-- Home key action
				basic_cursor_move(cursor~go_start_line)

			when Key_end then
					-- End key action
				basic_cursor_move(cursor~go_end_line)

			when Key_delete then
					-- Delete key action
				if has_selection then
					delete_selection
				else
					history.record_delete (cursor.item)
					cursor.delete_char
				end
				my_device.redraw
				my_device.flush

			when Key_back_space then
					-- Backspace key action
				if has_selection then
					delete_selection
				else
					cursor.delete_previous
				end
				my_device.redraw
				my_device.flush

			when Key_enter then
					-- Return/Enter key action
				if has_selection then
					delete_selection
				end
				if editor_preferences.smart_identation then
					history.record_paste ("%N"+cursor.line.identation)
				else
					history.record_insert_eol
				end
				cursor.insert_eol
				my_device.redraw
				my_device.flush

			when Key_insert then
					-- Insert key action
				insert_mode := not insert_mode
				my_device.redraw
				my_device.flush

			when Key_tab then
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

				my_device.redraw
				my_device.flush
			else
				-- Key not handled, do nothing
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
				my_device.redraw
				my_device.flush
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
	
 	update_buffered_screen (top: INTEGER; bottom: INTEGER) is
 			-- Update the device context `dc'. Redraw the text.
 		local
 			curr_line			: INTEGER
 			first_line_to_draw	: INTEGER
 			last_line_to_draw	: INTEGER
 			curr_y				: INTEGER
 		do
			buffered_screen.set_background_color(editor_preferences.normal_background_color)
			buffered_screen.clear_rectangle(0, top, my_device.width, bottom)

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
 					display_line (curr_line, text_displayed.current_line)
 					curr_line := curr_line + 1
 					text_displayed.forth
 				end
 
 				curr_y := (curr_line - first_line_displayed) * line_increment
 			end
 
 			if curr_y < bottom then
 				-- The file is too small for the screen, so we fill in the
 				-- last portion of the screen.
				buffered_screen.clear_rectangle(0, curr_y, my_device.width, bottom)
 			end
 		end
 
 	display_line (a_line: INTEGER; line: EDITOR_LINE) is
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
 			local_begin_selection 	: EDITOR_CURSOR -- cache of the value of begin_selection
 			local_end_selection		: EDITOR_CURSOR -- cache of the value of end_selection
 			clr: EV_COLOR
 			old_clr: EV_COLOR
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
 					curr_token.display (curr_y, buffered_screen)
 				when Token_selected then
 					curr_token.display_selected (curr_y, buffered_screen)
 				when Token_half_selected then
 					curr_token.display_half_selected (curr_y, token_begin_selection, token_end_selection, buffered_screen)
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
 					draw_bloc_cursor(start_cursor, curr_y, width_cursor, line_height)
	 				end
 
 					-- prepare next iteration
 				line.forth
 				curr_token := line.item
 			end
 
 				-- Display the end token
 			curr_token := line.eol_token
 			if has_selection and then (local_begin_selection.y_in_lines /= local_end_selection.y_in_lines) and then 
 			   (selected_line or else (a_line = local_begin_selection.y_in_lines)) then 
 				line.eol_token.display_end_token_selected(curr_y, buffered_screen, my_device.width)
 			else
 				line.eol_token.display_end_token_normal(curr_y, buffered_screen, my_device.width)
 			end
 
 				-- Display the cursor (if its on the current end of line).
 			if cursor_line and then cursor.token = curr_token then
 					-- Compute the start pixel of the cursor.
 				start_cursor := curr_token.position + curr_token.get_substring_width(cursor.pos_in_token - 1)
 				width_cursor := 2
 					-- Draw the cursor
				draw_bloc_cursor(start_cursor, curr_y, width_cursor, line_height)
 			end
 		end

	invalidate_cursor_rect (flush_screen: BOOLEAN) is
			-- Set the line where the cursor is situated to be redrawn
			-- Redraw immediately if `flush' is set.
		local
			cursor_up: INTEGER
		do
   				-- Invalidate old cursor location.
			cursor_up := (cursor.y_in_lines-first_line_displayed) * line_increment
			my_device.redraw_rectangle(0, cursor_up, my_device.width, cursor_up + line_increment -1)
			if flush_screen then
				my_device.flush
			end
		end

	invalidate_line (line_number: INTEGER; flush_screen: BOOLEAN) is
			-- Set the line where the cursor is situated to be redrawn
			-- Redraw immediately if `flush' is set.
		local
			cursor_up: INTEGER
		do
   				-- Invalidate old cursor location.
			cursor_up := (line_number - first_line_displayed) * line_increment
			my_device.redraw_rectangle (0, cursor_up, my_device.width, cursor_up + line_increment -1)
			if flush_screen then
				my_device.flush
			end
		end

	draw_bloc_cursor(x1, y1, x2, y2: INTEGER) is
			-- Draw the cursor bloc defined by the rectangle
			-- (`x1',`y1')-(`x2',`y2') on the screen
		do
			buffered_screen.set_xor_mode
			buffered_screen.set_foreground_color(editor_preferences.normal_text_color)
			buffered_screen.fill_rectangle(x1, y1, x2, y2)
			buffered_screen.draw_rectangle(x1, y1, x2, y2)
			buffered_screen.set_copy_mode
		end

feature {NONE} -- Status Report
	
	number_of_lines: INTEGER is
			-- Whole number of lines.
		do
			if text_displayed /= Void then
				Result := text_displayed.count
			else
				Result := 0
			end
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

	font: EDITOR_FONT is
			-- Current text font.
		once
				-- create the font
			create Result.make_with_values (editor_preferences.font_family, Ev_font_weight_regular, Ev_font_shape_regular, 15)
		end

feature {NONE} -- Load/Save File handling

	effective_load_file(file_d: EV_FILE_OPEN_DIALOG) is
			-- Actions performed when the user click on the
			-- "OK" button of the FileOpenDialog box.
		do
				-- Read and parse the file.
			file_name := file_d.file_name
			start_reading_file

				-- Setup the scroll bars.
			my_scrollbar.set_maximum (vertical_range_max)

				-- Initialize history
			create history.make (Current)

				-- Initialize the cursor
			create cursor.make_from_absolute_pos (0, 1, Current)
			selection_start := cursor --| this is just for selection_start not to be Void.

				-- We're all setup, let's display the thing & enable user input
			my_device.clear_and_redraw
			my_device.enable_sensitive
			my_scrollbar.enable_sensitive
		end

	start_reading_file is
			-- Read the file named `a_name' and perform a lexical analysis
		local
			line_item	: EDITOR_LINE
			curr_string	: STRING
			fake_text	: EDITOR_TOKEN_TEXT
		do
				-- reset the displayed text & display the drawing area.
			create text_displayed.make
			my_device.enable_sensitive

				-- read the file
			create file.make_open_read (file_name)
			
			from
				file.start
			until
				text_displayed.count > number_of_lines_displayed or else file.after
			loop
				file.read_line
				curr_string := clone (file.last_string)
				text_displayed.lexer.execute (curr_string)
				create line_item.make_from_lexer (text_displayed.lexer)
				text_displayed.extend (line_item)
			end

			if not file.after then
					-- the file has not been entirely loaded, so we will
					-- finish loading the file on idle actions.
				idle_actions.extend(Finish_reading_file_agent)
			end
		end

	finish_reading_file is
			-- Read the file named `a_name' and perform a lexical analysis
		local
			line_item	: EDITOR_LINE
			curr_string	: STRING
			fake_text	: EDITOR_TOKEN_TEXT
			lines_read	: INTEGER
		do
			from
				lines_read := 1
			until
				lines_read > Lines_read_per_idle_action or else file.after
			loop
				file.read_line
				curr_string := clone (file.last_string)
				text_displayed.lexer.execute (curr_string)
				create line_item.make_from_lexer (text_displayed.lexer)
				text_displayed.extend (line_item)

					-- prepare next iteration
				lines_read := lines_read + 1
			end

				-- Update the scroll bars.
			my_scrollbar.set_maximum (vertical_range_max)

			if file.after then
					-- We have finished reading the file, so we remove
					-- ourself from the idle actions.
				idle_actions.prune_all(Finish_reading_file_agent)
			end
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

	selection_start: EDITOR_CURSOR
			-- Position where the user has started to select
			-- the text. This position can be below the current
			-- cursor (and therefore represent the end of the
			-- selection)

	begin_selection: EDITOR_CURSOR is
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

	end_selection: EDITOR_CURSOR is
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

feature {NONE} -- Initialisations and File status

	file_loaded: BOOLEAN
			-- Have we finished loading the file?

	file_name: STRING
			-- Name of the current edited file.
	
	file: PLAIN_TEXT_FILE
			-- Current edited file.

	initialized: BOOLEAN
			-- Has initialisations been performed?

feature {NONE} -- Private Constants

	Token_not_selected	: INTEGER is 0
	Token_selected		: INTEGER is 1
	Token_half_selected	: INTEGER is 4

	Lines_read_per_idle_action : INTEGER is 25
		-- Number of lines read each time finish_reading_file
		-- is called on an idle action.

	Finish_reading_file_agent: PROCEDURE[EDITOR_WINDOW, TUPLE] is
		once
			Result := ~finish_reading_file
		end


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
