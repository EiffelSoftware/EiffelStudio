indexing
	description: "[
		Editor with search and pick n drop.
		Uses a tool to make feature text clickable.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICKABLE_EDITOR

inherit

	EB_EDITOR
		rename
			make as make_editor
		redefine
			reset, on_text_loaded,
			build_editor_area, gain_focus,
			on_mouse_button_down, on_click_in_margin,
			on_click_in_text, handle_extended_key,
			handle_extended_ctrled_key, left_margin_width,
			text_displayed, display_margin,
			copy_selection,
			reference_window,
			recycle
		end

	EB_FORMATTED_TEXT
		export
			{NONE} All
		undefine
			clear_window, reset
		redefine
			process_text
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

create
	make

feature {NONE}-- Initialization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize the editor. 
		do
			make_editor
			dev_window := a_dev_window
			if dev_window /= Void then
				dev_window.add_editor_to_list (Current)
					-- Register the dev_window as an observer of `Current'
				text_displayed.add_selection_observer (dev_window)
			end
			create after_reading_text_actions.make
			initialize_customizable_commands
		end

	initialize_customizable_commands is
			-- Create array of customizable commands.
		do
			create customizable_commands.make (3, 7)
			customizable_commands.put (~search, 3)
			customizable_commands.put (~replace, 4)
			customizable_commands.put (~find_selection, 5)
			customizable_commands.put (~find_next, 6)
			customizable_commands.put (~find_previous, 7)
		end

	build_editor_area is
			-- Initialize variables and objects related to display.
		do
			{EB_EDITOR} Precursor
			editor_area.set_pebble_function (~pebble_from_x_y)
			editor_area.enable_pebble_positioning
		end

feature -- Access

	search_tool: EB_SEARCH_TOOL is
			-- Current search tool.
		do
			if dev_window /= Void then
				Result := dev_window.search_tool
			end
		end

	text_length: INTEGER is
			-- Length of displayed text.
		do
			Result := text_displayed.text_length
		end

	position: INTEGER is
			-- Current cursor position.
		do
			if text_displayed.is_empty then
				Result := 0
			else
				Result := text_displayed.cursor.pos_in_text
			end
		end

	current_text: STRUCTURED_TEXT is
			-- Structured text loaded in the editor.
		do
			Result := text_displayed.current_text
		end

	structured_text: STRUCTURED_TEXT is
			-- Structured text corresponding to the text
			-- displayed in the editor
		do
			Result := current_text
			if Result = Void then
				Result := text_displayed.structured_text
			end
		end

	reference_window: EV_WINDOW is
			-- Window which error dialogs will be shown relative to.
		do
			if internal_reference_window = Void then
				if dev_window /= Void and then dev_window.window /= Void then
					Result := dev_window.window
				else
					Result := Window_manager.last_focused_window.window
				end
			else
				Result := internal_reference_window
			end
		end
			
feature -- Content Change

	process_text (str_text: STRUCTURED_TEXT) is
			-- Load `str_text' in the editor.
		local
			local_str_text: like str_text
		do
			editor_area.disable_sensitive

				-- Reset the editor state
			reset
			allow_edition := False
			if str_text /= Void and then not str_text.is_empty then
				local_str_text := str_text
			else
				create local_str_text.make
				local_str_text.add (create {BASIC_TEXT}.make (""))
			end
				-- Read and parse the text.
			text_displayed.set_first_read_block_size (number_of_lines_displayed)
			text_displayed.load_structured_text (local_str_text)

				-- Setup the editor (scrollbar, ...)
			setup_editor

			editor_area.enable_sensitive

		end

feature -- Status Report

	has_breakable_slots: BOOLEAN is
		do
			Result := text_displayed.has_breakable_slots
		end

feature -- Status setting

	enable_has_breakable_slots is
			-- Set `has_breakable_slots' to `True' and update display.
		do
			if not hidden_breakpoints then
				text_displayed.enable_has_breakable_slots

					-- Update display
				left_margin_buffered_screen.set_size (left_margin_width, editor_area.height)
				update_buffered_screen (0, editor_area.height)
				update_display
			end
		end	

	disable_has_breakable_slots is
			-- Set `has_breakable_slots' to `False' and update display.
		do
			text_displayed.disable_has_breakable_slots

				-- Update display
			left_margin_buffered_screen.set_size (left_margin_width, editor_area.height)
			update_buffered_screen (0, editor_area.height)
		end

feature -- Basic Operations

	hide_breakpoints is
			-- Do not show breakpoints even if there are some.
		do
			hidden_breakpoints := True
		end

	show_breakpoints is
			-- Show breakpoints if there are some.
		do
			hidden_breakpoints := False
		end

feature -- Possibly delayed operations

	display_line_when_ready (l_num: INTEGER; highlight: BOOLEAN) is
			-- same as select_region but scroll to the selected position
			-- (beginning of selection at then bottom of the editor) and
			-- does not need the text to be fully loaded			
		do
				if text_is_fully_loaded then
					if highlight then
						text_displayed.select_line (l_num)
					end
					display_line_with_context (l_num)
					refresh_now
				else
					after_reading_text_actions.extend(~display_line_when_ready (l_num, highlight))
				end
		end

	highlight_when_ready (a, b: INTEGER) is
			-- same as select_region but scroll to the selected position
			-- (beginning of selection at then bottom of the editor) and
			-- does not need the text to be fully loaded	
		local
			fld: INTEGER
			max_pos: INTEGER
		do
				if text_is_fully_loaded then
					max_pos := text_displayed.text_length
					select_region (a.min (max_pos), b.min (max_pos))
					if number_of_lines > number_of_lines_displayed then
						fld := text_displayed.selection_start.y_in_lines - number_of_lines_displayed + (number_of_lines_displayed // 2).min(2)
						fld := fld.max (1).min (maximum_top_line_index)
						set_first_line_displayed (fld, True)
					end
				else
					after_reading_text_actions.extend(~ highlight_when_ready (a, b))
				end
		end

	scroll_to_when_ready (pos: INTEGER) is
			-- scroll to position `pos' in characters
			-- does not need the text to be fully loaded
		local
			cursor: EDITOR_CURSOR			
		do
				if text_is_fully_loaded then
					cursor := text_displayed.cursor
					if text_displayed.has_selection then
						text_displayed.disable_selection
					end
					cursor.make_from_integer (pos.min (text_displayed.text_length), text_displayed)
					if number_of_lines > number_of_lines_displayed then
						set_first_line_displayed (cursor.y_in_lines.min (maximum_top_line_index), True)
						check_position (cursor)
					end
					refresh
				else
					after_reading_text_actions.extend(~scroll_to_when_ready (pos))
				end
		end

	scroll_to_end_when_ready is
			-- scroll to position `pos' in characters
			-- does not need the text to be fully loaded			
		do
				if text_is_fully_loaded then
					if text_displayed.has_selection then
						text_displayed.disable_selection
					end
					text_displayed.cursor.make_from_character_pos (1, number_of_lines, text_displayed)
					if number_of_lines > number_of_lines_displayed then
						check_cursor_position
					end
					refresh
				else
					after_reading_text_actions.extend(~scroll_to_end_when_ready)
				end
		end

	display_breakpoint_number_when_ready (bpn: INTEGER) is
			-- scroll to position `pos' in characters
			-- does not need the text to be fully loaded			
		do
			if text_is_fully_loaded then
				display_breakpoint_number (bpn)
			else
				after_reading_text_actions.extend(~display_breakpoint_number (bpn))
			end
		end

feature  -- Compatibility

	set_position (a_position: INTEGER) is
			-- Set cursor position to `a_position'.
		do
			text_displayed.set_position (a_position)
		end

	put_string (s: STRING) is
			-- Put string `s' at current position.
		do
			text_displayed.put_string (s)
		end

	put_char (c: CHARACTER) is
			-- Put a character `c' at current position.
		do
			text_displayed.put_char (c)
		end

	new_line is
			-- Put a new line at current position.
		do
			text_displayed.new_line
		end

feature {EB_COMMAND} -- Search commands

	find_next is
			-- Find next occurrence of last searched pattern.
		do
			search_tool.go_to_next_found
			check_cursor_position
		end

	find_previous is
			-- Find next occurrence of last searched pattern.
		do
			search_tool.go_to_previous_found
			check_cursor_position
		end

	find_selection is
			-- Find next occurence of selection.
		do
			if not text_displayed.selection_is_empty then
				search_tool.set_current_searched (text_displayed.selected_string)
			end
			find_next
		end

	search is
			-- Display search tool if necessary.
		do
			if not search_tool.mode_is_search then
				search_tool.set_mode_is_search (True)
			end
			prepare_search_tool
		end

	replace is
			-- Display search tool (with Replace field) if necessary.
		do
			if search_tool.mode_is_search then
				search_tool.set_mode_is_search (False)
			end
			prepare_search_tool
		end

	copy_selection is
			-- Copy current selection to clipboard.
		do
			{EB_EDITOR} Precursor
			if dev_window /= Void then
				dev_window.update_paste_cmd
			end
		end

feature {EB_FEATURE_INFO_FORMATTER} -- Feature click tool

	enable_feature_click is
			-- enable feature click tool		
		do
			text_displayed.enable_feature_click
		end

	disable_feature_click is
			-- disable feature click tool					
		do
			text_displayed.disable_feature_click
		end

	set_feature_for_click (feat: E_FEATURE) is
			-- initialize feature click tool with feature `feat'
		do
			text_displayed.set_feature_for_click (feat)
		end

	feature_click_enabled: BOOLEAN is
			-- do we use feature click tool?
		do
			Result := text_displayed.feature_click_enabled
		end

feature {NONE}-- Process Vision2 Events

	on_mouse_button_down (abs_x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process single click on mouse buttons.
		do
			if pick_n_drop_status = pnd_pick then
				refresh_now
			end
			{EB_EDITOR} Precursor (abs_x_pos, y_pos, button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

	on_click_in_margin (x_pos, y_pos, button: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Process click in the margin. `x_pos' and `y_pos' are coordinates relative to the upper left
			-- left corner of the margin, i.e. offset has already been added/substracted to them.
			-- `a_screen_x' and `a_screen_y' are the mouse pointer absolute coordinates on the screen.
		local
			ln: EDITOR_LINE
			l_number: INTEGER
			bkstn: BREAKABLE_STONE
		do
			if button = 1 and then pick_n_drop_status /= pnd_drop then
				mouse_right_button_down := False
				l_number := (y_pos // line_height) + first_line_displayed
				if l_number <= number_of_lines then
					ln := text_displayed.line (l_number)
					bkstn ?= ln.real_first_token.pebble
					if bkstn /= Void then
						toggle_bkpt (bkstn)
					end
					{EB_EDITOR} Precursor (x_pos, y_pos, 1, a_screen_x, a_screen_y)
				end
			elseif button = 3 then
				on_click_in_text (x_pos - left_margin_width, y_pos, 3, a_screen_x, a_screen_y)
			end
		end

	on_click_in_text (x_pos, y_pos, button: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Process click on the text. `x_pos' and `y_pos' are coordinates relative to the upper left
			-- left corner of the text, i.e. margin width and offset have already been added/substracted to them.
			-- `a_screen_x' and `a_screen_y' are the mouse pointer absolute coordinates on the screen.
		local
			l_number: INTEGER
			ln: EDITOR_LINE
			stone: STONE
			bkstn: BREAKABLE_STONE
			cur: EDITOR_CURSOR
		do
			if button = 1 and then pick_n_drop_status /= pnd_drop then
				{EB_EDITOR} Precursor (x_pos, y_pos, button, a_screen_x, a_screen_y)
			elseif button = 3 then
				mouse_right_button_down := True
				if x_pos <= 0 then
					l_number := (y_pos // line_height) + first_line_displayed
					if text_displayed.number_of_lines >= l_number then
						ln := text_displayed.line (l_number)
						bkstn ?= ln.real_first_token.pebble
					end
					create cur.make_from_character_pos (1, 1, text_displayed)
					position_cursor (cur, 1, y_pos)
				else
					create cur.make_from_character_pos (1, 1, text_displayed)
					position_cursor (cur, x_pos, y_pos)
					bkstn ?= cur.token.pebble
				end
				if bkstn = Void then
					if ctrled_key then
						stone := text_displayed.stone_at (cur)
						if stone /= Void then
							Window_manager.create_window
							if Window_manager.last_created_window /= Void then
								Window_manager.last_created_window.set_stone (stone)
							end
						end
					end
				else
					text_displayed.cursor.make_from_character_pos (cur.x_in_characters, cur.y_in_lines, text_displayed)
					display_bkpt_menu (bkstn)
					refresh_now
				end
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			index: LINKED_LIST [INTEGER]
			executed_command: BOOLEAN
		do
			index := index_of_customizable_commands (ev_key.code, False, alt_key, shifted_key)
			from
				index.start
			until
				index.after or executed_command
			loop
				if customizable_commands.valid_index (index.item) then
					(customizable_commands @ index.item).apply
					executed_command := True
				end
				index.forth
			end
			if executed_command then
				check_cursor_position
			else
				{EB_EDITOR} Precursor (ev_key)
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			index: LINKED_LIST [INTEGER]
			executed_command: BOOLEAN
		do
			index := index_of_customizable_commands (ev_key.code, True, alt_key, shifted_key)
			from
				index.start
			until
				index.after or executed_command
			loop
				if customizable_commands.valid_index (index.item) then
					(customizable_commands @ index.item).apply
					executed_command := True
				end
				index.forth
			end
			if executed_command then
				check_cursor_position
			else
				{EB_EDITOR} Precursor (ev_key)
			end
		end

feature {NONE} -- Pick and drop

	pebble_from_x_y (x_pos_with_margin, y_pos: INTEGER): STONE is
			-- Stone on (`x_pos', `y_pos').
		local
			cur		: EDITOR_CURSOR
			l_number	: INTEGER
			x_pos		: INTEGER
			token_pos	: INTEGER
			bkst		: BREAKABLE_STONE
			old_offset	: INTEGER
		do
			if not (ctrled_key or else mouse_copy_cut) then
				if not text_displayed.is_empty then
					x_pos := x_pos_with_margin - left_margin_width + offset
						-- Compute the line number pointed by the mouse cursor
						-- and asdjust it if its over the number of lines in the text.
					l_number := (y_pos // line_height) + first_line_displayed
					if
						l_number > 0 and then
						l_number <= number_of_lines and then
						x_pos >= -left_margin_width + offset and then
						x_pos < editor_area.width + offset
					then
						create cur.make_from_character_pos (1, 1, text_displayed)
						position_cursor (cur, x_pos.max (1), y_pos)
						Result := text_displayed.stone_at (cur)
						if Result /= Void and then Result.is_valid then
							bkst ?= Result
							if bkst = Void then
								l_number := cur.y_in_lines
								--old_l_number := text_displayed.cursor.y_in_lines
								token_pos := cur.token.position
								if text_displayed.has_selection then
									text_displayed.disable_selection
									invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines)
								else
									invalidate_line (text_displayed.cursor.y_in_lines, False)
								end
								cur.set_current_char (cur.token, 1)
								text_displayed.cursor.make_from_character_pos (cur.x_in_characters, l_number, text_displayed)
								text_displayed.selection_cursor.make_from_character_pos (cur.x_in_characters + cur.token.length, l_number, text_displayed)
								text_displayed.enable_selection
								old_offset := offset
								check_cursor_position
								editor_area.set_pebble_position (token_pos + left_margin_width - offset, (l_number - first_line_displayed)*line_height + line_height//2)
								if Result.stone_cursor /= Void then
									editor_area.set_accept_cursor (Result.stone_cursor)
								end
								if Result.x_stone_cursor /= Void then
									editor_area.set_deny_cursor (Result.x_stone_cursor)
								end
								pick_n_drop_status := pnd_pick
								invalidate_line (l_number, True)
							else
								Result := Void
							end
						else
							Result := Void
						end
					end
				end
			end
		end

	pick_n_drop_status: INTEGER
			-- Step of the pick n drop where the editor is.

	pnd_pick, pnd_drop, no_pnd: INTEGER is unique

feature {NONE} -- Text Loading

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
				-- First abort our previous actions.
			{EB_EDITOR} Precursor
			if search_tool /= Void then
				search_tool.force_new_search
			end
			after_reading_text_actions.wipe_out
		end

	on_text_loaded  is
			-- Finish editor setup as the entire text has been loaded.
		do
			{EB_EDITOR} Precursor
			from
				after_reading_text_actions.start
			until
				after_reading_text_actions.after
			loop
				after_reading_text_actions.item.call([])
				after_reading_text_actions.forth
			end
			after_reading_text_actions.wipe_out
		end

feature {EB_EDITOR_TOOL} -- Update

	on_text_saved is
			-- Update the editor as the text has been saved.
		local
			fn: STRING
			backup_file: RAW_FILE
			file: RAW_FILE
		do
			text_displayed.set_changed (False)
			if open_backup then
				fn := clone (file_name)
				create backup_file.make (file_name)
				backup_file.delete
				fn.head (fn.count - 4)
				create file_name.make_from_string (fn)
				open_backup := False
			end
			if file_name /= Void then
				create file.make (file_name)
				if file.exists then
					date_of_file_when_loaded := file.date
				end
			end
		end

feature {NONE} -- Implementation

	customizable_commands: ARRAY [PROCEDURE [like Current, TUPLE]]
			-- Array of customizable commands

	dev_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window

	after_reading_text_actions: LINKED_LIST [PROCEDURE [EB_CLICKABLE_EDITOR, TUPLE]]
			-- Procedures to be applied when the text is completely loaded.

	text_displayed: CLICKABLE_TEXT
			-- Text displayed in the editor.

	hidden_breakpoints: BOOLEAN
			-- Are brekpoints hidden ?

	index_of_customizable_commands (key_code: INTEGER; ctrl, alt, shift: BOOLEAN): LINKED_LIST[INTEGER] is
			-- List of indeces in `customizable_commands' of commands that correspond to the shortcut
			-- defined by key of code `key_code' and Ctrl if `ctrl', Shift if `shift' and Alt if `alt'.
		local
			index, i: INTEGER
			meta: ARRAY [BOOLEAN]
		do
			create Result.make
			from
				i := 1
				index := Editor_preferences.key_codes_for_actions.index_of (key_code, 1)
			until
				index = 0
			loop
				create meta.make (1,3)
				meta.put (ctrl, 1)
				meta.put (alt, 2)
				meta.put (shift, 3)
				if meta.is_equal (Editor_preferences.ctrl_alt_shift_for_actions.item (index)) then
					Result.extend (index)
				end
				i := i + 1
				index := Editor_preferences.key_codes_for_actions.index_of (key_code, i)
			end
		end

	prepare_search_tool is
			-- Show and give focus to search panel.
		do
			if search_tool.is_visible then
				search_tool.set_focus
			else
				if not text_displayed.selection_is_empty then
					search_tool.set_current_searched (text_displayed.selected_string)
				end
				search_tool.show_and_set_focus
			end
			check_cursor_position
		end

	display_breakpoint_number (bp_number: INTEGER) is
			-- Show `bp_number'-th breakpoint.
		require
			bp_number_is_valid: bp_number > 0
			text_completely_loaded: text_is_fully_loaded
		local
			ln: EDITOR_LINE
			bp_count, line_index: INTEGER
			bp_token: EDITOR_TOKEN_BREAKPOINT
		do
			from
				ln := text_displayed.first_line
			until
				ln = Void or else bp_count = bp_number
			loop
				bp_token ?= ln.real_first_token
				if bp_token /= Void and then bp_token.pebble /= Void then
					bp_count := bp_count + 1
				end
				line_index := line_index + 1
				ln := ln.next
			end
			if bp_count = bp_number then
				display_line_with_context (line_index)
			else
				debug ("EDITOR")
					io.error.putstring ("%N Editor Warning : Unable to scroll to Breakpoint number "+ bp_number.out + "%N")
					io.error.putstring ("                   There are only " + bp_count.out + " in currently displayed class.%N")
				end
			end
		end

	gain_focus is
			-- Update the editor as it has just gained the focus.
		do
			{EB_EDITOR} Precursor
			if dev_window /= Void then
				dev_window.set_current_editor (Current)
			end
		end

	display_bkpt_menu (bkpt: BREAKABLE_STONE) is
			-- Display a context menu associated with `bkpt', so that
			-- the user can enable/disable/remove it, or run to cursor.
		local
			menu: EV_MENU
			item: EV_MENU_ITEM
			conv_dev: EB_DEVELOPMENT_WINDOW
		do
			create menu
			create item.make_with_text (Interface_names.m_Enable_this_bkpt)
			item.select_actions.extend (Application~enable_breakpoint (bkpt.routine, bkpt.index))
			item.select_actions.extend (Output_manager~display_stop_points)
			item.select_actions.extend (window_manager~quick_refresh_all)
			if Application.is_breakpoint_enabled (bkpt.routine, bkpt.index) then
				item.disable_sensitive
			end
			menu.extend (item)
			create item.make_with_text (Interface_names.m_Disable_this_bkpt)
			item.select_actions.extend (Application~disable_breakpoint (bkpt.routine, bkpt.index))
			item.select_actions.extend (Output_manager~display_stop_points)
			item.select_actions.extend (window_manager~quick_refresh_all)
			if Application.is_breakpoint_disabled (bkpt.routine, bkpt.index) then
				item.disable_sensitive
			end
			menu.extend (item)
			create item.make_with_text (Interface_names.m_Remove_this_bkpt)
			item.select_actions.extend (Application~remove_breakpoint (bkpt.routine, bkpt.index))
			item.select_actions.extend (Output_manager~display_stop_points)
			item.select_actions.extend (window_manager~quick_refresh_all)
			if not Application.is_breakpoint_set (bkpt.routine, bkpt.index) then
				item.disable_sensitive
			end
			menu.extend (item)
			create item.make_with_text (Interface_names.m_Run_to_this_point)
			conv_dev ?= window_manager.last_focused_window
			if conv_dev /= Void then
					-- `conv_dev = Void' should never happen.
				menu.extend (create {EV_MENU_SEPARATOR})
				item.select_actions.extend (debugger_manager~set_debugging_window (conv_dev))
				item.select_actions.extend ( (debugger_manager.debug_run_cmd)~process_breakable (bkpt))
				menu.extend (item)
			end

			menu.show
			mouse_right_button_down := False
			mouse_left_button_down := False
		end

	toggle_bkpt (bkpt: BREAKABLE_STONE) is
			-- If `bkpt' was not set or disabled, enable it.
			-- If `bkpt' was already enabled, remove it.
		do
			if Application.is_breakpoint_enabled (bkpt.routine, bkpt.index) then
				Application.remove_breakpoint (bkpt.routine, bkpt.index)
			else
				Application.enable_breakpoint (bkpt.routine, bkpt.index)
			end
			Output_manager.display_stop_points
			window_manager.quick_refresh_all
		end

feature {NONE} -- Constants & Text Attributes

	Left_margin_width: INTEGER is
			-- Width in pixel of the margin on the left
			-- of the screen.
			--
			-- Breakpoint slot are placed in this margin.
		do
			if Display_margin then 
				Result := 16
			else
				Result := 6
			end
		end

	Display_margin: BOOLEAN is
			-- Should the margin be displayed or not?
		do
			Result := (not hidden_breakpoints) and then has_breakable_slots
		end

feature -- Memory management

	recycle is
			-- Destroy `Current'
		do
			Precursor {EB_EDITOR}
			if customizable_commands /= Void then
				customizable_commands.discard_items
				customizable_commands := Void
			end
			if after_reading_text_actions /= Void then
				after_reading_text_actions.wipe_out
				after_reading_text_actions := Void
			end
		end

end -- class EB_CLICKABLE_EDITOR
