indexing
	description: "[
		Read-only text area with cursor and selection.
		Cursor and selection can be modifed by using the keyboard and the mouse.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTABLE_TEXT_PANEL

inherit
	KEYBOARD_SELECTABLE_TEXT_PANEL
		redefine
			build_editor_area,
			recycle
		end

create
	make

feature {NONE} -- Initialization

	build_editor_area is
			-- Initialize variables and objects related to display.
		do

			Precursor {KEYBOARD_SELECTABLE_TEXT_PANEL}

			----------------------------
			-- Vision2 initialisation --
			----------------------------
			editor_area.pointer_button_press_actions.extend (~on_mouse_button_down)
			editor_area.pointer_double_press_actions.extend (~on_double_click)
			editor_area.pointer_button_release_actions.extend (~on_mouse_button_up)
			editor_area.pointer_motion_actions.extend (~on_mouse_move)

			create click_delay.make_with_interval (0)
			click_delay.actions.wipe_out
			click_delay.actions.extend (~mouse_time_out_action)

			create autoscroll.make_with_interval (0)
			autoscroll.actions.extend (~scroll)
		end

feature {NONE} -- Process Vision2 events

	on_mouse_button_down (abs_x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process single click on mouse buttons.
		local
			x_pos: INTEGER
		do
			if not text_displayed.is_empty then
				editor_x := editor_area.screen_x
				editor_y := editor_area.screen_y

				if 
					abs_x_pos >= 0 
						and then
					y_pos > 0
						and then
					y_pos <= editor_area.height
				then
					x_pos := abs_x_pos + offset 
					if x_pos <= left_margin_width then
						on_click_in_margin (x_pos, y_pos, button, a_screen_x, a_screen_y)
					elseif abs_x_pos <= editor_area.width then
						on_click_in_text (x_pos - left_margin_width, y_pos, button, a_screen_x, a_screen_y)
					end
				end
			end
		end

	on_double_click (abs_x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process double clicks on mouse buttons 
		do
			if not text_displayed.is_empty then
				editor_x := editor_area.screen_x
				editor_y := editor_area.screen_y
				if 
					button = 1 
						and then
					not shifted_key
						and then
					(click_count \\ 2) = 1
						and then
					abs_x_pos + offset >= left_margin_width 
						and then
					y_pos >= 0
						and then
					y_pos <= editor_area.height
				then
					process_left_click (abs_x_pos + offset - left_margin_width, y_pos, a_screen_x, a_screen_y)
				end
			end
		end
	
	on_mouse_move (abs_x_pos, abs_y_pos: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y:INTEGER) is
			-- Process events related to mouse pointeur moves.
		do
			if	(not text_displayed.is_empty)
					and then
				click_count < 4
					and then
				mouse_left_button_down
			then
				scroll_and_select (abs_x_pos, abs_y_pos,a_screen_x, a_screen_y)
			end
		end

	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- Process release of mouse buttons.
		do
			if button = 1 then
				mouse_left_button_down := False
				if editor_area.has_capture then
					editor_area.disable_capture
				end
			elseif button = 3 then
				mouse_right_button_down := False
			end
			queue_mouse_up (button)
		end

feature {NONE} -- Scroll Management

	scroll is
			-- Scroll one step (i.e. 10 pixels horizontally and/or one line vertically)
			-- in the direction defined by `scroll_horizontal', `scroll_right', `scroll_vertical'
			-- and `scroll_up'.
		do
			if scroll_horizontal then
				if scroll_right then
					set_offset ((offset + 10).min (editor_width - editor_area.width).max (0))
				else
					set_offset ((offset - 10).max (0))
				end
			end
			if scroll_vertical then
				if scroll_up then
					set_first_line_displayed ((first_line_displayed - 1).max (1), False)
				else
					set_first_line_displayed ((first_line_displayed + 1).min (maximum_top_line_index), False)
				end
			else
				update_display
			end
			if current_mouse_coordinates /= Void then
				check
						-- array has indexes 1 to 4
					current_mouse_coordinates.index_set.is_equal (create {INTEGER_INTERVAL}.make (1, 4))
				end
					-- call on_mouse_move back to handle selection.
				on_mouse_move (current_mouse_coordinates @ 1, current_mouse_coordinates @ 2, 0, 0, 0, current_mouse_coordinates @ 3, current_mouse_coordinates @ 4)
			end
		end

feature {NONE} -- Handle mouse clicks

	on_click_in_margin (x_pos, y_pos, button: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Process click in the margin. `x_pos' and `y_pos' are coordinates relative to the upper left
			-- left corner of the margin, i.e. offset has already been added/substracted to them.
			-- `a_screen_x' and `a_screen_y' are the mouse pointer absolute coordinates on the screen.
		require
			in_window: y_pos > 0 and then (y_pos // line_height) <= number_of_lines + number_of_lines_displayed
		do
			on_click_in_text (0, y_pos, button, a_screen_x, a_screen_y)
		end

	on_click_in_text (x_pos, y_pos, button: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Process click on the text. `x_pos' and `y_pos' are coordinates relative to the upper left
			-- left corner of the text, i.e. margin width and offset have already been added/substracted to them.
			-- `a_screen_x' and `a_screen_y' are the mouse pointer absolute coordinates on the screen.
		require
			in_window: y_pos > 0 and then (y_pos // line_height) <= number_of_lines_displayed + first_line_displayed
		local
			l_number: INTEGER
			old_l_number: INTEGER
		do
			if button = 1 then
				mouse_right_button_down := False
				l_number := (y_pos // line_height) + first_line_displayed
				if (click_count \\ 2) /= 1 then
					if shifted_key and then (not text_displayed.has_selection) then
							-- No selection? We have to start one.
						text_displayed.set_selection_cursor(clone (text_displayed.cursor))
						text_displayed.enable_selection
						old_l_number := text_displayed.cursor.y_in_lines
					end
					process_left_click (x_pos.max (1), y_pos, a_screen_x, a_screen_y)
					if shifted_key then
							-- Look if we have preform a deselection.
						if text_displayed.cursor.is_equal (text_displayed.selection_cursor) then
								-- The selection has to be forgotten.
							text_displayed.disable_selection
							invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
						else
							invalidate_block (old_l_number.min (l_number), l_number.max (old_l_number))
						end
					end
				end
			end
		end

	process_left_click (x_pos, y_pos: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Process click with mouse left button. `x_pos' and `y_pos' are coordinates relative to the upper left
			-- left corner of the text, i.e. margin width and offset have already been added/substracted to them.
			-- `a_screen_x' and `a_screen_y' are the mouse pointer absolute coordinates on the screen.
		require
			text_displayed /= Void
			x_valid: x_pos > 0
			y_valid: y_pos > 0
		local
			old_l_number	: INTEGER
			stop, cursor: TEXT_CURSOR
		do
			cursor := text_displayed.cursor
			old_l_number := cursor.y_in_lines
			mouse_left_button_down := True
			if not shifted_key and then text_displayed.has_selection then
					-- The selection has to be forgotten.
				text_displayed.disable_selection
				invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
			end

			if not editor_area.has_capture then
				editor_area.enable_capture
			end			
			position_cursor (cursor, x_pos + font.width // 3, y_pos)
			former_pointed_line := cursor.y_in_lines
			former_pointed_char := cursor.x_in_characters
			former_y := y_pos
			former_mouse_y := a_screen_y

	--		tab ?= cursor.token
	--		if tab /= Void or else cursor.token.next = Void then
	--				-- update cursor x_in_pixel if cursor on a tabulation or at the end of a line
	--			cursor.set_current_char (cursor.token, cursor.pos_in_token)
	--		end
			invalidate_line (old_l_number, False)
			invalidate_line (cursor.y_in_lines, False)
			if not shifted_key then
				store_mouse_up := True
				click_delay.set_interval (0)				 
				click_delay.set_interval (300)
				click_count := click_count + 1
				mouse_up_delayed := False
				check
					no_selection: not text_displayed.has_selection
				end
				if click_count /= 1 then
					if click_count = 2 then
						empty_word_selection := False
						stop := clone (cursor)
						text_displayed.set_selection_cursor (cursor)
						text_displayed.selection_cursor.go_start_word
						cursor.go_end_word
						if cursor.is_equal (text_displayed.selection_cursor) then
							cursor.go_right_char_no_down_line
							cursor.go_end_word
							if cursor.is_equal (text_displayed.selection_cursor) then
								text_displayed.disable_selection
								empty_word_selection := True
								cursor := stop
							end
						end
						invalidate_line (cursor.y_in_lines, False)
					elseif quadruple_click_enabled and then click_count > 3 then
						select_all
					else
						cursor.go_start_line
						text_displayed.set_selection_cursor (cursor)
						cursor.go_end_line
						cursor.go_right_char
						invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
					end
				end
			end
		end

	mouse_time_out_action is
			-- Process mouse button up event if necessary.
			-- Called when `click_delay' is out.
		do
			click_delay.set_interval (0)
				-- Change the state of our flag.
			store_mouse_up := false
			if mouse_up_delayed then
				mouse_up_delayed := False
				mouse_up_action (1)
			end
		end
		
	queue_mouse_up (button: INTEGER) is
			-- Delay or launch mouse left button up event processing
			-- according to `store_mouse_up'.
		do
			if store_mouse_up and button = 1 then 
				mouse_up_delayed := true
			else
				mouse_up_action (button)
			end
		end

	mouse_up_action (button: INTEGER) is
			-- Process mouse button `button' up event.
		local
			l_num: INTEGER
			cursor: TEXT_CURSOR
		do
			if button = 1 then
				click_count := 0
				if not text_displayed.is_empty then
					cursor := text_displayed.cursor
					if cursor.token /= Void then
						l_num := cursor.y_in_lines
						if cursor.token = cursor.line.real_first_token then
							cursor.make_from_character_pos (1, l_num, text_displayed)
						else
							cursor.make_from_character_pos (cursor.x_in_characters, l_num, text_displayed)
						end
						invalidate_line (l_num, False)
						invalidate_line (cursor.y_in_lines, True)
						check_cursor_position
					end
				end
			end
			if not text_displayed.is_empty and then text_displayed.selection_is_empty and then has_selection then
				disable_selection
			end
			if autoscroll.interval /= 0 then
				autoscroll.set_interval(0)
			end
		end

	scroll_and_select (abs_x_pos, abs_y_pos: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Compute valid coordinates if the mouse is out of the panel, use these values
			-- to position cursor, begin automatic scroll if necessary and update selection.
			-- Part of mouse pointer moves event processing.
		local
			x_pos		: INTEGER
			y_pos		: INTEGER
			i		: INTEGER
			editr_height	: INTEGER
			x_computed	: BOOLEAN
			stop_scrolling	: BOOLEAN
		do
			editr_height := editor_area.height
			y_pos := abs_y_pos.max (1)
			x_pos := (abs_x_pos - left_margin_width + offset).max (1)
			scroll_horizontal := false
			scroll_vertical := false
			stop_scrolling := true
			current_mouse_coordinates := <<abs_x_pos, abs_y_pos, a_screen_x, a_screen_y>>

				-- Let's check if the pointer is still in the editor area
				-- if not launch automatic scroll and correct `x_pos' and `y_pos' values.

			if a_screen_x <= editor_x + left_margin_width then
					-- cursor on the left of the text
					-- launch horizontal scroll if necessary
				if editor_area.width < editor_width then	
					stop_scrolling := False
					scroll_horizontal := true
					scroll_right := false
					i := editor_x + left_margin_width - a_screen_x
					autoscroll.set_interval (2000 // (5 + i.min (95)))
					y_pos:= (former_y + a_screen_y - former_mouse_y).max (1)
				end
				x_pos := offset + 1
				x_computed := true

			elseif a_screen_x >= editor_x + editor_area.width then
					-- cursor on the right of the text
					-- launch horizontal scroll if necessary
				if editor_area.width < editor_width then	
					stop_scrolling := False
					scroll_horizontal := true
					scroll_right := true
					i := a_screen_x - editor_x - editor_area.width
					autoscroll.set_interval (2000 // (5 + i.min (95)))
					y_pos := (former_y + a_screen_y - former_mouse_y).max (1)
				end
				x_pos := offset + editor_area.width - left_margin_width
				x_computed := True
			end

			if a_screen_y <= editor_y then
					-- cursor above the text
					-- launch vertical scroll if necessary
				if number_of_lines > number_of_lines_displayed then
					scroll_vertical := true
					scroll_up := true
					stop_scrolling := false
					i := i.max(editor_y - a_screen_y)
					autoscroll.set_interval (2000 // (5 + i.min (95)))
					y_pos := 1
				end
				if not x_computed then
					x_pos := former_x + a_screen_x - former_mouse_x
				end

			elseif a_screen_y >= editor_y + editr_height then
					-- cursor below the text
					-- launch vertical scroll if necessary
				if number_of_lines > number_of_lines_displayed then
					stop_scrolling := false
					scroll_vertical := true
					scroll_up := false
					i := i.max (a_screen_y - editor_y - editr_height)
					autoscroll.set_interval (2000 // (5 + i.min (95)))
					y_pos := editr_height - 1
				end
				if not x_computed then
					x_pos := former_x + a_screen_x - former_mouse_x
				end
			end
				-- if no scroll needed, stop automatic scroll
			if stop_scrolling then
				if autoscroll.interval /= 0 then
					autoscroll.set_interval(0)
				end
			end
			former_y := y_pos
			former_x := x_pos
			former_mouse_y := a_screen_y
			former_mouse_x := a_screen_x
			if not scroll_only then
				perform_selection (x_pos, y_pos, a_screen_x, a_screen_y)
			end
		end

	perform_selection (x_pos, y_pos, a_screen_x, a_screen_y:INTEGER) is
			-- Update selection as the mouse pointer has moved.
			-- Selection mode depends on how many times the user has clicked
			-- on the mouse button before moving the pointer.
		require
			valid_x: x_pos > 0
			valid_y: y_pos > 0
		local
			l_number		: INTEGER
			i			: INTEGER
			cur			: TEXT_CURSOR
			cursor			: TEXT_CURSOR
			selection_cursor	: TEXT_CURSOR
		do
			cursor := text_displayed.cursor
			selection_cursor := text_displayed.selection_cursor

				-- Save cursor position.	
			if not text_displayed.has_selection then	
					-- There is no selection, so we start a selection.
				text_displayed.set_selection_cursor(clone (cursor))
				text_displayed.enable_selection
			end
	
				-- Compute the line number pointed by the mouse cursor
			l_number := ((y_pos // line_height) + first_line_displayed)

			if click_count = 2 then
					-- movement after double click : word by word selection
				create cur.make_from_integer (1, text_displayed)
				position_cursor (cur, x_pos, y_pos)
				if empty_word_selection then
					if cur < selection_cursor then
						cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
						cursor.go_start_word
						if not text_displayed.has_selection then
							text_displayed.enable_selection
						end
					elseif cur > selection_cursor then
						cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
						cursor.go_end_word
						if not text_displayed.has_selection then
							text_displayed.enable_selection
						end
					else
						cursor.make_from_relative_pos(selection_cursor.line, selection_cursor.token, selection_cursor.pos_in_token, text_displayed)
						if text_displayed.has_selection then
							text_displayed.disable_selection
						end
					end
				elseif selection_cursor < cursor then
					if selection_cursor <= cur then
						cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
						if cursor.is_equal (selection_cursor) then
							cursor.go_right_char_no_down_line
						end
						cursor.go_end_word 
					elseif selection_cursor > cur then
						selection_cursor.go_right_char_no_down_line
						selection_cursor.go_end_word
						cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
						cursor.go_start_word
					end
				elseif selection_cursor > cursor then
					if cursor > cur then
						cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
						cursor.go_start_word
					elseif cursor < cur then
						if cur > selection_cursor then
							i := selection_cursor.y_in_lines
							selection_cursor.go_left_char
							if i /= selection_cursor.y_in_lines then
								selection_cursor.go_right_char
							end
							selection_cursor.go_start_word
							cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
							if cursor.is_equal (selection_cursor) then
								cursor.go_right_char_no_down_line
							end
							cursor.go_end_word
						elseif cur < selection_cursor then
							cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
							cursor.go_right_char_no_down_line
							cursor.go_end_word
							if cursor.is_equal (selection_cursor) then
								selection_cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
								selection_cursor.go_start_word
							else
								cursor.make_from_relative_pos (cur.line, cur.token, cur.pos_in_token, text_displayed)
								cursor.go_start_word
							end
						end
					end
				end
				l_number := cursor.y_in_lines
			elseif click_count = 3 then
				i := cursor.y_in_lines
				if selection_cursor <= cursor then
					position_cursor (cursor, x_pos, y_pos)
					if l_number >= selection_cursor.y_in_lines then
						selection_cursor.go_start_line
						cursor.go_end_line
						cursor.go_right_char
						invalidate_block (i.min (l_number), i.max (l_number))
					else
						selection_cursor.go_end_line
						selection_cursor.go_right_char
						cursor.go_start_line
						invalidate_block (l_number.min (i), i.max (l_number))
					end
				else
					position_cursor(cursor, x_pos, y_pos)
					if l_number >= selection_cursor.y_in_lines - 1 then
						selection_cursor.set_y_in_lines (selection_cursor.y_in_lines - 1)
						selection_cursor.go_start_line
						cursor.go_end_line
						cursor.go_right_char
						invalidate_block (i, l_number)
					else
						selection_cursor.go_start_line
						cursor.go_start_line
						invalidate_block (l_number.min (i), i.max (l_number))
					end
				end
			else
				position_cursor (cursor, x_pos, y_pos)
			end

			if cursor.is_equal (selection_cursor) then
					-- Forget selection if nothing is selected.
				text_displayed.disable_selection
			end

			if l_number /= former_pointed_line then
				from
					i := l_number.min (former_pointed_line)
				until
					i = l_number.max (former_pointed_line)
				loop
					invalidate_line (i,false)
					i := i + 1
				end
				invalidate_line (i,true)
				former_pointed_line := l_number
			elseif former_pointed_char /= cursor.x_in_characters then
				invalidate_line (l_number,true)
				former_pointed_char := cursor.x_in_characters
			end
		end

feature {NONE} -- Cursor positioning

	position_cursor (cursor: TEXT_CURSOR; x_pos, y_pos: INTEGER) is
			-- Position `cursor' as close as possible from coordinates (x_pos, y_pos).
		require
			valid_y: y_pos > 0
			valid_x: x_pos > 0
		local
			l_number	: INTEGER
			current_width	: INTEGER
			nol		: INTEGER
			pointed_line	: EDITOR_LINE
			pointed_token	: EDITOR_TOKEN
			tw		: INTEGER
		do
				-- Compute the line number pointed by the mouse cursor
				-- and adjust it if its over the number of lines in the text.
			l_number := (y_pos // line_height) + first_line_displayed
			nol := text_displayed.number_of_lines
			
			if
				l_number > nol
			then
				l_number := nol
			end
			current_width := x_pos
			pointed_line := text_displayed.line (l_number)
			pointed_token := pointed_line.first_token
			from
				tw := pointed_token.width
			until
				pointed_token = Void or else tw > current_width
			loop
				current_width := current_width - tw
				pointed_token := pointed_token.next
				if pointed_token /= Void then
					tw := pointed_token.width
				end
			end
			if pointed_token /= Void then
				cursor.make_from_relative_pos (pointed_line, pointed_token, pointed_token.retrieve_position_by_width (current_width), text_displayed)
			else
				cursor.make_from_relative_pos (pointed_line, pointed_line.eol_token, 1, text_displayed)
			end
		end

feature {NONE} -- Private Characteristics of the window

	mouse_left_button_down: BOOLEAN
			-- Is the left button of the mouse down?

	mouse_right_button_down: BOOLEAN
			-- Is the right button of the mouse down?

	editor_x: INTEGER
			-- Editor_area absolute position.
	
	editor_y: INTEGER
			-- Editor_area absolute position.

	click_delay: EV_TIMEOUT
			-- Timer to delay mouse up events processing between double click and triple click.

	store_mouse_up: BOOLEAN
			-- Delay mouse up event processing?
	
	mouse_up_delayed: BOOLEAN
			-- Is there delayed mouse up event to be processed?

	click_count: INTEGER
			-- Number of consecutive clicks.

	former_pointed_char: INTEGER
			-- Number of the pointed character before cursor moved.

	former_pointed_line: INTEGER
			-- Number of the pointed line before cursor moved.

	former_x: INTEGER
			-- Position of mouse pointer in the area before it moved.

	former_mouse_x: INTEGER
			-- Position of mouse pointer in the screen before it moved.

	former_y: INTEGER
			-- Position of mouse pointer in the area before it moved.

	former_mouse_y: INTEGER
			-- Position of the mouse pointer in the screen before it moved.

	autoscroll: EV_TIMEOUT
			-- Timer to scroll the text automatically.

	scroll_vertical: BOOLEAN
			-- Do automatic scroll perform vertical scroll?

	scroll_up: BOOLEAN
			-- If `vertical_scroll', automatic scroll to top?

	scroll_horizontal: BOOLEAN
			-- Do automatic scroll perform horizontal scroll?

	scroll_right: BOOLEAN
			-- If `horizontal_scroll', automatic scroll to right?

	current_mouse_coordinates: ARRAY [INTEGER]
			-- Coordinates of mouse pointer during automatic scrolling.

	empty_word_selection: BOOLEAN
			-- Did word by word selection begin with empty selection (end of line)?

	quadruple_click_enabled: BOOLEAN is
			-- Should a quadruple click result in the selection of the entire text?
		once
			Result := True
		end
	
	scroll_only: BOOLEAN is
			-- Block selection modification?
		do
		end

feature {NONE} -- Memory Management

	recycle is
			-- Destroy `Current'.
		do
			Precursor {KEYBOARD_SELECTABLE_TEXT_PANEL}

			if click_delay /= Void and then not click_delay.is_destroyed then
				click_delay.destroy
			end
			click_delay := Void

			if autoscroll /= Void and then not autoscroll.is_destroyed then
				autoscroll.destroy
			end
			autoscroll := Void
		end	
				
end -- class INTERACTIVE_TEXT_PANEL
