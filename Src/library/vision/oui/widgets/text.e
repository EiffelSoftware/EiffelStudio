
-- 

indexing

	date: "$Date$";
	revision: "$Revision$"

class TEXT 

inherit

	TEXT_FIELD
		redefine
			make, make_unmanaged, create_ev_widget,
			implementation
		end

creation

	make, make_word_wrapped, make_unmanaged, make_word_wrapped_unmanaged
	
feature {NONE} -- Creation

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
			implementation := toolkit.text (Current, man);
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
			implementation := toolkit.text_word_wrapped (Current, man);
			set_default
		end;

feature -- Callbacks (adding)

	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed before
			-- text is deleted from or inserted in current text widget.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_modify_action (a_command, argument)
		end; -- add_modify_action

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed before insert
			-- cursor is moved to a new position.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_motion_action (a_command, argument)
		end; -- add_motion_action

feature -- Callbacks (removing)

	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed before
			-- text is deleted from or inserted in current text widget.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_modify_action (a_command, argument)
		end; -- remove_modify_action

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed before
			-- insert cursor is moved to a new position.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_motion_action (a_command, argument)
		end; -- remove_motion_action


feature -- Text selection

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current selection highlightened
		require
			selection_active: is_selection_active;
			realized: realized
		do
			Result := implementation.begin_of_selection
		ensure
			Result >= 0;
			Result < count
		end; -- begin_of_selection

	clear_selection is
			-- Clear a selection
		require
			selection_active: is_selection_active;
			realized: realized
		do
			implementation.clear_selection
		ensure
			not is_selection_active
		end; -- clear_selection

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		require
			realized: realized
		do
			Result := implementation.is_selection_active
		end; -- is_selection_active

	set_selection (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require
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
		end -- set_selection

	x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		require
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			Result := implementation.x_coordinate (char_pos)
		end;
 
	y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		require
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			Result := implementation.y_coordinate (char_pos)
		end;
 
	character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		do
			Result := implementation.character_position (x_pos, y_pos)
		end;

	top_character_position: INTEGER is
			-- Character position of first character displayed
		do
			Result := implementation.top_character_position
		ensure
			valid_result: Result >= 0 and then Result <= count
		end;
 
	set_top_character_position (char_pos: INTEGER) is
			-- Set first character displayed to `char_pos'.
		require
			valid_position: char_pos >= 0 and then char_pos <= count
		do
			implementation.set_top_character_position (char_pos)
		ensure
			valid_position: top_character_position = char_pos
		end;
 
feature -- Text cursor position

	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		do
			Result := implementation.cursor_position
		ensure
			Result >= 0;
			Result <= count
		end; -- cursor_position

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		require
			selection_active: is_selection_active;
			realized: realized
		do
			Result := implementation.end_of_selection
		ensure
			Result > 0;
			Result <= count
		end; -- end_of_selection

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require
			a_position_positive_not_null: a_position >= 0;
			a_position_fewer_than_count: a_position <= count
		do
			implementation.set_cursor_position (a_position)
		ensure
			cursor_position = a_position
		end; -- set_cursor_position

feature -- Text margin

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		do
			Result := implementation.margin_height
		end; -- margin_height

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		do
			Result := implementation.margin_width
		end; -- margin_width

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		require
			new_height_large_enough: new_height >= 0
		do
			implementation.set_margin_height (new_height)
		end; -- set_margin_height

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		require
			new_width_large_enough: new_width >= 0
		do
			implementation.set_margin_width (new_width)
		end; -- set_margin_width

feature -- Text mode

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		do
			Result := implementation.is_read_only
		end; -- is_read_only

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		do
			Result := implementation.is_word_wrap_mode
		end; -- is_word_wrap_mode

	is_bell_enabled: BOOLEAN is
			-- Is the bell enabled when an action is forbidden
		do
			Result := implementation.is_bell_enabled
		end;

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		do
			implementation.allow_action
		end; -- allow_action

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		do
			implementation.forbid_action
		end; -- forbid_action

	set_read_only is
			-- Set current text to be read only.
		do
			implementation.set_read_only
		end; -- set_read_only

	set_editable is
			-- Set current text to be editable.
		do
			implementation.set_editable
		end; -- set_editable

	disable_word_wrap is
				obsolete "Use ``make'' instead (cannot be called after creation)"
			-- Specify that lines are free to go off the right edge
			-- of the window.
		do
		end; -- disable_word_wrap

	enable_word_wrap is
			-- Specify that lines are to be broken at word breaks.
			-- The text does not go off the right edge of the window.
				obsolete "Use ``make_with_word_wrap'' instead  (cannot be called after creation)"
		do
		end; -- disable_word_wrap

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		do
			implementation.disable_verify_bell
		end;

	enable_verify_bell is
			-- Enable the bell when an action is forbidden
		do
			implementation.enable_verify_bell
		end;

	rows: INTEGER is
			-- Height of Current widget measured in character
			-- heights. 
		require
			is_multi_line_mode: is_multi_line_mode
		do
			Result := implementation.rows
		end;

	set_rows (i: INTEGER) is
			-- Set the character height of Current widget to `i'.
		require
			is_multi_line_mode: is_multi_line_mode;
			valid_i: i > 0
		do
			implementation.set_rows (i)
		end;

	set_single_line_mode is
			-- Set editing for single line text.
		do
			implementation.set_single_line_mode
		ensure
			is_single_line_mode: not is_multi_line_mode
		end;

	set_multi_line_mode is
			-- Set editing for multiline text.
		do
			implementation.set_multi_line_mode
		ensure
			is_multi_line_mode: is_multi_line_mode
		end;

	is_multi_line_mode: BOOLEAN is
			-- Is Current editing a multiline text?
		do
			Result := implementation.is_multi_line_mode
		end;

	is_cursor_position_visible: BOOLEAN is
			-- Is the insert cursor position marked
			-- by a blinking text cursor?
		do
			Result := implementation.is_cursor_position_visible
		end;

	set_cursor_position_visible (flag: BOOLEAN) is
			-- Set is_cursor_position_visible to flag.
		do
			implementation.set_cursor_position_visible (flag)
		end;

feature -- Resize policies

	disable_resize is
			-- Disable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			implementation.disable_resize
		end; -- disable_resize
 
	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		do
			implementation.disable_resize_height
		end; -- disable_resize_height
 
	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		do
			implementation.disable_resize_width
		end; -- disable_resize_width

 	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			implementation.enable_resize
		end; -- enable_resize
 
	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		do
			implementation.enable_resize_height
		end; -- enable_resize_height
 
	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		do
			implementation.enable_resize_width
		end; -- enable_resize_width

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		do
			Result := implementation.is_height_resizable
		end; -- is_height_resizable

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		do
			Result := implementation.is_width_resizable
		end; -- is_width_resizable

	is_any_resizable: BOOLEAN is
            -- Is width and height of current text resizable?
        do
			Result := implementation.is_any_resizable 
        end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TEXT_I;
			-- Implementation of current text
	
end -- class TEXT


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
