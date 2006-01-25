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
			handle_character,
			process_text, load_file,
			load_text, reload,
			initialize_customizable_commands,
			basic_cursor_move,
			text_displayed,
			recycle	,
			file_loading_setup,
			on_text_saved,
			on_text_back_to_its_last_saved_state,
			on_key_down,
			make
		end

	CODE_COMPLETABLE
		export
			{NONE} all
		undefine
			default_create,
			shifted_key,
			ctrled_key,
			alt_key,
			unwanted_characters,
			refresh
		redefine
			can_complete,
			exit_complete_mode,
			handle_tab_action,
			complete_feature_call,
			on_key_pressed,
			calculate_completion_list_width
		end

	EB_COMPLETION_POSSIBILITIES_PROVIDER
		export
			{NONE} all
		undefine
			default_create,
			prepare_completion
		end

create
	make

feature {NONE} -- Initialize

	make(a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize the editor.
		do
			Precursor {EB_CLICKABLE_EDITOR} (a_dev_window)

				-- Initialize code completion.
			initialize_code_complete
			set_completion_possibilities_provider (Current)
			set_code_completable (Current)
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
			-- Complete feature name.
		do
			set_completing_feature (true)
			complete_code
		end

	complete_class_name is
			-- Complete class name.
		do
			set_completing_feature (false)
			complete_code
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

feature {NONE} -- Text loading

	string_loading_setup, file_loading_setup is
			-- Setup editor just before file/string loading begins.
		do
			text_displayed.enable_click_tool
			text_displayed.setup_click_tool (dev_window.stone, not is_unix_file)
			process_click_tool_error
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
			if not is_completing and then code = Key_tab and then allow_tab_selecting then
					-- Tab action
				handle_tab_action
			elseif not is_completing and then can_complete_by_key.item ([ev_key, ctrled_key, alt_key, shifted_key]) then
				trigger_completion
				debug ("Auto_completion")
					print ("Completion triggered.%N")
				end
			else
				block_completion
				debug ("Auto_completion")
					print ("Completion blocked.%N")
				end
				if code = Key_enter and then not has_selection then
						-- Return/Enter key action
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
					Precursor (ev_key)
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

	basic_cursor_move (action: PROCEDURE [like cursor_type,TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char.
		do
			Precursor {EB_CLICKABLE_EDITOR} (action)
			switch_auto_point := False
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

feature {NONE} -- Autocomplete implementation

	on_key_down (ev_key: EV_KEY)is
		do
			completion_timeout.actions.block
			Precursor (ev_key)
		end

	auto_point: BOOLEAN
			-- Should autocomplete add `.' next time it is called?

	switch_auto_point: BOOLEAN
			-- Should `auto_point' have the opposite value?

	auto_point_token: EDITOR_TOKEN
			-- Point where autocomplete should add a period.

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

feature {NONE} -- Possiblilities provider

	completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Completions proposals found by `prepare_auto_complete'
		do
			Result := text_displayed.click_tool.completion_possibilities
		end

	class_completion_possibilities: SORTABLE_ARRAY [EB_NAME_FOR_COMPLETION] is
			-- Completions proposals found by `prepare_auto_complete'
		do
			Result := text_displayed.click_tool.class_completion_possibilities
		end

	insertion: STRING is
			-- Strings to be partially completed : the first one is the dot or tilda if there is one
			-- the second one is the feature name to be completed
		do
			Result := text_displayed.click_tool.insertion.item
		end

	insertion_remainder: INTEGER is
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		do
			Result := text_displayed.click_tool.insertion_remainder
		end

	prepare_completion is
			-- Prepare completion
		do
			Precursor
			if completing_feature and then click_and_complete_is_active and then not has_selection then
				text_displayed.prepare_auto_complete (false)
			elseif not completing_feature and then not has_selection then
				text_displayed.prepare_class_name_complete
			end
		end

feature {NONE} -- Code completable implementation

	current_line: EIFFEL_EDITOR_LINE is
			-- Line of current cursor.
			-- Every query is not guarenteed the same object.
		do
			Result := text_displayed.cursor.line
			if Result = Void then
				create Result.make_empty_line
			end
		end

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN is
			-- Can completing by these keys?
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
		do
			if a_key /= Void then
				if
					a_key.code = {EV_KEY_CONSTANTS}.key_period and
					not a_ctrl and
					not a_alt and
					not a_shift
				then
					Result := true
					set_completing_feature (true)
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := true
					set_completing_feature (true)
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("class_autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := true
					set_completing_feature (false)
				end
			end
		end

	handle_tab_action is
			-- Handle tab action.
		do
			run_if_editable (agent tab_action)
			run_if_editable (agent invalidate_cursor_rect (True))
			run_if_editable (agent check_cursor_position)
		end

	go_to_start_of_selection is
			-- Move cursor to the start of the selection if possible.
		do
			if text_displayed.cursor /= text_displayed.selection_start then
				if text_displayed.selection_end.y_in_lines = text_displayed.selection_start.y_in_lines then
					text_displayed.cursor.make_from_relative_pos (text_displayed.current_line, text_displayed.selection_start.token, text_displayed.selection_start.pos_in_token, text_displayed)
				else
					text_displayed.cursor.make_from_relative_pos (text_displayed.current_line, text_displayed.current_line.first_token, 1, text_displayed)
				end
			end
			disable_selection
		end

	go_to_end_of_selection is
			-- Move cursor to the end of selection
		do
			if text_displayed.cursor /= text_displayed.selection_end then
				if text_displayed.selection_end.y_in_lines = text_displayed.selection_start.y_in_lines then
					text_displayed.cursor.make_from_relative_pos (text_displayed.current_line, text_displayed.selection_end.token, text_displayed.selection_end.pos_in_token, text_displayed)
				else
					text_displayed.cursor.make_from_relative_pos (text_displayed.current_line, text_displayed.current_line.eol_token, 1, text_displayed)
				end
			end
			disable_selection
		end

	go_to_start_of_line is
			-- Move cursor to the start of a line
			-- where tab switching to next feature argument should function.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.cursor.go_start_line
		end

	go_to_end_of_line is
			-- Move cursor to the start of a line.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.cursor.go_end_line
		end

	go_right_char is
			-- Go to right character.
		do
			text_displayed.cursor.go_right_char_no_down_line
		end

	move_cursor_to (a_token: EDITOR_TOKEN; a_line: like current_line) is
			-- Move cursor to `a_token' which is in `a_line'.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.cursor.make_from_relative_pos (a_line, a_token, 1, text_displayed)
		end

	select_region_between_token (a_start_token: EDITOR_TOKEN; a_start_line: like current_line; a_end_token: EDITOR_TOKEN; a_end_line: like current_line) is
			-- Select from the start position of `a_start_token' to the start position of `a_end_token'.
		do
			text_displayed.selection_cursor.make_from_relative_pos (a_start_line, a_start_token, 1, text_displayed)
			text_displayed.cursor.make_from_relative_pos (a_end_line, a_end_token, 1, text_displayed)
			text_displayed.enable_selection
		end

	allow_tab_selecting: BOOLEAN is
			-- Allow tab selecting?
		local
			l_current_line: like current_line
			l_current_token: EDITOR_TOKEN
			l_has_left_brace_ahead, l_has_right_brace_following, l_has_right_brace_ahead, seperator_ahead: BOOLEAN
		do
			if has_selection implies text_displayed.selection_start.y_in_lines = text_displayed.selection_end.y_in_lines then
				l_current_line := current_line
				from
					l_current_line.start
				until
					l_current_line.after or l_current_line.item = text_displayed.cursor.token
				loop
					if l_current_line.item.is_text and then l_current_line.item.image.is_equal ("(") then
						l_has_left_brace_ahead := true
					end
					if l_current_line.item.is_text and then l_current_line.item.image.is_equal (")") then
						l_has_right_brace_ahead := true
					end
					if l_current_line.item.is_text and then (l_current_line.item.image.is_equal (",") or else l_current_line.item.image.is_equal (";")) then
						seperator_ahead := true
					end
					l_current_line.forth
				end

				from
					l_current_token := current_token_in_line (l_current_line)
				until
					l_current_token = Void or else l_current_token = l_current_line.eol_token
				loop
					if l_current_token.image.is_equal (")") then
						l_has_right_brace_following := true
					end
					l_current_token := l_current_token.next
				end
				Result := l_has_left_brace_ahead or (l_has_right_brace_following and seperator_ahead) or l_has_right_brace_ahead
			end
		end

	current_token_in_line (a_line: like current_line): EDITOR_TOKEN is
			-- Token of the cursor.
		do
			Result := text_displayed.cursor.token
		end

	selection_start_token_in_line (a_line: like current_line): EDITOR_TOKEN is
			-- Start token in the selection.
		do
			if text_displayed.cursor.y_in_lines = text_displayed.selection_start.y_in_lines then
				Result := text_displayed.selection_start.token
			else
				Result := current_line.first_token
			end
		end

	selection_end_token_in_line (a_line: like current_line): EDITOR_TOKEN is
			-- Token after end of selection.
		do
			if text_displayed.cursor.y_in_lines = text_displayed.selection_end.y_in_lines then
				Result := text_displayed.selection_end.token
			else
				Result := current_line.eol_token
			end
		end

	show_possible_selection is
			-- Show possible selection
		do
			text_displayed.enable_selection
			if has_selection then
				show_selection (False)
			end
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := editor_drawing_area.key_press_actions
		end

	delete_char is
			-- Delete char.
		do
			text_displayed.delete_char
		end

	back_delete_char is
			-- Back delete character.
		do
			text_displayed.back_delete_char
		end

	insert_string (a_str: STRING) is
			-- Insert `a_str' at cursor position.
		do
			text_displayed.insert_string (a_str)
		end

	insert_char (a_char: CHARACTER) is
			-- Insert `a_char' at cursor position.
		do
			text_displayed.insert_char (a_char)
		end

	replace_char (a_char: CHARACTER) is
			-- Replace current char with `a_char'.
		do
			text_displayed.replace_char (a_char)
		end

	resume_focus_in_actions is
			-- Resume focus in actions
			-- (export status {EB_CODE_COMPLETION_WINDOW})
		do
			editor_drawing_area.focus_in_actions.resume
		end

	block_focus_in_actions is
			-- Block focus in actions
			-- (export status {EB_CODE_COMPLETION_WINDOW})
		do
			editor_drawing_area.focus_in_actions.block
		end

	block_focus_out_actions is
			-- Block focus out actions.
			-- (export status {EB_CODE_COMPLETION_WINDOW})
		do
			editor_drawing_area.focus_out_actions.block
		end

	resume_focus_out_actions is
			-- Resume focus out actions.
			-- (export status {EB_CODE_COMPLETION_WINDOW})
		do
			editor_drawing_area.focus_out_actions.resume
		end

	save_cursor_position is
			-- Save cursor position for retrieving.
		do
			saved_cursor := text_displayed.cursor.twin
		end

	retrieve_cursor_position is
			-- Retrieve cursor position from saving.
		do
			text_displayed.cursor.make_from_character_pos (saved_cursor.x_in_characters, saved_cursor.y_in_lines, text_displayed)
		end

	saved_cursor: EDITOR_CURSOR

	complete_feature_call (completed: STRING; is_feature_signature: BOOLEAN; appended_character: CHARACTER; remainder: INTEGER) is
			--
		do
			text_displayed.complete_feature_call (completed, is_feature_signature, appended_character, remainder)
		end


	select_from_cursor_to_saved is
			-- Select from cursor position to saved cursor position
		do
			check saved_cursor /= Void end
			text_displayed.selection_cursor.make_from_character_pos (text_displayed.cursor.x_in_characters, text_displayed.cursor.y_in_lines, text_displayed)
			text_displayed.cursor.make_from_character_pos (saved_cursor.x_in_characters, saved_cursor.y_in_lines, text_displayed)
			text_displayed.enable_selection
		end

	end_of_line: BOOLEAN is
			--
		do
			Result := text_displayed.cursor.token = text_displayed.cursor.line.eol_token
		end

	current_char: CHARACTER is
			-- Current character, to the right of the cursor.
		do
			Result := text_displayed.cursor.item
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Do nothing.
			-- We do it in `handle_extended_key'
		do
		end

	completing_automatically: BOOLEAN
			-- Is completion being shown automatically?

	completing_word: BOOLEAN is
			-- Has user requested to complete a word.
			-- Note: Word completion is based on context.
			-- Completing without context is considered completing (pressing CTRL+SPACE for a feature list of Current).
			-- Completing with context (a_var.f..., a_v...) is completing a word.
		require else
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
		ensure then
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
