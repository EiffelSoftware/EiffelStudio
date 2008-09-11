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
			load_file,
			load_text, reload,
			initialize_customizable_commands,
			basic_cursor_move,
			text_displayed,
			internal_recycle,
			internal_detach_entities,
			file_loading_setup,
			on_text_back_to_its_last_saved_state,
			on_text_edited,
			on_text_reset,
			on_key_down,
			on_mouse_wheel,
			on_mouse_button_up,
			make,
			create_token_handler
		end

	EB_TAB_CODE_COMPLETABLE
		rename
			is_word as is_word_token,
			is_keyword as is_keyword_token
		export
			{NONE} all
		undefine
			default_create,
			shifted_key,
			ctrled_key,
			alt_key,
			unwanted_characters,
			refresh,
			ev_application
		redefine
			can_complete,
			exit_complete_mode,
			handle_tab_action,
			complete_feature_call,
			on_key_pressed,
			calculate_completion_list_width,
			prepare_auto_complete
		end

	ES_HELP_REQUEST_BINDER
		export
			{NONE} all
		undefine
			default_create
		redefine
			show_help
		end

create
	make

feature {NONE} -- Initialize

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize the editor.
		require else
			dev_window_not_void: a_dev_window /= Void
		do
			Precursor {EB_CLICKABLE_EDITOR} (a_dev_window)
				-- Set parent window, for completion
			set_parent_window (a_dev_window.window)

				-- Initialize code completion.
			initialize_code_complete
			set_completion_possibilities_provider (text_displayed)
			text_displayed.set_code_completable (Current)

			if {l_window: !EV_WINDOW} a_dev_window then
				bind_help_shortcut (l_window)
			end
		end

feature {NONE} -- Access

	editor_context_cookie: !UUID
			-- The associated editor's context cookie for use with the event list service.
		do
			if {l_cookie: UUID} internal_editor_context_cookie then
				Result := l_cookie
			else
				Result ?= (create {UUID_GENERATOR}).generate_uuid
				internal_editor_context_cookie := Result
			end
		end

	event_list: !SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to the event list service for adding class syntax errors/warnings.
		once
			create Result
		end

	help_uri_scavenger: !ES_HELP_CONTEXT_SCAVENGER [!EB_SMART_EDITOR]
			-- Scavenger used to local help contexts within the editor
		require
			help_providers_is_service_available: help_providers.is_service_available
		once
			Result ?= create {!ES_EDITOR_HELP_CONTEXT_SCAVENGER}
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

feature {NONE} -- Basic operations

	show_help
			-- Attempts to show help given the current help context implemented on Current.
		local
			l_uri_scavenger: like help_uri_scavenger
			l_contexts: !DS_BILINEAR [!HELP_CONTEXT_I]
			l_dialog: ES_HELP_SELECTOR_DIALOG
		do
			if help_providers.is_service_available and then has_focus then
					-- Look for help contexts
				l_uri_scavenger := help_uri_scavenger
				if {l_editor: !EB_SMART_EDITOR} Current then
					l_uri_scavenger.probe (l_editor)
					if l_uri_scavenger.has_probed then
						l_contexts := l_uri_scavenger.scavenged_contexts
						if not l_contexts.is_empty then
							if l_contexts.count > 1 then
									-- Multiple pieces of help available, show dialog
								create l_dialog.make
								l_dialog.set_links (l_contexts)
								l_dialog.show_on_active_window
							else
									-- Only one piece of help available.
								on_help_requested (l_contexts.first)
							end
						end
					end
				end
			end
		end


feature -- Content change

	set_editor_text (s: STRING_32) is
			-- load text represented by `s' in the editor
			-- text is considered edited after load, i.e. save command
			-- is sensitive.
			-- `file_name' is left unchanged.
		local
			f_n: FILE_NAME
			f_d, f_d_c, f_s: INTEGER
		do
			f_n := file_name
			f_d := date_of_file_when_loaded
			f_s := size_of_file_when_loaded
			f_d_c := date_when_checked
			load_text (s)
			text_displayed.set_changed (True, False)
			file_name := f_n
			date_of_file_when_loaded := f_d
			size_of_file_when_loaded := f_s
			date_when_checked := f_d_c
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

	is_text_loaded (a_stone: STONE): BOOLEAN is
			-- If text loaded?
		do
			if is_text_loaded_called then
				Result := a_stone = stone
			else
				-- Do this for initialization
				is_text_loaded_called := True
			end
		end

feature -- Status setting

	no_save_before_next_load is
			-- Disable check before next loading.
		do
			load_without_save := True
		end

feature -- Search

	find_feature_named (a_name: STRING_32) is
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

feature {EB_COMMAND, EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Commands

	complete_feature_name is
			-- Complete feature name.
		do
			if not is_empty and then text_displayed.completing_context and is_editable then
				set_completing_feature (True)
				if auto_complete_after_dot and then not shifted_key then
					completing_automatically := True
				end
				complete_code
			end
		end

	complete_class_name is
			-- Complete class name.
		do
			if not is_empty and then text_displayed.completing_context and is_editable then
				set_completing_feature (False)
				if auto_complete_after_dot and then not shifted_key then
					completing_automatically := True
				end
				complete_code
			end
		end

	find_matching_brace
			-- Attempts to find a matching brace under the caret.
		require
			is_interface_usable: is_interface_usable
			not_is_empty: not is_empty
			text_is_fully_loaded: text_is_fully_loaded
		local
			l_brace: ?like brace_match_caret_token
			l_caret_outside: BOOLEAN
		do
			l_brace := brace_match_caret_token
			if l_brace /= Void then
				-- Determine location of caret, if it's before/after then the new cursor position
					-- should be after/before the matching brace.
				if brace_matcher.is_opening_brace (l_brace.token) then
					l_caret_outside := position <= l_brace.token.pos_in_text
				else
					l_caret_outside := position >= l_brace.token.pos_in_text + l_brace.token.wide_image.count
				end

				l_brace := brace_matcher.match_brace (l_brace.token, l_brace.line)
				if l_brace /= Void then
					if has_selection then
							-- Remove any previous selection.
						disable_selection
					end

						-- Set new cursor position
					if {l_eiffel_line: EIFFEL_EDITOR_LINE} l_brace.line then
						text_displayed.cursor.set_line (l_eiffel_line)
						if brace_matcher.is_closing_brace (l_brace.token) then
							if l_caret_outside then
								text_displayed.cursor.set_current_char (l_brace.token.next, 1)
							else
								text_displayed.cursor.set_current_char (l_brace.token, 1)
							end
						else
							if l_caret_outside then
								text_displayed.cursor.set_current_char (l_brace.token, 1)
							else
								text_displayed.cursor.set_current_char (l_brace.token.next, 1)
							end
						end
					else
							-- Should never happen, we are using an Eiffel editor.
						check False end
					end
				end
			end
		end

	embed_in_block (keyword: STRING_32; pos_in_keyword: INTEGER) is
			-- Embed selection or current line in block formed by `keyword' and "end".
			-- Cursor is positioned to the `pos_in_keyword'-th character of `keyword'.
		require
			keyword_not_void: keyword /= Void
			pos_in_keyword_valid: pos_in_keyword > 0 and then pos_in_keyword <= keyword.count
		do
			if is_editable and then not is_empty then
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
			if dev_window.stone /= Void and then text_displayed.click_tool_enabled and then not text_displayed.text_being_processed then
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
			set_title_saved (True)
		end

	on_text_reset is
			-- Redefine
		do
			Precursor
			set_title_saved (True)
		end

	on_text_edited (directly_edited: BOOLEAN) is
			-- Redefine
		do
			Precursor (directly_edited)
			set_title_saved (False)
		end

	is_text_loaded_called: BOOLEAN
			-- If text loaded called?

feature {EB_COMPLETION_CHOICE_WINDOW} -- Process Vision2 Events

	handle_character (c: CHARACTER_32) is
 			-- Process the push on a character key.
		local
			t: EDITOR_TOKEN_KEYWORD
			token: EDITOR_TOKEN
			look_for_keyword: BOOLEAN
			insert: CHARACTER_32
			syntax_completed: BOOLEAN
			cur: like cursor_type
 		do
			switch_auto_point := auto_point
			if is_editable then
				Precursor (c)

					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces

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
			if not is_completing and then code = Key_tab and then allow_tab_selecting and then not shifted_key then
					-- Tab action
				handle_tab_action (False)
			elseif not is_completing and then code = Key_tab and then allow_tab_selecting and then shifted_key then
				handle_tab_action (True)
			elseif is_editable and not is_completing and then text_displayed.completing_context and then key_completable.item ([ev_key, ctrled_key, alt_key, shifted_key]) then
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
									latest_typed_word_is_keyword := False
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
				else
					Precursor (ev_key)
					if ev_key.code = key_back_space or else ev_key.code = key_delete then
							-- Peform brace match highlighting
						highlight_matched_braces
					end
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
			Precursor (ev_key)
				-- if `auto_point' is true, user has called auto complete
				-- we don't change the value. Else, its new value is set to False unless
				-- only ctrl key was pressed
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

				-- Perform brace matching, or unmatching
			highlight_matched_braces
		end

feature {EB_CODE_COMPLETION_WINDOW} -- automatic completion

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

				-- Perform brace match highlighting/unhighlighting.
			highlight_matched_braces
		end

	calculate_completion_list_x_position: INTEGER is
			-- Determine the x position to display the completion list
		local
			screen: EB_STUDIO_SCREEN
			tok: EDITOR_TOKEN
			cursor: like cursor_type
			right_space,
			list_width: INTEGER
			l_helpers: EVS_HELPERS
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

				-- Remove space for pixmap
			Result := Result - 20

			create l_helpers
			if {l_window: !EV_TITLED_WINDOW} l_helpers.widget_top_level_window (widget, True) and then l_window.is_maximized then
				Result := l_helpers.suggest_pop_up_widget_location_with_size (l_window, Result, 0, list_width, 10).x
			end
			Result := Result.max (0)
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
			l_height: INTEGER
			l_helpers: EVS_HELPERS
		do
				-- Get y pos of cursor
			create l_helpers

			if {l_window: !EV_TITLED_WINDOW} l_helpers.widget_top_level_window (widget, True) and then l_window.is_maximized then
				l_height := l_helpers.window_working_area (l_window).height
			end
			if l_height = 0 then
				create screen
				l_height := screen.virtual_height
			end

			cursor := text_displayed.cursor
			show_below := True
			Result := widget.screen_y + ((cursor.y_in_lines - first_line_displayed) * line_height)

			if Result < ((l_height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := Result - completion_border_size
			lower_space := l_height - Result - completion_border_size

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
				Result := Precursor {EB_TAB_CODE_COMPLETABLE}
			end
		end

feature {NONE} -- Brace matching

	brace_matcher: !ES_EDITOR_BRACE_MATCHER
			-- Brace matcher utility access.
		require
			is_interface_usable: is_interface_usable
		once
			create Result
		end

	brace_match_caret_token: ?TUPLE [token: !EDITOR_TOKEN; line: !EDITOR_LINE]
			-- Attempts to retrieve the most applicable brace match token under the caret.
			--
			-- `Result': The most applicable token or Void if no token was found.
		require
			is_interface_usable: is_interface_usable
			not_is_empty: not is_empty
			text_is_fully_loaded: text_is_fully_loaded
		local
			l_utils: !like brace_matcher
			l_token: ?EDITOR_TOKEN
			l_prev_token: ?EDITOR_TOKEN
			l_line: ?EDITOR_LINE
		do
				-- Locate applicable tokens
			l_utils := brace_matcher
			l_token := text_displayed.cursor.token
			l_line := text_displayed.cursor.line
			if l_token /= Void and l_line /= Void then
				l_prev_token := l_token.previous
				if l_utils.is_closing_brace (l_token) and then position = l_token.pos_in_text
					and then l_prev_token /= Void and then l_utils.is_closing_brace (l_prev_token) then
						-- Check the previous token for a closing brace, because it has priority
					l_token := l_prev_token
				else
					if not l_utils.is_brace (l_token) and then (l_token.is_new_line or else position <= l_token.pos_in_text) then
							-- Grab previous token because the move will always get the next token.
						l_token := l_prev_token
					end
				end

				if l_token /= Void and then l_utils.is_brace (l_token) then
					Result := [l_token, l_line]
				end
			end
		ensure
			result_token_belongs_on_line: Result /= Void implies Result.line.has_token (Result.token)
			result_token_is_brace: Result /= Void implies brace_matcher.is_brace (Result.token)
		end

	highlight_matched_braces
			-- Match editor braces.
		require
			is_interface_usable: is_interface_usable
			not_is_empty: not is_empty
			text_is_fully_loaded: text_is_fully_loaded
		local
			l_utils: !like brace_matcher
			l_token: ?EDITOR_TOKEN
			l_line: ?EDITOR_LINE
			l_brace: ?like brace_match_caret_token
			l_invalidated_lines: ARRAYED_SET [EDITOR_LINE]
			l_last_matches: !like last_highlighted_matched_braces
		do
			create l_invalidated_lines.make (2)

				-- Remove last matches
			l_last_matches := last_highlighted_matched_braces
			from l_last_matches.start until l_last_matches.after loop
				l_brace ?= l_last_matches.item
				if l_brace /= Void then
					l_brace.token.set_highlighted (False)
					if not l_invalidated_lines.has (l_brace.line) then
						l_invalidated_lines.extend (l_brace.line)
					end
				end
				l_last_matches.remove
			end

			if not has_selection then
					-- Locate applicable tokens
				l_brace := brace_match_caret_token
				if l_brace /= Void then
					l_token := l_brace.token
					l_line := l_brace.line
					if l_token /= Void and then l_line /= Void then
							-- Find matching brace tokens.
						l_utils := brace_matcher
						if l_utils.is_brace (l_token) and then l_line.has_token (l_token) then
							l_brace := l_utils.match_brace (l_token, l_line)
							if l_brace /= Void then
									-- There was a match.
								l_token.set_highlighted (True)
								if not l_invalidated_lines.has (l_line) then
									l_invalidated_lines.extend (l_line)
								end
								l_last_matches.extend ([l_token, l_line])

								l_brace.token.set_highlighted (True)
								if not l_invalidated_lines.has (l_brace.line) then
									l_invalidated_lines.extend (l_brace.line)
								end
								l_last_matches.extend ([l_brace.token, l_brace.line])
							end
						end
					end
				end
			end

			if not l_invalidated_lines.is_empty then
					-- Perform line redraws
				from l_invalidated_lines.start until l_invalidated_lines.after loop
					invalidate_line (l_invalidated_lines.item.index, True)
					l_invalidated_lines.forth
				end
			end
		end

	last_highlighted_matched_braces: !ARRAYED_LIST [!TUPLE [token: EDITOR_TOKEN; line: EDITOR_LINE]]
			-- Last matched brace tokens, set in `highlight_matched_braces'.
		require
			is_interface_usable: is_interface_usable
		once
			create Result.make (2)
		end

feature {EB_SAVE_FILE_COMMAND, EB_SAVE_ALL_FILE_COMMAND, EB_DEVELOPMENT_WINDOW, EB_STONE_CHECKER} -- Docking title

	set_title_saved (a_saved: BOOLEAN) is
			-- Set '*' in the title base on `a_saved'.
		local
			l_title: STRING_32
		do
			if docking_content /= Void then
				if docking_content.short_title /= Void then
					l_title := docking_content.short_title.as_string_32
				else
					create l_title.make_empty
				end

				set_title_saved_with (a_saved, l_title)
			end
		end

	set_title_saved_with (a_saved: BOOLEAN; a_title: STRING) is
			-- Set '*' in the title base on `a_saved'.
			-- `a_title' will be used as name in editor docking_content
		require
			not_void: a_title /= Void
		local
			l_short_title: STRING
			l_title: STRING
		do
			if docking_content /= Void then
				if not a_title.is_empty then
					-- We must twin it, otherwise it will change the class name
					l_title := a_title.twin

					-- First we make sure docking_content title has `l_title'
					l_short_title := docking_content.short_title.as_string_8
					if l_short_title = Void or else not l_short_title.has_substring (l_title) then
						docking_content.set_short_title (l_title)
						docking_content.set_long_title (l_title)
					end

					if l_title.item (1).code = ('*').code then
						if a_saved then
							l_title.keep_tail (l_title.count - 1)
							docking_content.set_short_title (l_title)
							docking_content.set_long_title (l_title)
						end
					else
						if not a_saved then
							l_title.insert_string ("*", 1)
							docking_content.set_short_title (l_title)
							docking_content.set_long_title (l_title)
						end
					end
				else
					if not a_saved then
						docking_content.set_short_title ("*")
						docking_content.set_long_title ("*")
					end
				end
			end
		end

feature {NONE} -- Autocomplete implementation

	on_key_down (ev_key: EV_KEY)is
		do
			completion_timeout.actions.block
			if ev_key.code = {EV_KEY_CONSTANTS}.key_f1 then
				show_help
			else
				Precursor (ev_key)
			end

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

	previous_token_image: STRING_32
			-- Image of the previous token

	keyword_image (token: EDITOR_TOKEN_KEYWORD): STRING_32 is
			-- Image of keyword beginning by `token'.
		local
			test: STRING_32
			kw: like token
			blnk: EDITOR_TOKEN_BLANK
			tok: EDITOR_TOKEN
			is_else, is_then: BOOLEAN
		do
			Result := token.wide_image.twin
			test := Result
			is_else := string_32_is_caseless_ascii_string (test, "else")
			is_then := string_32_is_caseless_ascii_string (test, "then")
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
						test := kw.wide_image.twin
						if string_32_is_caseless_ascii_string (test, "or") then
							Result.prepend ("or ")
						elseif string_32_is_caseless_ascii_string (test, "require") then
							Result.prepend ("require ")
						end
					elseif is_then then
						test := kw.wide_image.twin
						if string_32_is_caseless_ascii_string (test, "and") then
							Result.prepend ("and ")
						elseif string_32_is_caseless_ascii_string (test, "ensure") then
							Result.prepend ("ensure ")
						end
					end
				end
			end
		end

feature -- Access

	text_displayed: SMART_TEXT
			-- Displayed text.

feature {NONE} -- Implementation

	process_click_tool_error is
			-- Show warning corresponding to `click_tool' error.
		local
			l_displayed: ES_ERROR_DISPLAYER
			l_item: EVENT_LIST_ERROR_ITEM
			l_error: SYNTAX_ERROR
		do
			if event_list.is_service_available then
					-- Remove any error items associated with the editor
				event_list.service.prune_event_items (editor_context_cookie)
			end

			if text_displayed.click_tool_status = text_displayed.class_name_changed then
				show_warning_message (Warning_messages.w_Class_name_changed)
			elseif text_displayed.click_tool_status = text_displayed.syntax_error then
					-- There has been a syntax error so add the item to the list
				l_error := text_displayed.last_syntax_error
				check l_error_attached: l_error /= Void end
				if event_list.is_service_available then
					create l_displayed.make (window_manager)
					create l_item.make ({ENVIRONMENT_CATEGORIES}.editor, l_error.out, l_error)
					event_list.service.put_event_item (editor_context_cookie, l_item)
				end
			end
		end

	complementary_character (c:CHARACTER_32): CHARACTER_32 is
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
			create customizable_commands.make (11)
			customizable_commands.put (agent complete_feature_name, "autocomplete")
			customizable_commands.put (agent complete_class_name, "class_autocomplete")
			customizable_commands.put (agent quick_search, "show_quick_search_bar")
			customizable_commands.put (agent replace, "show_search_and_replace_panel")
			customizable_commands.put (agent find_next_selection, "search_selection_forward")
			customizable_commands.put (agent find_previous_selection, "search_selection_backward")
			customizable_commands.put (agent find_next, "search_forward")
			customizable_commands.put (agent find_previous, "search_backward")
			customizable_commands.put (agent run_if_editable (agent comment_selection), "comment")
			customizable_commands.put (agent run_if_editable (agent uncomment_selection), "uncomment")
			customizable_commands.put (agent run_if_editable (agent set_selection_case (False)), "set_to_uppercase")
			customizable_commands.put (agent run_if_editable (agent set_selection_case (True)), "set_to_lowercase")
			customizable_commands.put (agent run_if_editable (agent embed_in_block ("if  then", 3)), "embed_if_clause")
			customizable_commands.put (agent run_if_editable (agent embed_in_block ("debug", 5)), "embed_debug_clause")
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
			txt: STRING_32
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
					end
				end
			else
				after_reading_text_actions.extend(agent show_syntax_warning)
			end
		rescue
			retried := True
			retry
		end

	on_mouse_wheel (a_delta: INTEGER) is
			-- <Precursor>
		local
			l_env: EV_ENVIRONMENT
			l_preference: EB_SHARED_PREFERENCES
			l_old_value: INTEGER
		do
			create l_env
			if l_env.application.ctrl_pressed then
				create l_preference
				l_old_value := l_preference.preferences.editor_data.font_zoom_factor_preference.value
				l_preference.preferences.editor_data.font_zoom_factor_preference.set_value (l_old_value + a_delta)
			else
				Precursor {EB_CLICKABLE_EDITOR}(a_delta)
			end
		end

	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER) is
			-- <Precursor>
		do
			if button = 1 then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces
			end
			Precursor (x_pos, y_pos, button, unused1, unused2, unused3, unused4, unused5)
		end

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

	load_text (s: STRING_GENERAL) is
			-- <Precursor>
		local
			l_d_class : DOCUMENT_CLASS
			l_scanner: EDITOR_EIFFEL_SCANNER
			l_stone: CLASSI_STONE
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (agent load_text (s))
			else
				l_d_class := get_class_from_type (once "e")
				set_current_document_class (l_d_class)
				l_scanner ?= l_d_class.scanner
				if l_scanner /= Void then
					text_displayed.set_lexer (l_scanner)
					l_stone ?= stone
					if l_stone /= Void then
						l_scanner.set_current_class (l_stone.class_i.config_class)
					end
				end
				text_displayed.set_current_document_class (get_class_from_type (once "e"))
				Precursor {EB_CLICKABLE_EDITOR} (s)
			end
			load_without_save := False
		end

feature {NONE} -- Memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_CLICKABLE_EDITOR}
			if completion_timeout /= Void and then not completion_timeout.is_destroyed then
				completion_timeout.destroy
			end

			if event_list.is_service_available then
					-- Remove any added error items
				event_list.service.prune_event_items (editor_context_cookie)
			end
		end

	internal_detach_entities is
			-- <Precursor>
		do
			completion_timeout := Void
			internal_editor_context_cookie := Void
			auto_point_token := Void
			previous_token_image := Void
			saved_cursor := Void
			Precursor
		end

feature {NONE} -- Factory

	create_token_handler: ?ES_EDITOR_TOKEN_HANDLER
			-- Create a token handler, used to perform actions or respond to mouse/keyboard events
			-- Note: Return Void to prevent any handling from takening place.
		do
			if {l_editor: !EB_CUSTOM_WIDGETTED_EDITOR} Current then
				create {!ES_SMART_EDITOR_TOKEN_HANDLER} Result.make (l_editor)
			end
		end

feature {NONE} -- Code completable implementation

	prepare_auto_complete is
			-- Prepare possibilities in provider.
		do
			check_need_signature
			Precursor {EB_TAB_CODE_COMPLETABLE}
		end

	check_need_signature is
			-- Check if signature needed.
			-- We don't need signature when completing outside a feature.
		local
			l_line: EIFFEL_EDITOR_LINE
			l_kt: EDITOR_TOKEN_KEYWORD
			l_end_loop, l_quit: BOOLEAN
			l_cursor: EDITOR_CURSOR
			l_token: EDITOR_TOKEN
			l_found_blank: BOOLEAN
		do
			set_discard_feature_signature (False)
			need_tabbing := False
			if not is_empty then
					-- Look for the fist feature within the whole editor.
					-- We do not need signature before the first feature clause of a class.
				from
					text_displayed.start
					l_end_loop := False
				until
					text_displayed.after or l_end_loop
				loop
					l_line := text_displayed.current_line
					from
						l_line.start
					until
						l_line.after or l_end_loop
					loop
						if string_32_is_caseless_ascii_string (l_line.item.wide_image, "feature") then
							l_kt ?= l_line.item
							if l_kt /= Void then
								l_end_loop := True
								create l_cursor.make_from_relative_pos (l_line, l_kt, 1, text_displayed)
								if l_cursor.pos_in_text < text_displayed.cursor.pos_in_text then
									set_discard_feature_signature (False)
								else
									set_discard_feature_signature (True)
								end
							end
						end
						l_line.forth
					end
					text_displayed.forth
				end
				if not discard_feature_signature then
					from
						l_token := text_displayed.cursor.token
						l_end_loop := False
					until
						l_token = Void or l_end_loop or l_quit
					loop
						l_token := l_token.previous
						if l_token /= Void then
							if l_token.is_blank then
								l_found_blank := True
							else
								if l_found_blank then
										-- We do not need signature after "like feature"
										-- We do not need feature signature when it is a pointer reference. case: "$  feature"
									if string_32_is_caseless_ascii_string (l_token.wide_image, "like") or token_equal (l_token, "$") then
										l_end_loop := True
										set_discard_feature_signature (True)
									else
										l_quit := True
									end
								end
									-- Prevent create {like a}.input (a, b) from signature being discarded.
								if token_equal (l_token, "}") then
									l_end_loop := True
								end
							end
							-- We do not need feature signature when it is a pointer reference. case2: "$feature"
							if not l_found_blank and then not l_quit and then not l_end_loop then
								if token_equal (l_token, "$") then
									l_end_loop := True
									set_discard_feature_signature (True)
								end
							end
						end
					end
				end

					-- Check if there is already signature following when we discard signature.
				if not discard_feature_signature then
					from
						l_token := text_displayed.cursor.token
						l_end_loop := False
						if l_token /= Void then
							if token_equal (l_token, "(") then
								l_end_loop := True
								set_discard_feature_signature (True)
							end
						end
					until
						l_token = Void or l_end_loop
					loop
						l_token := l_token.next
						if l_token /= Void then
							if not l_token.is_blank then
								l_end_loop := True
								if token_equal (l_token, "(") then
									need_tabbing := True
									set_discard_feature_signature (True)
								end
							end
						end
					end
				end
			end
		end

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
			-- Can complete by these keys?
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
		do
			if a_key /= Void then
				if
					auto_complete_after_dot and then
					completion_activator_characters.has (a_key.out.item (1)) and
					not a_ctrl and
					not a_alt and
					not a_shift
				then
					Result := True
					set_completing_feature (True)
					completing_automatically := True
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := True
					set_completing_feature (True)
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("class_autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := True
					set_completing_feature (False)
				end
			end
		end

	handle_tab_action (a_backwards: BOOLEAN) is
			-- Handle tab action.
		do
			if a_backwards then
				run_if_editable (agent shift_tab_action)
			else
				run_if_editable (agent tab_action)
			end
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
			if has_selection then
				disable_selection
			end
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
			if has_selection then
				disable_selection
			end
			text_displayed.selection_cursor.make_from_relative_pos (a_start_line, a_start_token, 1, text_displayed)
			text_displayed.cursor.make_from_relative_pos (a_end_line, a_end_token, 1, text_displayed)
			show_possible_selection
		end

	allow_tab_selecting: BOOLEAN is
			-- Allow tab selecting?
		local
			l_current_line: like current_line
			l_current_token, l_cur_token: EDITOR_TOKEN
			l_comment: EDITOR_TOKEN_COMMENT
			l_has_left_brace_ahead,
			l_has_right_brace_ahead,
			l_has_right_brace_following,
			l_has_left_brace_following,
			l_seperator_ahead,
			l_seperator_following: BOOLEAN
			l_comment_ahead: BOOLEAN
		do
			if has_selection implies text_displayed.selection_start.y_in_lines = text_displayed.selection_end.y_in_lines then
				l_current_line := current_line

				l_cur_token := current_token_in_line (l_current_line)
				l_current_token := l_cur_token
				from
				until
					l_cur_token = Void or else l_cur_token.is_text
				loop
					l_cur_token := l_cur_token.previous
				end
				if l_cur_token /= Void then
					l_comment ?= l_cur_token
					l_comment_ahead := (l_comment /= Void)
				end
				Result := not l_comment_ahead
				if Result then
					from
						l_current_line.start
					until
						l_current_line.after or l_current_line.item = text_displayed.cursor.token
					loop
						if not l_has_left_brace_ahead and then l_current_line.item.is_text and then token_equal (l_current_line.item, "(") then
							l_has_left_brace_ahead := True
						end
						if not l_has_right_brace_ahead and then l_current_line.item.is_text and then token_equal (l_current_line.item, ")") then
							l_has_right_brace_ahead := True
						end
						if
							not l_seperator_ahead and then
							l_current_line.item.is_text and then
							(token_equal (l_current_line.item, ",") or else token_equal (l_current_line.item, ";"))
						then
							l_seperator_ahead := True
						end
						l_current_line.forth
					end

					from
						l_current_token := current_token_in_line (l_current_line)
					until
						l_current_token = Void or else
						l_current_token = l_current_line.eol_token or else
						{lt_com: EDITOR_TOKEN_COMMENT}l_current_token
					loop
						if
							not l_has_right_brace_following and then
							token_equal (l_current_token, ")")
						then
							l_has_right_brace_following := True
						end
						if
							not l_has_left_brace_following and then
							token_equal (l_current_token, "(") then
							l_has_left_brace_following := True
						end
						if
							not l_seperator_following and then
							l_current_token.is_text and then
							(token_equal (l_current_token, ",") or else token_equal (l_current_token, ";"))
						then
							l_seperator_following := True
						end
						l_current_token := l_current_token.next
					end
					Result := 	((l_has_left_brace_ahead or l_seperator_ahead) and then (l_has_right_brace_following or l_seperator_following))
				end
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
			if has_selection then
				disable_selection
			end
			text_displayed.delete_char

				-- Perform brace match highlighting/unhighlighting.
			highlight_matched_braces
		end

	back_delete_char is
			-- Back delete character.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.back_delete_char

				-- Perform brace match highlighting/unhighlighting.
			highlight_matched_braces
		end

	insert_string (a_str: STRING_32) is
			-- Insert `a_str' at cursor position.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.insert_string (a_str)

				-- Perform brace match highlighting/unhighlighting.
			highlight_matched_braces
		end

	insert_char (a_char: CHARACTER_32) is
			-- Insert `a_char' at cursor position.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.insert_char (a_char)
		end

	replace_char (a_char: CHARACTER_32) is
			-- Replace current char with `a_char'.
		do
			if has_selection then
				disable_selection
			end
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

	save_cursor is
			-- Save cursor position for retrieving.
		do
			saved_cursor := text_displayed.cursor.twin
		end

	retrieve_cursor is
			-- Retrieve cursor position from saving.
		do
			text_displayed.cursor.make_from_character_pos (saved_cursor.x_in_characters, saved_cursor.y_in_lines, text_displayed)
		end

	saved_cursor: EDITOR_CURSOR

	complete_feature_call (completed: STRING_32; is_feature_signature: BOOLEAN; appended_character: CHARACTER_32; remainder: INTEGER; a_continue_completion: BOOLEAN) is
			--
		do
			text_displayed.complete_feature_call (completed, is_feature_signature, appended_character, remainder, not a_continue_completion)
		end

	select_from_cursor_to_saved is
			-- Select from cursor position to saved cursor position
		do
			check saved_cursor /= Void end
			text_displayed.selection_cursor.make_from_character_pos (text_displayed.cursor.x_in_characters, text_displayed.cursor.y_in_lines, text_displayed)
			text_displayed.cursor.make_from_character_pos (saved_cursor.x_in_characters, saved_cursor.y_in_lines, text_displayed)
			text_displayed.enable_selection
			show_possible_selection
		end

	end_of_line: BOOLEAN is
			--
		do
			Result := text_displayed.cursor.token = text_displayed.cursor.line.eol_token
		end

	current_char: CHARACTER_32 is
			-- Current character, to the right of the cursor.
		do
			Result := text_displayed.cursor.wide_item
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
					if not l_tok.wide_image.is_empty then
						Result := not completion_activator_characters.has (l_tok.wide_image.item (1))
					else
						Result := True
					end
					if not Result then
							-- is a '.'
						Result := not completing_automatically
					end
				else
					Result := preferences.editor_data.auto_complete_words
				end
			end
			completing_automatically := False
		ensure then
			completing_automatically_reset: completing_automatically = False
		end

feature {NONE} -- Implementation: Internal cache

	internal_editor_context_cookie: ?like editor_context_cookie
			-- Cached version of `editor_context_cookie'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
