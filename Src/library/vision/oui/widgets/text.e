indexing

	desciption: "A text editor for several lines of text. "
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	TEXT 

inherit

	TEXT_FIELD
		redefine
			make, make_unmanaged, create_ev_widget,
			implementation
		end

creation

	make, make_word_wrapped, make_unmanaged, make_word_wrapped_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			 create_ev_widget (a_name, a_parent, True)
		ensure then
			is_multi_line_mode: is_multi_line_mode
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			 create_ev_widget (a_name, a_parent, False)
		ensure then
			is_multi_line_mode: is_multi_line_mode
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!TEXT_IMP!implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

	make_word_wrapped (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a text with `a_name' as identifier, 
			-- `a_parent' as parent, call `set_default'
			-- and enable word wrap.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget_ww (a_name, a_parent, True)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			managed: managed
		end;

	make_word_wrapped_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged text with `a_name' as identifier, 
			-- `a_parent' as parent, call `set_default'
			-- and enable word wrap.
		require
			valid_name: a_name /= Void;
			valid_parent: a_parent /= Void
		do
			create_ev_widget_ww (a_name, a_parent, False)
		ensure
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name);
			not_managed: not managed
		end;

	create_ev_widget_ww (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a text with `a_name' as identifier, 
			-- `a_parent' as parent, call `set_default'
			-- and enable word wrap.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!TEXT_IMP! implementation.make_word_wrapped (Current, man, a_parent);
			set_default
		end;

feature -- Access

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current selection highlightened
		require
			exists: not destroyed;
			selection_active: is_selection_active;
			realized: realized
		do
			Result := implementation.begin_of_selection
		ensure
			Result >= 0;
			Result < count
		end;

	coordinate (char_pos: INTEGER): COORD_XY is
			-- Coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		require
			exists: not destroyed;
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			Result := implementation.coordinate (char_pos)
		end;

	x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		require
			exists: not destroyed;
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			Result := implementation.x_coordinate (char_pos)
		end;
 
	y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		require
			exists: not destroyed;
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			Result := implementation.y_coordinate (char_pos)
		end;
 
	character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		require
			exists: not destroyed
		do
			Result := implementation.character_position (x_pos, y_pos)
		end;

	top_character_position: INTEGER is
			-- Character position of first character displayed
		require
			exists: not destroyed
		do
			Result := implementation.top_character_position
		ensure
			valid_result: Result >= 0 and then Result <= count
		end;
 
	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		require
			exists: not destroyed
		do
			Result := implementation.cursor_position
		ensure
			Result >= 0;
			Result <= count
		end;

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		require
			exists: not destroyed;
			selection_active: is_selection_active;
			realized: realized
		do
			Result := implementation.end_of_selection
		ensure
			Result > 0;
			Result <= count
		end;

feature -- Element change

	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed before
			-- text is deleted from or inserted in current text widget.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_modify_action (a_command, argument)
		end;

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed before insert
			-- cursor is moved to a new position.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			exists: not destroyed;
			Valid_command: a_command /= Void
		do
			implementation.add_motion_action (a_command, argument)
		end;

feature -- Removal

	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed before
			-- text is deleted from or inserted in current text widget.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_modify_action (a_command, argument)
		end;

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed before
			-- insert cursor is moved to a new position.
		require
			exists: not destroyed;
			not_a_command_void: a_command /= Void
		do
			implementation.remove_motion_action (a_command, argument)
		end;

feature -- Status report

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		require
			exists: not destroyed;
			realized: realized
		do
			Result := implementation.is_selection_active
		end;


	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		require
			exists: not destroyed
		do
			Result := implementation.is_height_resizable
		end;

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		require
			exists: not destroyed
		do
			Result := implementation.is_width_resizable
		end;

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		require
			exists: not destroyed
		do
			Result := implementation.is_any_resizable 
		end;

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		require
			exists: not destroyed
		do
			Result := implementation.is_read_only
		end;

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		require
			exists: not destroyed
		do
			Result := implementation.is_word_wrap_mode
		end;

	is_bell_enabled: BOOLEAN is
			-- Is the bell enabled when an action is forbidden
		require
			exists: not destroyed
		do
			Result := implementation.is_bell_enabled
		end;

	is_multi_line_mode: BOOLEAN is
			-- Is Current editing a multiline text?
		require
			exists: not destroyed
		do
			Result := implementation.is_multi_line_mode
		end;

	is_cursor_position_visible: BOOLEAN is
			-- Is the insert cursor position marked
			-- by a blinking text cursor?
		require
			exists: not destroyed
		do
			Result := implementation.is_cursor_position_visible
		end;

feature -- Status setting

	disable_resize is
			-- Disable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		require
			exists: not destroyed
		do
			implementation.disable_resize
		end;
 
	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		require
			exists: not destroyed
		do
			implementation.disable_resize_height
		end;
 
	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		require
			exists: not destroyed
		do
			implementation.disable_resize_width
		end;

 	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		require
			exists: not destroyed
		do
			implementation.enable_resize
		end;
 
	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		require
			exists: not destroyed
		do
			implementation.enable_resize_height
		end;
 
	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		require
			exists: not destroyed
		do
			implementation.enable_resize_width
		end;

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		require
			exists: not destroyed
		do
			implementation.allow_action
		end;

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		require
			exists: not destroyed
		do
			implementation.forbid_action
		end;

	set_read_only is
			-- Set current text to be read only.
		require
			exists: not destroyed
		do
			implementation.set_read_only
		end;

	set_editable is
			-- Set current text to be editable.
		require
			exists: not destroyed
		do
			implementation.set_editable
		end;

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		require
			exists: not destroyed
		do
			implementation.disable_verify_bell
		end;

	enable_verify_bell is
			-- Enable the bell when an action is forbidden
		require
			exists: not destroyed
		do
			implementation.enable_verify_bell
		end;

	set_single_line_mode is
			-- Set editing for single line text.
		require
			exists: not destroyed
		do
			implementation.set_single_line_mode
		ensure
			is_single_line_mode: not is_multi_line_mode
		end;

	set_multi_line_mode is
			-- Set editing for multiline text.
		require
			exists: not destroyed
		do
			implementation.set_multi_line_mode
		ensure
			is_multi_line_mode: is_multi_line_mode
		end;

feature -- Measurement

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		require
			exists: not destroyed
		do
			Result := implementation.margin_height
		end;

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		require
			exists: not destroyed
		do
			Result := implementation.margin_width
		end;

	rows: INTEGER is
			-- Height of Current widget measured in character
			-- heights. 
		require
			exists: not destroyed;
			is_multi_line_mode: is_multi_line_mode
		do
			Result := implementation.rows
		end;

feature -- Basic operations

	clear_selection is
			-- Clear a selection
		require
			exists: not destroyed;
			selection_active: is_selection_active;
			realized: realized
		do
			implementation.clear_selection
		ensure
			not is_selection_active
		end;

	set_selection (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require
			exists: not destroyed;
			first_positive_not_null: first >= 0;
			last_fewer_than_count: last <= count;
			first_fewer_than_last: first <= last;
			realized: realized
		do
			implementation.set_selection (first, last)
		ensure
			is_selection_active;
			begin_of_selection = first;
			end_of_selection = last
		end

	set_top_character_position (char_pos: INTEGER) is
			-- Set first character displayed to `char_pos'.
		require
			exists: not destroyed;
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			implementation.set_top_character_position (char_pos)
		ensure
			valid_position: top_character_position = char_pos
		end;
 
	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require
			exists: not destroyed;
			a_position_positive_not_null: a_position >= 0;
			a_position_fewer_than_count: a_position <= count
		do
			implementation.set_cursor_position (a_position)
		ensure
			cursor_position = a_position
		end;

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		require
			exists: not destroyed;
			new_height_large_enough: new_height >= 0
		do
			implementation.set_margin_height (new_height)
		end;

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		require
			exists: not destroyed;
			new_width_large_enough: new_width >= 0
		do
			implementation.set_margin_width (new_width)
		end;

	find (text_to_find: STRING; match_case: BOOLEAN; start_from: INTEGER): INTEGER is
			-- Search for the string `text_to_find' in the TEXT
			-- Return the position of the first occurrence
		require
			text_to_find_not_void: text_to_find /= Void
		do
			Result := implementation.find (text_to_find, match_case, start_from)
		end

feature -- Text mode

	set_rows (i: INTEGER) is
			-- Set the character height of Current widget to `i'.
		require
			exists: not destroyed;
			is_multi_line_mode: is_multi_line_mode;
			valid_i: i > 0
		do
			implementation.set_rows (i)
		end;

	set_cursor_position_visible (flag: BOOLEAN) is
			-- Set is_cursor_position_visible to flag.
		require
			exists: not destroyed
		do
			implementation.set_cursor_position_visible (flag)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: TEXT_I;
			-- Implementation of current text
	
end -- class TEXT



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

