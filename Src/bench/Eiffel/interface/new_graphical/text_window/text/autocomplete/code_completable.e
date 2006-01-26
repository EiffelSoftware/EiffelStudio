indexing
	description: "Object that is able to auto complete code."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CODE_COMPLETABLE

feature {NONE} -- Initialization

	initialize_code_complete is
			-- Initialization
		require
			key_press_actions_attached: key_press_actions /= Void
		do
			key_press_actions.extend (agent on_key_pressed)
			set_completing_feature (true)
			can_complete_by_key := agent can_complete
			create completion_timeout.make_with_interval (default_timer_interval)
			completion_timeout.actions.extend (agent complete_code)
			completion_timeout.actions.block
		ensure
			completion_timeout_not_void: completion_timeout /= Void
			can_complete_by_key_not_void: can_complete_by_key /= Void
		end

feature -- Access

	choices: EB_CODE_COMPLETION_WINDOW is
			-- Completion choice window for show feature and class completion options.
		once
			create Result.make
		end

	completion_possibilities_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER
			-- Possibilities provider.

	can_complete_by_key : FUNCTION [ANY, TUPLE [EV_KEY, BOOLEAN, BOOLEAN, BOOLEAN], BOOLEAN]
			-- EV_KEY can activate text completion?

feature {NONE} -- Access

	current_token_in_line (a_line: like current_line): EDITOR_TOKEN is
			-- Token at or behind cursor position
		require
			a_line_attached: a_line /= Void
		deferred
		ensure
			current_token_in_line_not_void: Result /= Void
		end

	selection_start_token_in_line (a_line: like current_line) : EDITOR_TOKEN is
			-- Start token in the selection.
		require
			has_selection: has_selection
		deferred
		ensure
			selection_start_token_in_line_not_void: Result /= Void
		end

	selection_end_token_in_line (a_line: like current_line) : EDITOR_TOKEN is
			-- Token after end of selection.
		require
			has_selection: has_selection
		deferred
		ensure
			selection_end_token_in_line_not_void: Result /= Void
		end

	current_line : EDITOR_LINE is
			-- Line of current cursor.
			-- Every query is not guarenteed the same object.
		deferred
		ensure
			current_line_not_void: Result /= Void
		end

	current_char: CHARACTER is
			-- Current character, to the right of the cursor.
		deferred
		end

feature -- Status change

	set_can_complete (a_fun: like can_complete_by_key) is
			-- Set `can_complete_by_key' with `a_fun'.
		require
			a_fun_attached: a_fun /= Void
		do
			can_complete_by_key := a_fun
		ensure
			can_complete_by_key_not_void: can_complete_by_key /= Void
		end

	set_discard_feature_signature (a_b: like discard_feature_signature) is
			-- Set `discard_feature_signature' with `a_b'
		do
			discard_feature_signature := a_b
		ensure
			discard_feature_signature_set: discard_feature_signature = a_b
		end

	set_completion_possibilities_provider (a_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER) is
			-- Set `completion_possibilities_provider'.
		do
			completion_possibilities_provider := a_provider
		end

	refresh is
			-- Refresh current display.
		do
		end

	set_completing_feature (a_completing_feature: BOOLEAN) is
			-- Set `completing_feature' with `a_completing_feature'.
		do
			completing_feature := a_completing_feature
		ensure
			completing_feature_set: completing_feature = a_completing_feature
		end

feature -- Status report

	is_completing: BOOLEAN
			-- Is completion currently being processed?	

	has_selection: BOOLEAN is
			-- Does current have a selection?
		deferred
		end

	allow_tab_selecting: BOOLEAN is
			-- Allow tab selecting?
		deferred
		end

	discard_feature_signature: BOOLEAN
			-- Discard feature signature?

	completing_feature: BOOLEAN
			-- Completing feature? Otherwise completing classes.

feature {NONE} -- Status report

	auto_complete_is_possible: BOOLEAN is
			-- Is auto complete possible.
		do
			if completion_possibilities_provider /= Void then
				Result := completion_possibilities_provider.completion_possible
			end
		end

	completing_word: BOOLEAN is
			-- Is in completing word mode?
		deferred
		end

	end_of_line: BOOLEAN is
			-- Is cursor at the end of the line.
		deferred
		end

	start_of_line (a_token: EDITOR_TOKEN; a_line: like current_line): BOOLEAN is
			-- Is `a_token' start of `a_line'?
		do
			if a_token /= Void then
				if a_token.previous = Void or else a_token.previous.is_margin_token then
					Result := true
				end
			end
		end

feature -- Text operation

	back_delete_char is
			-- Back delete character.
		deferred
		end

	delete_char is
			-- Delete char.
		deferred
		end

	insert_string (a_str: STRING) is
			-- Insert `a_str' at cursor position.
		require
			a_str_attached: a_str /= Void
		deferred
		end

	insert_char (a_char: CHARACTER) is
			-- Insert `a_char' at cursor position.
		deferred
		end

	replace_char (a_char: CHARACTER) is
			-- Replace current char with `a_char'.
		deferred
		end

feature -- Cursor

	go_right_char is
			-- Go to right character.
		deferred
		end

	go_to_end_of_selection is
			-- Move cursor to the end of selection
		require
			has_selection: has_selection
		deferred
		end

	go_to_start_of_line is
			-- Move cursor to the start of a line
			-- where tab switching to next feature argument should function.
		deferred
		end

	go_to_end_of_line is
			-- Move cursor to the start of a line.
		deferred
		end

	go_to_start_of_selection is
			-- Move cursor to the start of the selection if possible.
		require
			has_selection: has_selection
		deferred
		end

	move_cursor_to (a_token: EDITOR_TOKEN; a_line: like current_line)is
			-- Move cursor to `a_token' which is in `a_line'.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
		deferred
		end

	save_cursor_position is
			-- Save cursor position for retrieving.
		deferred
		end

	retrieve_cursor_position is
			-- Retrieve cursor position from saving.
		deferred
		end

feature -- Selection

	select_from_cursor_to_saved is
			-- Select from cursor position to saved cursor position
		deferred
		end

	disable_selection is
			-- Disable selection
		deferred
		end

	show_possible_selection is
			-- Show possible selection
		deferred
		end

	select_region_between_token (a_start_token: EDITOR_TOKEN; a_start_line: like current_line; a_end_token: EDITOR_TOKEN; a_end_line: like current_line) is
			-- Select from the start position of `a_start_token' to the start position of `a_end_token'.
		deferred
		end

feature -- Tab actions

	tab_action is
			-- Process push on tab key when in auto_complete mode.
			-- Select the closest argument of a feature.
		local
			l_line: like current_line
			l_cur_token, l_end_token, l_start_token, l_save_token: EDITOR_TOKEN
			l_found_start: BOOLEAN
			l_selected: BOOLEAN
			l_stop, l_is_start, l_jumped: BOOLEAN
		do
			l_line := current_line
			l_save_token := current_token_in_line (l_line)

			if has_selection then
					-- Seek "(", ",", or ";" token in the selection.
					-- If not, go to end of selection.
				l_cur_token := find_selection_start_in_selection (l_line)
				if l_cur_token = Void then
					go_to_end_of_selection
				end
			elseif end_of_line then
				go_to_start_of_line
				l_jumped := true
			else
				if not between_seperator (current_token_in_line (l_line), l_line) and not seperator_following (l_line) then
					l_cur_token := find_previous_start_token (l_line)
				end
			end
			if l_cur_token = Void then
				l_cur_token := current_token_in_line (l_line)
			end
			if l_jumped and then start_of_line (l_cur_token, l_line) and then between_seperator (l_cur_token, l_line) then
				l_stop := true
			end
			if not l_stop then
					-- Search possible arguments separator.
				from
					if l_cur_token = Void then
						l_cur_token := current_token_in_line (l_line)
					end
				until
					start_of_line (l_cur_token, l_line) or l_cur_token.image.is_equal ("(") or l_cur_token.image.is_equal (",") or l_cur_token.image.is_equal (";") or l_cur_token = l_line.eol_token
				loop
					if l_cur_token.image.is_equal ("[") then
						l_cur_token := skip_pairs (l_cur_token, l_line, "[", "]")
					elseif l_cur_token.image.is_equal ("{") then
						l_cur_token := skip_pairs (l_cur_token, l_line, "{", "}")
					end
					l_cur_token := l_cur_token.next
				end
				if start_of_line (l_cur_token, l_line) then
					l_is_start := true
				end
					-- Discard blank tokens.
				from
				until
					l_cur_token.next = Void or else l_cur_token.next.is_text or l_cur_token.next = l_line.eol_token
				loop
					l_cur_token := l_cur_token.next
				end
				if l_cur_token /= l_line.eol_token then
					if l_cur_token.next /= l_line.eol_token then
						if not l_is_start then
							l_cur_token := l_cur_token.next
						elseif between_seperator (l_cur_token, l_line) then
							l_cur_token := l_cur_token.next
						end
						l_start_token := l_cur_token
						l_found_start := true
							l_end_token := find_end_token (l_start_token, l_line, not l_is_start)
							if l_end_token = Void then
								l_end_token := l_line.eol_token
							end
						select_region_between_token (l_start_token, l_line, l_end_token, l_line)
						show_possible_selection
						l_selected := true
					else
						go_to_end_of_line
						l_selected := true
					end
				else
					go_to_end_of_line
					l_selected := true
				end
				if not l_selected then
					move_cursor_to (l_save_token, l_line)
				end
			end
		end

feature {EB_CODE_COMPLETION_WINDOW} -- Autocompletion from window

	complete_feature_from_window (cmp: STRING; is_feature_signature: BOOLEAN; appended_character: CHARACTER; remainder: INTEGER) is
			-- Insert `cmp' in the editor and switch to completion mode.
			-- If `is_feature_signature' then try to complete arguments and remove the type.
			-- `appended_character' is a character that should be appended after the feature. '%U' if none.
		local
			completed: STRING
			ind: INTEGER
			lp: INTEGER
		do
			if is_feature_signature then
				completed := cmp.twin
				ind := completed.last_index_of (':', completed.count)
				lp := completed.last_index_of (')', completed.count)
				if ind > 0 and ind > lp then
					completed.keep_head (ind - 1)
				end
				if discard_feature_signature and completed.has ('(') then
					completed.keep_head (completed.index_of ('(', 1) - 1)
				end
			else
				completed := cmp
			end
			if completed.is_empty then
				if appended_character /= '%U' then
					insert_char (appended_character)
				end
				--history.unbind_current_item_to_next
			else
				complete_feature_call (completed, is_feature_signature, appended_character, remainder)
				if is_feature_signature then
					if completed.last_index_of (')',completed.count) = completed.count then
						tab_action
					end
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
					delete_char
					i := i + 1
				end
			end
			if not completed.is_empty then
				insert_string (completed)
			end
			if appended_character /= '%U' then
				insert_char (appended_character)
			end
			refresh
		end

	complete_feature_call (completed: STRING; is_feature_signature: BOOLEAN; appended_character: CHARACTER; remainder: INTEGER) is
 			-- Finish completion process by inserting the completed expression.
		local
			i: INTEGER
		do
			if completion_possibilities_provider.insertion /= Void and then not completion_possibilities_provider.insertion.is_empty then --  valid_index (1) and then not click_tool.insertion.item (1).is_empty then
				if completed.item (1) = ' ' then
					back_delete_char
				end
			end
			save_cursor_position
			if remainder > 0 then
				from
					i := 0
				until
					i = remainder
				loop
					delete_char
					i := i + 1
				end
			end
			completed.replace_substring_all (";", ",")
			completed.replace_substring_all ("#", "# ")
			insert_string (completed)

			if appended_character /= '%U' then
				insert_char (appended_character)
			end

			if is_feature_signature and then completed.last_index_of (')',completed.count) = completed.count then
				select_from_cursor_to_saved
			end
		end

feature -- Basic operation

	trigger_completion is
			-- Start timer, let timer to start code completion.
		do
			completion_timeout.reset_count
			completion_timeout.actions.resume
		end

	block_completion is
			-- Stop timer, block code completion.
		do
			completion_timeout.reset_count
			completion_timeout.actions.block
		end

	complete_code is
			-- Prepare auto complete and show choice window directly.
		do
			if completion_possibilities_provider /= Void then
				prepare_auto_complete
				if completion_possibilities_provider.completion_possible then
					block_focus_out_actions
					show_completion_list (completing_feature)
				else
					block_completion
				end
			end
			block_completion
		end

	position_completion_choice_window is
			-- Reposition the completion choice window
		require
			choices_not_void: choices /= Void
		local
			l_x, l_y: INTEGER
			l_width, l_height: INTEGER
		do
			l_width := calculate_completion_list_width
			l_height := calculate_completion_list_height
			l_x := calculate_completion_list_x_position
			l_y := calculate_completion_list_y_position
			choices.set_size (l_width, l_height)
			choices.set_position (l_x, l_y)
		end

	exit_complete_mode is
			-- Set mode to normal (not completion mode).
		do
			is_completing := False
				-- Invalidating cursor forces cursor to be updated.
			set_focus
		ensure
			not_is_completing: is_completing = false
		end

	set_focus is
			-- Set focus.
		deferred
		end

feature {EB_CODE_COMPLETION_WINDOW} -- Basic operation

	block_focus_in_actions is
			-- Block focus in actions
		deferred
		end

	resume_focus_in_actions is
			-- Resume focus in actions
		deferred
		end

	block_focus_out_actions is
			-- Block focus out actions.
		deferred
		end

	resume_focus_out_actions is
			-- Resume focus out actions.
		deferred
		end

feature {EB_CODE_COMPLETION_WINDOW} -- Interact with code complete window.

	Completion_border_size: INTEGER is 75
			-- Size in pixels that the completion list can go to (virtual border)

	unwanted_characters: SPECIAL [BOOLEAN] is
			-- Unwanted characters: backspace, tabulation, carriage return and escape.
		local
			c: CHARACTER
			i: INTEGER
		once
			create Result.make (256)
			from
				i := 0
			until
				i = 256
			loop
				c := i.to_character
				Result.put (c.is_control, i)
				i := i + 1
			end
		end

	calculate_completion_list_width: INTEGER is
			-- Determine the width the completion list should have			
		do
				-- Calculate correct size to fit
			if choices.choice_list.column_count > 0 then
				Result := choices.choice_list.column (1).required_width_of_item_span (1, choices.choice_list.row_count) + completion_border_size
			end
		end

	handle_character (a_char: CHARACTER) is
			-- Handle `a_char'
		deferred
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
 		deferred
 		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
 		deferred
 		end

 	handle_tab_action is
 			-- Handle tab action.
 		do
 			tab_action
 		end

	calculate_completion_list_x_position: INTEGER is
			-- Determine the x position to display the completion list
		deferred
		end

	calculate_completion_list_y_position: INTEGER is
			-- Determine the y position to display the completion list
		deferred
		end

	calculate_completion_list_height: INTEGER is
			-- Determine the height the completion should list should have
		deferred
		end

feature -- Trigger completion

	on_key_pressed (a_key: EV_KEY) is
			-- If `a_key' can activate text completion, activate it.
		require
			a_key_attached: a_key /= Void
		do
			if not is_completing then
				if a_key.code = {EV_KEY_CONSTANTS}.key_tab and allow_tab_selecting then
					handle_tab_action
				end
				if can_complete_by_key.item ([a_key, ctrled_key, alt_key, shifted_key]) then
					trigger_completion
					debug ("Auto_completion")
						print ("Completion triggered.%N")
					end
				else
					block_completion
					debug ("Auto_completion")
						print ("Completion blocked.%N")
					end
				end
			end
		end

	shifted_key: BOOLEAN is
			-- Is any of the shift key pushed?
		do
			Result := ev_application.shift_pressed
		end

	ctrled_key: BOOLEAN is
			-- Is any of the ctrl key pushed?
		do
			Result := ev_application.ctrl_pressed
		end

	alt_key: BOOLEAN is
			-- Is any of the alt key pushed?
		do
			Result := ev_application.alt_pressed
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is pressed.
		deferred
		ensure
			key_press_actions_not_void: Result /= Void
		end

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN is
			-- `a_key' can activate text completion?
		require
			a_key_attached: a_key /= Void
		do
		end

feature {NONE}

	show_completion_list (is_feature: BOOLEAN) is
			-- Show completion window.
		do
			if is_feature then
				choices.initialize_for_features
					(
						Current,
						feature_name_part_to_be_completed,
						feature_name_part_to_be_completed_remainder,
						completion_possibilities_provider.completion_possibilities,
						completing_word
					)
			else
				choices.initialize_for_classes
					(
						Current,
						feature_name_part_to_be_completed,
						feature_name_part_to_be_completed_remainder,
						completion_possibilities_provider.class_completion_possibilities
					)
			end
			if choices.is_displayed then
				choices.hide
			end
			block_focus_out_actions
			if choices.show_needed then
				position_completion_choice_window
				choices.show
			end
		end

	prepare_auto_complete is
			-- Prepare possibilities in provider.
		do
			completion_possibilities_provider.prepare_completion
		end

feature {EB_CODE_COMPLETION_WINDOW} -- Complete essentials

	feature_name_part_to_be_completed: STRING is
			-- Word, which is the beginning of feature names, which is being completed.
		do
			Result := completion_possibilities_provider.insertion
		end

	feature_name_part_to_be_completed_remainder: INTEGER is
			-- Number of characters past the cursor on the token currenly being completed.
		do
			Result := completion_possibilities_provider.insertion_remainder
		end

feature -- Timer

	set_delay (l_time: INTEGER) is
			-- Set timer interval.
		do
			completion_timeout.set_interval (l_time)
		end

feature {NONE} -- Timer

	completion_timeout: EV_TIMEOUT
			-- Timeout for showing completion list

	ev_application: EV_APPLICATION is
			-- The application
		deferred
		end

	default_timer_interval: INTEGER is 1500

feature {NONE} -- Implementation

	between_seperator (a_token: EDITOR_TOKEN; a_line: like current_line) : BOOLEAN is
			-- Is cursor before `a_token' between seperators?
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
		local
			l_cur_token: EDITOR_TOKEN
		do
			l_cur_token := a_token.previous
			Result := l_cur_token = Void or else start_of_line (l_cur_token, a_line) or l_cur_token.image.is_equal ("(") or l_cur_token.image.is_equal (")") or l_cur_token.image.is_equal (",") or l_cur_token.image.is_equal (";") or l_cur_token = a_line.eol_token
			l_cur_token := a_token
			Result := Result and (l_cur_token = Void or else l_cur_token.image.is_equal ("(") or l_cur_token.image.is_equal (")") or l_cur_token.image.is_equal (",") or l_cur_token.image.is_equal (";") or l_cur_token = a_line.eol_token)
		end

	seperator_following (a_line: like current_line) : BOOLEAN is
			-- Is cursor before a seperator?
		require
			a_line_attached: a_line /= Void
		local
			l_cur_token: EDITOR_TOKEN
		do
			l_cur_token := current_token_in_line (a_line)
			Result := l_cur_token.image.is_equal (")") or l_cur_token.image.is_equal (",") or l_cur_token.image.is_equal (";") or l_cur_token = a_line.eol_token
		end

	skip_pairs (a_token: EDITOR_TOKEN; a_line: like current_line; a_left: STRING; a_right: STRING): EDITOR_TOKEN is
			-- Skip tokens from `a_token' that are and between pairs of `a_left' and `a_right'.
			-- i.e "[INETEGER, STRING]" where `a_token' is "[", `a_left' is "[", `a_right' is "]", "]" is returned.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_left_and_a_right_attached: a_left /= Void and a_right /= Void
			a_token_same_as_a_left: a_token.image.is_equal (a_left)
		local
			l_token: EDITOR_TOKEN
			l_pair_count: INTEGER
		do
			from
				l_token := a_token
				l_pair_count := 0
			until
				l_token = a_line.eol_token or l_token = Void or else (l_pair_count = 1 and l_token.image.is_equal (a_right))
			loop
				if l_token.image.is_equal (a_left) then
					l_pair_count := l_pair_count + 1
				elseif l_pair_count /= 0 and then l_token.image.is_equal (a_right) then
					l_pair_count := l_pair_count - 1
				end
				l_token := l_token.next
			end
			if l_token /= Void and l_token /= a_line.eol_token then
				Result := l_token
			else
				Result := a_line.eol_token
			end
		end

	skip_pairs_backward (a_token: EDITOR_TOKEN; a_line: like current_line; a_left: STRING; a_right: STRING): EDITOR_TOKEN is
			-- Skip backwards tokens from `a_token' that are and between pairs of `a_left' and `a_right'.
			-- i.e "[INETEGER, STRING]" where `a_token' is "]", `a_left' is "[", `a_right' is "]", "[" is returned.
		require
			a_token_attached: a_token /= Void
			a_line_attached: a_line /= Void
			a_left_and_a_right_attached: a_left /= Void and a_right /= Void
			a_token_same_as_a_left: a_token.image.is_equal (a_right)
		local
			l_token: EDITOR_TOKEN
			l_pair_count: INTEGER
		do
			from
				l_token := a_token
				l_pair_count := 0
			until
				l_token = a_line.real_first_token or else l_token = Void or else (l_pair_count = 1 and l_token.image.is_equal (a_left))
			loop
				if l_token.image.is_equal (a_right) then
					l_pair_count := l_pair_count + 1
				elseif l_pair_count /= 0 and then l_token.image.is_equal (a_left) then
					l_pair_count := l_pair_count - 1
				end
				l_token := l_token.previous
			end
			if l_token /= Void and l_token /= a_line.real_first_token then
				Result := l_token
			else
				Result := a_line.real_first_token
			end
		end

	find_end_token (a_token: EDITOR_TOKEN; a_line: like current_line; a_know_right_brace: BOOLEAN): EDITOR_TOKEN is
			-- Find end token from `a_token' in `a_line' for selection that is triggered by tab.
		local
			l_cur_token: EDITOR_TOKEN
			pair_counted: INTEGER
		do
			from
				l_cur_token := a_token
				pair_counted := 0
			until
				l_cur_token = Void or else (pair_counted = 0 and ((a_know_right_brace and l_cur_token.image.is_equal (")")) or l_cur_token.image.is_equal (",") or l_cur_token.image.is_equal (";"))) or l_cur_token = a_line.eol_token
			loop
				if l_cur_token.image.is_equal ("(") then
					if not a_know_right_brace then
						l_cur_token := skip_pairs (l_cur_token, a_line, "(", ")")
					end
				elseif l_cur_token.image.is_equal ("[") then
					l_cur_token := skip_pairs (l_cur_token, a_line, "[", "]")
				elseif l_cur_token.image.is_equal ("{") then
					l_cur_token := skip_pairs (l_cur_token, a_line, "{", "}")
				end
				if l_cur_token.image.is_equal ("(") then
					pair_counted := pair_counted + 1
				elseif l_cur_token.image.is_equal (")") then
					pair_counted := pair_counted - 1
				end
				l_cur_token := l_cur_token.next
			end
			Result := l_cur_token
		end

	find_previous_start_token (a_line: like current_line): EDITOR_TOKEN is
			-- Find start token for selection caused by tab action.
		local
			l_cur_token: EDITOR_TOKEN
		do
			from
				l_cur_token := current_token_in_line (a_line).previous
			until
				l_cur_token = Void or else l_cur_token.image.is_equal ("(") or l_cur_token.image.is_equal (",") or l_cur_token.image.is_equal (";")
			loop
				if l_cur_token.image.is_equal ("]") then
					l_cur_token := skip_pairs_backward (l_cur_token, a_line, "[", "]")
				elseif l_cur_token.image.is_equal ("}") then
					l_cur_token := skip_pairs_backward (l_cur_token, a_line, "{", "}")
				end
				l_cur_token := l_cur_token.previous
			end
			Result := l_cur_token
		end

	find_selection_start_in_selection (a_line: like current_line): EDITOR_TOKEN is
			-- Find in selection start token for selection caused by tab action.
		require
			has_selection: has_selection
		local
			l_cur_token, l_start_token, l_end_token: EDITOR_TOKEN
		do
			from
				l_start_token := selection_start_token_in_line (a_line)
				l_end_token := selection_end_token_in_line (a_line)
				l_cur_token := l_start_token
			until
				l_cur_token = Void or else l_cur_token = l_end_token or else l_cur_token.image.is_equal ("(")
			loop
				l_cur_token := l_cur_token.next
			end
			if l_cur_token /= Void and then l_cur_token /= l_end_token then
				Result := l_cur_token
			end
		end
end
