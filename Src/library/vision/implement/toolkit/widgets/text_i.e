indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TEXT_I 

inherit

	TEXT_FIELD_I

feature -- Access

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current selection highlightened
		require
			selection_active: is_selection_active;
			realized: realized
		deferred
		ensure
			result_large_enough: Result >= 0;
			result_small_enough: Result < count
		end;

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		require
			selection_active: is_selection_active;
			realized: realized
		deferred
		ensure
			result_large_enough: Result > 0;
			result_small_enough: Result <= count
		end;

	show_selection is
			-- Show the selection when there is one.
			-- The text will scroll if the selection is out
			-- of range.
	 	require
			realized: realized
		deferred
		ensure
			show_selection: is_selection_visible = True
		end

	hide_selection is
			-- Hide the selection when there is one.
			-- The text will not scroll if the selection is out
			-- of range.
		require
			realized: realized
		deferred
		ensure
			hide_selection: is_selection_visible = False
		end

	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		deferred
		ensure
			result_large_enough: Result >= 0;
			result_small_enough: Result <= count
		end;

	character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		deferred
		end;

	top_character_position: INTEGER is
			-- Character position of first character displayed
		deferred
		end;

	rows: INTEGER is
			-- Height of Current widget measured in character
			-- heights.
		require
			is_multi_line_mode: is_multi_line_mode
		deferred
		end;
 
	coordinate (char_pos: INTEGER): COORD_XY is
			-- Coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		deferred
		end;

	x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		deferred
		end;

	y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		deferred
		end;

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		deferred
		end;

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		deferred
		end;

feature -- Status report

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		deferred
		ensure
			Result implies is_width_resizable and is_height_resizable
		end;

	is_bell_enabled: BOOLEAN is
			-- Is the bell enabled when an action is forbidden
		deferred
		end;

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		deferred
		end;

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		deferred
		end;

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		require
			realized: realized
		deferred
		end;

	is_selection_visible: BOOLEAN is
			-- Will the selection be visible ?
		require
			realized: realized
		deferred
		end;

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		deferred
		end;

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		deferred
		end;

	is_multi_line_mode: BOOLEAN is
			-- Is Current editing a multiline text?
		deferred
		end;

	is_cursor_position_visible: BOOLEAN is
			-- Is the insert cursor position marked
			-- by a blinking text cursor?
		deferred
		end;

feature -- Status setting

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		deferred
		end;

	clear_selection is
			-- Clear a selection
		require
			selection_active: is_selection_active;
			realized: realized
		deferred
		ensure
			not is_selection_active
		end;

	disable_resize is
			-- Disable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		deferred
		end;

	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		deferred
		end;

	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		deferred
		end;

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		deferred
		end

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		deferred
		end;

	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		deferred
		end;

	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		deferred
		end;

	enable_verify_bell is
			-- Enable the bell when an action is forbidden
		deferred
		end;


	set_cursor_position_visible (flag: BOOLEAN) is
			-- Set is_cursor_position_visible to flag.
		deferred
		end;

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		deferred
		end;

	set_read_only is
			-- Set current text to be read only.
		deferred
		end;

	set_single_line_mode is
			-- Set editing for single line text.
		deferred
		end;
 
	set_multi_line_mode is
			-- Set editing for multiline text.
		deferred
		end;

	set_editable is
			-- Set current text to be editable.
		deferred
		end;

feature -- Basic functions

	find (text_to_find: STRING; match_case: BOOLEAN; start_from: INTEGER): INTEGER is
			-- Search for the string `text_to_find' in the TEXT
		require
			text_to_find_not_void: text_to_find /= Void
		deferred
		end

feature -- Element change

	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before insert
			-- cursor is moved to a new position.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		require
			new_height_large_enough: new_height >= 0
		deferred
		end;

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		require
			new_width_large_enough: new_width >= 0
		deferred
		end;

	set_selection (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require
			first_positive_not_null: first >= 0;
			last_fewer_than_count: last <= count;
			first_fewer_than_last: first <= last;
			realized: realized
		deferred
		ensure
			selection_set: first /= last implies is_selection_active;
			begin_set: begin_of_selection = first;
			end_set: end_of_selection = last
		end

	set_top_character_position (char_pos: INTEGER) is
			-- Set first character displayed to `char_pos'.
		deferred
		end;

	set_rows (i: INTEGER) is
			-- Set the character height of Current widget to `i'.
		require
			is_multi_line_mode: is_multi_line_mode;
			valid_i: i > 0
		deferred
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require
			a_position_positive_not_null: a_position >= 0;
			a_position_fewer_than_count: a_position <= count
		deferred
		ensure
			set: cursor_position = a_position
		end;

feature -- Removal

	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- insert cursor is moved to a new position.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;
 
end -- class TEXT_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

