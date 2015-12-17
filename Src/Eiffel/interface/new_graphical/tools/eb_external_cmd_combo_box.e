note
	description: "[
					Completable text field
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_CMD_COMBO_BOX

inherit
	EV_COMBO_BOX
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
			can_complete,
			is_focus_back_needed
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create,
			is_equal,
			copy
		end

	SHARED_WORKBENCH
		undefine
			default_create,
			is_equal,
			copy
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

	possibilities_provider: EB_EXTERNAL_CMD_COMPLETION_PROVIDER
			-- Possibilities provider

	can_complete_agent: FUNCTION [TUPLE [a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN], BOOLEAN]
			-- Agent to decide if completion can start

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

feature -- Status report

	completing_word: BOOLEAN = true
			-- Has user requested to complete a word.

	is_key_matched_with_shortcut (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN; a_shortcut: SHORTCUT_PREFERENCE): BOOLEAN
			-- Does key combination `a_key', `a_ctrl', `a_alt' and `a_shift' match `a_shortcut'?
		require
			a_key_attached: a_key /= Void
			a_shortcut_attached: a_shortcut /= Void
		do
			Result :=
				a_key.code = a_shortcut.key.code and then
				a_ctrl = a_shortcut.is_ctrl and then
				a_alt = a_shortcut.is_alt and then
				a_shift = a_shortcut.is_shift
		end

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN
			-- `a_key' can activate text completion?
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
		do
			if a_key /= Void then
				if can_complete_agent /= Void then
					Result := can_complete_agent.item ([a_key, a_ctrl, a_alt, a_shift])
				end
				if not Result then
					l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
					check l_shortcut_pref /= Void end
					Result := is_key_matched_with_shortcut (a_key, a_ctrl, a_alt, a_shift, l_shortcut_pref)
					if not Result then
						l_shortcut_pref := preferences.editor_data.shortcuts.item ("class_autocomplete")
						check l_shortcut_pref /= Void end
						Result := is_key_matched_with_shortcut (a_key, a_ctrl, a_alt, a_shift, l_shortcut_pref)
					end
					if Result then
							-- We remove the 'key' character on windows platform.
							-- On linux the key has not been inserted.
							-- Fix needed.
						precompletion_actions.wipe_out
						precompletion_actions.extend_kamikaze (agent remove_keyed_character (a_key))
					end
				end
			end
		end

	is_focus_back_needed: BOOLEAN
			-- Should focus be set back after code completion?
		do
			Result := not is_destroyed
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
			if not universe.platform_constants.is_unix then
				if caret_position > 1 then
					if is_same_key (a_key, text.item (caret_position - 1)) then
						back_delete_char
					end
				end
			end
		end

	is_same_key (a_key: EV_KEY; a_char_code: CHARACTER_32): BOOLEAN
			-- Is `a_key' a `a_char_code' character?
		require
			a_key_not_void: a_key /= Void
		local
			l_string: STRING_32
			l_keys: EV_KEY_CONSTANTS
		do
			create l_keys
			l_string := l_keys.key_strings.item (a_key.code)
			if l_string /= Void then
				if l_string.count = 1 then
					if l_string.item (1) = a_char_code and then a_char_code /= '.' then
						Result := True
					end
				elseif l_string.same_string ({STRING_32} "Space") then
					Result := True
				elseif a_key.is_numpad then
					if l_string.item (l_string.count) = a_char_code then
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
			Result := preferences.development_window_data.remember_completion_list_size
		end

	preferred_height: INTEGER
			-- Preferred height
		do
			Result := preferences.development_window_data.completion_list_height
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
			Result := preferences.metric_tool_data.criterion_completion_list_width
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
