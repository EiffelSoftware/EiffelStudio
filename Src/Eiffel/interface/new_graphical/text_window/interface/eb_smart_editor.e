note
	description: "[
		Advanced editor for Eiffel Studio.
		Completes syntax automatically.
		Includes tool to make basic eiffel text clickable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SMART_EDITOR

inherit
	EB_CLICKABLE_EDITOR
		export
			{ANY} highlight_selected, first_line_displayed
		redefine
			handle_extended_key,
			handle_extended_ctrled_key,
			handle_character,
			load_file_path,
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
			on_char,
			on_text_saved,
			on_text_fully_loaded,
			make,
			create_token_handler,
			select_current_token
		end

	EB_TAB_CODE_COMPLETABLE
		rename
			is_keyword as is_keyword_token,
			on_char as on_char_completable
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
			prepare_auto_complete,
			on_char_completable,
			complete_template_call
		end

	ES_HELP_REQUEST_BINDER
		export
			{NONE} all
			{EB_DEVELOPMENT_WINDOW} show_help
		undefine
			default_create
		redefine
			show_help
		end

	CURSOR_COMPLETABLE_POSITIONING
		export
			{NONE} all
		undefine
			default_create
		redefine
			calculate_completion_list_x_position
		end

create
	make

feature {NONE} -- Initialize

	make (a_dev_window: EB_DEVELOPMENT_WINDOW)
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

			-- Note: Help binding is done through the IDE window and help is shown for the editor through
			--       delegation. See {EB_DEVELOPMENT_WINDOW}.show_help for more info.
		end

feature {NONE} -- Access

	editor_context_cookie: attached UUID
			-- The associated editor's context cookie for use with the event list service.
		do
			if attached internal_editor_context_cookie as l_cookie then
				Result := l_cookie
			else
				Result := (create {UUID_GENERATOR}).generate_uuid
				internal_editor_context_cookie := Result
			end
		end

	event_list: attached SERVICE_CONSUMER [EVENT_LIST_S]
			-- Access to the event list service for adding class syntax errors/warnings.
		once
			create Result
		end

	help_uri_scavenger: attached ES_HELP_CONTEXT_SCAVENGER [attached EB_SMART_EDITOR]
			-- Scavenger used to local help contexts within the editor
		require
			help_providers_is_service_available: attached help_providers.service
		once
			create {ES_EDITOR_HELP_CONTEXT_SCAVENGER} Result
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

feature {EB_DEVELOPMENT_WINDOW} -- Basic operations

	show_help
			-- Attempts to show help given the current help context implemented on Current.
		local
			l_uri_scavenger: like help_uri_scavenger
			l_contexts: attached DS_BILINEAR [attached HELP_CONTEXT_I]
			l_dialog: ES_HELP_SELECTOR_DIALOG
		do
			if attached help_providers.service and then has_focus then
					-- Look for help contexts
				l_uri_scavenger := help_uri_scavenger
				l_uri_scavenger.probe (Current)
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

feature -- Content change

	set_editor_text (s: STRING_32)
			-- load text represented by `s' in the editor
			-- text is considered edited after load, i.e. save command
			-- is sensitive.
			-- `file_name' is left unchanged.
		local
			f_n: PATH
			f_d, f_d_c, f_s: INTEGER
		do
			f_n := file_path
			f_d := date_of_file_when_loaded
			f_s := size_of_file_when_loaded
			f_d_c := date_when_checked
			load_text (s)
			text_displayed.set_changed (True, False)
			file_path := f_n
			date_of_file_when_loaded := f_d
			size_of_file_when_loaded := f_s
			date_when_checked := f_d_c
		end

	reload
			-- Reload the file named `file_name' in the editor.
		do
			load_without_save := True
			Precursor {EB_CLICKABLE_EDITOR}
		end

feature -- Status report

	click_and_complete_is_active: BOOLEAN
			-- If in the basic text format, is the text clickable?
		do
			Result := text_displayed.click_and_complete_is_active and then allow_edition and then not open_backup
		end

	syntax_is_correct: BOOLEAN
			-- When text was parsed, was a syntax error found?
		do
			Result := text_displayed.click_tool_status /= text_displayed.syntax_error
		end

	load_without_save: BOOLEAN
			-- Check and save file before loading a new content?

	exploring_current_class: BOOLEAN
			-- Is the current class being explored by the click tool?
		do
			Result := text_displayed.exploring_current_class
		end

	is_text_loaded (a_stone: STONE): BOOLEAN
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

	no_save_before_next_load
			-- Disable check before next loading.
		do
			load_without_save := True
		end

feature -- Search

	find_feature_named (a_name: STRING_32)
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

	found_feature: BOOLEAN
			-- Was last searched feature name found?
		do
			Result := text_displayed.found_feature
		end

feature {EB_COMMAND, EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_MENU_BUILDER} -- Commands

	complete_alias_name
		do
			if
				not is_empty and then
				attached text_displayed.cursor as l_cursor and then
				attached {EDITOR_TOKEN_STRING} l_cursor.token as str_tok
			then
				if
					attached {EDITOR_TOKEN_SPACE} str_tok.previous as space_tok and then
					attached {EDITOR_TOKEN_KEYWORD} space_tok.previous as kwd_tok and then
					kwd_tok.wide_image.is_case_insensitive_equal_general ("alias")
				then
						-- Insert text
					set_completing_alias_name (True)
					complete_code
				end
			else
				complete_feature_name
			end
		end

	complete_feature_name
			-- Complete feature name.
		do
			if not is_empty and then text_displayed.completing_context and is_editable then
				set_completing_feature
				if auto_complete_after_dot and then not shifted_key then
					completing_automatically := True
				end
				complete_code
			end
		end

	complete_class_name
			-- Complete class name.
		do
			if not is_empty and then text_displayed.completing_context and is_editable then
				set_completing_class
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
			l_brace: detachable like brace_match_caret_token
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

				l_brace := brace_matcher.match_brace (l_brace.token, l_brace.line, Void)
				if l_brace /= Void then
					if has_selection then
							-- Remove any previous selection.
						disable_selection
					end

						-- Set new cursor position
					if attached {EIFFEL_EDITOR_LINE} l_brace.line as l_eiffel_line then
						check valid_line: l_eiffel_line.is_valid end
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

	embed_in_block (keyword: STRING_32; pos_in_keyword: INTEGER)
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

	update_click_list (after_save: BOOLEAN)
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

	string_loading_setup, file_loading_setup
			-- Setup editor just before file/string loading begins.
		do
					-- If `load_file_error' has been set before, we simply do not setup the click tool.
			if not load_file_error then
				text_displayed.enable_click_tool
				text_displayed.setup_click_tool (dev_window.stone)
				process_click_tool_error
			end
		end

	on_text_back_to_its_last_saved_state
			-- Reset click tool when back to the saved state
		do
			Precursor
			if dev_window.stone /= Void and then text_displayed.click_tool_enabled then
				text_displayed.update_click_list (dev_window.stone, True)
				text_displayed.clear_syntax_error
			end
			set_title_saved (True)
			setup_eis_links
		end

	on_text_reset
			-- Redefine
		do
			Precursor
			set_title_saved (True)
		end

	on_text_edited (directly_edited: BOOLEAN)
			-- Redefine
		do
			Precursor (directly_edited)
			set_title_saved (False)
		end

	on_text_fully_loaded
			-- <Precursor>
		do
			Precursor
				-- Must done when text is fully loaded.
				-- So the parser to retrieve EIS info takes text from the editor
				-- Instead of the text from original file.
			setup_eis_links
			in_generation_mode := False
		end

	is_text_loaded_called: BOOLEAN
			-- If text loaded called?

feature -- Process Vision2 events

	on_char_completable (character_string: STRING_32)
			-- <precursor>
		do
			if
				is_editable and
				not is_completing and then
				character_string.count = 1 and then
				text_displayed.completing_context and then
				is_char_activator_character (character_string.item (1))
			then
				set_completing_feature
				trigger_completion
				debug ("Auto_completion")
					print ("Completion triggered.%N")
				end
			else
				block_completion
				debug ("auto_completion")
					print ("Completion blocked.%N")
				end
			end
		end

 	on_char (character_string: STRING_32)
   			-- Process displayable character key press event.
   		do
   			Precursor {EB_CLICKABLE_EDITOR}(character_string)
			if not ignore_keyboard_input and then not character_string.is_empty and then not is_empty then
					-- Perform brace match highlighting/unhighlighting.
	   			highlight_matched_braces (True)
			end
 		end

feature {NONE} -- Process Vision2 Events

	handle_character (c: CHARACTER_32)
 			-- Process the push on a character key.
		local
			tok, token: detachable EDITOR_TOKEN
			look_for_keyword: BOOLEAN
			insert: CHARACTER_32
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
							if
								attached {EDITOR_TOKEN_KEYWORD} token.previous as l_keyword_token
							then
								tok := l_keyword_token
								if
									keyword_image (l_keyword_token).is_equal (previous_token_image)
								then
									text_displayed.back_delete_char
									text_displayed.complete_syntax (previous_token_image, True, False)
									syntax_completed := text_displayed.syntax_completed
									look_for_keyword := False
									latest_typed_word_is_keyword := False
								end
							end
						end
					else
						token := text_displayed.cursor.token
						if text_displayed.cursor.line.eol_token = token then
								-- case: keyword|space|eol
							if token.previous /= Void and then token.previous.length = 1 then
								tok := token.previous.previous
							end
						elseif token /= Void then
								-- case: keyword|space|space|...
							if text_displayed.cursor.pos_in_token = 2 then
								tok := token.previous
							end
						end
						if attached {EDITOR_TOKEN_KEYWORD} tok as l_keyword_token then
							text_displayed.back_delete_char
							look_for_keyword := False
							text_displayed.complete_syntax (keyword_image (l_keyword_token), False, False)
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
						tok := text_displayed.cursor.token.previous
					end
					if
						attached {EDITOR_TOKEN_KEYWORD} tok as l_keyword_token and then
						text_displayed.cursor.pos_in_token = 1
					then
						latest_typed_word_is_keyword := True
						previous_token_image := keyword_image (l_keyword_token)
					else
						latest_typed_word_is_keyword := False
 					end
				end
			else
				display_not_editable_warning_message
			end
			auto_point := switch_auto_point xor auto_point
		end

	handle_extended_key (ev_key: EV_KEY)
 			-- Process the push on an extended key.
		local
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
								if
									attached {EDITOR_TOKEN_KEYWORD} token.previous as t and then
									keyword_image (t).is_equal (previous_token_image)
								then
									text_displayed.complete_syntax (previous_token_image, True, True)
									syntax_completed := text_displayed.syntax_completed
									latest_typed_word_is_keyword := False
								end
							else
								if
									attached {EDITOR_TOKEN_KEYWORD} token.previous as t and then
									text_displayed.cursor.pos_in_token = 1
								then
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
				end
			end
			auto_point := switch_auto_point xor auto_point

			if not is_empty then
				if ev_key.code = key_back_space or else ev_key.code = key_delete or else ev_key.code = key_enter then
						-- Perform brace match highlighting/unhighlighting.
						-- Enter key requires special processing.
					highlight_matched_braces (ev_key.code = key_enter)
				end
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY)
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

feature {NONE} -- Handle mouse clicks

	select_current_token (is_for_word: BOOLEAN)
		local
			txt: like text_displayed
			ctrl_pressed: BOOLEAN
			pos: INTEGER
		do
			ctrl_pressed := ev_application.ctrl_pressed
			txt := text_displayed
			pos := txt.cursor.pos_in_text

			empty_word_selection := False
			Precursor (is_for_word)
			if
				preferences.editor_data.is_linked_editing_enabled and then
				ctrl_pressed -- FIXME: preference for shortcut?
			then
				activate_linked_edit (pos, Void)
			end
		end

	activate_linked_edit (a_pos_in_text: INTEGER; a_regions: detachable LIST [TUPLE [start_pos,end_pos: INTEGER]])
			-- Activate linked edit at position `a_pos_in_text' if set, otherwise at cursor.
			-- And if `a_regions' is not empty, limit the impact token in those regions.
		do
			if attached text_displayed as txt then
				if
					has_selection and then
					is_word (wide_string_selection)
	--| Alternative code using cursor.
	--				attached txt.cursor as l_cursor and then
	--				attached l_cursor.token as tok and then
	--				tok.is_text and then is_word (tok.wide_image)
				then
					if a_regions = Void then
						txt.enable_linked_editing (Current, a_pos_in_text, current_feature_scope_as_regions (txt), Void)
					else
						txt.enable_linked_editing (Current, a_pos_in_text, a_regions, Void)
					end
				else
					txt.disable_linked_editing
				end
			end
		end

feature {NONE} -- Handle keystrokes

	current_feature_scope_as_regions (txt: SMART_TEXT): ARRAYED_LIST [TUPLE [start_pos: INTEGER; end_pos: INTEGER]]
		local
			tok: detachable EDITOR_TOKEN
			l_line: detachable EDITOR_LINE
			l_curr_line: EDITOR_LINE
			l_curr_token: EDITOR_TOKEN
			l_start_pos, l_end_pos: INTEGER
		do
			l_curr_line := txt.cursor.line
			l_curr_token := txt.cursor.token
			l_start_pos := l_curr_token.pos_in_text
			l_end_pos := l_start_pos + l_curr_token.length
			from
				l_line := l_curr_line
				tok := l_curr_token
			until
				tok = Void or l_line = Void--or attached {EDITOR_TOKEN_EOL} t
			loop
				if attached {EDITOR_TOKEN_FEATURE_START} tok then
					l_end_pos := tok.pos_in_text
					tok := Void
				else
					l_end_pos := tok.pos_in_text + tok.length
					tok := tok.next
					if tok = Void then
						if l_line /= Void then
							l_line := l_line.next
							if l_line /= Void then
								tok := l_line.first_token
							end
						end
					end
				end
			end
			from
				tok := l_curr_token.previous
				l_line := l_curr_line
			until
				tok = Void or l_line = Void
			loop
				if attached {EDITOR_TOKEN_FEATURE_START} tok then
					l_start_pos := tok.pos_in_text + tok.length
					tok := Void
				else
					l_start_pos := tok.pos_in_text
					tok := tok.previous
					if tok = Void then
						if l_line /= Void then
							l_line := l_line.previous
							if l_line /= Void then
								from
									tok := l_line.first_token
								until
									attached {EDITOR_TOKEN_EOL} tok or tok = Void
								loop
									if tok /= Void then
										tok := tok.next
									end
								end
							end
						end
					end
				end
			end
			create Result.make (1)
			Result.force ([l_start_pos, l_end_pos])
		end

	completion_bckp: INTEGER

	basic_cursor_move (action: PROCEDURE)
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char.
		do
			Precursor {EB_CLICKABLE_EDITOR} (action)
			switch_auto_point := False

			if not is_empty then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces (True)
			end
		end

feature {EB_CODE_COMPLETION_WINDOW} -- automatic completion

	auto_complete_after_dot: BOOLEAN
	        -- Should build autocomplete dialog after call on valid target?
	  	do
	  	   	Result := preferences.editor_data.auto_auto_complete
	  	end

	exit_complete_mode
			-- Set mode to normal (not completion mode).
		do
			is_completing := False

				-- Invalidating cursor forces cursor to be updated.
			invalidate_cursor_rect (False)
			resume_cursor_blinking
			set_focus

			if not is_empty then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces (True)
			end
		end

	working_area_height: INTEGER
			-- <Precursor>
		local
			l_helpers: EVS_HELPERS
			l_screen: EV_RECTANGLE
		do
			create l_helpers
			if attached {EV_TITLED_WINDOW} l_helpers.widget_top_level_window (widget) as l_window and then l_window.is_maximized then
				Result := l_helpers.window_working_area (l_window).height
			end
			if Result = 0 then
				l_screen := (create {EV_SCREEN}).monitor_area_from_position (cursor_screen_x, cursor_screen_y)
				Result := l_screen.height
			end
		end

	use_preferred_height: BOOLEAN
			-- User preferred height?
		do
			Result := preferences.development_window_data.remember_completion_list_size
		end

	preferred_height: INTEGER
			-- Preferred height
		do
			Result := preferences.development_window_data.completion_list_height
		end

	calculate_completion_list_x_position: INTEGER
			-- <Precursor>
		local
			l_screen: EV_RECTANGLE
			l_helpers: EVS_HELPERS
			l_y, list_width, right_space: INTEGER
		do
			Result := Precursor {CURSOR_COMPLETABLE_POSITIONING}

			l_screen := (create {EV_SCREEN}).monitor_area_from_position (cursor_screen_x, cursor_screen_y)
			right_space := l_screen.right - Result
			list_width := calculate_completion_list_width

			create l_helpers
			if attached {EV_TITLED_WINDOW} l_helpers.widget_top_level_window (widget) as l_window and then l_window.is_maximized then
				l_y := cursor_screen_y
				Result := l_helpers.suggest_pop_up_widget_location_with_size (l_window, Result.max (l_screen.left), l_y, list_width, 10).x
				Result := Result.max (l_screen.left)
			end

			if right_space > list_width then
				Result := Result - 20
			end
		end

	calculate_completion_list_width: INTEGER
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

	brace_matcher: attached ES_EDITOR_BRACE_MATCHER
			-- Brace matcher utility access.
		require
			is_interface_usable: is_interface_usable
		once
			create Result
		end

	brace_match_caret_token: detachable TUPLE [token: attached EDITOR_TOKEN; line: attached EDITOR_LINE]
			-- Attempts to retrieve the most applicable brace match token under the caret.
			--
			-- `Result': The most applicable token or Void if no token was found.
		require
			is_interface_usable: is_interface_usable
			not_is_empty: not is_empty
			text_is_fully_loaded: text_is_fully_loaded
		local
			l_utils: attached like brace_matcher
			l_token: detachable EDITOR_TOKEN
			l_prev_token: detachable EDITOR_TOKEN
			l_line: detachable EDITOR_LINE
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
					if not l_token.is_highlighted then
							-- This is a minor hack, and not even a hack really but it's necessary due to the brace finder's
							-- function to place the caret on the inside of outside of a matching brace, based on the original
							-- position. For instance, )|), where | is the caret has two possible matches. For this case, if the right
							-- token is hightlighted, it has priority, overriding the left-priority semantics.
						l_token := l_prev_token
					end

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

	highlight_matched_braces (a_update: BOOLEAN)
			-- Match editor braces.
		require
			is_interface_usable: is_interface_usable
			not_is_empty: not is_empty
		local
			l_utils: attached like brace_matcher
			l_token: attached EDITOR_TOKEN
			l_line: attached EDITOR_LINE
			l_invalidated_lines: ARRAYED_SET [EDITOR_LINE]
			l_last_matches: attached like last_highlighted_matched_braces
			l_invalidated_line: detachable EDITOR_LINE
			l_action: PROCEDURE
		do
			if text_is_fully_loaded then
				create l_invalidated_lines.make (2)

					-- Remove last matches
				l_last_matches := last_highlighted_matched_braces
				from l_last_matches.start until l_last_matches.after loop
					if attached {like brace_match_caret_token} l_last_matches.item as l_brace then
						l_brace.token.set_highlighted (False)
						if not l_invalidated_lines.has (l_brace.line) then
							l_invalidated_lines.extend (l_brace.line)
						end
					end
					l_last_matches.remove
				end

				if not has_selection and then preferences.editor_data.highlight_matching_braces then
						-- Locate applicable tokens
					if attached {like brace_match_caret_token} brace_match_caret_token as l_brace then
						l_token := l_brace.token
						l_line := l_brace.line

							-- Find matching brace tokens.
						l_utils := brace_matcher
						if l_utils.is_brace (l_token) and then l_line.has_token (l_token) then
							if attached l_utils.match_brace (l_token, l_line, Void) as l_matched_brace then
									-- There was a match.
								l_token.set_highlighted (True)
								if not l_invalidated_lines.has (l_line) then
									l_invalidated_lines.extend (l_line)
								end
								l_last_matches.extend ([l_token, l_line])

								l_matched_brace.token.set_highlighted (True)
								if not l_invalidated_lines.has (l_matched_brace.line) then
									l_invalidated_lines.extend (l_matched_brace.line)
								end
								l_last_matches.extend ([l_matched_brace.token, l_matched_brace.line])
							end
						end
					end
				end

				if a_update and then not l_invalidated_lines.is_empty then
						-- Perform line redraws
					from l_invalidated_lines.start until l_invalidated_lines.after loop
						l_invalidated_line := l_invalidated_lines.item
						if l_invalidated_line.is_valid then
							invalidate_line (l_invalidated_line.index, False)
						end
						l_invalidated_lines.forth
					end
				end
			else
					-- We are not ready to hightlight braces just yet, deferred until the text
					-- has been fully loaded.
				l_action := agent highlight_matched_braces (a_update)
				if not after_reading_text_actions.has (l_action) then
					after_reading_text_actions.extend (l_action)
				end
			end
		end

	last_highlighted_matched_braces: attached ARRAYED_LIST [attached TUPLE [token: EDITOR_TOKEN; line: EDITOR_LINE]]
			-- Last matched brace tokens, set in `highlight_matched_braces'.
		require
			is_interface_usable: is_interface_usable
		once
			create Result.make (2)
		end

feature {EB_SAVE_FILE_COMMAND, EB_SAVE_ALL_FILE_COMMAND, EB_DEVELOPMENT_WINDOW, EB_STONE_CHECKER} -- Docking title

	set_title_saved (a_saved: BOOLEAN)
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

	set_title_saved_with (a_saved: BOOLEAN; a_title: READABLE_STRING_32)
			-- Set '*' in the title base on `a_saved'.
			-- `a_title' will be used as name in editor docking_content
		require
			not_void: a_title /= Void
		local
			l_short_title: READABLE_STRING_32
			l_title: STRING_32
		do
			if docking_content /= Void then
				if not a_title.is_empty then
					-- We must twin it, otherwise it will change the class name
					create l_title.make_from_string (a_title)

					-- First we make sure docking_content title has `l_title'
					l_short_title := docking_content.short_title
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

	on_key_down (ev_key: EV_KEY)
		do
			completion_timeout.actions.block
			Precursor (ev_key)
		end

	auto_point: BOOLEAN
			-- Should autocomplete add `.' next time it is called?

	switch_auto_point: BOOLEAN
			-- Should `auto_point' have the opposite value?

	auto_point_token: detachable EDITOR_TOKEN
			-- Point where autocomplete should add a period.

feature {NONE} -- syntax completion

	latest_typed_word_is_keyword: BOOLEAN
			-- Is the preceding token a keyword?

	previous_token_image: detachable STRING_32
			-- Image of the previous token

	keyword_image (token: EDITOR_TOKEN_KEYWORD): STRING_32
			-- Image of keyword beginning by `token'.
		local
			test: STRING_32
			tok: EDITOR_TOKEN
			is_else, is_then: BOOLEAN
		do
			Result := token.wide_image.twin
			test := Result
			is_else := test.is_case_insensitive_equal ({STRING_32} "else")
			is_then := test.is_case_insensitive_equal ({STRING_32} "then")
			if is_else or is_then then
				from
					tok := token.previous
				until
					not attached {EDITOR_TOKEN_BLANK} tok as blnk
				loop
					tok := blnk.previous
				end
				if attached {like token} tok as kw then
					if is_else then
						test := kw.wide_image.twin
						if test.is_case_insensitive_equal ({STRING_32} "or") then
							Result.prepend ("or ")
						elseif test.is_case_insensitive_equal ({STRING_32} "require") then
							Result.prepend ("require ")
						end
					elseif is_then then
						test := kw.wide_image.twin
						if test.is_case_insensitive_equal ({STRING_32} "and") then
							Result.prepend ("and ")
						elseif test.is_case_insensitive_equal ({STRING_32} "ensure") then
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

	process_click_tool_error
			-- Show warning corresponding to `click_tool' error.
		local
			l_displayed: ES_ERROR_DISPLAYER
			l_error: SYNTAX_ERROR
		do
				-- We lock the list because when you double click on a syntax error of an editor
				-- we don't want to see the UI reflecting the fact we are removing all errors associated
				-- to that editor and then adding them later (below).
			event_list.service.lock
			if attached event_list.service as s then
					-- Remove any error items associated with the editor
				s.prune_event_items (editor_context_cookie)
			end

			if text_displayed.click_tool_status = text_displayed.class_name_changed then
				show_warning_message (Warning_messages.w_Class_name_changed)
			elseif text_displayed.click_tool_status = text_displayed.syntax_error then
					-- There has been a syntax error so add the item to the list
				l_error := text_displayed.last_syntax_error
				check l_error_attached: l_error /= Void end
				create l_displayed.make (window_manager)
				l_displayed.trace_error ({ENVIRONMENT_CATEGORIES}.editor, editor_context_cookie, l_error)

				if attached {ES_ERROR_LIST_TOOL} dev_window.shell_tools.tool ({ES_ERROR_LIST_TOOL}) as l_tool then
					if not l_tool.is_tool_instantiated then
							-- If the error list tool is not yet shown, show it, but just the first time.
							-- The purpose is two fold; This is the first error generated and so the user should
							-- be alerted to the first error, much like in the same way the compiler error
							-- brings the UI to the front. Second, it will update the error count index.
						l_tool.show (False)
							-- Brings focus back (Legacy tool implementation causes focusing when show is called - Grr!)
						set_focus
					end
				end
			end
			event_list.service.unlock
		end

	complementary_character (c:CHARACTER_32): CHARACTER_32
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

	initialize_customizable_commands
			-- Create array of customizable commands.
		do
			create customizable_commands.make (11)
			customizable_commands.put (agent complete_alias_name, "autocomplete")
			customizable_commands.put (agent complete_class_name, "class_autocomplete")
			customizable_commands.put (agent quick_search, "show_quick_search_bar")
			customizable_commands.put (agent replace, "show_search_and_replace_panel")
			customizable_commands.put (agent find_next_selection, "search_selection_forward")
			customizable_commands.put (agent find_previous_selection, "search_selection_backward")
			customizable_commands.put (agent find_next, "search_forward")
			customizable_commands.put (agent find_previous, "search_backward")
			customizable_commands.put (agent run_if_editable (agent prettify), "prettify")
			customizable_commands.put (agent run_if_editable (agent toggle_comment_selection), "toggle_comment")
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

	insert_customized_string (index: INTEGER)
			--
		do
			text_displayed.insert_customized_expression (preferences.editor_data.customized_strings.i_th (index).value)
			refresh_now
		end

	show_syntax_warning
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
					show_warning_message (Warning_messages.w_Cannot_read_file (file_path.name))
				else
					deselect_all
					syn_error := text_displayed.last_syntax_error
					text_displayed.clear_syntax_error
					if file_path /= Void and syn_error /= Void then
						create fl.make_with_path (file_path)
						fl.open_read
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

	on_mouse_wheel (a_delta: INTEGER)
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

	on_mouse_button_up (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; unused4,unused5:INTEGER)
			-- <Precursor>
		do
			if button = 1 and then not is_empty then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces (True)
			end
			Precursor (x_pos, y_pos, button, unused1, unused2, unused3, unused4, unused5)
		end

feature -- Text Loading	

	load_file_path (a_file_name: PATH)
			-- Load file named `a_file_name' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (agent load_file_path (a_file_name))
			else
				Precursor {EB_CLICKABLE_EDITOR} (a_file_name)
			end
			load_without_save := False
		end

	load_text (s: STRING_GENERAL)
			-- <Precursor>
		local
			l_d_class : DOCUMENT_CLASS
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (agent load_text (s))
			else
				l_d_class := get_class_from_type (once "e")
				set_current_document_class (l_d_class)
				if attached {EDITOR_EIFFEL_SCANNER} l_d_class.scanner as l_scanner then
					text_displayed.set_lexer (l_scanner)
					if attached {CLASSI_STONE} stone as l_classi_stone then
						l_scanner.set_current_class (l_classi_stone.class_i.config_class)
					end
				end
				text_displayed.set_current_document_class (get_class_from_type (once "e"))
				Precursor {EB_CLICKABLE_EDITOR} (s)
			end
			load_without_save := False
		end

	setup_eis_links
			-- Setup eis links in current editor
		local
			l_list: SEARCH_TABLE [EIS_ENTRY]
			l_context: ES_EIS_ENTRY_HELP_CONTEXT
		do
			if not in_generation_mode and then attached dev_window as l_window and then attached {ES_INFORMATION_TOOL_COMMANDER_I} l_window.shell_tools.tool ({ES_INFORMATION_TOOL}) as l_info_tool_commander and then l_info_tool_commander.is_interface_usable then
				if attached {CLASSI_STONE} stone as l_stone and then attached l_stone.class_i as l_classi then
					l_list := l_info_tool_commander.class_entries (l_classi)
					across
						l_list as l_c
					loop
						if not l_c.item.is_auto and then attached l_c.item.source as l_source and then attached l_c.item.source_pos as l_pos then
							create l_context.make (l_c.item, False)
							set_link_between (l_pos.pos, l_pos.pos + l_pos.len - 1, True, create {EIS_LINK_STONE}.make (l_context))
						end
					end
				end
			end
		end

feature -- Update

	on_text_saved
			-- On text saved
		do
			Precursor {EB_CLICKABLE_EDITOR}
			setup_eis_links
			if attached text_displayed as txt then
				txt.disable_linked_editing
			end
		end

feature {NONE} -- Memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_CLICKABLE_EDITOR}
			if attached completion_timeout as l_timeout and then not l_timeout.is_destroyed then
				l_timeout.destroy
			end

			if attached event_list.service as s then
					-- Remove any added error items
				s.prune_event_items (editor_context_cookie)
			end
		end

	internal_detach_entities
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

	create_token_handler: detachable ES_EDITOR_TOKEN_HANDLER
			-- Create a token handler, used to perform actions or respond to mouse/keyboard events
			-- Note: Return Void to prevent any handling from takening place.
		do
			if attached {EB_CUSTOM_WIDGETTED_EDITOR} Current as l_editor then
				create {attached ES_SMART_EDITOR_TOKEN_HANDLER} Result.make (l_editor)
			end
		end

feature {NONE} -- Code completable implementation

	prepare_auto_complete
			-- Prepare possibilities in provider.
		do
			check_need_signature
			Precursor {EB_TAB_CODE_COMPLETABLE}
		end

	check_need_signature
			-- Check if signature needed.
			-- We don't need signature when completing outside a feature.
		local
			l_line: EIFFEL_EDITOR_LINE
			l_end_loop, l_quit: BOOLEAN
			l_cursor: EDITOR_CURSOR
			l_token: detachable EDITOR_TOKEN
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
						if l_line.item.wide_image.is_case_insensitive_equal ({STRING_32} "feature") then
							if attached {EDITOR_TOKEN_KEYWORD} l_line.item as l_kt then
								l_end_loop := True
								check l_line_valid: l_line.is_valid end
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
									if l_token.wide_image.is_case_insensitive_equal ({STRING_32} "like") or token_equal (l_token, "$") then
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

	current_line: EIFFEL_EDITOR_LINE
			-- Line of current cursor.
			-- Every query is not guarenteed the same object.
		local
			l_line: detachable EIFFEL_EDITOR_LINE
		do
			l_line := text_displayed.cursor.line
			if l_line = Void then
				create l_line.make (is_windows_file)
			end
			Result := l_line
		end

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN
			-- Can complete by these keys?
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
		do
			if a_key /= Void then
				l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := True
					set_completing_feature
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
					set_completing_class
				end
			end
		end

	handle_tab_action (a_backwards: BOOLEAN)
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

	go_to_start_of_selection
			-- Move cursor to the start of the selection if possible.
		do
			if text_displayed.cursor /= text_displayed.selection_start then
				if text_displayed.selection_end.y_in_lines = text_displayed.selection_start.y_in_lines then
					text_displayed.cursor.set_from_relative_pos (text_displayed.current_line, text_displayed.selection_start.token, text_displayed.selection_start.pos_in_token, text_displayed)
				else
					text_displayed.cursor.set_from_relative_pos (text_displayed.current_line, text_displayed.current_line.first_token, 1, text_displayed)
				end
			end
			disable_selection
		end

	go_to_end_of_selection
			-- Move cursor to the end of selection
		do
			if text_displayed.cursor /= text_displayed.selection_end then
				if text_displayed.selection_end.y_in_lines = text_displayed.selection_start.y_in_lines then
					text_displayed.cursor.set_from_relative_pos (text_displayed.current_line, text_displayed.selection_end.token, text_displayed.selection_end.pos_in_token, text_displayed)
				else
					text_displayed.cursor.set_from_relative_pos (text_displayed.current_line, text_displayed.current_line.eol_token, 1, text_displayed)
				end
			end
			disable_selection
		end

	go_to_start_of_line
			-- Move cursor to the start of a line
			-- where tab switching to next feature argument should function.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.cursor.go_start_line
		end

	go_to_end_of_line
			-- Move cursor to the start of a line.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.cursor.go_end_line
		end

	go_right_char
			-- Go to right character.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.cursor.go_right_char_no_down_line
		end

	move_cursor_to (a_token: EDITOR_TOKEN; a_line: like current_line)
			-- Move cursor to `a_token' which is in `a_line'.
		do
			if has_selection then
				disable_selection
			end
			check a_line_valid: a_line.is_valid end
			text_displayed.cursor.set_from_relative_pos (a_line, a_token, 1, text_displayed)
		end

	select_region_between_token (a_start_token: EDITOR_TOKEN; a_start_line: like current_line; a_end_token: EDITOR_TOKEN; a_end_line: like current_line)
			-- Select from the start position of `a_start_token' to the start position of `a_end_token'.
		do
			if has_selection then
				disable_selection
			end
			check
				start_line_valid: a_start_line.is_valid
				end_line_valid: a_end_line.is_valid
			end
			text_displayed.selection_cursor.set_from_relative_pos (a_start_line, a_start_token, 1, text_displayed)
			text_displayed.cursor.set_from_relative_pos (a_end_line, a_end_token, 1, text_displayed)
			show_possible_selection
		end

	allow_tab_selecting: BOOLEAN
			-- Allow tab selecting?
		local
			l_current_line: like current_line
			l_current_token, l_cur_token: EDITOR_TOKEN
			l_has_left_brace_ahead,
			l_has_right_brace_ahead,
			l_has_right_brace_following,
			l_has_left_brace_following,
			l_separator_ahead,
			l_separator_following: BOOLEAN
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
					l_comment_ahead := attached {EDITOR_TOKEN_COMMENT} l_cur_token
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
							not l_separator_ahead and then
							l_current_line.item.is_text and then
							(token_equal (l_current_line.item, ",") or else token_equal (l_current_line.item, ";"))
						then
							l_separator_ahead := True
						end
						l_current_line.forth
					end

					from
						l_current_token := current_token_in_line (l_current_line)
					until
						l_current_token = Void or else
						l_current_token = l_current_line.eol_token or else
						attached {EDITOR_TOKEN_COMMENT} l_current_token as lt_com
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
							not l_separator_following and then
							l_current_token.is_text and then
							(token_equal (l_current_token, ",") or else token_equal (l_current_token, ";"))
						then
							l_separator_following := True
						end
						l_current_token := l_current_token.next
					end
					Result := 	((l_has_left_brace_ahead or l_separator_ahead) and then (l_has_right_brace_following or l_separator_following))
				end
			end
		end

	current_token_in_line (a_line: like current_line): EDITOR_TOKEN
			-- Token of the cursor.
		do
			Result := text_displayed.cursor.token
		end

	selection_start_token_in_line (a_line: like current_line): EDITOR_TOKEN
			-- Start token in the selection.
		do
			if text_displayed.cursor.y_in_lines = text_displayed.selection_start.y_in_lines then
				Result := text_displayed.selection_start.token
			else
				Result := current_line.first_token
			end
		end

	selection_end_token_in_line (a_line: like current_line): EDITOR_TOKEN
			-- Token after end of selection.
		do
			if text_displayed.cursor.y_in_lines = text_displayed.selection_end.y_in_lines then
				Result := text_displayed.selection_end.token
			else
				Result := current_line.eol_token
			end
		end

	show_possible_selection
			-- Show possible selection
		do
			text_displayed.enable_selection
			if has_selection then
				show_selection (False)
			end
		end

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
		do
			Result := editor_drawing_area.key_press_string_actions
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Key pressed action
		do
			Result := editor_drawing_area.key_press_actions
		end

	delete_char
			-- Delete char.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.delete_char

			if not is_empty then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces (False)
			end
		end

	back_delete_char
			-- Back delete character.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.back_delete_char

			if not is_empty then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces (False)
			end
		end

	insert_string (a_str: STRING_32)
			-- Insert `a_str' at cursor position.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.insert_string (a_str)

			if not is_empty then
					-- Perform brace match highlighting/unhighlighting.
				highlight_matched_braces (False)
			end
		end

	insert_char (a_char: CHARACTER_32)
			-- Insert `a_char' at cursor position.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.insert_char (a_char)
		end

	replace_char (a_char: CHARACTER_32)
			-- Replace current char with `a_char'.
		do
			if has_selection then
				disable_selection
			end
			text_displayed.replace_char (a_char)
		end

	resume_focus_in_actions
			-- Resume focus in actions
		do
			editor_drawing_area.focus_in_actions.resume
		end

	block_focus_in_actions
			-- Block focus in actions
		do
			editor_drawing_area.focus_in_actions.block
		end

	block_focus_out_actions
			-- Block focus out actions.
		do
			editor_drawing_area.focus_out_actions.block
		end

	resume_focus_out_actions
			-- Resume focus out actions.
		do
			editor_drawing_area.focus_out_actions.resume
		end

	save_cursor
			-- Save cursor position for retrieving.
		do
			saved_cursor := text_displayed.cursor.twin
		end

	retrieve_cursor
			-- Retrieve cursor position from saving.
		do
			text_displayed.cursor.set_from_character_pos (saved_cursor.x_in_characters, saved_cursor.y_in_lines, text_displayed)
		end

	saved_cursor: detachable EDITOR_CURSOR

	complete_feature_call (completed: STRING_32; is_feature_signature: BOOLEAN; appended_character: CHARACTER_32; remainder: INTEGER; a_continue_completion: BOOLEAN)
			--
		do
			text_displayed.complete_feature_call (completed, is_feature_signature, appended_character, remainder, not a_continue_completion)
		end

	complete_template_call (a_template: EB_TEMPLATE_FOR_COMPLETION)
			-- Insert code template `a_template'.
		local
			l_template: STRING_32
			l_locals: READABLE_STRING_GENERAL
			s: STRING_32
			l_pos, l_feat_pos: INTEGER
			txt: like text_displayed
			l_local_pos, l_start_pos, p: INTEGER
			l_locals_offset: INTEGER
			l_code_texts: TUPLE [locals: STRING_32; code: STRING_32; linked_token: ARRAY [READABLE_STRING_GENERAL]]
			l_regions: ARRAYED_LIST [TUPLE [start_pos,end_pos: INTEGER]]
			l_template_region, l_locals_region: detachable TUPLE [start_pos,end_pos: INTEGER]
			l_nb_cr: INTEGER
			txt_is_windows_eol_style: BOOLEAN
		do
				-- local varianles and code from template
			l_code_texts := a_template.code_texts

			txt := text_displayed
			txt_is_windows_eol_style := txt.is_windows_eol_style -- and False

				-- Maybe a bit heavy...
			txt.update_token_pos_in_text_from (1)


				-- Body
			l_pos := txt.cursor.pos_in_characters
			create l_template.make_from_string_general (l_code_texts.code)
			l_template.prune_all ('%R')


				-- TODO: remove previous token!
			if
				attached txt.cursor.token.previous as prev and then prev.wide_image.same_string_general (".") and then
				attached prev.previous as prev2
			then
				p := l_pos - prev2.wide_image.count - 2 + 1
				txt.select_region (p, l_pos)
				txt.delete_selection
				l_pos := p
				txt.go_to (p)
				l_pos := p
			else
				txt.insert_string ("%N")
				l_pos := l_pos + 1
				if txt_is_windows_eol_style then
					l_pos := l_pos + 1 -- Inserted CR  %R
				end
			end

				-- Insert template body

			txt.paste_with_indentation (l_template)
			if txt_is_windows_eol_style then
				l_nb_cr := l_template.occurrences ('%N') -- For the missing %R.
			else
				l_nb_cr := 0
			end
			l_template_region := [l_pos, l_pos + l_template.count + l_nb_cr]
--			l_regions.force ([l_pos, l_pos + 3 + l_template.count + l_nb_cr]) -- code region

				-- Locals
			if attached a_template.e_feature as f then
					-- FIXME: check for inline agent !
				txt.find_feature_named (f.name_32) -- Cursor is moved.
				if txt.found_feature then
					l_locals := l_code_texts.locals

					l_feat_pos := txt.cursor.pos_in_characters

					txt.cursor.go_to_position (l_feat_pos)
					txt.search_string_from_cursor ("local")
					if txt.successful_search then
						l_local_pos := txt.found_string_total_character_position
					end

					txt.cursor.go_to_position (l_feat_pos)
					txt.search_string_from_cursor ("do")
					if txt.successful_search then
						l_start_pos := txt.found_string_total_character_position
					end

					txt.cursor.go_to_position (l_feat_pos)
					txt.search_string_from_cursor ("once")
					if txt.successful_search then
						p := txt.found_string_total_character_position
						if l_start_pos = 0 then
							l_start_pos := p
						else
							l_start_pos := l_start_pos.min (p)
						end
					end

					if l_start_pos > 0 then
						check locals_do_not_start_with_new_line: not l_locals.starts_with ("%N") end
						check locals_ends_with_new_line: not l_locals.starts_with ("%N") end

						txt.cursor.go_to_position (l_start_pos + 1) -- goto "do" , "once" ,... start of the body!
						p := txt.cursor.line.first_token.pos_in_text
						txt.cursor.go_to_position (p) -- cursor at the beginning of the line.

						if l_local_pos > 0 and l_local_pos < l_start_pos then
							create s.make_from_string_general (l_locals)
						else -- no "local" found!
							create s.make_from_string_general ("%T%Tlocal%N")
							s.append_string_general (l_locals)
						end
						s.prune_all ('%R')
						txt.insert_string (s)
						if txt_is_windows_eol_style then
							l_nb_cr := s.occurrences ('%N') -- For the missing %R.
						else
							l_nb_cr := 0
						end
						l_locals_offset := s.count + l_nb_cr

						l_locals_region := [p, p + s.count + l_nb_cr] -- locals region
						l_pos := l_pos + l_locals_offset
						if l_template_region /= Void then
							l_template_region.start_pos := l_template_region.start_pos + l_locals_offset
							l_template_region.end_pos := l_template_region.end_pos + l_locals_offset
						end
					end
				end
			end

			txt.cursor.go_to_position (l_pos + 1)
			refresh_now

				-- Update pos in text for tokens.
			create l_regions.make (2)
			if l_locals_region /= Void then
				l_regions.force (l_locals_region)
			end
			if l_template_region /= Void then
				l_regions.force (l_template_region)
			end

			across
				l_regions as ic
			loop
				p := p.min (ic.item.start_pos)
			end
			dev_window.save_text
			txt.update_token_pos_in_text_from (p)

			if True then
				txt.enable_linked_editing (Current, l_pos, l_regions, l_code_texts.linked_token)
				refresh_now
			end

		end

	select_from_cursor_to_saved
			-- Select from cursor position to saved cursor position
		do
			check saved_cursor /= Void end
			text_displayed.selection_cursor.set_from_character_pos (text_displayed.cursor.x_in_characters, text_displayed.cursor.y_in_lines, text_displayed)
			text_displayed.cursor.set_from_character_pos (saved_cursor.x_in_characters, saved_cursor.y_in_lines, text_displayed)
			text_displayed.enable_selection
			show_possible_selection
		end

	end_of_line: BOOLEAN
			--
		do
			Result := text_displayed.cursor.token = text_displayed.cursor.line.eol_token
		end

	current_char: CHARACTER_32
			-- Current character, to the right of the cursor.
		do
			Result := text_displayed.cursor.wide_item
		end

	on_key_pressed (a_key: EV_KEY)
			-- Do nothing.
			-- We do it in `handle_extended_key'
		do
		end

	completing_automatically: BOOLEAN
			-- Is completion being shown automatically?

	completing_word: BOOLEAN
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
						Result := not is_char_activator_character (l_tok.wide_image.item (1))
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
			completing_automatically_reset: not completing_automatically
		end

feature {NONE} -- Implementation: Internal cache

	internal_editor_context_cookie: detachable like editor_context_cookie
			-- Cached version of `editor_context_cookie'
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
