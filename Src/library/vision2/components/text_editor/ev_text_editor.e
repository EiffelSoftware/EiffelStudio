indexing 
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_EDITOR

inherit
	EV_RICH_TEXT
		redefine
			make
		end
		
	EV_KEY_CODE
		rename
			make as make_key_code,
			implementation as key_code_implementation
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			make_key_code
			create {EV_TEXT_EDITOR_HISTORY} history.make
			{EV_RICH_TEXT} Precursor (par)
			
			add_text_editor_commands
--			set_text ("Ln1%R%NLn2")
--			select_all
--			set_character_format (test_font)
--			deselect_all
		end
feature -- Status Report

	syntax_highlighting_enabled: BOOLEAN

feature -- Status Settings

	turn_syntax_highlighting_off is
		require
			exists: not destroyed
			syntax_highlighting_enabled: syntax_highlighting_enabled
		do
			syntax_highlighting_enabled := False
		end
	
	turn_syntax_highlighting_on is
		require
			exists: not destroyed
			syntax_highlighting_not_enabled: not syntax_highlighting_enabled
		do
			syntax_highlighting_enabled := True
		end
		
feature -- Element Change

	comment_lines (first_line, last_line: INTEGER) is
			-- Comments lines from `first_line' to `last_line'.
		require
			exist: not destroyed
			valid_line_numbers: valid_line_index (first_line) and valid_line_index (last_line)
		do
			prepend_lines ("--", first_line, last_line)
		ensure
			text_bigger_or_equal: old text.count <= text.count
		end

	indent_lines (first_line, last_line: INTEGER) is
			-- Indents lines from `first_line' to `last_line'.
		require
			exist: not destroyed
			valid_line_numbers: valid_line_index (first_line) and valid_line_index (last_line)
		do
			prepend_lines ("%T", first_line, last_line)
		ensure
			text_bigger_or_equal: old text.count <= text.count
		end

	deindent_lines (first_line, last_line: INTEGER) is
			-- Deindents lines from `first_line' to `last_line' (if possible).
			-- If a line has no whitecharacters at the beginning it won't be changed.
		require
			exist: not destroyed
			valid_line_numbers: valid_line_index (first_line) and valid_line_index (last_line)
		local
			i: INTEGER
			line_buffer: STRING
		do
			from
				i := first_line
			until
				i > last_line
			loop
				line_buffer := line (i)
				if
					line_buffer.count >= 1 and then 
					(line_buffer.item (1) = '%T' or line_buffer.item (1) = ' ')
				then
					prune_leading_from_line (1, i)
				end
				i := i + 1
			end
		end

	decomment_lines (first_line, last_line: INTEGER) is
			-- Deindents lines from `first_line' to `last_line' (if possible).
			-- If a line has no whitecharacters at the beginning it won't be changed.
		require
			exist: not destroyed
			valid_line_numbers: valid_line_index (first_line) and valid_line_index (last_line)
		local
			i: INTEGER
			line_buffer: STRING
		do
			from
				i := first_line
			until
				i > last_line
			loop
				line_buffer := line (i)
				if
					line_buffer.count >= 2 and then line_buffer.item (1) = '-' and then line_buffer.item (2) = '-'
				then
					prune_leading_from_line (2, i)
				end
				i := i + 1
			end
		end


	prune_leading_from_line (number_of_characters, line_index: INTEGER) is
			-- Remove `number_of_characters' characters from the beginning of the
			-- `line_index'-th line.
		require
			valid_line_index: valid_line_index (line_index)
			number_of_characters_greater_zero: number_of_characters > 0
		local
			line_buffer: STRING
		do
			line_buffer := line (line_index)
			select_lines (line_index, line_index)
			delete_selection

			line_buffer.tail (line_buffer.count - number_of_characters)
			insert_text (line_buffer)
		end

	prepend_lines (s: STRING; first_line, last_line: INTEGER) is
			-- Prepend `s' at the beginning of the lines with an index
			-- between `first_line' and `last_line' line.
		require
			exist: not destroyed
			valid_line_numbers: valid_line_index (first_line) and valid_line_index (last_line)
			s_not_void: s /= Void
		local
			line_pos: INTEGER
					-- Line index.
		do
			from
				line_pos := first_line
			until
				line_pos > last_line
			loop
				set_position (first_position_from_line_number (line_pos))
				insert_text (s)
				line_pos := line_pos + 1
			end
		ensure
			text_bigger_or_equal: old text.count <= text.count
		end

	update_highlighting (first_pos, last_pos: INTEGER) is
			-- Update syntax highlighting from position `first_pos'
			-- to position `last_pos'.
			-- This feature does nothing by default.
			-- You may want to redefine this feature in a descentant to
			-- implement your custom syntax highlighting pattern.
			-- If you implement this feature call `execute_highlight'
			-- whenever you encounter a token that needs to be highlighted.
		require
			exists: not destroyed
			valid_first_position: valid_position (first_pos)
			valid_last_position: valid_position (last_pos)
		do
		end

	update_highlighting_all is
			-- Update syntax highlighting for all the text.
		require
			exists: not destroyed
		do
			if 
				text_length > 0
			then
				update_highlighting (1, text_length)		
			end
		end
	

	update_highlighting_selected_text is
			-- Update syntax highlighting for all the text that is currently visible.
		require
			exists: not destroyed
			has_selection: has_selection			
		do
			update_highlighting (selection_start, selection_end)		
		end

	update_highlighting_lines_from_character_position (first_pos, last_pos: INTEGER) is
			-- Update syntax highlighting beginning with the line that contains `first_pos'
			-- until the line that conatins `last_pos'. 
		require
			exists: not destroyed
			valid_positions: valid_position (first_pos) and valid_position (last_pos)
		do
			update_highlighting_lines (line_number_from_position (first_pos),
												line_number_from_position (last_pos))
		end

	update_highlighting_lines (first_line, last_line: INTEGER) is
			-- Update syntax highlighting for all text between 'first_line' and 'last_line'.
		require
			exists: not destroyed
			valid_lines: valid_line_index (first_line) and valid_line_index (last_line)
		do
			update_highlighting (first_position_from_line_number (first_line ),
										last_position_from_line_number (last_line))
		end

			
feature -- Event - command association

	add_indent_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to intend the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.add_command ("indent_lines", cmd, arg)
		end

	add_deindent_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to deintend the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.add_command ("deindent_lines", cmd, arg)
		end

	add_comment_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to comment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.add_command ("comment_lines", cmd, arg)
		end

	add_decomment_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to decomment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.add_command ("decomment_lines", cmd, arg)
		end

	add_highlight_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to decomment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.add_command ("highlight", cmd, arg)
		end


feature -- Event -- removing command association

	remove_indent_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to indent the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.remove_all_commands ("indent_lines")			
		end
	
	remove_deindent_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to decomment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.remove_all_commands ("indent_lines")			
		end

	remove_comment_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to comment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.remove_all_commands ("comment_lines")			
		end
	
	remove_decomment_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to decomment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.remove_all_commands ("comment_lines")			
		end

	remove_highlight_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to decomment the currently selected lines.
		require
			exists: not destroyed
		do
			custom_event_handler.remove_all_commands ("highlight")			
		end

	
feature {NONE} -- Implementation

	add_text_editor_commands is
		require
			exists: not destroyed
		local
			cmd: EV_COMMAND
		do
				-- The undo/redo commands
				-- They are not undoable and redoable as it
				-- would course recursion and make limited sense
			create {EV_ROUTINE_COMMAND} cmd.make (~on_undo)
			add_undo_command (cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (~on_redo)
			add_redo_command (cmd, Void)

			create {EV_INSERT_TEXT_COMMAND} cmd.make (history)
			add_insert_text_command (cmd, Void)

			create {EV_DELETE_TEXT_COMMAND} cmd.make (history)
			add_delete_text_command (cmd, Void)
			
			create {EV_ROUTINE_COMMAND} cmd.make (~on_key_press)
			add_key_press_command (cmd, Void)
			
			create {EV_INDENT_LINES_COMMAND} cmd.make (history)
			add_indent_lines_command (cmd, Void)

			create {EV_COMMENT_LINES_COMMAND} cmd.make (history)
			add_comment_lines_command (cmd, Void)

			create {EV_DEINDENT_LINES_COMMAND} cmd.make (history)
			add_deindent_lines_command (cmd, Void)

			create {EV_DECOMMENT_LINES_COMMAND} cmd.make (history)
			add_decomment_lines_command (cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (~on_highlight)
			add_highlight_command (cmd, Void)

			create {EV_ROUTINE_COMMAND} cmd.make (~on_change)
			add_change_command (cmd, Void)


		end

	history: EV_HISTORY
	custom_event_handler: EV_CUSTOM_EVENT_HANDLER [STRING]

	on_undo (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Undo a the last recorded command
		require
			exists: not destroyed
		do
			if
				history.can_undo
			then
				history.undo
			else
				print ("Cannot undo%N")
			end
		end

	on_redo (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Redo the last undone command
		require
			exists: not destroyed
		do
			if
				history.can_redo
			then
				history.redo
			else
				print ("Cannot redo%N")
			end
		end

	on_change (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			exists: not destroyed
		do
			update_highlighting_all
			--print ("change")
			--insert_text ("foo")
		end


	on_highlight (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			exists: not destroyed
		local
			highlight_data: EV_HIGHLIGHT_EVENT_DATA
		do
			highlight_data ?= data
			check
				valid_cast: highlight_data /= Void		
			end
			format_region (highlight_data.first_pos, highlight_data.last_pos, highlight_data.format)
			--select_region (highlight_data.first_pos, highlight_data.last_pos)
		end

		
	execute_highlight (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Raise a "highligh" event.
		require
			exists: not destroyed
			valid_positions: valid_position (first_pos) and valid_position (last_pos)
			format_not_void: format /= Void
		local
			data: EV_HIGHLIGHT_EVENT_DATA
		do
			create data.make (Current, first_pos, last_pos, format)
			custom_event_handler.execute_command ("highlight", data)
		end

	get_line_range_data_from_selection: EV_LINE_RANGE_EVENT_DATA is
		require
			exists: not destroyed
		do
			create Result.make (Current, line_number_from_position (selection_start),
									  line_number_from_position (selection_end))
		end

	on_key_press (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Check for certain key combinations and
			-- trigger their associated commands
		require
			exists: not destroyed
		local
			key_data: EV_KEY_EVENT_DATA
			new_data: EV_EVENT_DATA
		do
			key_data ?= data
			check
				valid_cast: key_data /= Void
			end

			if
				key_data.keycode = Key_tab
			then
				if
					has_selection
				then
						-- Trigger indent or de_indent lines event 
					if
						not key_data.shift_key_pressed
					then
						if 
							custom_event_handler.has_command ("indent_lines") 
						then
							new_data := get_line_range_data_from_selection
							custom_event_handler.execute_command ("indent_lines", new_data)
						end
					else
						if 
							custom_event_handler.has_command ("deindent_lines") 
						then
							new_data := get_line_range_data_from_selection
							custom_event_handler.execute_command ("deindent_lines", new_data)
						end
					end
				end
			elseif 
				key_data.keycode = Key_o
			then
				if
					key_data.control_key_pressed and has_selection
				then
						-- Trigger comment lines event
					if 
						custom_event_handler.has_command ("comment_lines") 
					then
						new_data := get_line_range_data_from_selection
						custom_event_handler.execute_command ("comment_lines", new_data)
					end
				end
			elseif
				key_data.keycode = Key_p
			then
				if
					key_data.control_key_pressed and has_selection
				then
						-- Trigger decomment lines event
					if 
						custom_event_handler.has_command ("decomment_lines") 
					then
						new_data := get_line_range_data_from_selection
						custom_event_handler.execute_command ("decomment_lines", new_data)
					end
				end
			end
--			update_highlighting (1, text_length)
		end



end -- class EV_RICH_TEXT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
