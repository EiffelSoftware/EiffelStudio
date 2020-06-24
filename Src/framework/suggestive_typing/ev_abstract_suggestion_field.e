note
	description: "[
		Abstraction for any UI that wants to support some suggestion facility.
		
		In addition to deferred routines that are required to be implemented, it
		is recommended to properly hookup `new_default_key_processing_handler' to
		the vision2 `default_key_processing_handler' by redefining
		`set_default_key_processing_handler' and `remove_default_key_processing_handler'.
		This enables a nicer integration to the underlying text field to ignore or handle
		certain keystroke (e.g. Ctrl+Space for example) without trying to loose the 
		original behavior of the `default_key_processing_handler' specified in the 
		underlying text field.
		An example of such redefinition can be found in EV_SUGGESTION_TEXT_FIELD.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ABSTRACT_SUGGESTION_FIELD

inherit
	ANY
		undefine
			default_create,
			is_equal,
			copy
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	create_interface_objects
			-- Creation of attached attributes of Current.
		do
			create suggestion_timeout.make_with_interval (0)
			create show_actions
			create close_actions

				-- Because we are having our own handler and we still want
				-- to let users provide their own customization, so we define
				-- variables holding the user provided customization and ours.
			old_default_key_processing_handler := Void
			new_default_key_processing_handler := Void -- agent is_default_key_processing_enabled
		end

	initialize_suggestion_field
			-- Initialization done after creating all attached attributes of Current.
		do
				-- Handlers
			new_default_key_processing_handler := agent is_default_key_processing_enabled

				-- Create the window used to show the list of choices.
			create choices.make (Current)

				-- Hook up the action monitoring the field.
			key_press_string_actions.extend (agent on_key_string_pressed)
			key_press_actions.extend (agent on_key_down)
			focus_out_actions.extend (agent on_lose_focus)
			mouse_wheel_actions.extend (agent on_mouse_wheel)
			set_default_key_processing_handler (new_default_key_processing_handler)

				-- Timeout action is connected but created with a timeout of 0 which means it is not activated.
			suggestion_timeout.actions.extend (agent provide_suggestion)
		end

feature -- Access

	suggestion_provider: SUGGESTION_PROVIDER
			-- Provider of suggestion for Current.

	parent_window: detachable EV_WINDOW
			-- Parent window if any of current field.

	last_suggestion: detachable SUGGESTION_ITEM
			-- Last match suggestion item.
		obsolete
			"Use `selected_suggestion' instead."
		do
			Result := selected_suggestion
		end

	selected_suggestion: detachable SUGGESTION_ITEM
			-- Currently selected suggestion if any.
			-- If Void, no items were selected or selection was cancelled.

feature {EV_SUGGESTION_WINDOW, EV_SUGGESTION_ACCESS} -- Access: shared

	settings: EV_SUGGESTION_SETTINGS
			-- Settings used for controlling various aspects of the way
			-- suggestions are presented to the end user.
			--| By default it uses the value of `default_suggestion_settings' unless overridden by calling `set_settings'..
		do
			if attached internal_settings as l_settings then
				Result := l_settings
			else
				Result := default_suggestion_settings
			end
		end

feature -- Configuration

	key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Actions to be performed when a char is entered.
		deferred
		end

	key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Actions to be performed when a keyboard key is pressed.
		deferred
		end

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when a focus is lost.
		deferred
		end

	mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Actions to be performed when mouse wheel is rotated.
		deferred
		end

	default_key_processing_handler: detachable PREDICATE [EV_KEY] assign set_default_key_processing_handler
			-- Agent used to determine whether the default key processing should occur for Current.
			-- If agent returns True then default key processing continues as normal, False prevents
			-- default key processing from occurring.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when completion list is shown.

	close_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [selected_item: detachable SUGGESTION_ITEM]]
			-- Actions to be performed when completion list is shown.

feature -- Status report

	is_suggesting: BOOLEAN
			-- Is suggestion currently being processed?

	is_suggestion_requested: BOOLEAN
			-- Is suggestion activated manually?
			-- (as opposed to automatically)

	last_suggestion_activator_character: CHARACTER_32
			-- Last suggestion activator character used for current suggestion.

	is_updating_text: BOOLEAN
			-- If true, an entry was selected in the completion list and we are updating Current with the associated
			-- `displayed_text' of the entry.

	is_destroyed: BOOLEAN
			-- Is `Current' no longer usable?
		deferred
		end

	is_sensitive: BOOLEAN
			-- Is `Current' sensitive to user input.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	is_editable: BOOLEAN
			-- Is `Current' editable?
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Element change

	set_settings (a_settings: like settings)
			-- Use `a_settings' as settings used internally by Current to control various aspects
			-- on how suggestions are presented to the end user.
		do
			internal_settings := a_settings
		ensure
			settings_set: settings = a_settings
		end

	set_parent_window (a_window: like parent_window)
			-- Set `parent_window' to `a_window'.
		require
			a_window_attached: a_window /= Void
		do
			parent_window := a_window
		ensure
			parent_window_set: parent_window = a_window
		end

	set_suggestion_provider (a_provider: like suggestion_provider)
			-- Set `suggestion_provider' with `a_provider'.
		do
			suggestion_provider := a_provider
		ensure
			suggestion_provder_set: suggestion_provider = a_provider
		end

	set_suggestion_timeout (a_timeout: INTEGER)
			-- Set `suggestion_timeout' with an interval of `a_timeout' milliseconds.
		do
			suggestion_timeout.set_interval (a_timeout)
		ensure
			suggestion_timeout_set: suggestion_timeout.interval = a_timeout
		end

	set_default_key_processing_handler (a_handler: like default_key_processing_handler)
			-- Set `default_key_processing_handler' with `a_handler'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	refresh
			-- Refresh current display.
			-- To be redefined to provide descendant specific actions.
		do
		end

feature -- Text operation

	select_all_text
			-- Select all text.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	delete_word_before
			-- Delete one word before the `caret_position'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	delete_word_after
			-- Delete one word after the `caret_position'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	set_displayed_text (a_text: separate READABLE_STRING_GENERAL)
			-- Set `a_text' to `displayed_text'.
		require
			not_destroyed: not is_destroyed
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		deferred
		end

	move_caret_to_end
			-- Move caret at the end of displayed text.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	searched_text: STRING_32
			-- Text which is going to be used as basis for suggestion.
			--| For example, if you have the following partial phone number "(555) 253-4" in `displayed_text'
			--| then the searched text could be "5552534".
		require
			not_destroyed: not is_destroyed
		do
			if attached settings.searched_text_agent as l_agent then
				Result := l_agent.item ([displayed_text])
			else
				Result := displayed_text
			end
			Result := text_without_activator (Result)
		end

	text_without_activator (s: STRING_32): STRING_32
		local
			ch: like last_suggestion_activator_character
		do
			Result := s
			ch := last_suggestion_activator_character
			if
				ch /= '%U' and then
				not Result.is_empty and then
				Result [1] = ch
			then
				Result := Result.substring (2, Result.count)
			end
		end

	displayed_text: STRING_32
			-- Text which is currently displayed.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	caret_position: INTEGER
			-- Current position of caret in `text'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Basic operation

	provide_requested_suggestion
		do
			is_suggestion_requested := True
			disable_suggestion_timeout
			process_suggestion
		ensure
			is_suggesting_updated: old is_suggesting implies is_suggesting
		end

	provide_suggestion
			-- Prepare suggestion list and show suggestion window directly.
		do
			is_suggestion_requested := False
			process_suggestion
		ensure
			is_suggesting_updated: old is_suggesting implies is_suggesting
		end

	terminate_suggestion
			-- Suggestion has either been accepted or cancelled.
		do
			is_suggesting := False
				-- We are done with the suggestion, we can therefore stop the timer.
			disable_suggestion_timeout
		ensure
			not_is_suggesting: not is_suggesting
		end

feature {NONE} -- Execution

	process_suggestion
		do
			if
				is_editable and then not is_suggesting and then
				suggestion_provider.is_available and then attached choices as l_choices
			then
					-- We are done processing the keys for the time being until
					-- the `choices' are hidden and user starts typing again.
				is_suggesting := True
					-- We are resetting the previous suggestion.
				set_selected_suggestion (Void)
				disable_suggestion_timeout
				l_choices.show_suggestion_list (searched_text, True)
			end
		ensure
			is_suggesting_updated: old is_suggesting implies is_suggesting
		end

feature {EV_SUGGESTION_WINDOW} -- Interact with suggestion window.

	insert_suggestion (a_selected_item: attached like last_suggestion)
			-- Insert associated text of `a_selected_item' in Current if valid,
			-- move caret to the end and update `last_suggestion' with `a_selected_item'.
		require
			not_destroyed: not is_destroyed
		local
			l_text: READABLE_STRING_GENERAL
		do
			set_selected_suggestion (a_selected_item)
			l_text := suggested_text (a_selected_item)
			if not l_text.is_empty and not l_text.has_code (('%R').natural_32_code)then
					-- Before updating the text of the underlying field, we flag our editing
					-- so that clients can control some of the change_actions and do something
					-- different if needed
				is_updating_text := True
				set_displayed_text (l_text)
				move_caret_to_end
				is_updating_text := False
			end
			refresh
		ensure
			is_suggesting_unchanged: is_suggesting = old is_suggesting
			last_suggestion_set: selected_suggestion = a_selected_item
		end

	suggested_text (a_selected_item: SUGGESTION_ITEM): READABLE_STRING_GENERAL
		local
			s32: STRING_32
		do
			Result := a_selected_item.text
			if not Result.is_empty then
					-- Keep or not the suggestion activator character, if any ?
				if
					last_suggestion_activator_character /= '%U' and then
					settings.is_suggestion_activator_character_included (last_suggestion_activator_character)
				then
					create s32.make (Result.count + 1)
					s32.append_character (last_suggestion_activator_character)
					s32.append_string_general (Result)
					Result := s32
				end
			end
		end

	set_selected_suggestion (a_suggestion_item: like selected_suggestion)
			-- Set `selected_suggestion' with `a_suggestion_item'.
		do
			selected_suggestion := a_suggestion_item
		ensure
			selected_suggestion_set: selected_suggestion = a_suggestion_item
		end

	is_default_key_processing_enabled (a_key: EV_KEY): BOOLEAN
			-- Will `a_key' be processed by underlying implementation.
		do
			if
				is_ctrl_pressed and (a_key.code = {EV_KEY_CONSTANTS}.key_back_space or
				a_key.code = {EV_KEY_CONSTANTS}.key_delete)
			then
					-- Ctrl+Backspace or Ctrl+Delete should not yield any default behavior
					-- as our implementation will handle the expected behavior `handle_deletion_keys'.
				Result := False
			else
					-- If we press the shortcut for completion, we do not want any characters
					-- to appear in the underlying control. Ideally we would like to do it only
					-- when `not is_suggesting' but `is_suggesting' might be set to True in
					-- `on_key_down' and the handling of the character we do not want to display
					-- is done in `on_key_string_pressed' where `is_suggesting' is set to True.
				Result := not is_shortcut_for_suggestion (a_key, is_ctrl_pressed, is_alt_pressed, is_shift_pressed)
				if Result then
						-- We use the original `default_key_processing_handler' to  find out.
					if attached old_default_key_processing_handler as l_handler then
						Result := l_handler.item ([a_key])
					end
				end
			end
		end

	font: EV_FONT
			-- Font used by current to display text.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	width: INTEGER
			-- Horizontal size in pixels.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	height: INTEGER
			-- Vertical size in pixels.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature {NONE} -- Key handling

	on_key_down (a_key: EV_KEY)
			-- Handle `a_key' and check against `settings.override_shortcut_trigger', if specified,
			-- that `a_key' is a shortcut for triggering the suggestion. If not specified
			-- we use `is_shortcut_for_suggestion' instead.
		local
			l_suggested: BOOLEAN
		do
			if is_editable then
				if not is_suggesting then
					if attached settings.override_shortcut_trigger as l_agent then
						if l_agent.item ([a_key, is_ctrl_pressed, is_alt_pressed, is_shift_pressed]) then
							provide_requested_suggestion
							l_suggested := True
						end
					else
						if is_shortcut_for_suggestion (a_key, is_ctrl_pressed, is_alt_pressed, is_shift_pressed) then
							provide_requested_suggestion
							l_suggested := True
						end
					end
					if not l_suggested then
						disable_suggestion_timeout
					end
					if is_ctrl_pressed then
							-- If Backspace or Delete is pressed we perform
							-- whatever the implementation decided. By default it is to
							-- remove the word before or after `caret_position'.
						handle_keys (a_key)
					elseif not l_suggested and then a_key.is_printable then
						reset_suggestion_timeout
					end
				elseif choices /= Void and then not choices.is_destroyed and then choices.is_displayed then
					inspect
						a_key.code
					when {EV_KEY_CONSTANTS}.key_left, {EV_KEY_CONSTANTS}.key_right then
						if settings.has_arrows_key_text_navigation and not choices.is_navigable then
							if a_key.code = {EV_KEY_CONSTANTS}.key_left then
								if caret_position = 1 then
										-- We are at the beginning, so going to the left one more
										-- time is a user intent to say he does not want to be
										-- provided with a suggestion.
									choices.cancel_and_close
								end
							else
								if caret_position >= displayed_text.count + 1 then
										-- We are at the end, so going to the right one more
										-- time is a user intent to say he does not want to
										-- be provided with a suggestion.
									choices.cancel_and_close
								end
							end
						end
					when {EV_KEY_CONSTANTS}.Key_up then
						choices.go_to_next_item (False)
					when {EV_KEY_CONSTANTS}.Key_down then
						choices.go_to_next_item (True)
					when {EV_KEY_CONSTANTS}.Key_page_up then
						choices.go_to_next_page (False)
					when {EV_KEY_CONSTANTS}.Key_page_down then
						choices.go_to_next_page (True)
					when {EV_KEY_CONSTANTS}.key_home then
						choices.go_first
					when {EV_KEY_CONSTANTS}.key_end then
						choices.go_last
					when {EV_KEY_CONSTANTS}.Key_enter then
						choices.suggest_and_close
					when {EV_KEY_CONSTANTS}.Key_escape then
						choices.cancel_and_close

					when {EV_KEY_CONSTANTS}.key_back_space, {EV_KEY_CONSTANTS}.key_delete then
						if is_ctrl_pressed then
							handle_deletion_keys (a_key)
						else
								-- Note that `displayed_text' is the text representation before handling `a_key'.
							if displayed_text.is_empty then
									-- List is discarded if all the characters inserted have been
									-- removed and that the user press one more time the backspace key
									-- showing his intent of stopping the suggestion.
								choices.cancel_and_close
							else
								ev_application.do_once_on_idle (agent do
									if choices /= Void and then not choices.is_destroyed and then choices.is_displayed then
										choices.show_suggestion_list (searched_text, False)
									end
								end)
							end
						end

					else
						-- Do nothing
					end
				end
			end
		end

	on_key_string_pressed (s: STRING_32)
			-- Process character `s', if it is part of
			-- `settings.suggestion_activator_characters' suggestion list is shown.
		local
			c: CHARACTER_32
		do
			if is_editable then
				if s.count = 1 then
					if not is_suggesting then
						last_suggestion_activator_character := '%U'
						if settings.is_suggesting_as_typing and not s.is_whitespace then
--							provide_suggestion
							ev_application.do_once_on_idle (agent process_suggestion)
						elseif settings.is_suggestion_activator_character (s [1]) then
							last_suggestion_activator_character := s [1]
--							provide_suggestion
							ev_application.do_once_on_idle (agent process_suggestion)
						else
							disable_suggestion_timeout
						end
					elseif attached choices as l_choices and then not l_choices.is_destroyed and then l_choices.is_displayed then
						c := s.item (1)
						if attached settings.character_translator as l_translator then
							c := l_translator.item ([c])
						end
						if c /= '%U' then
							if settings.is_suggestion_deactivator_character (c) then
								choices.suggest_and_close
							else
								ev_application.do_once_on_idle (agent do
									if attached choices as i_choices and then not i_choices.is_destroyed and then i_choices.is_displayed then
										i_choices.show_suggestion_list (searched_text, False)
									end
								end)
							end
						end
					end
				end
			end
		end

	handle_keys (a_key: EV_KEY)
  			-- Process the push on Ctrl + an extended key.
  		require
 			not_destroyed: not is_destroyed
 		do
  			inspect
  				a_key.code
			when {EV_KEY_CONSTANTS}.key_a then
				select_all_text
			else
				handle_deletion_keys (a_key)
			end
 		end

	handle_deletion_keys (a_key: EV_KEY)
 			-- Process the push on Ctrl + an extended key.
 		require
			not_destroyed: not is_destroyed
		do
 			inspect
 				a_key.code
 			when {EV_KEY_CONSTANTS}.key_back_space then
				delete_word_before

			when {EV_KEY_CONSTANTS}.key_delete then
				delete_word_after

			else
			end
 		end

	is_shift_pressed: BOOLEAN
			-- Are any of the Shift keys pressed?
		do
			Result := ev_application.shift_pressed
		end

	is_ctrl_pressed: BOOLEAN
			-- Are any of the Ctrl keys pressed?
		do
			Result := ev_application.ctrl_pressed
		end

	is_alt_pressed: BOOLEAN
			-- Are any of the Alt keys pressed?
		do
			Result := ev_application.alt_pressed
		end

	is_shortcut_for_suggestion (a_key: EV_KEY; a_ctrl, a_alt, a_shift: BOOLEAN): BOOLEAN
			-- Can `a_key' associated with the state of the modifiers `a_ctrl', `a_alt'
			-- and `a_shift' activate text suggestion?
			-- By default we use `Ctrl+space' as trigger. It can be redefined in descendants or
			-- overridden by `override_shortcut_trigger'.
		do
			Result := a_ctrl and a_key.code = {EV_KEY_CONSTANTS}.key_space
		end

feature {NONE} -- Events

	on_lose_focus
			-- Current just lost focus, we need to close suggestion window if visible.
		do
			if
				is_suggesting and then attached choices as l_choices and then
				not l_choices.is_destroyed and then l_choices.is_displayed
			then
				l_choices.cancel_and_close
			end
		end

	on_mouse_wheel (a_offset: INTEGER)
			-- Handling of wheel
		do
			if
				is_suggesting and then attached choices as l_choices  and then
				not l_choices.is_destroyed and then l_choices.is_displayed
			then
				l_choices.on_mouse_wheel (a_offset)
			end
		end

feature {NONE} -- Implementation

	reset_suggestion_timeout
			-- When a key is pressed, we reset `suggestion_timeout'.
		do
			suggestion_timeout.set_interval (settings.timeout)
		end

	disable_suggestion_timeout
			-- Stop `suggestion_timeout'.
		do
			suggestion_timeout.set_interval (0)
		end

	enable_suggestion_timeout
			-- Restart `suggestion_timeout'.
		require
			suggestion_timeout.interval = 0
		do
			suggestion_timeout.set_interval (settings.timeout)
		end

feature {NONE} -- Implementation: Access

	internal_settings: detachable EV_SUGGESTION_SETTINGS
			-- Storage for `settings'.

	choices: detachable EV_SUGGESTION_WINDOW note option: stable attribute end
			-- Window used internally to show the list of choices.

	default_suggestion_settings: EV_SUGGESTION_SETTINGS
			-- Default settings used for displaying the list of suggestions.
			-- It can be overridden by setting `settings'.
		once
			create Result.make
		end

	suggestion_timeout: EV_TIMEOUT
			-- Timeout for showing suggestion list if not already shown, and if shown, timeout
			-- to refresh the suggestion list with new input if any.

	new_default_key_processing_handler: like default_key_processing_handler
			-- Handler used whenever Vision2 is using `default_key_processing_handler'.

	old_default_key_processing_handler: like default_key_processing_handler
			-- Original `default_key_processing_handler' set by user. It is called when `choices' is not shown,
			-- otherwise we use our own.

invariant

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
