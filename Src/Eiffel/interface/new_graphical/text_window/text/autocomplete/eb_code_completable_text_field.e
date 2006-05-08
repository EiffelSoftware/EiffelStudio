indexing
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
			can_complete
		end

	EV_TEXT_FIELD
		redefine
			make_with_text
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			default_create
			initialize_code_complete
			key_completable := agent can_complete
			set_discard_feature_signature (true)
		end

	make_with_text (a_text: STRING) is
			-- Initialization
		do
			Precursor {EV_TEXT_FIELD} (a_text)
			make
		end

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Access

	current_token_in_line (a_line: EDITOR_LINE): EDITOR_TOKEN is
			-- Token to the right of the cursor in `a_line'
		do
			Result := token_at_position (caret_position, a_line)
		end

	token_at_position (a_pos: INTEGER; a_line: EDITOR_LINE): EDITOR_TOKEN is
			-- Token at `a_pos' in `a_line'
		require
			a_pos_valid: a_pos >= 1 and a_pos <= text_length + 1
			a_line_attached: a_line /= Void
			a_line_valid: a_line.image.count = text_length
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

	position_in_token: INTEGER is
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
				if l_offset <= token_length then
					Result := l_offset
					end_loop := true
				else
					token_start_pos := token_start_pos + token_length
				end
				l_line.forth
			end
		end

	token_position (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): INTEGER is
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

	current_char: CHARACTER is
			-- Current character, to the right of the cursor.
		do
			if text_length > 0 and then caret_position <= text_length then
				Result := text.item (caret_position).to_character_8
			else
				Result := '%N'
			end
		end

	current_line: EDITOR_LINE is
			-- Current line.
		do
			Result := line_from_lexer
		end

	selection_start_token_in_line (a_line: EDITOR_LINE): EDITOR_TOKEN is
			-- Start token in the selection.
		do
			Result := token_at_position (selection_start, a_line)
		end

	selection_end_token_in_line (a_line: EDITOR_LINE) : EDITOR_TOKEN is
			-- Token after end of selection.
		do
			Result := token_at_position (selection_end, a_line)
		end

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Status report

	completing_word: BOOLEAN is true
			-- Has user requested to complete a word.

	end_of_line: BOOLEAN is
			-- Is current cursor at the end of line?
		do
			if text_length = 0 or else caret_position = text_length + 1 then
				Result := true
			end
		end

	allow_tab_selecting: BOOLEAN is false

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Text operation

	handle_character (a_char: CHARACTER) is
			-- Handle `a_char'
		do
			insert_char (a_char)
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

feature {EB_CODE_COMPLETION_WINDOW} -- Interact with code completion window.


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

	calculate_completion_list_x_position: INTEGER is
			-- Determine the x position to display the completion list
		local
			screen: EB_STUDIO_SCREEN
			right_space,
			list_width: INTEGER
			l_font: EV_FONT
			l_text_before_cursor: STRING
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

			if preferences.development_window_data.remember_completion_list_size then
				preferred_height := preferences.development_window_data.completion_list_height

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
			else
				if show_below then
					preferred_height := lower_space
				else
					preferred_height := upper_space
				end
			end

			if show_below then
				Result := Result + height
			else
				Result := Result - preferred_height - height
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

			if preferences.development_window_data.remember_completion_list_size then
				Result := preferences.development_window_data.completion_list_height

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
			else
				if show_below then
					Result := lower_space
				else
					Result := upper_space
				end
			end
		end

	calculate_completion_list_width: INTEGER is
			-- Determine the width the completion list should have			
		do
			if preferences.development_window_data.remember_completion_list_size then
				Result := preferences.development_window_data.completion_list_width
			else
					-- Calculate correct size to fit
				Result := choices.choice_list.column (1).required_width_of_item_span (1, choices.choice_list.row_count) + completion_border_size
			end
		end

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Cursor operation and selection

	save_cursor is
			-- Save cursor position for retrieving.
		do
			saved_cursor_position := caret_position
		end

	retrieve_cursor is
			-- Retrieve cursor position from saving.
		do
			set_caret_position (saved_cursor_position)
		end

	select_from_cursor_to_saved is
			-- Select from cursor position to saved cursor position
		local
			l_car, l_sav: INTEGER
		do
			l_car := caret_position.max (1).min (text_length)
			l_sav := saved_cursor_position.max (1).min (text_length)
			set_caret_position (l_sav)
			if l_car > l_sav then
				select_region (l_car - 1, l_sav)
			elseif l_car < l_sav then
				select_region (l_car, l_sav - 1)
			elseif l_car = l_sav then
				disable_selection
			end
		end

	select_region_between_token (a_start_token: EDITOR_TOKEN; a_start_line: EDITOR_LINE; a_end_token: EDITOR_TOKEN; a_end_line: EDITOR_LINE) is
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

	show_possible_selection is
			-- Show possible selection
		do
		end

	disable_selection is
			-- Disable selection
		do
			deselect_all
		end

	go_to_start_of_selection is
			-- Move cursor to the start of the selection.
		do
			set_caret_position (selection_start)
		end

	go_to_end_of_selection is
			-- Move cursor to the end of the selection.
		do
			set_caret_position (selection_end + 1)
		end

	go_to_start_of_line is
			-- Move cursor to the start of a line
			-- where tab switching to next feature argument should function.
		do
			set_caret_position (1)
		end

	go_to_end_of_line is
			-- Move cursor to the start of a line.
		do
			if text_length > 0 then
				set_caret_position (text_length + 1)
			end
		end

	go_right_char is
			-- Go to right character.
		do
			if text_length > 0 and then caret_position <= text_length then
				set_caret_position (caret_position + 1)
			end
		end

	move_cursor_to (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE)is
			-- Move cursor to `a_token' which is in `a_line'.
		do
			set_caret_position (token_position (a_token, a_line))
		end

	saved_cursor_position: INTEGER

feature {EB_COMPLETION_POSSIBILITIES_PROVIDER} -- Basic operations

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

	insert_string (a_str: STRING) is
			-- Insert `a_str' at cursor position.
		do
			insert_text (a_str)
			set_caret_position (caret_position + a_str.count)
		end

	insert_char (a_char: CHARACTER) is
			-- Insert `a_char' at cursor position.
		do
			insert_text (a_char.out)
			set_caret_position (caret_position + 1)
		end

	replace_char (a_char: CHARACTER) is
			-- Replace current char with `a_char'.
		do
			delete_char
			insert_text (a_char.out)
		end

feature {NONE} -- History

	history_bind_to_next_item is
			-- Do noting.
		do
		end

feature {NONE} -- Implementation

	can_complete (a_key: EV_KEY; a_ctrl: BOOLEAN; a_alt: BOOLEAN; a_shift: BOOLEAN): BOOLEAN is
			-- `a_key' can activate text completion?
		local
			l_shortcut_pref: SHORTCUT_PREFERENCE
		do
			if a_key /= Void then
				if
					auto_complete_after_dot and then
					a_key.code = {EV_KEY_CONSTANTS}.key_period and
					not a_ctrl and
					not a_alt and
					not a_shift
				then
					Result := true
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := true
				end

				l_shortcut_pref := preferences.editor_data.shortcuts.item ("class_autocomplete")
				check l_shortcut_pref /= Void end
				if
					a_key.code = l_shortcut_pref.key.code and
					a_ctrl = l_shortcut_pref.is_ctrl and
					a_alt = l_shortcut_pref.is_alt and
					a_shift = l_shortcut_pref.is_shift
				then
					Result := true
				end
			end
		end

feature {NONE} -- Implementation

	auto_complete_after_dot: BOOLEAN is
	        -- Should build autocomplete dialog after call on valid target?
	  	do
	  	   	Result := preferences.editor_data.auto_auto_complete
	  	end

feature {NONE} -- Lexer

	scanner: EDITOR_EIFFEL_SCANNER is
			--
		once
			create Result.make
		end

	line_from_lexer: EDITOR_LINE is
			-- Editor line from lexer.
		do
			scanner.execute (text)
			create Result.make_from_lexer (scanner)
		end

invariant
	invariant_clause: True -- Your invariant here

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
