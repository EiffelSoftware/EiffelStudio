note
	description: "Text field that can conduct auto-completion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CODE_COMPLETABLE_TEXT_FIELD

inherit
	EB_TAB_CODE_COMPLETABLE
		export
			{ANY}
				set_completion_possibilities_provider,
				set_can_complete
		undefine
			default_create,
			copy
		redefine
			calculate_completion_list_width,
			can_complete,
			is_focus_back_needed
		end

	EV_TEXT_FIELD
		redefine
			initialize,
			set_focus
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	CURSOR_COMPLETABLE_POSITIONING
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
			initialize_code_complete
			key_completable := agent can_complete
			set_discard_feature_signature (true)

				-- Add handler to trap completion
			set_default_key_processing_handler (agent on_default_key_processing)
		end

feature -- Status setting

	set_focus
			-- <Precursor>
		local
			l_caret_pos: INTEGER
		do
			if {PLATFORM}.is_unix then
				l_caret_pos := caret_position
			end
			Precursor
				-- This is a hack, because gtk automatically select all text
				-- and forget the caret position when getting focus.
			if {PLATFORM}.is_unix then
				if has_selection then
					disable_selection
					set_caret_position (l_caret_pos)
				end
			end
		end

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Access

	current_token_in_line (a_line: EDITOR_LINE): EDITOR_TOKEN
			-- Token to the right of the cursor in `a_line'
		do
			Result := token_at_position (caret_position, a_line)
		end

	token_at_position (a_pos: INTEGER; a_line: EDITOR_LINE): EDITOR_TOKEN
			-- Token at `a_pos' in `a_line'
		require
			a_pos_valid: a_pos >= 1 and a_pos <= text_length + 1
			a_line_attached: a_line /= Void
			a_line_valid: a_line.wide_image.count = text_length
		local
			token_length, cursor_pos, token_start_pos: INTEGER
			end_loop: BOOLEAN
		do
			cursor_pos := a_pos
			from
				a_line.start
				token_start_pos := 1
			until
				a_line.after or end_loop
			loop
				token_length := a_line.item.length
				if cursor_pos - token_start_pos < token_length then
					end_loop := true
					Result := a_line.item
				else
					token_start_pos := token_start_pos + token_length
				end
				a_line.forth
			end
		ensure
			token_at_position_not_void: Result /= Void
		end

	position_in_token: INTEGER
			-- Cursor position in token.
		local
			l_line: EDITOR_LINE
			end_loop: BOOLEAN
			l_offset, token_length, cursor_pos, token_start_pos: INTEGER
		do
			l_line := line_from_lexer
			cursor_pos := caret_position
			from
				l_line.start
				token_start_pos := 1
			until
				l_line.after or end_loop
			loop
				l_offset := cursor_pos - token_start_pos
				token_length := l_line.item.length
				if l_offset < token_length then
					Result := l_offset + 1
					end_loop := true
				else
					token_start_pos := token_start_pos + token_length
				end
				l_line.forth
			end
		end

	token_position (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): INTEGER
			-- Token start position.
			-- a_token should in a_line. Or 0 is returned.
		require
			a_token_attached: a_token /= Void
			l_line_attached: a_line /= Void
		local
			token_length, cursor_pos, token_start_pos: INTEGER
			end_loop: BOOLEAN
		do
			cursor_pos := caret_position
			from
				a_line.start
				token_start_pos := 1
			until
				a_line.after or end_loop
			loop
				token_length := a_line.item.length
				if a_token = a_line.item then
					end_loop := true
					Result := token_start_pos
				else
					token_start_pos := token_start_pos + token_length
				end
				a_line.forth
			end
		end

	current_char: CHARACTER_32
			-- Current character, to the right of the cursor.
		do
			if text_length > 0 and then caret_position <= text_length then
				Result := text.item (caret_position)
			else
				Result := '%N'
			end
		end

	current_line: EDITOR_LINE
			-- Current line.
		do
			Result := line_from_lexer
		end

	selection_start_token_in_line (a_line: EDITOR_LINE): EDITOR_TOKEN
			-- Start token in the selection.
		do
			Result := token_at_position (start_selection, a_line)
		end

	selection_end_token_in_line (a_line: EDITOR_LINE) : EDITOR_TOKEN
			-- Token after end of selection.
		do
			Result := token_at_position (end_selection, a_line)
		end

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Status report

	completing_word: BOOLEAN = true
			-- Has user requested to complete a word.

	end_of_line: BOOLEAN
			-- Is current cursor at the end of line?
		do
			if text_length = 0 or else caret_position = text_length + 1 then
				Result := true
			end
		end

	allow_tab_selecting: BOOLEAN = false

	is_focus_back_needed: BOOLEAN
			-- Should focus be set back after code completion?
		do
			Result := not is_destroyed
		end

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Text operation

	handle_character (a_char: CHARACTER_32)
			-- Handle `a_char'
		do
			insert_char (a_char)
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

feature {NONE} -- Action handlers

	on_default_key_processing (a_key: EV_KEY): BOOLEAN
			-- Process default key handling so any displayable character can be ignored.
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
			l_alt, l_ctrl, l_shift: BOOLEAN
		do
			Result := True

			l_alt := alt_key
			l_ctrl := ctrled_key
			l_shift := shifted_key

			if can_complete (a_key, l_ctrl, l_alt, l_shift) then
					-- Ignore any keys for completion shortcuts

					-- Check feature completion
				l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
				check l_shortcut_pref /= Void end
				Result := not (
					l_shortcut_pref /= Void and then
					a_key.code = l_shortcut_pref.key.code and
					l_ctrl = l_shortcut_pref.is_ctrl and
					l_alt = l_shortcut_pref.is_alt and
					l_shift = l_shortcut_pref.is_shift)

				if Result then
						-- Check class completion
					l_shortcut_pref := preferences.editor_data.shortcuts.item ("class_autocomplete")
					Result := not (
						l_shortcut_pref /= Void and then
						a_key.code = l_shortcut_pref.key.code and
						l_ctrl = l_shortcut_pref.is_ctrl and
						l_alt = l_shortcut_pref.is_alt and
						l_shift = l_shortcut_pref.is_shift)
				end
			end
		end

feature {EB_CODE_COMPLETION_WINDOW} -- Interact with code completion window.

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

	calculate_completion_list_width: INTEGER
			-- Determine the width the completion list should have			
		do
			if preferences.development_window_data.remember_completion_list_size then
				Result := preferences.development_window_data.completion_list_width
			else
					-- Calculate correct size to fit
				Result := Precursor {EB_TAB_CODE_COMPLETABLE}
			end
			Result := Result.max (width)
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

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Cursor operation and selection

	save_cursor
			-- Save cursor position for retrieving.
		do
			if saved_cursor_positions = Void then
			 	create saved_cursor_positions.make
			end
			saved_cursor_positions.put_front (caret_position)
		end

	retrieve_cursor
			-- Retrieve cursor position from saving.
		do
			if saved_cursor_positions /= Void and then not saved_cursor_positions.is_empty then
				saved_cursor_positions.go_i_th (1)
				set_caret_position (saved_cursor_positions.item)
				saved_cursor_positions.remove
			end
		end

	select_region_between_token (a_start_token: EDITOR_TOKEN; a_start_line: EDITOR_LINE; a_end_token: EDITOR_TOKEN; a_end_line: EDITOR_LINE)
			-- Select from the start position of `a_start_token' to the start position of `a_end_token'.
		local
			l_line: EDITOR_LINE
			l_start_pos, l_end_pos: INTEGER
		do
			l_line := a_start_line -- Only one line.
			l_start_pos := token_position (a_start_token, a_start_line)
			l_end_pos := token_position (a_end_token, a_end_line)
			if l_start_pos >= 1 and l_start_pos <= text_length and l_end_pos - 1 <= text_length and l_end_pos - 1 >= 1 then
				if l_start_pos = l_end_pos then
					set_caret_position (l_start_pos)
				else
					select_region (l_start_pos, l_end_pos - 1)
				end
			end
		end

	show_possible_selection
			-- Show possible selection
		do
		end

	disable_selection
			-- Disable selection
		do
			deselect_all
		end

	go_to_start_of_selection
			-- Move cursor to the start of the selection.
		do
			set_caret_position (start_selection)
		end

	go_to_end_of_selection
			-- Move cursor to the end of the selection.
		do
			set_caret_position (end_selection)
		end

	go_to_start_of_line
			-- Move cursor to the start of a line
			-- where tab switching to next feature argument should function.
		do
			set_caret_position (1)
		end

	go_to_end_of_line
			-- Move cursor to the start of a line.
		do
			if text_length > 0 then
				set_caret_position (text_length + 1)
			end
		end

	go_right_char
			-- Go to right character.
		do
			if text_length > 0 and then caret_position <= text_length then
				set_caret_position (caret_position + 1)
			end
		end

	go_left_char
			-- Go to right character.
		do
			if text_length > 0 and then caret_position >= 1 then
				set_caret_position (caret_position - 1)
			end
		end

	move_cursor_to (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE)
			-- Move cursor to `a_token' which is in `a_line'.
		do
			set_caret_position (token_position (a_token, a_line))
		end

	saved_cursor_positions: LINKED_LIST [INTEGER]

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Basic operations

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
			insert_text (create {STRING_32}.make_filled (a_char, 1))
		end

feature {NONE} -- History

	history_bind_to_next_item
			-- Do noting.
		do
		end

feature {NONE} -- Implementation

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN
			-- `a_key' can activate text completion?
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
					Result := completing_feature
					if Result then
						Result := possibilities_provider /= Void and then possibilities_provider.completing_context
					end
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("class_autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := not completing_feature
				end

				precompletion_actions.wipe_out
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

feature {NONE} -- Implementation

	auto_complete_after_dot: BOOLEAN
	        -- Should build autocomplete dialog after call on valid target?
	  	do
	  	   	Result := preferences.editor_data.auto_auto_complete
	  	end

feature {NONE} -- Lexer

	scanner: EDITOR_EIFFEL_SCANNER
			--
		once
			create Result.make
		end

	line_from_lexer: EDITOR_LINE
			-- Editor line from lexer.
		do
			if not is_destroyed then
				if text.is_empty then
					create Result.make_unix_style
				else
					scanner.execute (text)
						-- We use Unix style because it is not relevant to source code.
					create Result.make_from_lexer_and_style (scanner, False)
				end
			else
				create Result.make_unix_style
			end
		end

invariant
	invariant_clause: True -- Your invariant here

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
