--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision text, implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RICH_TEXT_I

inherit
	EV_SCROLLABLE_TEXT_I
		rename
			make as scrollable_make,
			make_with_text as scrollable_make_with_text,
			make_with_properties as scrollable_make_with_properties
		export
			{NONE}
				scrollable_make,
				scrollable_make_with_text,
				scrollable_make_with_properties,
				show_vertical_scroll_bar,
				hide_vertical_scroll_bar,
				show_horizontal_scroll_bar,
				hide_horizontal_scroll_bar
		end

feature -- Initialization

--	make_with_properties (txt: STRING; hscroll: BOOLEAN) is
--			-- Create a rich text area with `par' as parent and
--			-- `txt' as text. Vertically scrollable and if `hscroll'
--			-- then horizontally scrollable.
--		deferred
--		end

feature -- Access

	character_format: EV_CHARACTER_FORMAT is
			-- Current character format.
		require
		deferred
		end

feature -- Status setting

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		require
			valid_format: format /= Void
		deferred
		end

	format_region (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Set the format of the text between `first_pos' and `last_pos' to
			-- `format'. May or may not change the cursor position.
		require
			valid_positions: valid_position (first_pos) and valid_position (last_pos)
			format_not_void: format /= Void
		deferred
		end

feature -- Status report

	line_number_from_position (a_pos: INTEGER): INTEGER is
			-- Retrieves the line number from a character position
			-- Line numbers start at 1.
		require
			index_large_enough: a_pos >= 0
			index_small_enough: a_pos <= text_length + 2
		deferred
		ensure
			valid_result: Result >= 1
		end
		
feature -- Element change

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		require
			valid_format: format /= Void
		deferred
--		ensure
--			format_set: character_format = format
		end

	remove_text (start_pos, end_pos: INTEGER) is
			-- Remove the text between `start_pos' and `end_pos'.
		require
			valid_positions: valid_position (start_pos) and valid_position (end_pos)
		deferred
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
			x_large_enough: value_x >= 0
			y_large_enough: value_y >= 0
		deferred
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
			index_large_enough: value >= 0
			index_small_enough: value <= text_length + 2
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
feature -- Event - command association

	add_insert_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user inputs a text.
		require
			valid_command: cmd /= Void
		deferred
		end

	add_delete_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user deletes a text.
		require
			valid_command: cmd /= Void
		deferred
		end


	add_delete_right_character_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to delete the right character.
		require
			valid_command: cmd /= Void
		deferred
		end


	add_undo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to undo a command.
		require
			valid_command: cmd /= Void
		deferred
		end

	add_redo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to redo a command.
		require
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_insert_text_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs a text.
		require
		deferred
		end

	remove_delete_text_commands is
			-- Empty the list of commands to be executed when
			-- when the user deletes a text.
		require
		deferred
		end

	remove_delete_right_character_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to delete the left character.
		require
		deferred
		end

	remove_undo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to undo a command.
		require
		deferred
		end

	remove_redo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to redo a command.
		require
		deferred
		end


		

end -- class EV_RICH_TEXT_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.2.2.2.3  2000/01/27 19:30:05  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.2.2.2.2  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.9.2.2.2.1  1999/11/24 17:30:13  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
