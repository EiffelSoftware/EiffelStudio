indexing 
	description: "A edit control based on EV_RICH_TEXT optimized for%
					 %source code editing. It supports various advanced %
					 %editing mechanisms and a rudimentary support for%
					 %syntax highlighting"
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			make_key_code
			create custom_event_handler
			create {EV_TEXT_EDITOR_HISTORY} history.make
			{EV_RICH_TEXT} Precursor (par)
			
			add_text_editor_commands
		end
		
	init_accelerators is
		require
			exists: not destroyed
		local
			accelerator: EV_ACCELERATOR
			cmd: EV_COMMAND
		do
--			make (code: INTEGER; shift, alt, control: BOOLEAN) is

			create accelerator.make (Key_tab, False, False, False)
			create {EV_ROUTINE_COMMAND} cmd.make (~accel_on_indent_lines)
			add_accelerator_command (accelerator, cmd, Void)

			create accelerator.make (Key_tab, True, False, False)
			create {EV_ROUTINE_COMMAND} cmd.make (~accel_on_deindent_lines)
			add_accelerator_command (accelerator, cmd, Void)

			create accelerator.make (Key_o, False, False, True)
			create {EV_ROUTINE_COMMAND} cmd.make (~accel_on_comment_lines)
			add_accelerator_command (accelerator, cmd, Void)

			create accelerator.make (Key_p, False, False, True)
			create {EV_ROUTINE_COMMAND} cmd.make (~accel_on_decomment_lines)
			add_accelerator_command (accelerator, cmd, Void)

		end		

	accel_on_indent_lines (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			exists: not destroyed
		local
			new_data: EV_EVENT_DATA
		do
			if
				has_selection
			then
				new_data := get_line_range_data_from_selection
				custom_event_handler.execute_command ("indent_lines", new_data)
			else
				insert_text_as_command ("%T")
			end
		end

	accel_on_deindent_lines (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			exists: not destroyed
		local
			new_data: EV_EVENT_DATA
		do
			if
				has_selection
			then
				new_data := get_line_range_data_from_selection
				custom_event_handler.execute_command ("deindent_lines", new_data)
			else
				insert_text_as_command ("%T")
			end
		end

	accel_on_comment_lines (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			exists: not destroyed
		local
			new_data: EV_EVENT_DATA
		do
			if
				has_selection
			then
				new_data := get_line_range_data_from_selection
				custom_event_handler.execute_command ("comment_lines", new_data)
			end
		end

	accel_on_decomment_lines (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			exists: not destroyed
		local
			new_data: EV_EVENT_DATA
		do
			if
				has_selection
			then
				new_data := get_line_range_data_from_selection
				custom_event_handler.execute_command ("decomment_lines", new_data)
			end
		end


feature -- Status Report

	syntax_highlighting_enabled: BOOLEAN
	
	basic_auto_intending_enabled: BOOLEAN
			-- If basic auto intending is switched on
			-- pressing enter will place the cursor
			-- in the new row at the column that contains
			-- the first non white character in the
			-- previous row. The columns between the cursor
			-- and the newline will be filled with the same
			-- white characters the previous row contains.
			 
			

feature -- Status Settings

	enable_syntax_highlighting is
			-- Enables syntax highlighting
		require
			exists: not destroyed
			syntax_highlighting_disabled: not syntax_highlighting_enabled
		do
			syntax_highlighting_enabled := True
		ensure
			syntax_highlighting_enabled: syntax_highlighting_enabled
		end
	
	disable_syntax_highlighting is
			-- Disables syntax highlighting
		require
			exists: not destroyed
			syntax_highlighting_enabled: syntax_highlighting_enabled
		do
			syntax_highlighting_enabled := False
		ensure
			syntax_highlighting_disabled: not syntax_highlighting_enabled
		end
		
	enable_basic_auto_intending is
			-- Enables basic auto intending
		require
			exists: not destroyed
			basic_auto_intending_disabled: not basic_auto_intending_enabled
		do
			basic_auto_intending_enabled := True
		ensure
			basic_auto_intending_enabled: basic_auto_intending_enabled
		end

	disable_basic_auto_intending is
			-- Disables basic auto intending
		require
			exists: not destroyed
			basic_auto_intending_enabled: basic_auto_intending_enabled
		do
			basic_auto_intending_enabled := False
		ensure
			basic_auto_intending_disabled: not basic_auto_intending_enabled
		end


		
feature -- Element Change

	insert_text_as_command (a_text: STRING) is
			-- Inserts `a_text' at the current cursor position and
			-- adds this change as a undoable command to the history.
		local
			cmd: EV_COMMAND
			data: EV_PUBLIC_INSERT_TEXT_EVENT_DATA
		do
			create {EV_INSERT_TEXT_COMMAND} cmd.make (history)
			create data.make
			data.set_all (Current, position, a_text)
			cmd.execute (Void, data)
			insert_text (a_text)
		end

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
			-- Decomments lines from `first_line' to `last_line' (if possible).
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
			-- Called after the text of the widget has been
			-- changed.
			-- This function is used to update the syntax 
			-- highlighting of the text
		require
			exists: not destroyed
		local
			first_line, last_line: INTEGER
		do
			-- update_highlighting_all
			
			--history.next_undo_command
			first_line := current_line_number
			last_line := current_line_number + 1
			if
				valid_line_index (first_line) and
				valid_line_index (last_line)
			then
				update_highlighting_lines (first_line, last_line)
			end
			
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
--			key_data ?= data
--			check
--				valid_cast: key_data /= Void
--			end
--
--			if
--				key_data.keycode = Key_tab
--			then
--				if
--					has_selection
--				then
--						-- Trigger indent or de_indent lines event 
--					if
--						not key_data.shift_key_pressed
--					then
--						if 
--							custom_event_handler.has_command ("indent_lines") 
--						then
--							new_data := get_line_range_data_from_selection
--							custom_event_handler.execute_command ("indent_lines", new_data)
--						end
--					else
--						if 
--							custom_event_handler.has_command ("deindent_lines") 
--						then
--							new_data := get_line_range_data_from_selection
--							custom_event_handler.execute_command ("deindent_lines", new_data)
--						end
--					end
--				end
--			elseif 
--				key_data.keycode = Key_o
--			then
--				if
--					key_data.control_key_pressed and has_selection
--				then
--						-- Trigger comment lines event
--					if 
--						custom_event_handler.has_command ("comment_lines") 
--					then
--						new_data := get_line_range_data_from_selection
--						custom_event_handler.execute_command ("comment_lines", new_data)
--					end
--				end
--			elseif
--				key_data.keycode = Key_p
--			then
--				if
--					key_data.control_key_pressed and has_selection
--				then
--						-- Trigger decomment lines event
--					if 
--						custom_event_handler.has_command ("decomment_lines") 
--					then
--						new_data := get_line_range_data_from_selection
--						custom_event_handler.execute_command ("decomment_lines", new_data)
--					end
--				end
--			elseif
--				key_data.keycode = Key_enter
--			then
--				if
--					not key_data.control_key_pressed and basic_auto_intending_enabled
--				then
--					do_basic_auto_intending
--				end
--			end
--			update_highlighting (1, text_length)
		end


	do_basic_auto_intending is
		do
			--current_line_number
		end

end -- class EV_RICH_TEXT

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
