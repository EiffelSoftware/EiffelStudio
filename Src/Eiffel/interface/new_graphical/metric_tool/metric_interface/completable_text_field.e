indexing
	description: "[
					Completable text field
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
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

create
	default_create,
	make_with_text

feature{NONE} -- Initialization

	initialize is
			-- Initialize current.
		do
			Precursor
			initialize_code_complete
		end

feature -- Access

	possibilities_provider: COMPLETION_POSSIBILITIES_PROVIDER
			-- Possibilities provider

	can_complete_agent: FUNCTION [ANY, TUPLE [a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN], BOOLEAN]
			-- Agent to decide if completion can start

feature -- Setting

	set_can_complete_agent (a_agent: like can_complete_agent) is
			-- Set `can_complete_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
		do
			can_complete_agent := a_agent
		ensure
			can_complete_agent_set: can_complete_agent = a_agent
		end

feature -- Status report

	completing_word: BOOLEAN is true
			-- Has user requested to complete a word.

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN is
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
					if
						a_key.code = l_shortcut_pref.key.code and
						a_ctrl = l_shortcut_pref.is_ctrl and
						a_alt = l_shortcut_pref.is_alt and
						a_shift = l_shortcut_pref.is_shift
					then
						Result := true
					else
						Result := False
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

	is_focus_back_needed: BOOLEAN is
			-- Should focus be set back after code completion?
		do
			if is_destroyed then
				Result := False
			else
				Result := True
			end
		end

feature{NONE} -- Implementation

	place_post_cursor is
			-- Place cursor after completion
		do
		end

	back_delete_char is
			-- Back delete character.
		do
			if text_length > 0 and caret_position > 1 then
				select_region (caret_position - 1, caret_position - 1)
				delete_selection
			end
		end

	delete_char is
			-- Delete character.
		do
			if text_length > 0 and caret_position <= text_length then
				select_region (caret_position, caret_position)
				delete_selection
			end
		end

	insert_string (a_str: STRING_32) is
			-- Insert `a_str' at cursor position.
		do
			insert_text (a_str)
			set_caret_position (caret_position + a_str.count)
		end

	insert_char (a_char: CHARACTER_32) is
			-- Insert `a_char' at cursor position.
		do
			insert_text (create {STRING_32}.make_filled (a_char, 1))
			set_caret_position (caret_position + 1)
		end

	replace_char (a_char: CHARACTER_32) is
			-- Replace current char with `a_char'.
		do
			delete_char
			insert_text (a_char.out)
		end

	block_focus_in_actions is
			-- Block focus in actions
		do
			focus_in_actions.block
		end

	resume_focus_in_actions is
			-- Resume focus in actions
		do
			focus_in_actions.resume
		end

	block_focus_out_actions is
			-- Block focus out actions.
		do
			focus_out_actions.block
		end

	resume_focus_out_actions is
			-- Resume focus out actions.
		do
			focus_out_actions.resume
		end

	handle_character (a_char: CHARACTER_32) is
			-- Handle `a_char'
		do
			if not unwanted_characters.item (a_char.code) then
				insert_char (a_char)
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
 		do
 		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
 		do
			if ev_key.code = 40 then -- Backspace
				back_delete_char
			elseif ev_key.code = 67 then -- Delete
				delete_char
			end
 		end

	remove_keyed_character (a_key: EV_KEY) is
			-- We remove the 'key' character on windows platform.
			-- On linux the key has not been inserted.
			-- Fix needed.
		require
			a_key_not_void: a_key /= Void
		do
			if not universe.platform_constants.is_unix then
				if caret_position > 1 then
					if is_same_key (a_key, text.item_code (caret_position - 1)) then
						back_delete_char
					end
				end
			end
		end

	is_same_key (a_key: EV_KEY; a_char_code: INTEGER): BOOLEAN is
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
					if l_string.item_code (1) = a_char_code and then a_char_code /= ('.').code then
						Result := True
					end
				elseif l_string.is_equal ("Space") then
					Result := True
				elseif a_key.is_numpad then
					if l_string.item_code (l_string.count) = a_char_code then
						Result := True
					end
				end
			end
		end

feature{NONE} -- Position calculation

	calculate_completion_list_x_position: INTEGER is
			-- Determine the x position to display the completion list
		local
			screen: EB_STUDIO_SCREEN
			right_space,
			list_width: INTEGER
			l_font: EV_FONT
			l_text_before_cursor: STRING_32
		do
			create screen

				-- Get current x position of cursor
			l_font := font
			l_text_before_cursor := text.substring (1, caret_position)
			Result := screen_x + l_font.string_width (l_text_before_cursor)

				-- Determine how much room there is free on the right of the screen from the cursor position
			right_space := screen.virtual_right - Result - completion_border_size

			list_width := calculate_completion_list_width

			if right_space < list_width then
					-- Shift x pos back so it fits on the screen
				Result := Result - (list_width - right_space)
			end
			Result := Result.max (0)
		end

	calculate_completion_list_y_position: INTEGER is
			-- Determine the y position to display the completion list
		local
			screen: EB_STUDIO_SCREEN
			preferred_height,
			upper_space,
			lower_space: INTEGER
			show_below: BOOLEAN
		do
				-- Get y pos of cursor
			create screen
			show_below := True
			Result := screen_y

			if Result < ((screen.virtual_height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := Result - completion_border_size
			lower_space := screen.virtual_bottom - Result - completion_border_size

			preferred_height := preferences.metric_tool_data.criterion_completion_list_height

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
			if show_below then
				Result := Result + height
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
			show_below: BOOLEAN
		do
				-- Get y pos of cursor
			create screen
			show_below := True
			y_pos := screen_y

			if y_pos < ((screen.virtual_height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := y_pos - completion_border_size
			lower_space := screen.virtual_bottom - y_pos - completion_border_size

			Result := preferences.metric_tool_data.criterion_completion_list_height

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
		end

	calculate_completion_list_width: INTEGER is
			-- Determine the width the completion list should have			
		do
			Result := preferences.metric_tool_data.criterion_completion_list_width
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
