
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TEXT_M

inherit

	TEXT_I;

	PRIMITIVE_M
		rename
			clean_up as primitive_clean_up
		export
			{NONE} all;
			{ANY} realized
		end;

	PRIMITIVE_M
		export
			{NONE} all;
			{ANY} realized
		redefine
			clean_up
		select
			clean_up
		end;

	TEXT_R_M
		export
			{NONE} all
		end;

	TEXT_FIELD_R_M
		export
			{NONE} all
		end;

	READ_ACT_R_M
		export
			{NONE} all
		end;

	FONTABLE_M
		rename
			resource_name as MfontList,
			screen_object as action_target
		end

creation

	make

feature -- Creation

	make (a_text: TEXT) is
			-- Create a motif text.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_text.identifier.to_c;
			screen_object := create_text ($ext_name,
					parent_screen_object (a_text, widget_index));
			a_text.set_font_imp (Current)
		end;

feature 

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			if (activate_actions = Void) then
				!!activate_actions.make (action_target, Mactivate, widget_oui)
			end;
			activate_actions.add (a_command, argument)
		end;
 
	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			activate_actions.remove (a_command, argument)
		end;
 
	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (modify_actions = Void) then
				!! modify_actions.make (action_target, MmodifyVerify, widget_oui)
			end;
			modify_actions.add (a_command, argument)
		end;

	add_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before insert
			-- cursor is moved to a new position.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (motion_actions = Void) then
				!! motion_actions.make (action_target, MmotionVerify, widget_oui)
			end;
			motion_actions.add (a_command, argument)
		end;

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		require else
			must_be_in_verification_action: is_in_a_verification_callback
		do
			c_set_do_it (1)
		end;

	append (a_text: STRING) is
			-- Append `a_text' at the end of current text.
		require else
			not_a_text_void: not (a_text = Void)
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_append (action_target, $ext_name)
		end;

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current selection highlightened
		require else
			selection_active: is_selection_active;
			realized: realized
		do
			Result := xm_get_begin_of_selection (action_target)
		ensure then
			Result >= 0;
			Result < count
		end;

	clear is
			-- Clear current text field.
		local
			a_null_string: STRING;
			ext_name: ANY
		do
			a_null_string := "";
			ext_name := a_null_string.to_c;
			xm_text_set_string (action_target, $ext_name)
		end;

	clear_selection is
			-- Clear a selection
		require else
			selection_active: is_selection_active;
			realized: realized
		do
			xm_text_clear_selection (action_target, c_current_time)
		ensure then
			not is_selection_active
		end;

	count: INTEGER is
			-- Number of character in current text field
		do
			Result := xm_text_count (action_target)
		ensure then
			Result >= 0
		end;

	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		do
			Result := xm_text_cursor_position (action_target)
		ensure then
			Result >= 0;
			Result <= count
		end;

	disable_word_wrap is
			-- Specify that lines are free to go off the right edge
			-- of the window.
		do
			set_xt_boolean (action_target, False, MwordWrap)
		end;

	enable_word_wrap is
			-- Specify that lines are to be broken at word breaks.
			-- The text does not go off the right edge of the window.
		do
			set_xt_boolean (action_target, True, MwordWrap)
		end;

	disable_verify_bell is
			-- Disable the bell when an action is forbidden
		do
			set_xt_boolean (action_target, False, MverifyBell)
		end;

	enable_verify_bell is
			-- enable the bell when an action is forbidden
		do
			set_xt_boolean (action_target, True, MverifyBell)
		end;

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		require else
			selection_active: is_selection_active;
			realized: realized
		do
			Result := xm_get_end_of_selection (action_target)
		ensure then
			Result > 0;
			Result <= count
		end;

feature 

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		require else
			must_be_in_verification_action: is_in_a_verification_callback
		do
			c_set_do_it (0)
		end;

	insert (a_text: STRING; a_position: INTEGER) is
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
		require else
			not_a_text_void: not (a_text = Void);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_insert (action_target, a_position, $ext_name)
		ensure then
--			count = (old count) + a_text.count;
			a_text.count > 0 implies a_text.is_equal (text.substring (a_position+1, a_position+a_text.count))
		end;

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		do
			Result := is_width_resizable and then is_height_resizable
		end;

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		do
			Result := xt_boolean (action_target, MresizeHeight)
		end;

feature 

	is_in_a_verification_callback: BOOLEAN is
			-- Is the program in a `motion' or `modify' action ?
		do
			Result := (c_reason = MovingInsertCursor) or (c_reason = ModifyingTextValue)
		end;

feature 

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		do
			Result := not (xt_boolean (action_target, Meditable))
		end;

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		require else
			realized: realized
		do
			Result := xm_is_selection_active (action_target)
		end;

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		do
			Result := xt_boolean (action_target, MresizeWidth)
		end;

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		do
			Result := xt_boolean (action_target, MwordWrap)
		end;

	is_bell_enabled: BOOLEAN is
			-- Is the bell enabled when an action is forbidden
		do
			Result := xt_boolean (action_target, MverifyBell)
		end;

feature {NONE}

	activate_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when
			-- an activate event occurs
 
	modify_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs before text is deleted
			-- from or inserted in current text widget.

	motion_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs before insert cursor is
			-- moved to a new position

	clean_up is
		do
			primitive_clean_up;
			if activate_actions /= Void then
				activate_actions.free_cdfd
			end;
			if modify_actions /= Void then
				modify_actions.free_cdfd
			end;
			if motion_actions /= Void then
				motion_actions.free_cdfd
			end;
		end

feature 

	remove_modify_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require else
			not_a_command_void: not (a_command = Void)
		do
			modify_actions.remove (a_command, argument)
		end;

	remove_motion_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute before
			-- insert cursor is moved to a new position.
		require else
			not_a_command_void: not (a_command = Void)
		do
			motion_actions.remove (a_command, argument)
		end;

	replace (from_position, to_position: INTEGER; a_text: STRING) is
			-- Replace text from `from_position' to `to_position' by `a_text'.
		require else
			not_text_void: not (a_text = Void);
			from_position_smaller_than_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_replace (action_target, from_position, to_position,
						$ext_name)
		ensure then
--			count = (old count) + a_text.count + to_position - from_position;
			a_text.count > 0 implies a_text.is_equal
				(text.substring (from_position+1, from_position+a_text.count))
		end;

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require else
			a_position_positive_not_null: a_position >= 0;
			a_position_fewer_than_count: a_position <= count
		do
			xm_set_text_cursor_pos (action_target, a_position)
		ensure then
			cursor_position = a_position
		end;

	set_editable is
			-- Set current text to be editable.
		do
			set_xt_boolean (action_target, True, Meditable)
		end;

	set_read_only is
			-- Set current text to be read only.
		do
			set_xt_boolean (action_target, False, Meditable)
		end;

	set_selection (first, last: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require else
			first_positive_not_null: first >= 0;
			last_fewer_than_count: last <= count;
			first_fewer_than_last: first <= last;
			realized: realized
		do
			xm_set_selection (action_target, first, last)
		ensure then
			is_selection_active;
			begin_of_selection = first;
			end_of_selection = last
		end;

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require else
			not_a_text_void: not (a_text = Void)
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_set_string (action_target, $ext_name)
		end;

	text: STRING is
			-- Value of current text field
		do
			Result := xm_text_value (action_target)
		ensure then
			Result.count = count
		end;

	disable_resize is
			-- Disable that current text widget attempts to resize its width an
			-- height to accommodate all the text contained.
		do
			set_xt_boolean (action_target, False, MresizeHeight);
			set_xt_boolean (action_target, False, MresizeWidth)
		end;

	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		do
			set_xt_boolean (action_target, False, MresizeHeight)
		end;

	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		do
			set_xt_boolean (action_target, False, MresizeWidth)
		end;

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			set_xt_boolean (action_target, True, MresizeWidth);
			set_xt_boolean (action_target, True, MresizeHeight)
		end;

	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		do
			set_xt_boolean (action_target, True, MresizeHeight)
		end;

	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		do
			set_xt_boolean (action_target, True, MresizeWidth)
		end;

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		do
			Result := xt_dimension (action_target, MmarginHeight)
		end;

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		do
			Result := xt_dimension (action_target, MmarginWidth)
		end;

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		do
			Result := xm_text_length (action_target)
		end;

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		require else
			new_height_large_enough: new_height >= 0
		do
			set_xt_dimension (action_target, new_height, MmarginHeight)
		end;

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		require else
			new_width_large_enough: new_width >= 0
		do
			set_xt_dimension (action_target, new_width, MmarginWidth)
		end;

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require else
			not_negative_maximum: not (a_max < 0)
		do
			xm_text_set_length (action_target, a_max)
		end;

feature -- Cursor position

    x_coordinate (char_pos: INTEGER): INTEGER is
            -- X coordinate relative to the upper left corner
            -- of Current text widget at character position `char_pos'.
        do
			Result := xm_text_x_coord (action_target, char_pos)
        end;

    y_coordinate (char_pos: INTEGER): INTEGER is
            -- Y coordinate relative to the upper left corner
            -- of Current text widget at character position `char_pos'.
        do
			Result := xm_text_y_coord (action_target, char_pos)
        end;

    character_position (x_pos, y_pos: INTEGER): INTEGER is
            -- Character position at cursor position `x' and `y'
        do
			Result := xm_text_cur_pos (action_target, x_pos, y_pos)
        end;

    top_character_position: INTEGER is
            -- Character position of first character displayed
        do
			Result := xm_text_top_char (action_target)
        end;

    set_top_character_position (char_pos: INTEGER) is
            -- Set first character displayed to `char_pos'.
        do
			xm_text_set_top_char (action_target, char_pos)
        end;

feature {NONE} -- External features

	c_set_do_it (value: INTEGER) is
		external
			"C"
		end;

	xm_text_value (scr_obj: POINTER): STRING is
		external
			"C"
		end;

	xm_set_selection (scr_obj: POINTER; first, last: INTEGER) is
		external
			"C"
		end;

	xm_set_text_cursor_pos (scr_obj: POINTER; position: INTEGER) is
		external
			"C"
		end;

	xm_text_replace (scr_obj: POINTER; from_pos, to_pos: INTEGER; name: ANY) is
		external
			"C"
		end;

	xm_is_selection_active (scr_obj: POINTER): BOOLEAN is
		external
			"C"
		end;

	c_reason: INTEGER is
		external
			"C"
		end;

	xm_text_insert (scr_obj: POINTER; position: INTEGER; name: ANY) is
		external
			"C"
		end;

	xm_get_end_of_selection (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_cursor_position (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_count (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	c_current_time: INTEGER is
		external
			"C"
		end;

	xm_text_clear_selection (scr_obj: POINTER; value: INTEGER) is
		external
			"C"
		end;

	xm_text_set_string (scr_obj: POINTER; name: ANY) is
		external
			"C"
		end;

	xm_get_begin_of_selection (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_append (scr_obj: POINTER; t_name: ANY) is
		external
			"C"
		end;

	create_text (t_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_text_length (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_set_length (scr_obj: POINTER; value: INTEGER) is
		external
			"C"
		end;

	xm_text_x_coord (scr_obj: POINTER; char_pos: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_text_y_coord (scr_obj: POINTER; char_pos: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_text_cur_pos (scr_obj: POINTER; x_pos, y_pos: INTEGER): INTEGER is
		external
			"C"
		end;

	xm_text_top_char (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_set_top_char (scr_obj: POINTER; char_pos: INTEGER) is
		external
			"C"
		end;

end

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
