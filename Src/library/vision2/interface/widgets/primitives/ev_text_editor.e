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

	test_font: EV_CHARACTER_FORMAT is
		local
			font: EV_FONT
			color: EV_COLOR
		once
			create Result.make

			!! color.make_rgb (0, 0, 255)
			Result.set_color (color)
			!! font.make_by_name ("Courier New")
			font.set_height (10)
			Result.set_font (font)
			Result.set_bold (False)
		end

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			make_key_code
			create custom_event_handler.make (4)
			create {EV_LINKED_HISTORY} history.make
			{EV_RICH_TEXT} Precursor (par)
			
			add_text_editor_commands
			select_all
			set_character_format (test_font)
			deselect_all

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
				set_position (first_character_from_line_number (line_pos))
				insert_text (s)
				line_pos := line_pos + 1
			end
		ensure
			text_bigger_or_equal: old text.count <= text.count
		end
			
feature -- Event - command association

	add_indent_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to intend the currently selected lines.
		do
			custom_event_handler.add_command ("indent_lines", cmd, arg)
		end

	add_deindent_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to deintend the currently selected lines.
		do
			custom_event_handler.add_command ("deindent_lines", cmd, arg)
		end

	add_comment_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to comment the currently selected lines.
		do
			custom_event_handler.add_command ("comment_lines", cmd, arg)
		end

	add_decomment_lines_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to decomment the currently selected lines.
		do
			custom_event_handler.add_command ("decomment_lines", cmd, arg)
		end


feature -- Event -- removing command association

	remove_indent_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to indent the currently selected lines.
		do
			custom_event_handler.remove_all_commands ("indent_lines")			
		end
	
	remove_deindent_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to decomment the currently selected lines.
		do
			custom_event_handler.remove_all_commands ("indent_lines")			
		end

	remove_comment_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to comment the currently selected lines.
		do
			custom_event_handler.remove_all_commands ("comment_lines")			
		end
	
	remove_decomment_lines_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs wants to decomment the currently selected lines.
		do
			custom_event_handler.remove_all_commands ("comment_lines")			
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

		end

	history: EV_HISTORY
	custom_event_handler: EV_CUSTOM_EVENT_HANDLER [STRING]

	on_undo (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Undo a the last recorded command
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
		do
			if
				history.can_redo
			then
				history.redo
			else
				print ("Cannot redo%N")
			end
		end

	get_line_range_data_from_selection: EV_LINE_RANGE_EVENT_DATA is
		do
			create Result.make (Current, line_number_from_position (selection_start),
									  line_number_from_position (selection_end))
		end
	ttt is
		local
			t: STRING
		do
			t := text
			print (t)
		end

	on_key_press (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Check for certain key combinations and
			-- trigger their associated commands
		local
			key_data: EV_KEY_EVENT_DATA
			new_data: EV_EVENT_DATA
		do
			key_data ?= data
			check
				valid_cast: key_data /= Void
			end

			if
				key_data.keycode = Key_F
			then
				ttt
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
					key_data.control_key_pressed
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
					key_data.control_key_pressed
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
