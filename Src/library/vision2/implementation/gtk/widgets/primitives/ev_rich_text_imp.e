indexing 
	description:
		" EiffelVision rich text, gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP

inherit
	EV_RICH_TEXT_I

	EV_TEXT_IMP
		redefine
			insert_text
		end

creation
	make

feature -- Access

	character_format: EV_CHARACTER_FORMAT
			-- Current character format.

feature -- Status report

	line_number_from_position (a_pos: INTEGER): INTEGER is
			-- Retrieves the line number from a character position
			-- Line numbers start at 1.
		do
		end
		
feature -- Status setting

	insert_text (txt: STRING) is
		local
			a: ANY
			font_imp: EV_FONT_IMP
			color: EV_COLOR
		do
			if character_format /= Void then
				a := txt.to_c
				font_imp ?= character_format.font.implementation
				color := character_format.color
				c_gtk_text_full_insert (widget, font_imp.widget,
					color.red, color.green, color.blue,
					$a, txt.count)
			else
				{EV_TEXT_IMP} Precursor (txt)
			end
		end

	apply_format (format: EV_TEXT_FORMAT) is
			-- Apply the given format to the text.
		local
			tt: EV_RICH_TEXT
		do
			tt ?= interface
			format.apply (tt)
		end

	format_region (first_pos, last_pos: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Set the format of the text between `first_pos' and `last_pos' to
			-- `format'. May or may not change the cursor position.
		do
			check
				To_be_implemented: False
			end
		end

feature -- Element change

	set_character_format (format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to the selection and make it the
			-- current character format.
		local
			str: STRING
			index: INTEGER
			font_imp: EV_FONT_IMP
			color: EV_COLOR
			a: ANY
		do
			character_format := format
			if has_selection then
				str := selected_text
				index := selection_start
				delete_selection
				set_position (index)
				a := str.to_c
				font_imp ?= character_format.font.implementation
				color := character_format.color
				c_gtk_text_full_insert (widget, font_imp.widget,
					color.red, color.green, color.blue,
					$a, str.count)
			end
		end

	remove_text (start_pos, end_pos: INTEGER) is
			-- Remove the text between `start_pos' and `end_pos'.
		do
			gtk_editable_delete_text (widget, start_pos - 1, end_pos - 1)
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
		do
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
		do
		end

feature -- Event - command association

	add_insert_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user inputs a text.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_INSERT_TEXT_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "insert_text", cmd, arg, ev_data, 0, False, default_pointer)
		end

	add_delete_text_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user deletes a text.
		local
			ev_data: EV_EVENT_DATA		
		do
			!EV_INSERT_TEXT_EVENT_DATA!ev_data.make
			add_command_with_event_data (widget, "delete_text", cmd, arg, ev_data, 0, False, default_pointer)
		end


	add_delete_right_character_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to delete the right character.
		do
			add_command (widget, "key_press_event", cmd, arg, default_pointer)
		end


	add_undo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to undo a command.
		do
		end

	add_redo_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the user wants to redo a command.
		do
		end

feature -- Event -- removing command association

	remove_insert_text_commands is
			-- Empty the list of commands to be executed when
			-- the user inputs a text.
		do
			remove_commands (widget, insert_text_id)
		end

	remove_delete_text_commands is
			-- Empty the list of commands to be executed when
			-- when the user deletes a text.
		do
			remove_commands (widget, delete_text_id)
		end

	remove_delete_right_character_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to delete the left character.
		do
		end

	remove_undo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to undo a command.
		do
		end

	remove_redo_commands is
			-- Empty the list of commands to be executed when
			-- when the user wants to redo a command.
		do
		end

end -- class EV_RICH_TEXT_IMP

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
