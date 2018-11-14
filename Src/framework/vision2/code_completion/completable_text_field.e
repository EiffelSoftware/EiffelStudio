note
	description: "Completable text field."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETABLE_TEXT_FIELD

inherit
	EV_TEXT_FIELD
		redefine
			initialize
		end

	CODE_COMPLETABLE
		undefine
			default_create,
			is_equal,
			copy
		redefine
			calculate_completion_list_width,
			possibilities_provider,
			is_focus_back_needed,
			is_char_activator_character
		end

	CURSOR_COMPLETABLE_POSITIONING
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make_with_text

feature{NONE} -- Initialization

	initialize
			-- Initialize current.
		do
			Precursor
			initialize_code_complete
		end

feature -- Access

	possibilities_provider: detachable COMPLETION_POSSIBILITIES_PROVIDER
			-- Possibilities provider

	can_complete_agent: detachable FUNCTION [CHARACTER_32, BOOLEAN]
			-- Agent to decide if completion can start

	preferred_width_agent: detachable FUNCTION [INTEGER]
			-- Preferred width

	preferred_height_agent: detachable FUNCTION [INTEGER]
			-- Preferred height

feature -- Setting

	set_can_complete_agent (a_agent: like can_complete_agent)
			-- Set `can_complete_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			can_complete_agent := a_agent
		ensure
			can_complete_agent_set: can_complete_agent = a_agent
		end

	set_preferred_width_agent (a_agent_width: like preferred_width_agent)
			-- Set `preferred_width_agent' and  with `a_agent'.
		do
			preferred_width_agent := a_agent_width
		ensure
			preferred_width_agent_set: preferred_width_agent = a_agent_width
		end

	set_preferred_height_agent (a_agent_height: like preferred_height_agent)
			-- Set `preferred_height_agent' and  with `a_agent'.
		do
			preferred_height_agent := a_agent_height
		ensure
			preferred_height_agent_set: preferred_height_agent = a_agent_height
		end

feature -- Status report

	completing_word: BOOLEAN = True
			-- Has user requested to complete a word.

	is_focus_back_needed: BOOLEAN
			-- Should focus be set back after code completion?
		do
			Result := not is_destroyed
		end

	is_char_activator_character (a_char: CHARACTER_32): BOOLEAN
			-- <precursor>
		do
			Result := True
			if attached can_complete_agent as l_agent then
				Result := l_agent.item ([a_char, ev_application.ctrl_pressed, ev_application.alt_pressed, ev_application.shift_pressed])
			end
		end

feature{NONE} -- Implementation

	place_post_cursor
			-- Place cursor after completion
		do
		end

	back_delete_char
			-- Back delete character.
		do
			if text_length > 0 and caret_position > 1 then
				select_region (caret_position - 1, caret_position - 1)
				delete_selection
			end
		end

	delete_char
			-- Delete character.
		do
			if text_length > 0 and caret_position <= text_length then
				select_region (caret_position, caret_position)
				delete_selection
			end
		end

	insert_string (a_str: STRING_32)
			-- Insert `a_str' at cursor position.
		do
			insert_text (a_str)
			set_caret_position (caret_position + a_str.count)
		end

	insert_char (a_char: CHARACTER_32)
			-- Insert `a_char' at cursor position.
		do
			insert_text (create {STRING_32}.make_filled (a_char, 1))
			set_caret_position (caret_position + 1)
		end

	replace_char (a_char: CHARACTER_32)
			-- Replace current char with `a_char'.
		do
			delete_char
			insert_text (a_char.out)
		end

	block_focus_in_actions
			-- Block focus in actions
		do
			focus_in_actions.block
		end

	resume_focus_in_actions
			-- Resume focus in actions
		do
			focus_in_actions.resume
		end

	block_focus_out_actions
			-- Block focus out actions.
		do
			focus_out_actions.block
		end

	resume_focus_out_actions
			-- Resume focus out actions.
		do
			focus_out_actions.resume
		end

	handle_character (a_char: CHARACTER_32)
			-- Handle `a_char'
		do
			if not unwanted_characters.item (a_char.code) then
				insert_char (a_char)
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY)
 			-- Process the push on Ctrl + an extended key.
 		do
 		end

	handle_extended_key (ev_key: EV_KEY)
 			-- Process the push on an extended key.
 		do
			if ev_key.code = 40 then -- Backspace
				back_delete_char
			elseif ev_key.code = 67 then -- Delete
				delete_char
			end
 		end

	remove_keyed_character (a_key: EV_KEY)
			-- We remove the 'key' character on windows platform.
			-- On linux the key has not been inserted.
			-- Fix needed.
		require
			a_key_not_void: a_key /= Void
		do
			if
				not {PLATFORM}.is_unix and then
				caret_position > 1 and then
				is_same_key (a_key, text.code (caret_position - 1))
			then
				back_delete_char
			end
		end

	is_same_key (a_key: EV_KEY; a_char_code: NATURAL_32): BOOLEAN
			-- Is `a_key' a `a_char_code' character?
		require
			a_key_not_void: a_key /= Void
		do
			if attached (create {EV_KEY_CONSTANTS}).key_strings.item (a_key.code) as l_string then
				if l_string.count = 1 then
					if l_string.code (1) = a_char_code and then a_char_code /= ('.').natural_32_code then
						Result := True
					end
				elseif l_string.is_equal ("Space") then
					Result := True
				elseif a_key.is_numpad then
					if l_string.code (l_string.count) = a_char_code then
						Result := True
					end
				end
			end
		end

feature{NONE} -- Position calculation

	cursor_screen_x: INTEGER
			-- Cursor screen x position
		do
			Result := screen_x
		end

	cursor_screen_y: INTEGER
			-- Cursor screen y position
		do
			Result := screen_y
		end

	use_preferred_height: BOOLEAN
			-- User preferred height?
		do
			Result := attached preferred_height_agent
		end

	preferred_height: INTEGER
			-- Preferred height
		do
			if attached preferred_height_agent as l_agent then
				Result := l_agent.item (Void)
			end
		end

	working_area_height: INTEGER
			-- Height of the working area. Normally current screen.
		local
			l_screen: EV_RECTANGLE
		do
			l_screen := (create {EV_SCREEN}).monitor_area_from_position (cursor_screen_x, cursor_screen_y)
			Result := l_screen.height
		end

	line_height: INTEGER
			-- Line height
		do
			Result := height
		end

	calculate_completion_list_width: INTEGER
			-- Determine the width the completion list should have			
		do
			if attached preferred_width_agent as l_agent then
				Result := l_agent.item (Void)
			end
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
