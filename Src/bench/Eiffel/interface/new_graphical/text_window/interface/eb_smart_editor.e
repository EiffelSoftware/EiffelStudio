indexing
	description: "[
		Advanced editor for Eiffel Studio.
		Completes syntax automatically.
		Includes tool to make basic eiffel text clickable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SMART_EDITOR

inherit
	EB_CLICKABLE_EDITOR
		export
			{ANY} highlight_selected, first_line_displayed
			{EB_COMPLETION_CHOICE_WINDOW} Editor_preferences, line_height, offset
		redefine
			handle_extended_key,
			handle_extended_ctrled_key,
			handle_character, reset,
			on_mouse_button_down,
			on_double_click,
			process_text, load_file,
			load_text, reload,
			initialize_customizable_commands,
			basic_cursor_move,
			text_displayed,
			recycle	,
			file_loading_setup,
			key_not_handled_action,
			on_text_saved,
			on_text_back_to_its_last_saved_state,
			on_key_down,
			make
		end

create
	make

feature {NONE} -- Initialize

	make(a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize the editor.
		do
			Precursor {EB_CLICKABLE_EDITOR} (a_dev_window)

				-- Create timeout for completion list.
			create completion_timeout.make_with_interval (1500)
			completion_timeout.actions.extend (agent complete_feature_name)
			completion_timeout.actions.block
		end

feature -- Content change

	set_editor_text (s: STRING) is
			-- load text represented by `s' in the editor
			-- text is considered edited after load, i.e. save command
			-- is sensitive.
			-- `file_name' is left unchanged.
		local
			f_n: FILE_NAME
			f_d, f_d_c: INTEGER
		do
			f_n := file_name
			f_d := date_of_file_when_loaded
			f_d_c := date_when_checked
			load_text (s)
			text_displayed.set_changed (True, False)
			file_name := f_n
			date_of_file_when_loaded := f_d
			date_when_checked := f_d_c
		end

	process_text (str_text: STRUCTURED_TEXT) is
			-- Load the text `str_text' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (agent process_text (str_text))
			else
				Precursor {EB_CLICKABLE_EDITOR} (str_text)
			end
			load_without_save := False
		end

	reload is
			-- Reload the file named `file_name' in the editor.
		do
			load_without_save := True
			Precursor {EB_CLICKABLE_EDITOR}
		end

feature -- Status report

	click_and_complete_is_active: BOOLEAN is
			-- If in the basic text format, is the text clickable?
		do
			Result := text_displayed.click_and_complete_is_active and then allow_edition and then not open_backup
		end

	syntax_is_correct: BOOLEAN is
			-- When text was parsed, was a syntax error found?
		do
			Result := text_displayed.click_tool_status /= text_displayed.syntax_error
		end

	load_without_save: BOOLEAN
			-- Check and save file before loading a new content?

	exploring_current_class: BOOLEAN is
			-- Is the current class being explored by the click tool?
		do
			Result := text_displayed.exploring_current_class
		end

feature -- Status setting

	no_save_before_next_load is
			-- Disable check before next loading.
		do
			load_without_save := True
		end

feature -- Search

	find_feature_named (a_name: STRING) is
			-- Look for a feature named `a_name' in the text and
			-- scroll to the corresponding line.
		local
			click_tool_status: BOOLEAN
		do
			if text_is_fully_loaded then
				click_tool_status := text_displayed.click_tool_enabled
				text_displayed.enable_click_tool
				text_displayed.find_feature_named (a_name)
				if not click_tool_status then
					text_displayed.disable_click_tool
				end
				if text_displayed.found_feature then
					set_first_line_displayed (text_displayed.current_line_number.min (maximum_top_line_index), True)
					refresh_now
				end
			else
				after_reading_text_actions.extend (agent find_feature_named (a_name))
			end
		end

	found_feature: BOOLEAN is
			-- Was last searched feature name found?
		do
			Result := text_displayed.found_feature
		end

feature {EB_COMMAND, EB_DEVELOPMENT_WINDOW} -- Commands

	complete_feature_name is
			-- Autocomplete feature name before cursor.
		local
			add_point: BOOLEAN
		do
			if not is_completing then
				is_completing := True
				completion_timeout.actions.block
				if click_and_complete_is_active and then not has_selection then
					text_displayed.prepare_auto_complete (add_point)
					if text_displayed.completion_possibilities /= Void then
						completion_mode := completion_mode + 1
						show_completion_list (True)
					end
				end
				check_cursor_position
				is_completing := False
			end
		end

	complete_class_name is
			-- Autocomplete class name before cursor.
		do
			if not has_selection then
				text_displayed.prepare_class_name_complete
				if text_displayed.class_completion_possibilities /= Void then
					show_completion_list (False)
				end
			end
			check_cursor_position
		end

	embed_in_block (keyword: STRING; pos_in_keyword: INTEGER) is
			-- Embed selection or current line in block formed by `keyword' and "end".
			-- Cursor is positioned to the `pos_in_keyword'-th character of `keyword'.
		do
			if is_editable then
				text_displayed.embed_in_block (keyword, pos_in_keyword)
				refresh_now
				check_cursor_position
			end
		end

feature -- Autocomplete

	update_click_list (after_save: BOOLEAN) is
			-- update the click tool
			-- `after_save' must be True if current class text has just been saved
			-- and False otherwise.
		do
			if dev_window.stone /= Void and then text_displayed.click_tool_enabled then
				text_displayed.update_click_list (dev_window.stone, after_save)
				process_click_tool_error
			end
		end

	choices: EB_COMPLETION_CHOICE_WINDOW is
			-- Completion choice window for show feature and class completion options.
		once
			create Result.make
		end

	position_completion_choice_window is
			-- Reposition the completion choice window
		require
			choices_not_void: choices /= Void
		do
			choices.set_size (calculate_completion_list_width, calculate_completion_list_height)
			choices.set_position (calculate_completion_list_x_position, calculate_completion_list_y_position)
		end

	completion_timeout: EV_TIMEOUT
			-- Timeout for showing completion list

feature {NONE} -- Text loading

	string_loading_setup, file_loading_setup is
			-- Setup editor just before file/string loading begins.
		do
			text_displayed.enable_click_tool
			text_displayed.setup_click_tool (dev_window.stone, not is_unix_file)
			process_click_tool_error
		end

	reset is
			-- Make the editor ready to load a new content.
		do
			Precursor {EB_CLICKABLE_EDITOR}
			completion_mode := 0
		end

	on_text_back_to_its_last_saved_state is
			-- Reset click tool when back to the saved state
		do
			Precursor
			if dev_window.stone /= Void and then text_displayed.click_tool_enabled then
				text_displayed.update_click_list (dev_window.stone, True)
				text_displayed.clear_syntax_error
			end
		end

feature {NONE} -- Process Vision2 events

	on_mouse_button_down (abs_x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process single click on mouse buttons.
		do
			completion_mode := 0
			Precursor {EB_CLICKABLE_EDITOR} (abs_x_pos, y_pos, button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

	on_double_click (abs_x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process double clicks on mouse buttons
		do
			completion_mode := 0
			Precursor {EB_CLICKABLE_EDITOR} (abs_x_pos, y_pos, button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

feature {EB_COMPLETION_CHOICE_WINDOW} -- Process Vision2 Events

	handle_character (c: CHARACTER) is
 			-- Process the push on a character key.
		local
			t: EDITOR_TOKEN_KEYWORD
			token: EDITOR_TOKEN
			look_for_keyword: BOOLEAN
			insert: CHARACTER
			syntax_completed: BOOLEAN
			cur: like cursor_type
 		do
			switch_auto_point := auto_point
			if is_editable then
				Precursor (c)
				look_for_keyword := True
				if c = ' ' then
					if latest_typed_word_is_keyword then
							-- case: keyword (is, do, end, etc.)
						cur := text_displayed.cursor.twin
						cur.go_left_char
						token := cur.token
						if token /= Void then
							t ?= token.previous
							if t /= Void and then keyword_image(t).is_equal (previous_token_image) then
								text_displayed.back_delete_char
								text_displayed.complete_syntax (previous_token_image, True, False)
								syntax_completed := text_displayed.syntax_completed
								look_for_keyword := False
								latest_typed_word_is_keyword := False
							end
						end
					else
						token := text_displayed.cursor.token
						if text_displayed.cursor.line.eol_token = token then
								-- case: keyword|space|eol
							if token.previous /= Void and then token.previous.length = 1 then
								t ?= token.previous.previous
							end
						elseif token /= Void then
								-- case: keyword|space|space|...
							if text_displayed.cursor.pos_in_token = 2 then
								t ?= token.previous
							end
						end
						if t /= Void then
							text_displayed.back_delete_char
							look_for_keyword := False
							text_displayed.complete_syntax (keyword_image (t), False, False)
							syntax_completed := text_displayed.syntax_completed
							look_for_keyword := False
						end
					end
					if syntax_completed then
						refresh
					end
				else
					insert := complementary_character (c)
					if insert /= '%U' then
						text_displayed.insert_char (insert)
						text_displayed.cursor.go_left_char
						invalidate_cursor_rect (True)
					end
				end
				if look_for_keyword then
					if text_displayed.cursor.token /= Void then
						t ?= text_displayed.cursor.token.previous
					end
					latest_typed_word_is_keyword := (t /= Void) and then text_displayed.cursor.pos_in_token = 1
					if latest_typed_word_is_keyword then
						previous_token_image := keyword_image (t)
					end
				end
			else
				display_not_editable_warning_message
			end
			auto_point := switch_auto_point xor auto_point
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			t: EDITOR_TOKEN_KEYWORD
			code: INTEGER
			token: EDITOR_TOKEN
			syntax_completed: BOOLEAN
		do
			code := ev_key.code
			switch_auto_point := auto_point and then not (code = Key_shift or code = Key_left_meta or code = Key_right_meta)
			if code = Key_tab and then completion_mode > 0 then
					-- Tab action
				run_if_editable (agent tab_action)
			elseif code = Key_enter and then not has_selection then
					-- Return/Enter key action
				completion_mode := 0
				if is_editable then
					token := text_displayed.cursor.token
					if token /= Void then
						if latest_typed_word_is_keyword then
							t ?= token.previous
							if t /= Void and then keyword_image (t).is_equal (previous_token_image) then
								text_displayed.complete_syntax (previous_token_image, True, True)
								syntax_completed := text_displayed.syntax_completed
								latest_typed_word_is_keyword := false
							end
						else
							t ?= token.previous
							if t /= Void and then text_displayed.cursor.pos_in_token = 1 then
								text_displayed.complete_syntax (keyword_image (t), False, True)
								syntax_completed := text_displayed.syntax_completed
							end
						end
					end

					if syntax_completed then
						check_cursor_position
						refresh_now
					else
						Precursor {EB_CLICKABLE_EDITOR} (ev_key)
					end
				else
					display_not_editable_warning_message
				end
			elseif code = key_period then
					-- case: .				
				Precursor (ev_key)
				if auto_complete_after_dot and then not shifted_key then
					completing_automatically := True
					completion_timeout.reset_count
					completion_timeout.actions.resume
				end
			else
				if completion_mode > 0 then
					if code /= Key_back_space then
						completion_bckp := completion_mode
						completion_mode := 0
					end
					Precursor (ev_key)
					completion_bckp := 0
				else
					Precursor (ev_key)
					completion_mode := 0
				end
			end
			auto_point := switch_auto_point xor auto_point
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			code: INTEGER
		do
			code := ev_key.code
			switch_auto_point := auto_point and then not (code = Key_ctrl or code = Key_shift or code = Key_left_meta or code = Key_right_meta)
			if code = Key_i then
				if not shifted_key then
					if is_editable then
						embed_in_block ("if  then", 3)
					end
				end
			elseif code = Key_d then
				if not shifted_key then
					if is_editable then
						embed_in_block ("debug", 5)
					end
				end
			else
				Precursor (ev_key)
					-- if `auto_point' is true, user has called auto complete
					-- we don't change the value. Else, its new value is set to False unless
					-- only ctrl key was pressed
			end
			auto_point := auto_point xor switch_auto_point
		end

feature {NONE} -- Handle keystrokes

	completion_bckp: INTEGER

	key_not_handled_action is
			-- Apply default key processing.
		do
				-- "if" clause Prevents completion_mode from losing its status when it is larger than 0.
				-- When completion_mode is larger than 0, it implies that we are at the number of completion_mode
				-- deep of completion.
			if completion_mode = 0 then
				completion_mode := completion_bckp
			end
		end

	basic_cursor_move (action: PROCEDURE[like cursor_type,TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char.
		do
			Precursor {EB_CLICKABLE_EDITOR} (action)
			switch_auto_point := False
		end

	tab_action is
			-- Process push on tab key when in auto_complete mode.
		require
			text_displayed_not_void: text_displayed /= Void
		local
			x,y: INTEGER
			cursor: like cursor_type
		do
			from
				cursor := text_displayed.cursor
			until
				cursor.item = '(' or cursor.item = ';' or cursor.item = ')' or cursor.item = '%N'
			loop
				cursor.go_right_char
			end
			if cursor.item /= '%N' then
				if cursor.item = ')' then
					if has_selection then
						disable_selection
					end
					completion_mode := (completion_mode - 1).max (0)
					cursor.go_right_char
				else
					if cursor.item = ';' then
						text_displayed.replace_char (',')
					end
					cursor.go_right_char
					from
						x := cursor.x_in_characters
						y := cursor.y_in_lines
					until
						cursor.item = ';' or cursor.item = ')' or else cursor.token = cursor.line.eol_token
					loop
						cursor.go_right_char
					end
					text_displayed.selection_cursor.make_from_character_pos (cursor.x_in_characters, cursor.y_in_lines, text_displayed)
					cursor.set_y_in_lines (y)
					cursor.set_x_in_characters (x)
					if not has_selection and not cursor.is_equal (text_displayed.selection_cursor) then
						text_displayed.enable_selection
						show_selection (False)
					end
				end
			else
				completion_mode := (completion_mode - 1).max (0)
				handle_extended_key (create {EV_KEY}.make_with_code (key_tab))
			end

			invalidate_cursor_rect (True)
			check_cursor_position
		end

feature {EB_COMPLETION_CHOICE_WINDOW} -- automatic completion

	auto_complete_after_dot: BOOLEAN is
	        -- Should build autocomplete dialog after call on valid target?
	  	do
	  	   	Result := preferences.editor_data.auto_auto_complete
	  	end

	exit_complete_mode is
			-- Set mode to normal (not completion mode).
		do
			is_completing := False
				-- Invalidating cursor forces cursor to be updated.
			invalidate_cursor_rect (False)
			resume_cursor_blinking
			set_focus
		end

	complete_feature_from_window (cmp: STRING; is_feature_signature: BOOLEAN; appended_character: CHARACTER; remainder: INTEGER) is
			-- Insert `cmp' in the editor and switch to completion mode.
			-- If `is_feature_signature' then try to complete arguments and remove the type.
			-- `appended_character' is a character that should be appended after the feature. '%U' if none.
		local
			completed: STRING
			ind: INTEGER
			lp: INTEGER
		do
			auto_point := False
			if is_feature_signature then
				completed := cmp.twin
				ind := completed.last_index_of (':', completed.count)
				lp := completed.last_index_of (')', completed.count)
				if ind > 0 and ind > lp then
					completed.keep_head (ind - 1)
				end
			else
				completed := cmp
			end
			if completed.is_empty then
				completion_mode := (completion_mode - 1).max (0)
				if appended_character /= '%U' then
					text_displayed.insert_char (appended_character)
				end
				--history.unbind_current_item_to_next
			else
				text_displayed.complete_feature_call (completed, is_feature_signature, appended_character, remainder)
				if is_feature_signature then
					if completed.last_index_of (')',completed.count) = completed.count then
						tab_action
					else
						completion_mode := (completion_mode - 1).max (0)
						switch_auto_point := False
						if appended_character = '%U' then
							auto_point := True
							auto_point_token := text_displayed.cursor.token
						else
							auto_point := False
							auto_point_token := Void
						end
					end
				else
					completion_mode := (completion_mode - 1).max (0)
				end
			end
			refresh
		end

	complete_class_from_window (completed: STRING; appended_character: CHARACTER; remainder: INTEGER) is
			-- Insert `completed' in the editor.
		local
			i: INTEGER
		do
			if remainder > 0 then
				from
					i := 0
				until
					i = remainder
				loop
					text_displayed.delete_char
					i := i + 1
				end
			end
			if not completed.is_empty then
				text_displayed.insert_string (completed)
			end
			if appended_character /= '%U' then
				text_displayed.insert_char (appended_character)
			end
			refresh
		end

	insert_character_from_completion_dialog (a_character: CHARACTER) is
			-- Insert `a_character' at current curosor position
		do
			text_displayed.insert_char (a_character)
			invalidate_cursor_rect (True)
		end

	calculate_completion_list_x_position: INTEGER is
			-- Determine the x position to display the completion list
		local
			screen: EB_STUDIO_SCREEN
			tok: EDITOR_TOKEN
			cursor: like cursor_type
			right_space,
			list_width: INTEGER
		do
			create screen

				-- Get current x position of cursor
			cursor := text_displayed.cursor
			tok := cursor.token
			tok.update_position
			Result := tok.position + tok.get_substring_width (cursor.pos_in_token) + widget.screen_x + left_margin_width - offset

				-- Determine how much room there is free on the right of the screen from the cursor position
			right_space := screen.virtual_right - Result - completion_border_size

			list_width := calculate_completion_list_width

			if right_space < list_width then
					-- Shift x pos back so it fits on the screen
				Result := Result - (list_width - right_space)
			end

				-- Add margin width if necessary
			if line_numbers_visible then
				Result := Result + margin.width
			end

			Result := Result - 20
		end

	calculate_completion_list_y_position: INTEGER is
			-- Determine the y position to display the completion list
		local
			cursor: like cursor_type
			screen: EB_STUDIO_SCREEN
			preferred_height,
			upper_space,
			lower_space: INTEGER
			show_below: BOOLEAN
		do
				-- Get y pos of cursor
			create screen
			cursor := text_displayed.cursor
			show_below := True
			Result := widget.screen_y + ((cursor.y_in_lines - first_line_displayed) * line_height)

			if Result < ((screen.virtual_height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := Result - completion_border_size
			lower_space := screen.virtual_bottom - Result - completion_border_size

			if preferences.development_window_data.remember_completion_list_size then
				preferred_height := preferences.development_window_data.completion_list_height

				if show_below and then preferred_height > lower_space and then preferred_height <= upper_space then
						-- Not enough room to show below, but is enough room to show above, so we will show above
					show_below := False
				elseif not show_below and then preferred_height <= lower_space then
						-- Even though we are in the bottom 3rd of the screen we can actually show below because
						-- the saved size fits
					show_below := True
				end

				if show_below and then preferred_height > lower_space then
						-- Not enough room to show below so we must resize
					preferred_height := lower_space
				elseif not show_below and then preferred_height >= upper_space then
						-- Not enough room to show above so we must resize
					preferred_height := upper_space
				end
			else
				if show_below then
					preferred_height := lower_space
				else
					preferred_height := upper_space
				end
			end

			if show_below then
				Result := Result + line_height + 5
			else
				Result := Result - preferred_height
			end
		end

	calculate_completion_list_height: INTEGER is
			-- Determine the height the completion should list should have
		local
			upper_space,
			lower_space,
			y_pos: INTEGER
			screen: EB_STUDIO_SCREEN
			cursor: like cursor_type
			show_below: BOOLEAN
			tok: EDITOR_TOKEN
		do
				-- Get y pos of cursor
			create screen
			cursor := text_displayed.cursor
			tok := cursor.token
			tok.update_position
			show_below := True
			y_pos := widget.screen_y + ((cursor.y_in_lines - first_line_displayed) * line_height)

			if y_pos < ((screen.virtual_height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := y_pos - completion_border_size
			lower_space := screen.virtual_bottom - y_pos - completion_border_size

			if preferences.development_window_data.remember_completion_list_size then
				Result := preferences.development_window_data.completion_list_height

				if show_below and then Result > lower_space and then Result <= upper_space then
						-- Not enough room to show below, but is enough room to show above, so we will show above
					show_below := False
				elseif not show_below and then Result <= lower_space then
						-- Even though we are in the bottom 3rd of the screen we can actually show below because
						-- the saved size fits
					show_below := True
				end

				if show_below and then Result > lower_space then
						-- Not enough room to show below so we must resize
					Result := lower_space
				elseif not show_below and then Result >= upper_space then
						-- Not enough room to show above so we must resize
					Result := upper_space
				end
			else
				if show_below then
					Result := lower_space
				else
					Result := upper_space
				end
			end
		end

	calculate_completion_list_width: INTEGER is
			-- Determine the width the completion list should have			
		do
			if preferences.development_window_data.remember_completion_list_size then
				Result := preferences.development_window_data.completion_list_width
			else
					-- Calculate correct size to fit
				Result := choices.choice_list.column (1).required_width_of_item_span (1, choices.choice_list.row_count) + completion_border_size
			end
		end

	completion_border_size: INTEGER is 75
			-- Size in pixels that the completion list can go to (virtual border)

feature {NONE} -- Autocomplete implementation

	on_key_down (ev_key: EV_KEY)is
		do
			completion_timeout.actions.block
			Precursor (ev_key)
		end

	show_completion_list (is_feature: BOOLEAN) is
			-- Show list of possible features after a point.
		do
			if is_feature then
				choices.initialize_for_features
					(
						Current,
						text_displayed.feature_name_part_to_be_completed,
						text_displayed.feature_name_part_to_be_completed_remainder,
						text_displayed.completion_possibilities,
						completing_word
					)
			else
				choices.initialize_for_classes
					(
						Current,
						text_displayed.feature_name_part_to_be_completed,
						text_displayed.feature_name_part_to_be_completed_remainder,
						text_displayed.class_completion_possibilities
					)
			end
			if choices.is_displayed then
				choices.hide
			end
			if choices.show_needed then
				position_completion_choice_window
				choices.show
			end
		end

	completion_mode: INTEGER
			-- Are we in auto_complete mode?

	auto_point: BOOLEAN
			-- Should autocomplete add `.' next time it is called?

	switch_auto_point: BOOLEAN
			-- Should `auto_point' have the opposite value?

	auto_point_token: EDITOR_TOKEN
			-- Point where autocomplete should add a period.

	is_completing: BOOLEAN
			-- Is completion currently being processed?

feature {NONE} -- syntax completion

	latest_typed_word_is_keyword: BOOLEAN
			-- Is the preceeding token a keyword?

	previous_token_image: STRING
			-- Image of the previous token

	keyword_image (token: EDITOR_TOKEN_KEYWORD): STRING is
			-- Image of keyword beginning by `token'.
		local
			test: STRING
			kw: like token
			blnk: EDITOR_TOKEN_BLANK
			tok: EDITOR_TOKEN
			is_else, is_then: BOOLEAN
		do
			Result :=token.image.twin
			test := Result.as_lower
			is_else := test.is_equal ("else")
			is_then := test.is_equal ("then")
			if is_else or is_then then
				from
					blnk ?= token.previous
				until
					blnk = Void
				loop
					tok := blnk.previous
					blnk ?= tok
				end
				kw ?= tok
				if kw /= Void then
					if is_else then
						test :=kw.image.as_lower
						if test.is_equal ("or") then
							Result.prepend ("or ")
						elseif test.is_equal ("require") then
							Result.prepend ("require ")
						end
					elseif is_then then
						test := kw.image.as_lower
						if test.is_equal ("and") then
							Result.prepend ("and ")
						elseif test.is_equal ("ensure") then
							Result.prepend ("ensure ")
						end
					end
				end
			end
		end

feature {EB_EDITOR_TOOL} -- Implementation

	on_text_saved is
			--
		do
			Precursor {EB_CLICKABLE_EDITOR}
			if syntax_error_dialog /= Void and then not syntax_error_dialog.is_destroyed then
				syntax_error_dialog.destroy
			end
			syntax_error_dialog := Void
		end

feature -- Access

	text_displayed: SMART_TEXT
			-- Displayed text.

feature {NONE} -- Implementation

	process_click_tool_error is
			-- Show warning corresponding to `click_tool' error.
		do
			if text_displayed.click_tool_status = text_displayed.class_name_changed then
				show_warning_message (Warning_messages.w_Class_name_changed)
			elseif text_displayed.click_tool_status = text_displayed.syntax_error then
				show_syntax_warning
			end
		end

	complementary_character (c:CHARACTER): CHARACTER is
			-- Character complementary to `c', i.e. closing bracket
			-- for an opening one for instance.
		do
			Result := '%U'
			if preferences.editor_data.autocomplete_brackets_and_parentheses then
				inspect
					c
				when '%<' then
					Result := '%>'
				when '(' then
					Result := ')'
				when '%(' then
					Result := '%)'
				else
				end
			end
			if preferences.editor_data.autocomplete_quotes then
				inspect
					c
				when '%'' then
					Result := '%''
				when '%Q' then
					Result := '%''
				when '%"' then
					Result := '%"'
				else
				end
			end
		end

	initialize_customizable_commands is
			-- Create array of customizable commands.
		do
			create customizable_commands.make (10)
			customizable_commands.put (agent complete_feature_name, "autocomplete")
			customizable_commands.put (agent complete_class_name, "class_autocomplete")
			customizable_commands.put (agent search, "show_search_panel")
			customizable_commands.put (agent replace, "show_search_and_replace_panel")
			customizable_commands.put (agent find_selection, "search_selection")
			customizable_commands.put (agent find_next, "search_last")
			customizable_commands.put (agent find_previous, "search_backward")
			customizable_commands.put (agent insert_customized_string (1), "customized_insertion_1")
			customizable_commands.put (agent insert_customized_string (2), "customized_insertion_2")
			customizable_commands.put (agent insert_customized_string (3), "customized_insertion_3")
		end

	insert_customized_string (index: INTEGER) is
			--
		do
			text_displayed.insert_customized_expression (preferences.editor_data.customized_strings.i_th (index).value)
			refresh_now
		end

	show_syntax_warning is
			-- Display syntax error warning message
			-- and highlight error.
		require
			syntax_error: not syntax_is_correct
			dev_window_is_not_void: dev_window /= Void
		local
			syn_error: SYNTAX_ERROR
			txt: STRING
			retried: BOOLEAN
			fl: RAW_FILE
		do
			if text_is_fully_loaded then
				if retried then
					show_warning_message (Warning_messages.w_Cannot_read_file (file_name))
				else
					deselect_all
					syn_error := text_displayed.last_syntax_error
					text_displayed.clear_syntax_error
					if file_name /= Void and syn_error /= Void then
						create fl.make_open_read (file_name)
						fl.read_stream (fl.count)
						fl.close
						txt := fl.last_string
						highlight_when_ready (syn_error.line, syn_error.line)
						show_syntax_error
					end
				end
			else
				after_reading_text_actions.extend(agent show_syntax_warning)
			end
		rescue
			retried := True
			retry
		end

	show_syntax_error is
			--
		do
			if syntax_error_dialog = Void or else syntax_error_dialog.is_destroyed then
				create syntax_error_dialog.make_with_text (Warning_messages.w_Syntax_error)
				syntax_error_dialog.default_push_button.select_actions.extend (agent set_focus)
				syntax_error_dialog.show_relative_to_window (reference_window)
			end
		end

	syntax_error_dialog: EV_WARNING_DIALOG

feature -- Text Loading	

	load_file (a_file_name: FILE_NAME) is
			-- Load file named `a_file_name' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (agent load_file (a_file_name))
			else
				Precursor {EB_CLICKABLE_EDITOR} (a_file_name)
			end
			load_without_save := False
		end

	load_text (s: STRING) is
			-- Load text represented by `s' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (agent load_text (s))
			else
				Precursor {EB_CLICKABLE_EDITOR} (s)
			end
			load_without_save := False
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_CLICKABLE_EDITOR}
			if completion_timeout /= Void and then not completion_timeout.is_destroyed then
				completion_timeout.destroy
			end
			completion_timeout := Void
		end

feature {NONE} -- Implementation	

	completing_automatically: BOOLEAN
			-- Is completion being shown automatically?

	completing_word: BOOLEAN is
			-- Has user requested to complete a word.
			-- Note: Word completion is based on context.
			-- Completing without context is considered completing (pressing CTRL+SPACE for a feature list of Current).
			-- Completing with context (a_var.f..., a_v...) is completing a word.
		require
			text_is_fully_loaded: text_is_fully_loaded
		local
			l_text: like text_displayed
			l_tok: EDITOR_TOKEN
		do
			l_text := text_displayed
			if l_text /= Void and then not text_displayed.is_empty then
				from
					l_tok := l_text.cursor.token.previous
				until
					l_tok = Void or else not l_tok.is_blank
				loop
					l_tok := l_tok.previous
				end
				if l_tok /= Void and then l_tok.is_text then
					Result := l_tok.image.is_equal (".") = False
					if not Result then
							-- is a '.'
						Result := not completing_automatically
					end
				end
			end
			completing_automatically := False
		ensure
			completing_automatically_reset: completing_automatically = False
		end

invariant
	completion_timeout_not_void: completion_timeout /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SMART_EDITOR
