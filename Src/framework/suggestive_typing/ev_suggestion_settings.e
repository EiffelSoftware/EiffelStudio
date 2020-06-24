note
	description: "Settings controlling the behavior of suggestive typing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SUGGESTION_SETTINGS

inherit
	EV_SUGGESTION_MODES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Current with default settings for performing suggestion.
		do
				-- Default starts computation after `default_timeout' of inactivity.
			set_timeout (default_timeout)
			is_list_recomputed_when_typing := False
			is_list_filtered_when_typing := True
			is_single_match_completed := False
			is_list_x_position_set := False
			is_list_y_position_set := False
			is_initial_position_at_caret := False
			is_fit_list_window_to_content := True
			list_width := -1
			list_height := -1
			is_mouse_wheel_in_full_page_mode := False
			mouse_wheel_scroll_size := default_mouse_wheel_scroll_size
			scrolling_common_line_count := default_scrolling_common_line_count
			is_initial_position_at_caret := False
			has_arrows_key_text_navigation := False

				-- Setup characters that can be used to stop suggestion
			create suggestion_deactivator_characters.make (3)
			register_suggestion_deactivator_character (escape_character)
			register_suggestion_deactivator_character (carriage_return_character)
			register_suggestion_deactivator_character (newline_character)

				-- No characters are setup by default to trigger suggestion
			suggestion_activator_characters := Void

				-- No translator of character by default
			character_translator := Void

			query_cancel_request := Void
			internal_matcher := Void
		ensure
			timeout_set: timeout = default_timeout
			is_list_recomputed_when_typing_not_set: not is_list_recomputed_when_typing
			is_list_filtered_when_typing_set: is_list_filtered_when_typing
			is_single_match_completed_not_set: not is_single_match_completed
			list_x_position_not_set: not is_list_x_position_set
			list_y_position_not_set: not is_list_y_position_set
			is_initial_position_at_caret_not_set: not is_initial_position_at_caret
			is_fit_list_window_to_content_set: is_fit_list_window_to_content
			list_width_not_set: not is_list_width_set
			list_height_not_set: not is_list_height_set
			is_mouse_wheel_in_full_page_mode_not_set: not is_mouse_wheel_in_full_page_mode
			has_arrows_key_text_navigation_not_set: not has_arrows_key_text_navigation
			mouse_wheel_scroll_size_set: mouse_wheel_scroll_size = default_mouse_wheel_scroll_size
			scrolling_common_line_count_set: scrolling_common_line_count = default_scrolling_common_line_count
			is_initial_position_at_caret_not_set: not is_initial_position_at_caret
			suggestion_deactivator_characters_set: suggestion_deactivator_characters.has (escape_character) and
				suggestion_deactivator_characters.has (carriage_return_character) and suggestion_deactivator_characters.has (newline_character)
			suggestion_activator_characters_not_set: suggestion_activator_characters = Void
			character_translator: character_translator = Void
			query_cancel_request_not_set: query_cancel_request = Void
			matcher_set: matcher = default_matcher
		end

feature -- Constants

	default_timeout: INTEGER = 250
			-- Default timeout for `timeout' in milliseconds, 250ms.

	default_mouse_wheel_scroll_size: INTEGER = 3
			-- Default number of items by which the wheel scroll the grid.

	default_scrolling_common_line_count: INTEGER = 1
			-- Default number of rows that will be common between two pages
			-- on a page by page scrolling.

	escape_character: CHARACTER_32 = '%/027/'
			-- Character for escape.

	carriage_return_character: CHARACTER_32 = '%R'
			-- Character for carriage return.

	newline_character: CHARACTER_32 = '%N'
			-- Character for newline.

	default_matcher: SUBSTRING_SUGGESTION_MATCHER
			-- Default matcher for current.
		once
			create Result
		end

feature -- Access

	mode: INTEGER
			-- Mode currently used for showing suggestion. It is one among `{EV_SUGGESTION_MODES}'.

	timeout: INTEGER
			-- Number of milliseconds to wait after receiving the last keystroke event
			-- before starting a request to `suggestion_provider'.

	update_row_agent: detachable PROCEDURE [EV_GRID_ROW, SUGGESTION_ITEM]
			-- Agent called for converting SUGGESTION_ITEM into EV_GRID_ITEM in a grid row.

	mouse_wheel_scroll_size: INTEGER
			-- Number of rows to scroll if not in page by page scrolling mode.

	scrolling_common_line_count: INTEGER
			-- On a page by page scrolling, number of rows that will be common
			-- between the two pages.

	list_x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		require
			is_list_x_position_set: is_list_x_position_set
		attribute
		end

	list_y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		require
			is_list_y_position_set: is_list_y_position_set
		attribute
		end

	list_width: INTEGER
			-- Width of list in pixels.
			-- If -1, automatically computed to make whole content visible.
		require
			is_list_width_set: is_list_width_set
		attribute
		end

	list_height: INTEGER
			-- Height of list in pixels.
			-- If -1, automatically computed to take as much vertical space as needed.
		require
			is_list_height_set: is_list_height_set
		attribute
		end

	save_list_position_action: detachable PROCEDURE [TUPLE [x_position, y_position, width, height: INTEGER]]
			-- Action to save suggestion list position.

	query_cancel_request: detachable PREDICATE
			-- Action that is called after obtaining a result from the suggestion provider
			-- to find out if we should continue getting some more results or if we should stop.
			--| By default we get all the results unless overridden by user.

	matcher: SUGGESTION_MATCHER
			-- Object used to match an entry in the list of possibilities.
			-- The default one will only perform a substring match.
		do
			if attached internal_matcher as l_matcher then
				Result := l_matcher
			else
				Result := default_matcher
			end
		end

	searched_text_agent: detachable FUNCTION [TUPLE [displayed_text: STRING_32], STRING_32]
			-- Given a `displayed_text' return a string representing what we should be searching for.
			--| For example, if you have the following partial phone number displayed "(555) 253-4"
			--| then the searched text could be "5552534".

feature -- Character handling

	suggestion_activator_characters: detachable HASH_TABLE [BOOLEAN, CHARACTER_32]
			-- List of characters that can be used to trigger suggestion.

	suggestion_deactivator_characters: HASH_TABLE [CHARACTER_32, CHARACTER_32]
			-- List of characters that can be used to stop suggestion.
			-- By default, only Enter and Escape are set.

	override_shortcut_trigger: detachable FUNCTION [TUPLE [key: EV_KEY; ctrl, alt, shift: BOOLEAN], BOOLEAN]
			-- User controlled definition that can activate suggestion?

	character_translator: detachable FUNCTION [CHARACTER_32, CHARACTER_32]
			-- Given a character entered by users while performing completion, returns
			-- the character really wanted by the underlying tools. This is useful for
			-- example if you only want upper case to be printed for example.
			-- If `%U' is returned, then the character is not processed.

feature -- Status report

	is_list_recomputed_when_typing: BOOLEAN
			-- Once the suggestion list is shown, should successive typing
			-- restart a query or should it simply select the closest match?

	is_list_filtered_when_typing: BOOLEAN
			-- Should items not matching the entered text be hidden to shrink
			-- the list of possible choices to just what matters?

	is_single_match_completed: BOOLEAN
			-- If query only returns one match, should we auto suggest
			-- the entry without popping the suggestion window?

	is_list_x_position_set: BOOLEAN
			-- Is `list_x_position_set' set by user?

	is_list_y_position_set: BOOLEAN
			-- Is `list_y_position_set' set by user?

	is_list_width_set: BOOLEAN
			-- Is `list_width' set by user?
		do
			Result := list_width /= -1
		end

	is_list_height_set: BOOLEAN
			-- Is `list_height' set by user?
		do
			Result := list_height /= -1
		end

	is_mouse_wheel_in_full_page_mode: BOOLEAN
			-- Should we scroll by page rather by a fixed amount of rows?

	is_initial_position_at_caret: BOOLEAN
			-- Should the list be shown relative to the current caret position?

	has_arrows_key_text_navigation: BOOLEAN
			-- When the list is shown, should the left and right arrow key move the caret
			-- position left and right?

	is_fit_list_window_to_content: BOOLEAN
			-- Is the suggestion list resized automatically to fit the content, i.e. it will grow
			-- or shrink depending on the items being displayed.

	is_suggesting_as_typing: BOOLEAN
			-- Any character is a suggestion activator character.
			-- Default: False

	is_suggestion_activator_character (ch: CHARACTER_32): BOOLEAN
			-- Is `ch` a suggestion activator character?
		do
			if attached suggestion_activator_characters as tb then
				Result := tb.has (ch)
			end
		end

	is_suggestion_activator_character_included (ch: CHARACTER_32): BOOLEAN
		require
			is_suggestion_activator_character (ch)
		do
			if attached suggestion_activator_characters as tb then
				Result := tb.item (ch)
			end
		end

	is_suggestion_deactivator_character (ch: CHARACTER_32): BOOLEAN
		do
			if attached suggestion_deactivator_characters as tb then
				Result := tb.has (ch)
			end
		end

feature -- Conversion

	update_row (a_row: EV_GRID_ROW; a_suggestion: SUGGESTION_ITEM)
			-- Convert `a_suggestion' to a graphical representation in `a_row'.
			-- If `update_row_agent' is not set, default implementation create
			-- an EV_GRID_LABEL_ITEM with the `a_suggestion.displayed_text' as textual
			-- representation in the first column of `a_row'.
		do
			if attached update_row_agent as l_agent then
				l_agent.call ([a_row, a_suggestion])
			else
				a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (a_suggestion.displayed_text))
			end
		end

feature -- Settings

	set_mode (a_mode: like mode)
			-- Assign `a_mode' to `mode'.
		require
			valid_mode: is_valid_mode (a_mode)
		do
			mode := a_mode
		ensure
			mode_set: mode = a_mode
		end

	enable_recomputation_when_typing
			-- Allows suggestive typing to reissue a query to the suggestion provider instead
			-- of filtering based on the existing results.
		do
			is_list_recomputed_when_typing := True
		ensure
			is_list_recomputed_when_typing_set: is_list_recomputed_when_typing
		end

	disable_recomputation_when_typing
			-- Disallows suggestive typing to reissue a query to the suggestion provider. It will
			-- instead filter on the existing results.
		do
			is_list_recomputed_when_typing := False
		ensure
			is_list_recomputed_when_typing_set: not is_list_recomputed_when_typing
		end

	set_is_single_match_completed (v: like is_single_match_completed)
			-- Assign `v' to `is_single_match_completed'.
		do
			is_single_match_completed := v
		ensure
			is_single_match_completed_set: is_single_match_completed = v
		end

	set_is_list_filtered_when_typing (v: like is_list_filtered_when_typing)
			-- Assign `v' to `is_list_filtered_when_typing'.
		do
			is_list_filtered_when_typing := v
		ensure
			is_list_filtered_when_typing_set: is_list_filtered_when_typing = v
		end

	set_is_mouse_wheel_in_full_page_mode (v: like is_mouse_wheel_in_full_page_mode)
			-- Assign `v' to is_mouse_wheel_in_full_page_mode'.
		do
			is_mouse_wheel_in_full_page_mode := v
		ensure
			is_mouse_wheel_in_full_page_mode_set: is_mouse_wheel_in_full_page_mode = v
		end

	set_is_initial_position_at_caret (v: like is_initial_position_at_caret)
			-- Assign `v' to `is_initial_position_at_caret'.
		do
			is_initial_position_at_caret := v
		ensure
			is_initial_position_at_caret_set: is_initial_position_at_caret = v
		end

	set_has_arrows_key_text_navigation (v: like has_arrows_key_text_navigation)
			-- Assign `v' to `has_arrows_key_text_navigation'.
		do
			has_arrows_key_text_navigation := v
		ensure
			has_arrows_key_text_navigation_set: has_arrows_key_text_navigation = v
		end

	set_mouse_wheel_scroll_size (v: like mouse_wheel_scroll_size)
			-- Assign `v' to `mouse_wheel_scroll_size'.
		require
			v_positive: v > 0
		do
			mouse_wheel_scroll_size	:= v
		ensure
			mouse_wheel_scroll_size_set: mouse_wheel_scroll_size = v
		end

	set_scrolling_common_line_count (v: like scrolling_common_line_count)
			-- Assign `v' to `scrolling_common_line_count'.
		do
			scrolling_common_line_count := v
		ensure
			scrolling_common_line_count_set: scrolling_common_line_count = v
		end

	set_list_x_position (a_x: like list_x_position)
			-- Assign `a_x' to `list_x_position'.
		do
			list_x_position := a_x
			is_list_x_position_set := True
		ensure
			is_list_x_position_set: is_list_x_position_set
			list_x_position_set: list_x_position = a_x
		end

	set_list_y_position (a_y: like list_y_position)
			-- Assign `a_y' to `list_y_position'.
		do
			list_y_position := a_y
			is_list_y_position_set := True
		ensure
			is_list_y_position_set: is_list_y_position_set
			list_y_position_set: list_y_position = a_y
		end

	set_list_width (a_width: like list_width)
			-- Assign `a_width' to `list_width'.
		require
			width_positive: a_width > 0
		do
			list_width := a_width
		ensure
			is_list_width_set: is_list_width_set
			list_width_set: list_width = a_width
		end

	set_list_height (a_height: like list_height)
			-- Assign `a_height' to `list_height'.
		require
			height_positive: a_height > 0
		do
			list_height := a_height
		ensure
			is_list_height_set: is_list_height_set
			list_height_set: list_height = a_height
		end

	set_timeout (a_timeout: like timeout)
			-- Assign `a_timeout' to `timeout'.
		do
			timeout := a_timeout
		ensure
			suggestion_timeout_set: timeout = a_timeout
		end

	set_update_row_agent (a_conversion: like update_row_agent)
			-- Override the default implementation of `to_displayed_item' to use
			-- an agent to convert a {SUGGESTION_ITEM} instance to its corresponding
			-- graphical instance {EV_GRID_ITEM}.
		do
			update_row_agent := a_conversion
		ensure
			conversion_set: update_row_agent = a_conversion
		end

	set_save_list_position_action (a_action: like save_list_position_action)
			-- Set `save_list_position_action' with `a_action'.
		do
			save_list_position_action := a_action
		ensure
			save_list_position_action_set: save_list_position_action = a_action
		end

	set_query_cancel_request (a_action: like query_cancel_request)
			-- Set `query_cancel_request' with `a_action'.
		do
			query_cancel_request := a_action
		ensure
			query_cancel_request_set: query_cancel_request = a_action
		end

	set_matcher (v: like matcher)
			-- Set `matcher' with `v'.
		do
			internal_matcher := v
		ensure
			matcher_set: matcher = v
		end

	set_searched_text_agent (v: like searched_text_agent)
			-- Set `searched_text_agent' with `v'.
		do
			searched_text_agent := v
		ensure
			searched_text_agent_set: searched_text_agent = v
		end

	set_is_fit_list_window_to_content (v: like is_fit_list_window_to_content)
			-- Set `is_fit_list_window_to_content' with `v'.
		do
			is_fit_list_window_to_content := v
		ensure
			is_fit_list_window_to_content_set: is_fit_list_window_to_content = v
		end

	set_is_suggesting_as_typing (v: like is_suggesting_as_typing)
		do
			is_suggesting_as_typing := v
		ensure
			is_suggesting_as_typing_set: is_suggesting_as_typing = v
		end

feature -- Settings: Character handling

	set_suggestion_activator_characters (a_chars: like suggestion_activator_characters)
			-- Set `suggestion_activator_characters' with `a_chars'.
		do
			suggestion_activator_characters := a_chars
		ensure
			suggestion_activator_characters_set: suggestion_activator_characters = a_chars
		end

	register_suggestion_activator_character (ch: CHARACTER_32; a_included: BOOLEAN)
			-- Register `ch` as a character activating the suggestion.
			-- If `a_included` is False, keep the character in the suggested text,
			-- otherwise remove it.
		local
			tb: like suggestion_activator_characters
		do
			tb := suggestion_activator_characters
			if tb = Void then
				create tb.make (1)
				suggestion_activator_characters := tb
			end
			tb.force (a_included, ch)
		end

	unregister_suggestion_activator_character (ch: CHARACTER_32)
			-- Un-register `ch` as a character activating the suggestion.
		local
			tb: like suggestion_activator_characters
		do
			tb := suggestion_activator_characters
			if tb /= Void then
				tb.remove (ch)
			end
		end

	set_suggestion_deactivator_characters (a_chars: like suggestion_deactivator_characters)
			-- Set `suggestion_deactivator_characters' with `a_chars'.
		do
			suggestion_deactivator_characters := a_chars
		ensure
			suggestion_deactivator_characters_set: suggestion_deactivator_characters = a_chars
		end

	register_suggestion_deactivator_character (ch: CHARACTER_32)
		local
			tb: like suggestion_deactivator_characters
		do
			tb := suggestion_deactivator_characters
			if tb = Void then
				create tb.make (1)
				suggestion_deactivator_characters := tb
			end
			tb.force (ch, ch)
		end

	set_override_shortcut_trigger (a_trigger: like override_shortcut_trigger)
			-- Set `override_shortcut_trigger' with `a_trigger'.
		do
			override_shortcut_trigger := a_trigger
		ensure
			override_shortcut_trigger_set: override_shortcut_trigger = a_trigger
		end

	set_character_translator (a_translator: like character_translator)
			-- Set `character_translator' with `a_translator'.
		do
			character_translator := a_translator
		ensure
			character_translator_set: character_translator = a_translator
		end

feature {NONE} -- Implementation

	internal_matcher: detachable like matcher
			-- Internal storage for `matcher'.

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
