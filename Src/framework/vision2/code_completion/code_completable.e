indexing
	description: "Object that is able to auto complete code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CODE_COMPLETABLE

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize_code_complete is
			-- Initialization
		require
			key_press_actions_attached: key_press_actions /= Void
		do
			key_press_actions.extend (agent on_key_pressed)
			create precompletion_actions
			key_completable := agent can_complete
			create completion_timeout.make_with_interval (default_timer_interval)
			completion_timeout.actions.extend (agent complete_code)
			completion_timeout.actions.block
		ensure
			completion_timeout_not_void: completion_timeout /= Void
			can_complete_by_key_not_void: key_completable /= Void
		end

feature -- Access

	choices: CODE_COMPLETION_WINDOW is
			-- Completion choice window.
		once
			create Result.make
		end

	parent_window: EV_WINDOW assign set_parent_window
			-- Parent window, used to evaluate where the compilation list should be shown.

	possibilities_provider: COMPLETION_POSSIBILITIES_PROVIDER
			-- Possibilities provider.

	key_completable : FUNCTION [ANY, TUPLE [EV_KEY, BOOLEAN, BOOLEAN, BOOLEAN], BOOLEAN]
			-- EV_KEY can activate text completion?

	key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Actions to be performed when a keyboard key is pressed.
		deferred
		ensure
			key_press_actions_not_void: Result /= Void
		end

	save_list_position_action: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]]
			-- Action to save completion list position.
			-- [x_position, y_position, width, height]

	completion_activator_characters: ARRAYED_LIST [CHARACTER]
			-- List of completion activating keys
		once
			create Result.make (1)
			Result.extend ('.')
		end

feature -- Element change

	set_parent_window (a_window: like parent_window)
			-- Set parent window (used for screen location adjustments) to `a_window'.
		require
			a_window_attached: a_window /= Void
		do
			parent_window := a_window
		ensure
			parent_window_set: parent_window = a_window
		end

feature -- Status change

	set_can_complete (a_fun: like key_completable) is
			-- Set `key_completable' with `a_fun'.
		require
			a_fun_attached: a_fun /= Void
		do
			key_completable := a_fun
		ensure
			key_completable_not_void: key_completable /= Void
		end

	set_completion_possibilities_provider (a_provider: like possibilities_provider) is
			-- Set `completion_possibilities_provider'.
		do
			possibilities_provider := a_provider
		end

	set_save_list_position_action (a_action: like save_list_position_action) is
			-- Set `save_list_position_action' with `a_action'.
		do
			save_list_position_action := a_action
		ensure
			save_list_position_action_set: save_list_position_action = a_action
		end

	refresh is
			-- Refresh current display.
		do
		end

feature -- Status report

	is_completing: BOOLEAN
			-- Is completion currently being processed?

	is_focus_back_needed: BOOLEAN is
			-- Should focus be set back after code completion?
		do
			Result := True
		end

feature {NONE} -- Status report

	auto_complete_is_possible: BOOLEAN is
			-- Is auto complete possible.
		do
			if possibilities_provider /= Void then
				Result := possibilities_provider.completion_possible
			end
		end

	completing_word: BOOLEAN is
			-- Is in completing word mode?
		deferred
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

feature -- Cursor

	place_post_cursor is
			-- Place cursor after completion.
		deferred
		end

feature {CODE_COMPLETION_WINDOW} -- Autocompletion from window

	complete_from_window (cmp: STRING; appended_character: CHARACTER; remainder: INTEGER) is
			-- Insert `cmp' in the editor and switch to completion mode.
			-- `appended_character' is a character that should be appended after. '%U' if none.
		local
			completed: STRING
		do
			completed := cmp
			if completed.is_empty then
				if appended_character /= '%U' then
					insert_char (appended_character)
				end
			else
				complete_call (completed, appended_character, remainder)
				place_post_cursor
			end
			refresh
		end

	complete_call (completed: STRING; appended_character: CHARACTER; remainder: INTEGER) is
			-- Finish completion process by inserting the completed expression.
		local
			i: INTEGER
		do
			if possibilities_provider.insertion /= Void and then not possibilities_provider.insertion.is_empty then
				if completed.item (1) = ' ' then
					back_delete_char
				end
			end
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
			insert_string (completed)
			if appended_character /= '%U' then
				insert_char (appended_character)
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
		local
			retried: BOOLEAN
		do
			if not retried then
				if possibilities_provider /= Void then
					precompletion_actions.call (Void)
					prepare_auto_complete
					if possibilities_provider.completion_possible then
						block_focus_out_actions
						show_completion_list
					else
						block_completion
					end
				end
				block_completion
			end
		rescue
			retried := True
			if possibilities_provider /= Void then
				possibilities_provider.reset
			end
			resume_focus_out_actions
			block_completion
			retry
		end

	position_completion_choice_window is
			-- Reposition the completion choice window
		require
			choices_not_void: choices /= Void
		local
			l_x, l_y: INTEGER
			l_width, l_height: INTEGER
			l_helpers: EVS_HELPERS
			l_coords: TUPLE [x, y: INTEGER]
		do
			l_width := calculate_completion_list_width
			l_height := calculate_completion_list_height
			l_x := calculate_completion_list_x_position
			l_y := calculate_completion_list_y_position

			if parent_window /= Void and then not parent_window.is_destroyed and then parent_window.is_show_requested then
					-- Reposition based on screen coords
				create l_helpers
				l_coords := l_helpers.suggest_pop_up_widget_location_with_size (parent_window, l_x, l_y, l_width, l_height)
				if l_y >= l_coords.y then
						-- Adjust hieght to prevent the completion list from shift up and over the text.
						-- This is ok to do because `calculate_completion_list_y_position' determines if the
						-- list should be shown above or below the editor caret. If it's displayed below then
						-- we adjust the size of the list to remain on-screen.
					l_height := l_height - (l_y - l_coords.y)
				end
			end

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

feature {CODE_COMPLETION_WINDOW} -- Basic operation

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

feature {CODE_COMPLETION_WINDOW} -- Interact with code complete window.

	Completion_border_size: INTEGER is 5
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
				c := i.to_character_8
				Result.put (c.is_control, i)
				i := i + 1
			end
		end

	calculate_completion_list_width: INTEGER is
			-- Determine the width the completion list should have
		local
			l_grid: EV_GRID
			l_screen: EV_SCREEN
			l_height: INTEGER
			l_count_to_calculate: INTEGER
			i: INTEGER
			l_name: NAME_FOR_COMPLETION
		do
			l_grid := choices.choice_list
				-- Calculate correct size to fit
			if not l_grid.is_destroyed and then l_grid.column_count >= 1 and then l_grid.row_count > 0 then
				Result := l_grid.column (1).required_width_of_item_span (1, l_grid.row_count)
				if Result = 0 then
					l_height := calculate_completion_list_height
					l_count_to_calculate := l_height // l_grid.row_height + 1
					l_count_to_calculate := l_count_to_calculate.min (l_grid.row_count)
					from
						i := 1
					until
						i > l_count_to_calculate
					loop
						l_name ?= l_grid.row (i).data
						check
							l_name_not_void: l_name /= Void
						end
						Result := Result.max (l_name.grid_item.required_width)
						i := i + 1
					end
					Result := Result + completion_border_size
				end
			else
				Result := default_window_width
			end

			create l_screen
			Result := l_screen.width.min (Result)
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

feature {NONE} -- Trigger completion

	on_key_pressed (a_key: EV_KEY) is
			-- If `a_key' can activate text completion, activate it.
		require
			a_key_attached: a_key /= Void
		do
			if not is_completing then
				if key_completable.item ([a_key, ctrled_key, alt_key, shifted_key]) then
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

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN is
			-- `a_key' can activate text completion?
		require
			a_key_attached: a_key /= Void
		do
		end

feature {NONE} -- Implementation

	show_completion_list is
			-- Show completion window.
		do
			choices.common_initialization
				(
					Current,
					name_part_to_be_completed,
					name_part_to_be_completed_remainder,
					possibilities_provider.completion_possibilities,
					completing_word
				)
			if choices.is_displayed then
				choices.hide
			end
			block_focus_out_actions
			if choices.show_needed then
				position_completion_choice_window
				is_completing := True
				choices.show
			end
		end

	prepare_auto_complete is
			-- Prepare possibilities in provider.
		do
			possibilities_provider.prepare_completion
		end

	precompletion_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called before trying to complete

feature {NONE} -- Complete essentials

	name_part_to_be_completed: STRING is
			-- Word, which is being completed.
		do
			Result := possibilities_provider.insertion
		end

	name_part_to_be_completed_remainder: INTEGER is
			-- Number of characters past the cursor on the token currenly being completed.
		do
			Result := possibilities_provider.insertion_remainder
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

	default_timer_interval: INTEGER is
			-- Default completion window appearance time out interval
		once
			Result := 10
		end

	default_window_width: INTEGER
			-- Default completion window width
		once
			Result := 300
		end

	default_window_height: INTEGER
			-- Default completion window height
		once
			Result := 400
		end

indexing
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
end
