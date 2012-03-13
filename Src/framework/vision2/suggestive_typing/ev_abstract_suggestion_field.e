note
	description: "Abstraction for any UI that wants to support some suggestion facility."
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
		end

	initialize_suggestion_field
			-- Initialization done after creating all attached attributes of Current.
		do
				-- Create the window used to show the list of choices.
			create choices.make (Current)

			key_press_string_actions.extend (agent on_key_string_pressed)
			key_press_actions.extend (agent on_key_down)
			set_default_key_processing_handler (agent is_key_handled)
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

feature {EV_SUGGESTION_WINDOW} -- Access: shared

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

	default_key_processing_handler: detachable PREDICATE [ANY, TUPLE [EV_KEY]] assign set_default_key_processing_handler
			-- Agent used to determine whether the default key processing should occur for Current.
			-- If agent returns True then default key processing continues as normal, False prevents
			-- default key processing from occurring.
		require
			not_destroyed: not is_destroyed
		deferred
		end

feature -- Status report

	is_suggesting: BOOLEAN
			-- Is suggestion currently being processed?

	is_focus_back_needed: BOOLEAN
			-- Should focus be set back after suggestion is terminated?
		do
			Result := not is_destroyed
		end

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

	delete_character_before
			-- Delete one character before the `caret_position'.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	delete_character_after
			-- Delete one character after the `caret_position'.
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

	remove_text
			-- Removed `text' from current.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Set `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		deferred
		end

	insert_character (a_char: CHARACTER_32)
			-- Insert `a_char' after `caret_position'.
		require
			not_destroyed: not is_destroyed
			no_carriage_returns: a_char /= '%R'
		deferred
		end

	move_caret_to (a_pos: INTEGER)
			-- Move caret at `a_pos'. If `a_pos' is negative, carete is remains at the beginning. If `a_pos' is
			-- greater than the maximum possible caret position, it stays at the end.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	move_caret_to_start
			-- Move caret at the beginning.
		require
			not_destroyed: not is_destroyed
		do
			move_caret_to (0)
		end

	move_caret_to_end
			-- Move caret at the end.
		require
			not_destroyed: not is_destroyed
		deferred
		end

	text: STRING_32
			-- Text which is going to be used as basis for suggestion.
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

feature {EV_SUGGESTION_WINDOW} -- Focus operation

	block_focus_in_actions
			-- Block focus in actions.
		deferred
		end

	resume_focus_in_actions
			-- Resume focus in actions.
		deferred
		end

	block_focus_out_actions
			-- Block focus out actions.
		deferred
		end

	resume_focus_out_actions
			-- Resume focus out actions.
		deferred
		end

	set_focus
			-- Set focus.
		require
			not_destroyed: not is_destroyed
			is_sensitive: is_sensitive
		deferred
		end

feature -- Basic operation

	provide_suggestion
			-- Prepare suggestion list and show suggestion window directly.
		do
			if
				not is_suggesting and then
				suggestion_provider.is_available and then attached choices as l_choices
			then
					-- We are done processing the keys for the time being until
					-- the `choices' are hidden and user starts typing again.
				is_suggesting := True
					-- We are resetting the previous suggestion.
				last_suggestion := Void
				disable_suggestion_timeout
				l_choices.show
			end
		ensure
			is_suggesting_updated: old is_suggesting implies is_suggesting
		end

	terminate_suggestion
			-- Suggestion has either been accepted or cancelled.
		do
			is_suggesting := False
			if is_focus_back_needed then
					-- Invalidating cursor forces cursor to be updated.
				set_focus
			end
				-- We are done with the suggestion, we can therefore stop the timer.
			disable_suggestion_timeout
		ensure
			not_is_suggesting: not is_suggesting
		end

feature {EV_SUGGESTION_WINDOW} -- Interact with suggestion window.

	insert_suggestion (a_text: STRING_32; a_selected_item: like last_suggestion)
			-- Insert `a_text' in Current if valid, move caret to the end and update `last_suggestion'.
		require
			not_destroyed: not is_destroyed
		do
			last_suggestion := a_selected_item
			if not a_text.is_empty and not a_text.has_code (('%R').natural_32_code)then
				set_text (a_text)
				move_caret_to_end
			end
			refresh
		ensure
			is_suggesting_unchanged: is_suggesting = old is_suggesting
			last_suggestion_set: last_suggestion = a_selected_item
		end

	is_key_handled (a_key: EV_KEY): BOOLEAN
			-- Will `a_key' be processed by underlying implementation.
		do
				-- By default we let the underlying implementation handles the key
			Result := True
				-- If Ctrl is pressed then we handle the key handling via `handle_extended_ctrled_key'.
			if is_ctrl_pressed then
				Result := a_key.code /= {EV_KEY_CONSTANTS}.key_back_space and
					a_key.code /= {EV_KEY_CONSTANTS}.key_delete
			end
		end

	handle_character (a_char: CHARACTER_32)
			-- Insert `a_char' at `caret_position' unless it is excluded by `settings.unwanted_characters'.
		require
			not_destroyed: not is_destroyed
			no_carriage_returns: a_char /= '%R'
		do
			if not settings.unwanted_characters.has (a_char) then
				insert_character (a_char)
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY)
 			-- Process the push on Ctrl + an extended key.
 		do
 			inspect
 				ev_key.code
 			when {EV_KEY_CONSTANTS}.key_back_space then
				delete_character_before
			when {EV_KEY_CONSTANTS}.key_delete then
				delete_character_after
			else
			end
 		end

	handle_extended_key (ev_key: EV_KEY)
 			-- Process the push on an extended key.
 		do
			inspect ev_key.code
			when {EV_KEY_CONSTANTS}.key_back_space then
				delete_character_before
			when {EV_KEY_CONSTANTS}.key_delete then
				delete_character_after
			else
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

feature {NONE} -- Trigger suggestion

	on_key_down (a_key: EV_KEY)
			-- Handle `a_key' and check against `settings.override_shortcut_trigger', if specified,
			-- that `a_key' is a shortcut for triggering the suggestion. If not specified
			-- we use `is_shortcut_for_suggestion' instead.
		do
			if not is_suggesting then
				if attached settings.override_shortcut_trigger as l_agent then
					if l_agent.item ([a_key, is_ctrl_pressed, is_alt_pressed, is_shift_pressed]) then
						provide_suggestion
					end
				else
					if is_shortcut_for_suggestion (a_key, is_ctrl_pressed, is_alt_pressed, is_shift_pressed) then
						provide_suggestion
					end
				end
				if a_key.code /= {EV_KEY_CONSTANTS}.key_back_space and a_key.code /= {EV_KEY_CONSTANTS}.key_delete then
					reset_suggestion_timeout
				elseif is_ctrl_pressed then
						-- If Backspace or Delete is pressed we perform
						-- whatever the implementation decided. By default it is to
						-- remove the word before or after `caret_position'.
					handle_extended_ctrled_key (a_key)
				end
			end
		end

	on_key_string_pressed (character_string: STRING_32)
			-- Process character `character_string', if it is part of
			-- `settings.suggestion_activator_acharacts' suggestion list is shown.
		require
			a_key_attached: character_string /= Void
		do
			if not is_suggesting and then character_string.count = 1 then
				reset_suggestion_timeout
				if attached settings.suggestion_activator_characters as l_chars and then l_chars.has (character_string.item (1)) then
					provide_suggestion
				end
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

	saved_caret_position: INTEGER
			-- Value of `caret_position' before showing the suggestion.

	suggestion_timeout: EV_TIMEOUT
			-- Timeout for showing suggestion list if not already shown, and if shown, timeout
			-- to refresh the suggestion list with new input if any.

invariant

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
