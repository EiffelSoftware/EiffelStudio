class
	CHILD_WINDOW

inherit
	WEL_MDI_CHILD_WINDOW
		rename
			make as mdi_child_window_make
		redefine
			on_paint, on_size, class_icon, default_style,
			on_vertical_scroll, on_key_down, on_key_up,
			on_char, on_left_button_down
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
			-- Perform all initialization.
		local
			dc			: WEL_MEMORY_DC
			space_size	: WEL_SIZE
		do
			if not initialized then
					-- Initialisation done.
				initialized := True

					-- Compute Font related constants
				create dc.make
				dc.select_font(font)
				space_size := dc.string_size(" ")
				line_height := space_size.height
--				line_increment := line_height + 1
				line_increment := line_height
				dc.unselect_font
					-- First display the first line...
				first_line_displayed := 1
			end
		end

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: STRING) is
		do
				-- Create the window.
			mdi_child_window_make (a_parent, a_name)

				-- Retrieve user preferences (syntax highligting, tabulation width, ...).
			editor_preferences.set_tabulation_spaces(4)

				-- Read and parse the file.
			read_and_analyse_file(a_name)

				-- Load the font & Compute Font related constants.
			Initialize
			number_of_lines_displayed := height // line_increment

				-- Setup the scroll bars.
			set_vertical_range (1,vertical_range_max)

				-- Initialize the cursor
			create cursor.make_from_absolute_pos (0,1,Current)

				-- Get the focus
			set_focus
		end

	read_and_analyse_file (a_name: STRING) is
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
				curr_string := clone(file.last_string)
				text_displayed.lexer.execute(curr_string)
				create line_item.make_from_lexer(text_displayed.lexer)
				text_displayed.extend(line_item)
			end
		end

feature -- Access

	insert_mode: BOOLEAN

	first_line_displayed: INTEGER
		-- First line currently displayed on the screen.

	number_of_lines_displayed: INTEGER
		-- Number of lines currently displayed on the screen.

	text_displayed: STRUCTURED_TEXT
			-- text currently displayed on the screen.

feature -- Basic operations

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the bitmap
		do
			update_buffered_screen(paint_dc, invalid_rect.top, invalid_rect.bottom)
		end

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER) is
		local
			dc: WEL_CLIENT_DC
		do
			Initialize

				-- Recompute the number of displayed lines.
			number_of_lines_displayed := height // line_increment

				-- Setup the scroll bars.
			set_vertical_range(1,vertical_range_max)

				-- Compute the first line to be displayed [ = max (0,min(vpos,vmax)) ]
			first_line_displayed := (first_line_displayed.min(vertical_range_max)).max(1)
			set_vertical_position(first_line_displayed)
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

				-- Compute the first line to be displayed [ = max (0,min(vpos,vmax)) ]
			vscroll_inc := (vscroll_pos.min(vertical_range_max)).max(1) - first_line_displayed
			first_line_displayed := first_line_displayed + vscroll_inc

				-- Update the screen (if needed).
			if vscroll_inc /= 0 then

					-- Setup the new vertical position.
				scroll (0, -line_increment * vscroll_inc)
				set_vertical_position(first_line_displayed)

					-- Ask window to repaint our window.
				update
			end
		end

	invalidate_cursor_rect(redraw: BOOLEAN) is
			-- Set the line where the cursor is situated to be redrawn
			-- Redraw immediately if `redraw' is set.
		local
			wel_rect: WEL_RECT
			cursor_up: INTEGER
		do
   				-- Invalidate old cursor location.
   			cursor_up := (cursor.y_in_lines-first_line_displayed) * line_increment
   			create wel_rect.make(0, cursor_up, width, cursor_up + line_increment)
			invalidate_rect(wel_rect,true)
			if redraw then
				update
			end
		end

	on_key_down (virtual_key: INTEGER; key_data: INTEGER) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if virtual_key = Vk_left then 
				if not has_selection then
					if shifted_key then
						has_selection := True
						selection_start := clone (cursor)
					end
					invalidate_cursor_rect (False)
					cursor.go_left_char
					invalidate_cursor_rect (True)
				elseif shifted_key then
					invalidate_cursor_rect (False)
					cursor.go_left_char
					invalidate_cursor_rect (True)
				else
					cursor.go_left_char
					has_selection := False
					invalidate
					update
				end

			elseif  virtual_key = Vk_right then
				if not has_selection then
					if shifted_key then
						has_selection := True
						selection_start := clone (cursor)
					end
					invalidate_cursor_rect (False)
					cursor.go_right_char
					invalidate_cursor_rect (True)
				elseif shifted_key then
					invalidate_cursor_rect (False)
					cursor.go_right_char
					invalidate_cursor_rect (True)
				else
					cursor.go_right_char
					has_selection := False
					invalidate
					update
				end

			elseif  virtual_key = Vk_up then
				if not has_selection then
					if shifted_key then
						has_selection := True
						selection_start := clone (cursor)
					end
					invalidate_cursor_rect (False)
					cursor.go_up_line
					invalidate_cursor_rect (True)
				elseif shifted_key then
					invalidate_cursor_rect (False)
					cursor.go_up_line
					invalidate_cursor_rect (True)
				else
					cursor.go_up_line
					has_selection := False
					invalidate
					update
				end

			elseif  virtual_key = Vk_down then
				if not has_selection then
					if shifted_key then
						has_selection := True
						selection_start := clone (cursor)
					end
					invalidate_cursor_rect (False)
					cursor.go_down_line
					invalidate_cursor_rect (True)
				elseif shifted_key then
					invalidate_cursor_rect (False)
					cursor.go_down_line
					invalidate_cursor_rect (True)
				else
					cursor.go_down_line
					has_selection := False
					invalidate
					update
				end

			elseif  virtual_key = Vk_home then
				if not has_selection then
					if shifted_key then
						has_selection := True
						selection_start := clone (cursor)
					end
					invalidate_cursor_rect (False)
					cursor.go_start_line
					invalidate_cursor_rect (True)
				elseif shifted_key then
					invalidate_cursor_rect (False)
					cursor.go_start_line
					invalidate_cursor_rect (True)
				else
					cursor.go_start_line
					has_selection := False
					invalidate
					update
				end

			elseif  virtual_key = Vk_end then
				if not has_selection then
					if shifted_key then
						has_selection := True
						selection_start := clone (cursor)
					end
					invalidate_cursor_rect (False)
					cursor.go_end_line
					invalidate_cursor_rect(True)
				elseif shifted_key then
					invalidate_cursor_rect (False)
					cursor.go_end_line
					invalidate_cursor_rect(True)
				else
					cursor.go_end_line
					has_selection := False
					invalidate
					update
				end

			elseif  virtual_key = Vk_delete then
				if has_selection then
					delete_selection
				else
					cursor.delete_char
				end
				invalidate
				update

			elseif  virtual_key = Vk_Back then
				if has_selection then
					delete_selection
				else
					cursor.delete_previous
				end
				invalidate
				update

			elseif  virtual_key = Vk_Insert then
				insert_mode := not insert_mode
				invalidate
				update

			elseif virtual_key = Vk_Return then
				if has_selection then
					delete_selection
				end
				cursor.insert_eol
				invalidate
				update

			elseif virtual_key = Vk_Shift then
				shifted_key := True

			else
				-- Key not handled, do nothing
			end
		end

	on_key_up (virtual_key: INTEGER; key_data: INTEGER) is
			-- Process Wm_keydown message corresponding to the
			-- key `virtual_key' and the associated data `key_data'.
		do
			if virtual_key = Vk_Shift then
				shifted_key := False
			end
		end

 	on_char (character_code, key_data: INTEGER) is
   			-- Wm_char message
   			-- See class WEL_VK_CONSTANTS for `character_code' value.
		local
			c		: CHARACTER
			wel_rect: WEL_RECT
   		do

			if (character_code /= Vk_Back) and then	(character_code /= Vk_return) then
				c := character_code.ascii_char
				if has_selection then
					delete_selection
					cursor.insert_char (c)
					invalidate
					update
				else
					invalidate_cursor_rect(False)

					if insert_mode then
						cursor.replace_char (c)
					else
						cursor.insert_char (c)
					end

					invalidate_cursor_rect(True)
				end
			end
 		end

	on_left_button_down (mouse_key, x_pos, y_pos: INTEGER) is
		local
			l_number: INTEGER
			new_cursor: TEXT_CURSOR
			xline : EDITOR_LINE
		do
--			l_number := ((y_pos - Top_margin_width)// line_increment) + first_line_displayed
--			create cursor.make_from_absolute_pos (x_pos - Left_margin_width, l_number, text_displayed)
			l_number := (y_pos // line_increment) + first_line_displayed
			if l_number > number_of_lines then
				xline := text_displayed.last_line
				create new_cursor.make_from_relative_pos (xline, xline.end_token, 1, Current)
			else
				create new_cursor.make_from_absolute_pos (x_pos, l_number, Current)
			end
			if not has_selection then
				if shifted_key then
					has_selection := True
					selection_start := clone (cursor)
				end
				cursor := new_cursor
			elseif shifted_key then
				cursor := new_cursor
			else
				cursor := new_cursor
				has_selection := False
			end
			invalidate
			update
		end

feature -- Selection Handling

	cut_selection is
		do
			copy_selection
			delete_selection
		end

	copy_selection is
		do
		end

	paste_selection is
		do
		end

	delete_selection is
			-- delete text being in selection.
		local
			begin: TEXT_CURSOR
		do
			if (cursor < selection_start) then
				begin := cursor
				text_displayed.delete_selection (cursor, selection_start)
			else
				begin := selection_start
				text_displayed.delete_selection (selection_start, cursor)
			end
			cursor.make_from_absolute_pos (begin.x_in_pixels, begin.y_in_lines, Current)
			has_selection := False
		end



feature {NONE} -- Display functions
	
	update_buffered_screen (dc: WEL_DC; top: INTEGER; bottom: INTEGER) is
			-- Update the device context `dc'. Redraw the text.
		local
			curr_line: INTEGER
			first_line_to_draw: INTEGER
			last_line_to_draw: INTEGER
		do
				-- Draw all lines
			first_line_to_draw := (first_line_displayed + top // line_increment - 1).max(1)
			last_line_to_draw := (first_line_displayed + bottom // line_increment).min(number_of_lines)

			if first_line_to_draw <= last_line_to_draw then
				text_displayed.go_i_th(first_line_to_draw)
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
			end
		end

	display_line (a_line: INTEGER; line: EDITOR_LINE; dc: WEL_DC) is
			-- Display `line' at the coordinates (`d_x',`d_y') on the
			-- device context `dc'.
		local
			curr_y				: INTEGER
			cursor_line 		: BOOLEAN -- Is the cursor present in the current line?
			curr_token			: EDITOR_TOKEN
			width_cursor		: INTEGER
			start_cursor		: INTEGER
			selected_line		: BOOLEAN -- Is the entire line selected?
			not_selected_line	: BOOLEAN -- Is the entire line NOT selected?
			token_selection		: INTEGER
			token_begin_selection: INTEGER
			token_end_selection: INTEGER
			begin_selection		: TEXT_CURSOR -- Cursor that represents the begin of the selection
			end_selection		: TEXT_CURSOR
		do
			curr_y := (a_line - first_line_displayed)*line_increment
			cursor_line := (a_line = cursor.y_in_lines)

			if has_selection then
				if cursor > selection_start then
					begin_selection := selection_start
					end_selection := cursor
				else
					begin_selection := cursor
					end_selection := selection_start
				end
				if (a_line > begin_selection.y_in_lines) and (a_line < end_selection.y_in_lines) then
					selected_line := True
				end
				if (a_line < begin_selection.y_in_lines) or (a_line > end_selection.y_in_lines) then
					not_selected_line := True
				end
			end

			from
				line.start
			until
				line.after
			loop
				curr_token := line.item

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
					elseif (a_line = begin_selection.y_in_lines) and then (a_line = end_selection.y_in_lines) then
						if (curr_token.position > begin_selection.token.position) and then (curr_token.position < end_selection.token.position) then
							token_selection := Token_selected
						elseif (curr_token.position < begin_selection.token.position) or else (curr_token.position > end_selection.token.position) then
							token_selection := Token_not_selected
						else
							token_begin_selection := 1
							token_end_selection := curr_token.length + 1
							if (curr_token.position = begin_selection.token.position) then
								token_selection := Token_half_selected
								token_begin_selection := begin_selection.pos_in_token
							end
							if (curr_token.position = end_selection.token.position) then
								token_selection := Token_half_selected
								token_end_selection := end_selection.pos_in_token
							end
						end

						-- Some tokens in the line are selected (first selected line)
					elseif (a_line = begin_selection.y_in_lines) then
						if (curr_token.position > begin_selection.token.position) then
							token_selection := Token_selected
						elseif (curr_token.position = begin_selection.token.position) then
							token_selection := Token_half_selected
							token_begin_selection := begin_selection.pos_in_token
							token_end_selection := curr_token.length + 1
						end

						-- Some tokens in the line are selected (last selected line)
					elseif (a_line = end_selection.y_in_lines) then
						if (curr_token.position < end_selection.token.position) then
							token_selection := Token_selected
						elseif (curr_token.position = end_selection.token.position) then
							token_selection := Token_half_selected
							token_begin_selection := 1
							token_end_selection := end_selection.pos_in_token
						end

					end
				end

				inspect token_selection
				when Token_not_selected then
						-- Normally Display the token.
					curr_token.display(curr_y, dc)
				when Token_selected then
					curr_token.display_selected(curr_y, dc)
				when Token_half_selected then
					curr_token.display_half_selected(curr_y, token_begin_selection, token_end_selection, dc)
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
						width_cursor := curr_token.get_substring_width(cursor.pos_in_token) - curr_token.get_substring_width(cursor.pos_in_token - 1)
						width_cursor := width_cursor.max(2)
					else
						width_cursor := 2
					end
						-- Draw the cursor
					dc.select_brush(black_brush)
					dc.pat_blt(start_cursor, curr_y, width_cursor, line_height, Blackness)
					dc.unselect_brush
				end

					-- prepare next iteration
				line.forth
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
			Result := Result.max(1)
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

	black_brush: WEL_BRUSH is
		local
			black_color: WEL_COLOR_REF
		once
			create black_color.make_rgb(0,0,0)
			create Result.make_solid(black_color)
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
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

	cursor: TEXT_CURSOR

	selection_start: TEXT_CURSOR
			-- Position where the user has started to select
			-- the text. This position can be below the current
			-- cursor (and therefore represent the end of the
			-- selection)

	has_selection: BOOLEAN
			-- Is there a selection?

	shifted_key: BOOLEAN

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
