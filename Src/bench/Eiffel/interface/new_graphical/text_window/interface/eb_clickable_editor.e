indexing
	description: "[
		Editor pick n drop.
		Uses a tool to make feature text clickable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLICKABLE_EDITOR

inherit
	EB_CUSTOM_WIDGETTED_EDITOR
		export
			{EB_COMPLETION_CHOICE_WINDOW} unwanted_characters
			{EB_ROUTINE_FLAT_FORMATTER} invalidate_line
		redefine
			make,
			reset, on_text_loaded,
			gain_focus,
			on_mouse_button_down,
			on_click_in_text, handle_extended_key,
			handle_extended_ctrled_key,
			text_displayed,
			copy_selection,
			recycle,
			margin,
			has_margin,
			cursor_type,
			line_type
		end

	EB_FORMATTED_TEXT
		export
			{NONE} All
		undefine
			clear_window, reset, default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make

feature {NONE}-- Initialization

	make (a_dev_window: EB_DEVELOPMENT_WINDOW) is
			-- Initialize the editor.
		do
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR} (a_dev_window)
			if dev_window /= Void then
				dev_window.add_editor_to_list (Current)
					-- Register the dev_window as an observer of `Current'
				text_displayed.add_selection_observer (dev_window)
			end
			create after_reading_text_actions.make

			editor_drawing_area.set_pebble_function (agent pebble_from_x_y)
			editor_drawing_area.enable_pebble_positioning
			editor_drawing_area.drop_actions.extend (agent resume_cursor_for_drop)
		end

feature -- Access

	text_length: INTEGER is
			-- Length of displayed text.
		do
			Result := text_displayed.text_length
		end

	position: INTEGER is
			-- Current cursor position.
		do
			if text_displayed.is_empty then
				Result := 0
			else
				Result := text_displayed.cursor.pos_in_text
			end
		end

	margin: EB_CLICKABLE_MARGIN
			-- Margin widget for breakpoints, line numbers, etc. This is different to the left margin
			-- used in the editor for spacing purposes.		

feature -- Content Change

	handle_before_processing (append: BOOLEAN) is
			-- Reinitialize editor if not `append' so that new content be received
			-- If `append' we only reset related flags.
			-- Only we treat `text_displayed' as TEXT_FORMATTER, we need to call this method.
		do
			editor_viewport.disable_sensitive

				-- Reset the editor state
			if not append then
				reset
			end
			allow_edition := False

				-- Read and parse the text.
			text_displayed.set_first_read_block_size (number_of_lines_in_block)
			text_displayed.start_processing (append)
		end

	handle_after_processing is
			-- Setup editor after processing.
			-- Editor interface is reinitialized, text observer methods are called.
			-- Only we treat `text_displayed' as TEXT_FORMATTER, we need to call this method.
		do
			text_displayed.end_processing
			if not editor_set then
				setup_editor (1)
				editor_set := true
			else
				update_vertical_scrollbar
				update_horizontal_scrollbar
				update_width
				set_editor_width (editor_width)
				update_horizontal_scrollbar
				refresh_now
				margin.setup_margin
			end
			editor_viewport.enable_sensitive
		end

feature -- Status report

	has_margin: BOOLEAN is
			-- Should margin be displayed?
		do
			Result := (line_numbers_enabled and line_numbers_visible) or not hidden_breakpoints
		end

feature -- Status setting

	enable_has_breakable_slots is
			-- Set `has_breakable_slots' to `True' and update display.
		do
			margin.show_breakpoints
			if margin_container.is_empty then
				margin_container.put (margin.widget)
			end
			margin.refresh_now
		end

	disable_has_breakable_slots is
			-- Set `has_breakable_slots' to `False' and update display.
		do
			margin.hide_breakpoints
			if not line_numbers_visible and then not margin_container.is_empty then
				margin_container.prune (margin.widget)
			end
			margin.refresh_now
		end

feature -- Possibly delayed operations

	display_line_when_ready (l_num: INTEGER; highlight: BOOLEAN) is
			-- same as select_region but scroll to the selected position
			-- (beginning of selection at then bottom of the editor) and
			-- does not need the text to be fully loaded			
		do
			if text_is_fully_loaded then
				if highlight then
					text_displayed.select_line (l_num)
				end
				display_line_with_context (l_num)
				refresh_now
			else
				after_reading_text_actions.extend(agent display_line_when_ready (l_num, highlight))
			end
		end

	display_line_at_top_when_ready (l_num: INTEGER) is
			-- same as select_region but scroll to the selected position
			-- (beginning of selection at then bottom of the editor) and
			-- does not need the text to be fully loaded
		local
			ln: INTEGER
		do
				if text_is_fully_loaded then
					ln := l_num.min (maximum_top_line_index)
					set_first_line_displayed (ln, True)
					refresh_now
				else
					after_reading_text_actions.extend(agent display_line_at_top_when_ready (l_num))
				end
		end

	highlight_when_ready (a, b: INTEGER) is
			-- same as select_lines but scroll to the selected position
			-- (beginning of selection at then bottom of the editor) and
			-- does not need the text to be fully loaded	
		local
			fld: INTEGER
			max_line: INTEGER
		do
			if text_is_fully_loaded then
				max_line := text_displayed.number_of_lines
				select_lines (a.min (max_line), b.min (max_line))
				if number_of_lines > number_of_lines_displayed then
					fld := text_displayed.selection_start.y_in_lines - number_of_lines_displayed + (number_of_lines_displayed // 2).min(2)
					fld := fld.max (1).min (maximum_top_line_index)
					set_first_line_displayed (fld, True)
				end
			else
				after_reading_text_actions.extend(agent highlight_when_ready (a, b))
			end
		end

	scroll_to_when_ready (pos: INTEGER) is
			-- scroll to position `pos' in characters
			-- does not need the text to be fully loaded
		local
			cursor: like cursor_type
		do
			if text_is_fully_loaded then
				cursor := text_displayed.cursor
				if cursor /= Void then
					if text_displayed.has_selection then
						text_displayed.disable_selection
					end
					cursor.make_from_integer (pos.min (text_displayed.text_length), text_displayed)
					if number_of_lines > number_of_lines_displayed then
						set_first_line_displayed (cursor.y_in_lines.min (maximum_top_line_index), True)
						check_position (cursor)
					end
				end
				refresh
			else
				after_reading_text_actions.extend(agent scroll_to_when_ready (pos))
			end
		end

	scroll_to_end_when_ready is
			-- scroll to position `pos' in characters
			-- does not need the text to be fully loaded			
		do
			if text_is_fully_loaded then
				if text_displayed.cursor /= Void then
					if text_displayed.has_selection then
						text_displayed.disable_selection
					end
					text_displayed.cursor.make_from_character_pos (1, number_of_lines, text_displayed)
					if number_of_lines > number_of_lines_displayed then
						check_cursor_position
					end
					refresh
				end
			else
				after_reading_text_actions.extend (agent scroll_to_end_when_ready)
			end
		end

	display_breakpoint_number_when_ready (bpn: INTEGER) is
			-- scroll to position `pos' in characters
			-- does not need the text to be fully loaded			
		do
			if text_is_fully_loaded then
				display_breakpoint_number (bpn)
			else
				after_reading_text_actions.extend(agent display_breakpoint_number (bpn))
			end
		end

feature -- Compatibility

	set_position (a_position: INTEGER) is
			-- Set cursor position to `a_position'.
		do
			text_displayed.set_position (a_position)
		end

	put_string (s: STRING) is
			-- Put string `s' at current position.
		do
			text_displayed.add_string (s)
		end

	put_char (c: CHARACTER) is
			-- Put a character `c' at current position.
		do
			text_displayed.add_char (c)
		end

	put_new_line is
			-- Put a new line at current position.
		do
			text_displayed.add_new_line
		end

	copy_selection is
			-- Copy current selection to clipboard.
		do
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR}
			if dev_window /= Void then
				dev_window.update_paste_cmd
			end
		end

feature {EB_FEATURE_INFO_FORMATTER} -- Feature click tool

	enable_feature_click is
			-- enable feature click tool		
		do
			text_displayed.enable_feature_click
		end

	disable_feature_click is
			-- disable feature click tool					
		do
			text_displayed.disable_feature_click
		end

	set_feature_for_click (feat: E_FEATURE) is
			-- initialize feature click tool with feature `feat'
		do
			text_displayed.set_feature_for_click (feat)
		end

	feature_click_enabled: BOOLEAN is
			-- do we use feature click tool?
		do
			Result := text_displayed.feature_click_enabled
		end

feature {EB_CLICKABLE_MARGIN}-- Process Vision2 Events

	on_mouse_button_down (abs_x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process single click on mouse buttons.
		do
			if pick_n_drop_status = pnd_pick then
				refresh_now
			end
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR} (abs_x_pos, y_pos, button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

	on_click_in_text (x_pos, y_pos, button: INTEGER; a_screen_x, a_screen_y: INTEGER) is
			-- Process click on the text. `x_pos' and `y_pos' are coordinates relative to the upper left
			-- left corner of the text, i.e. margin width and offset have already been added/substracted to them.
			-- `a_screen_x' and `a_screen_y' are the mouse pointer absolute coordinates on the screen.
		local
			l_number: INTEGER
			ln: like line_type
			stone: STONE
			bkstn: BREAKABLE_STONE
			cur: like cursor_type
		do
			if button = 1 then
				Precursor {EB_CUSTOM_WIDGETTED_EDITOR} (x_pos, y_pos, button, a_screen_x, a_screen_y)
				set_pick_and_drop_status (no_pnd)
			elseif button = 3 then
				mouse_right_button_down := True
				if x_pos <= 0 then
					l_number := ((y_pos - editor_viewport.y_offset) // line_height) + first_line_displayed
					if text_displayed.number_of_lines >= l_number then
						ln ?= text_displayed.line (l_number)
						bkstn ?= ln.real_first_token.pebble
					end
					create cur.make_from_character_pos (1, 1, text_displayed)
					position_cursor (cur, 1, y_pos - editor_viewport.y_offset)
				else
					create cur.make_from_character_pos (1, 1, text_displayed)
					position_cursor (cur, x_pos, y_pos - editor_viewport.y_offset)
					bkstn ?= cur.token.pebble
				end
				if bkstn = Void then
					if ctrled_key then
						stone := text_displayed.stone_at (cur)
						if stone /= Void and then stone.is_valid then
							(create {EB_CONTROL_PICK_HANDLER}).launch_stone (stone)
						end
					end
				else
					check
						cursor_not_void: text_displayed.cursor /= Void
					end
					text_displayed.cursor.make_from_character_pos (cur.x_in_characters, cur.y_in_lines, text_displayed)
					bkstn.display_bkpt_menu
					mouse_right_button_down := False
					mouse_left_button_down := False
					refresh_now
				end
			end
		end

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			l_shortcuts: like matching_customizable_commands
		do
			l_shortcuts := matching_customizable_commands (ev_key.code, False, alt_key, shifted_key)
				--| Fixme: When l_shortcuts is not empty, l_short_cuts.first can be void.
			if not l_shortcuts.is_empty and then l_shortcuts.first /= Void then
				l_shortcuts.first.apply
				check_cursor_position
			else
				Precursor {EB_CUSTOM_WIDGETTED_EDITOR} (ev_key)
			end
		end

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			l_shortcuts: like matching_customizable_commands
		do
			l_shortcuts := matching_customizable_commands (ev_key.code, True, alt_key, shifted_key)
				--| Fixme: When l_shortcuts is not empty, l_short_cuts.first can be void.
			if not l_shortcuts.is_empty and then l_shortcuts.first /= Void then
				l_shortcuts.first.apply
				check_cursor_position
			else
				Precursor {EB_CUSTOM_WIDGETTED_EDITOR} (ev_key)
			end
		end

feature {EB_CLICKABLE_MARGIN} -- Pick and drop

	pebble_from_x_y (x_pos_with_margin, abs_y_pos: INTEGER): STONE is
			-- Stone on (`x_pos', `y_pos').
		local
			cur			: like cursor_type
			l_number	: INTEGER
			x_pos,
			y_pos		: INTEGER
			token_pos	: INTEGER
			bkst		: BREAKABLE_STONE
			old_offset	: INTEGER
			l_line		: INTEGER
		do
			if not (ctrled_key or else mouse_copy_cut) then
				if not text_displayed.is_empty then
					x_pos := x_pos_with_margin - left_margin_width
					y_pos := abs_y_pos - editor_viewport.y_offset

						-- Compute the line number pointed by the mouse cursor
						-- and adjust it if its over the number of lines in the text.
					l_number := (y_pos // line_height) + first_line_displayed
					if
						l_number > 0 and then
						l_number <= number_of_lines and then
						x_pos >= -left_margin_width + offset and then
						x_pos < editor_viewport.width + offset
					then
						create cur.make_from_character_pos (1, 1, text_displayed)
						position_cursor (cur, x_pos, y_pos)
						Result := text_displayed.stone_at (cur)
						if Result /= Void and then Result.is_valid then
							bkst ?= Result
							if bkst = Void then
								l_number := cur.y_in_lines
								token_pos := cur.token.position
								if text_displayed.has_selection then
									text_displayed.disable_selection
									invalidate_block (text_displayed.selection_start.y_in_lines, text_displayed.selection_end.y_in_lines, True)
								else
									invalidate_line (text_displayed.cursor.y_in_lines, False)
								end
								l_line := text_displayed.current_line_number
								cur.set_current_char (cur.token, 1)
								text_displayed.cursor.make_from_character_pos (cur.x_in_characters, l_number, text_displayed)
								text_displayed.selection_cursor.make_from_character_pos (cur.x_in_characters + cur.token.length, l_number, text_displayed)
								text_displayed.enable_selection
								old_offset := offset
								check_cursor_position
								editor_drawing_area.set_pebble_position (token_pos + left_margin_width, (l_number - first_line_displayed)*line_height + line_height//2 + editor_viewport.y_offset)
								if Result.stone_cursor /= Void then
									editor_drawing_area.set_accept_cursor (Result.stone_cursor)
								end
								if Result.x_stone_cursor /= Void then
									editor_drawing_area.set_deny_cursor (Result.x_stone_cursor)
								end
								set_pick_and_drop_status (pnd_pick)

								invalidate_line (l_number, True)
								invalidate_line (l_line, True)
							else
								Result := Void
							end
						else
							Result := Void
						end
					end
				end
			end
		end

	set_pick_and_drop_status (a_status: INTEGER) is
			-- Set status of pick and drop
		require
			status_valid: a_status = pnd_pick or a_status = no_pnd
		do
			if a_status = pnd_pick then
				suspend_cursor_blinking
			end
		end

	pick_n_drop_status: INTEGER
			-- Step of the pick n drop where the editor is.

	pnd_pick, no_pnd: INTEGER is unique

feature {NONE} -- Text Loading

	reset is
			-- Reinitialize `Current' so that it can receive a new content.
		do
				-- First abort our previous actions.
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR}
			if search_tool /= Void then
				search_tool.force_new_search
			end
			after_reading_text_actions.wipe_out
		end

	on_text_loaded is
			-- Finish editor setup as the entire text has been loaded.
		do
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR}
			from
				after_reading_text_actions.start
			until
				after_reading_text_actions.after
			loop
				after_reading_text_actions.item.call(Void)
				after_reading_text_actions.forth
			end
			after_reading_text_actions.wipe_out
		end

feature {EB_EDITOR_TOOL} -- Update

	on_text_saved is
			-- Update the editor as the text has been saved.
		local
			fn: STRING
			backup_file: RAW_FILE
			file: RAW_FILE
		do
			text_displayed.set_changed (False, True)
			if open_backup then
				fn := file_name.twin
				create backup_file.make (file_name)
				backup_file.delete
				fn.keep_head (fn.count - 4)
				create file_name.make_from_string (fn)
				open_backup := False
			end
			if file_name /= Void then
				create file.make (file_name)
				if file.exists then
					date_of_file_when_loaded := file.date
				end
			end
		end

feature -- Access

	text_displayed: CLICKABLE_TEXT
			-- Text displayed in the editor.

feature {NONE} -- Implementation

	after_reading_text_actions: LINKED_LIST [PROCEDURE [EB_CLICKABLE_EDITOR, TUPLE]]
			-- Procedures to be applied when the text is completely loaded.

	hidden_breakpoints: BOOLEAN
			-- Are brekpoints hidden ?

	matching_customizable_commands (key_code: INTEGER; ctrl, alt, shift: BOOLEAN): ACTION_SEQUENCE [TUPLE] is
			-- List of shortcuts agents in `customizable_commands' that correspond to the shortcut
			-- defined by key of code `key_code' and Ctrl if `ctrl', Shift if `shift' and Alt if `alt'.
		local
			l_shortcut: SHORTCUT_PREFERENCE
			l_shortcuts: HASH_TABLE [SHORTCUT_PREFERENCE, STRING]
		do
			create Result
			l_shortcuts := preferences.editor_data.shortcuts
			from
				l_shortcuts.start
			until
				l_shortcuts.after
			loop
				l_shortcut := l_shortcuts.item_for_iteration
				if l_shortcut.key.code = key_code then
					if l_shortcut.is_alt = alt and l_shortcut.is_ctrl = ctrl and l_shortcut.is_shift = shift then
						Result.extend (customizable_commands.item (l_shortcuts.key_for_iteration))
					end
				end
				l_shortcuts.forth
			end
		ensure
			matching_customizable_commands_not_void: Result /= Void
		end

	display_breakpoint_number (bp_number: INTEGER) is
			-- Show `bp_number'-th breakpoint.
		require
			bp_number_is_valid: bp_number > 0
			text_completely_loaded: text_is_fully_loaded
		local
			ln: like line_type
			bp_count, line_index: INTEGER
			bp_token: EDITOR_TOKEN_BREAKPOINT
		do
			from
				ln ?= text_displayed.first_line
			until
				ln = Void or else bp_count = bp_number
			loop
				bp_token ?= ln.real_first_token
				if bp_token /= Void and then bp_token.pebble /= Void then
					bp_count := bp_count + 1
				end
				line_index := line_index + 1
				ln := ln.next
			end
			if bp_count = bp_number then
					-- Only scroll when necessary
				if first_line_displayed > line_index or first_line_displayed + number_of_lines_displayed <= line_index then
					display_line_with_context (line_index)
				end
			else
				debug ("EDITOR")
					io.error.put_string ("%N Editor Warning : Unable to scroll to Breakpoint number "+ bp_number.out + "%N")
					io.error.put_string ("                   There are only " + bp_count.out + " in currently displayed class.%N")
				end
			end
		end

	gain_focus is
			-- Update the editor as it has just gained the focus.
		do
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR}
			if dev_window /= Void then
				dev_window.set_current_editor (Current)
			end
		end

	in_feature_click: BOOLEAN

	resume_cursor_for_drop (a: ANY) is
			-- Resumes cursor on drop from pick and drop
		do
			resume_cursor_blinking
		end

feature -- Memory management

	recycle is
			-- Destroy `Current'
		do
			Precursor {EB_CUSTOM_WIDGETTED_EDITOR}
			if customizable_commands /= Void then
				customizable_commands.wipe_out
				customizable_commands := Void
			end
			if after_reading_text_actions /= Void then
				after_reading_text_actions.wipe_out
				after_reading_text_actions := Void
			end
		end

feature {NONE} -- Implementation

	editor_set : BOOLEAN
			-- Has editor been setup?

	line_type: EIFFEL_EDITOR_LINE is
			-- Type of line.
		do
		end

	cursor_type: EIFFEL_EDITOR_CURSOR is
			-- Type of cursor.
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_CLICKABLE_EDITOR
