indexing 
	description:
		" EiffelVision text. A text area that contains%
		%a rich text."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT

inherit
	EV_SCROLLABLE_TEXT
		rename
			make as scrollable_make,
			make_with_text as scrollable_make_with_text,
			make_horizontally_scrollable as scrollable_make_horizontally_scrollable,
			make_horizontally_scrollable_with_text as scrollable_make_horizontally_scrollable_with_text
		export
			{NONE} 
				scrollable_make,
				scrollable_make_with_text,
				scrollable_make_horizontally_scrollable,
				scrollable_make_horizontally_scrollable_with_text,
				show_vertical_scroll_bar,
				hide_vertical_scroll_bar,
				show_horizontal_scroll_bar,
				hide_horizontal_scroll_bar
		redefine
			implementation
		end


creation
	make,
	make_with_text,
	make_horizontally_scrollable,
	make_horizontally_scrollable_with_text


feature {NONE} -- Initialization


	make (par: EV_CONTAINER) is
			-- Create an empty rich text area with `par' as parent.
			-- Only vertically scrollable. 
		do
			make_with_text (par, "")
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a rich text area with `par' as parent and
			-- `txt' as text. Only vertically scrollable.
		do
			create {EV_RICH_TEXT_IMP} implementation.make_with_properties (txt, False)
			widget_make (par)
		end

	make_horizontally_scrollable (par: EV_CONTAINER) is
			-- Create a rich text area with `par' as parent which
			-- is scrollable in both directions.
		do
			make_horizontally_scrollable_with_text (par, "")
		end

	make_horizontally_scrollable_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a rich text area with `par' as parent, `txt'
			-- as text and is scrollable in both directions.
		do
			create {EV_RICH_TEXT_IMP} implementation.make_with_properties (txt, True)
			widget_make (par)
		end

feature -- Access

	character_format: EV_CHARACTER_FORMAT is
			-- Current character format.
		require
			exists: not destroyed
		do
			Result := implementation.character_format
		end

feature -- Status report

	line_number_from_position (a_pos: INTEGER): INTEGER is
			-- Retrieves the line number from a character position.
			-- Line numbers start at 1.
		require
			exists: not destroyed
			index_large_enough: a_pos >= 0
			index_small_enough: a_pos <= text_length + 2
		do
			Result := implementation.line_number_from_position (a_pos)
		ensure
			valid_result: Result >= 1
		end

feature -- Status setting

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		require
			exists: not destroyed
			valid_format: format /= Void
		do
			implementation.apply_format (format)
		end

feature -- Element change

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		require
			exists: not destroyed
			valid_format: format /= Void
		do
			implementation.set_character_format (format)
--		ensure
--			format_set: character_format = format
		end

	format_region (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Set the format of the text between `first_pos' and `last_pos' to
			-- `format'. May or may not change the cursor position.
		require
			exists: not destroyed
			valid_positions: valid_position (first_pos) and valid_position (last_pos)
			format_not_void: format /= Void
		do
			implementation.format_region (first_pos, last_pos, format)
		end

		
	remove_character (pos: INTEGER) is
			-- Remove the character at the position `pos'
			-- Moves the cursor backwards
		require
			exists: not destroyed
			valid_pos: valid_position (pos)
		do
			remove_text (pos, pos)
		end

	remove_text (start_pos, end_pos: INTEGER) is
			-- remove the text between `start_pos' and `end_pos'.
		require
			exists: not destroyed
			valid_start_pos: valid_position (start_pos)
			valid_end_pos: valid_position (end_pos)
		do
			implementation.remove_text (start_pos, end_pos)
		end

feature -- Basic operation

	index_from_position (value_x, value_y: INTEGER): INTEGER is
			-- One-based character index of the character which is
			-- the nearest to `a_x' and `a_y' position in the client
			-- area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area. The coordinates are truncated
			-- to integer values and are in screen units relative
			-- to the upper-left corner of the client area of the
			-- control.
		require
			exists: not destroyed
			x_large_enough: value_x >= 0
			y_large_enough: value_y >= 0
		do
			Result := implementation.index_from_position (value_x, value_y)
		end

	position_from_index (value: INTEGER): EV_COORDINATES is
			-- Coordinates of a character at `value' in
			-- the client area.
			-- A returned coordinate can be negative if the
			-- character has been scrolled outside the edit
			-- control's client area.
			-- The coordinates are truncated to integer values and
			-- are in screen units relative to the upper-left
			-- corner of the client area of the control.
		require
			exists: not destroyed
			index_large_enough: value >= 0
			index_small_enough: value <= text_length + 2
		do
			Result := implementation.position_from_index (value)
		ensure
			result_not_void: Result /= Void
		end


feature -- Event - command association

	add_insert_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user inputs a text.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_insert_text_command (cmd, arg)
		end

	add_delete_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to delete a text.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_delete_text_command (cmd, arg)
		end


	add_delete_right_character_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to delete the right character.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_delete_right_character_command (cmd, arg)
		end


	add_undo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to undo a command.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_undo_command (cmd, arg)
		end

	add_redo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to redo a command.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_redo_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_insert_text_commands is
			-- Empty the list of commands to be executed when
			-- when the user inputs a text.
		require
			exists: not destroyed
		do
			implementation.remove_insert_text_commands
		end

	remove_delete_text_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to delete a text.
		require
			exists: not destroyed
		do
			implementation.remove_delete_text_commands
		end

	remove_delete_right_character_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to delete the left character.
		require
			exists: not destroyed
		do
			implementation.remove_delete_right_character_commands
		end

	remove_undo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to undo a command.
		require
			exists: not destroyed
		do
			implementation.remove_undo_commands
		end

	remove_redo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to redo a command.
		require
			exists: not destroyed
		do
			implementation.remove_undo_commands
		end

feature -- Implementation

	implementation: EV_RICH_TEXT_I
	
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
