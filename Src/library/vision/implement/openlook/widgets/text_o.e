--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TEXT_O 

inherit

	TEXT_R_O
		export
			{NONE} all
		end;

	TEXT_FIELD_R_O
		export
			{NONE} all
		end;

	TEXT_I;

	PRIMITIVE_O
		export
			{NONE} all
		end;	

	FONTABLE_O
		rename
			screen_object as action_target
		end

creation

	make
	
feature 

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			if (activate_actions = Void) then
				!!activate_actions.make (action_target, "",
widget_oui)
			end;
			activate_actions.add (a_command, argument)
		end;
 
	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			activate_actions.remove (a_command, argument)
		end;
 
	activate_actions: EVENT_HAND_O;
			-- An event handler to manage call-backs when
			-- an activate event occurs

	make (a_text: TEXT) is
			-- Create an openlook text.
		local
			ext_name: ANY;
		do
			ext_name := a_text.identifier.to_c;		
			screen_object := create_text ($ext_name, a_text.parent.implementation.screen_object);
			a_text.set_font_imp (Current)
		end;
	
	add_modify_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute before
			-- text is deleted from or inserted in current text widget.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (modify_actions = Void) then
				!!modify_actions.make (action_target, OmodifyVerify, widget_oui)
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
				!!motion_actions.make (action_target, OmotionVerify, widget_oui)
			end;
			motion_actions.add (a_command, argument)
		end;

	allow_action is
			-- Allow the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		require else
			must_be_in_verification_action: is_in_a_verification_callback
		
		do
			c_set_do_it (True)
		end;

	append (a_text: STRING) is
			-- Append `a_text' at the end of current text.
		require else
			not_a_text_void: not (a_text = Void)
		local
			new_text : STRING
		do
			new_text := text;
			new_text.append(a_text);
			set_text(new_text)
		end;

	clear is
			-- Clear current text field.
		do
			set_text ("")
		end;

	count: INTEGER is
			-- Number of character in current text field
		do
			Result := text.count
		ensure then
			Result >= 0
		end;

	insert (a_text: STRING; a_position: INTEGER) is
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
			-- FIXME : use insert in V3
		require else
			not_a_text_void: not (a_text = Void);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		local
			head : STRING;
			tail : STRING
		do
			head := text;
			tail := head.substring (a_position + 1, head.count);
			tail.prepend(a_text);
			head.tail (a_position);
			head.append(tail);
			set_text(head)				
		ensure then
			count = (old count) + a_text.count;
			a_text.count > 0 implies a_text.is_equal (text.substring (a_position+1, a_position+a_text.count))
		end;

	begin_of_selection: INTEGER is
			-- Position of the beginning of the current selection highlightened
		require else
--			selection_active: is_selection_active;
			realized: realized
		do
			Result := xt_int (action_target, OselectStart)
		ensure then
			Result >= 0;
			Result < count
		end;

	clear_selection is
			-- Clear a selection
		do
			set_xt_int (action_target, 0, OselectStart);
			set_xt_int (action_target, 0, OselectEnd);
		ensure then
			not is_selection_active
		end;

	cursor_position: INTEGER is
			-- Current position of the text cursor (it indicates the position
			-- where the next character pressed by the user will be inserted)
		do
			Result := xt_int (action_target, OcursorPosition)
		ensure then
			Result >= 0;
			Result <= count
		end;

	disable_resize is
			-- Disable that current text widget attempts to resize its width an
			-- height to accommodate all the text contained.
		do
			set_xt_int (action_target, OGROW_OFF, OgrowMode)
		end;

	disable_resize_height is
			-- Disable that current text widget attempts to resize its height
			-- to accommodate all the text contained.
		do
			if ((xt_int (action_target, OgrowMode)) = OGROW_HORIZONTAL) then
				set_xt_int (action_target, OGROW_OFF, OgrowMode);
				set_xt_int (action_target, OGROW_HORIZONTAL, OgrowMode);
			end
		end;

	disable_resize_width is
			-- Disable that current text widget attempts to resize its width
			-- to accommodate all the text contained.
		do
			if ((xt_int (action_target, OgrowMode)) = OGROW_VERTICAL) then
				set_xt_int (action_target, OGROW_OFF, OgrowMode);
				set_xt_int (action_target, OGROW_VERTICAL, OgrowMode);
			end
		end;

	disable_word_wrap is
			-- Specify that lines are free to go off the right edge
			-- of the window.
		do
			set_xt_boolean (action_target, False, OwordWrap)
		end;

	enable_resize is
			-- Enable that current text widget attempts to resize its width and
			-- height to accommodate all the text contained.
		do
			set_xt_int (action_target, OGROW_BOTH, OgrowMode)
		end;

	enable_resize_height is
			-- Enable that current text widget attempts to resize its height to
			-- accomodate all the text contained.
		do
			set_xt_int (action_target, OGROW_HORIZONTAL, OgrowMode);
		end;

	enable_resize_width is
			-- Enable that current text widget attempts to resize its width to
			-- accommodate all the text contained.
		do
			set_xt_int (action_target, OGROW_VERTICAL, OgrowMode);
		end;

	enable_word_wrap is
			-- Specify that lines are to be broken at word breaks.
			-- The text does not go off the right edge of the window.
		do
			set_xt_boolean (action_target, True, OwordWrap);
			set_xt_unsigned_char (action_target, OWRAP_WHITE_SPACE,OwrapMode);
		end; 

	end_of_selection: INTEGER is
			-- Position of the end of the current selection highlightened
		require else
--			selection_active: is_selection_active;
			realized: realized
		do
			Result := xt_int (action_target, OselectEnd)
		ensure then
			Result > 0;
			Result <= count
		end;

	replace (from_position: INTEGER; to_position: INTEGER; a_text: STRING) is
			-- Replace text from `from_position' to `to_position' by `a_text'.
		require else
			not_text_void: not (a_text = Void);
			from_position_smaller_than_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		local
			new_text : STRING
		do
			new_text := text;
			new_text.set (a_text, from_position, to_position);
			set_text (new_text)
		ensure then
			count = (old count) + a_text.count + to_position - from_position;
			a_text.count > 0 implies a_text.is_equal (text.substring (from_position+1, from_position+a_text.count))
		end;

	forbid_action is
			-- Forbid the cursor to move or the text to be modified
			-- during a `motion' or a `modify' action.
		require else
			must_be_in_verification_action: is_in_a_verification_callback
		
		do
			c_set_do_it (False)
		end; 

	is_height_resizable: BOOLEAN is
			-- Is height of current text resizable?
		do
			Result := (((xt_int (action_target, OgrowMode)) = OGROW_VERTICAL)
				or else ((xt_int (action_target, OgrowMode)) = OGROW_BOTH))
		end;

	
feature {NONE}

	is_in_a_verification_callback: BOOLEAN is
			-- Is the program in a `motion' or `modify' action ?
		do
		end;

feature 

	is_read_only: BOOLEAN is
			-- Is current text in read only mode?
		do
			Result := not (xt_boolean (action_target, Oeditable))
		end;

	is_selection_active: BOOLEAN is
			-- Is there a selection currently active ?
		require else
					realized: realized
		local
			sel_begin, sel_end, cursor_posit : INTEGER
		do
			sel_begin := begin_of_selection;
			sel_end := end_of_selection;
			cursor_posit := cursor_position;			
			Result := (sel_begin < sel_end) and ((cursor_posit = sel_begin) or (cursor_posit = sel_end))
		end;

	is_width_resizable: BOOLEAN is
			-- Is width of current text resizable?
		do
			Result := (((xt_int (action_target, OgrowMode)) = OGROW_HORIZONTAL)
					or ((xt_int (action_target, OgrowMode)) = OGROW_BOTH)) 
		end;

	is_word_wrap_mode: BOOLEAN is
			-- Is specified that lines are to be broken at word breaks?
		do
			Result := xt_boolean (action_target, OwordWrap)
		end;

	margin_height: INTEGER is
			-- Distance between top edge of text window and current text,
			-- and between bottom edge of text window and current text.
		do
			Result := xt_dimension (action_target, OtopMargin)
		end;

	margin_width: INTEGER is
			-- Distance between left edge of text window and current text,
			-- and between right edge of text window and current text.
		do
			Result := xt_dimension (action_target, OleftMargin)
		end; -- margin_width

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		do
			Result := xt_int (action_target, OcharsVisible)
		end;
	
feature {NONE}

	modify_actions: TEXT_MODIF_O;
			-- An event handler to manage call-backs before text is deleted
			-- from or inserted in current text widget.

	motion_actions: TEXT_MOTION_O;
			-- An event handler to manage call-backs before insert cursor is
			-- moved to a new position

	resource_name: STRING;

	
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

	set_cursor_position (a_position: INTEGER) is
			-- Set `cursor_position' to `a_position'.
		require else
			a_position_positive_not_null: a_position >= 0;
			a_position_fewer_than_count: a_position <= count
		do
			set_xt_int (action_target, a_position, OcursorPosition)
		ensure then
			cursor_position = a_position
		end;

	set_editable is
			-- Set current text to be editable.
		do
			set_xt_boolean (action_target, True, Oeditable)
		end;

	set_margin_height (new_height: INTEGER) is
			-- Set `margin_height' to `new_height'.
		require else
			new_height_large_enough: new_height >= 0
		do
			set_xt_dimension (action_target, new_height, OtopMargin);
			set_xt_dimension (action_target, new_height, ObottomMargin);
		end;

	set_margin_width (new_width: INTEGER) is
			-- Set `margin_width' to `new_width'.
		require else
			new_width_large_enough: new_width >= 0
		do
			set_xt_dimension (action_target, new_width, OleftMargin);
			set_xt_dimension (action_target, new_width, OrightMargin)
		end;

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require else
			not_negative_maximum: not (a_max < 0)
		do
		end;

	set_read_only is
			-- Set current text to be read only.
		do
			set_xt_boolean (action_target, False, Oeditable)
		end;

	set_selection (frst, lst: INTEGER) is
			-- Select the text between `first' and `last'.
			-- This text will be physically highlightened on the screen.
		require else
			first_positive_not_null: frst >= 0;
			last_fewer_than_count: lst <= count;
			first_fewer_than_last: frst <= lst;
				realized: realized
		do
			set_xt_int (action_target, frst, OselectStart);
			set_xt_int (action_target, lst, OselectEnd);
		ensure then
			is_selection_active;
			begin_of_selection = frst;
			end_of_selection = lst
		end;

	set_text (a_text: STRING) is
			-- Set text to `a_text'.
		require else
			not_a_text_void: not (a_text = Void)
		do
			set_cursor_position (0);
			set_xt_string (action_target, a_text , Osource)
		end; 

	text: STRING is
			-- Value of current text field
		
		do
			Result := get_text_buffer (action_target)
		ensure then
			Result.count = count
		end;

	is_any_resizable: BOOLEAN is
			-- Is width and height of current text resizable?
		do
			Result := is_width_resizable and then is_height_resizable 
		end;


feature {NONE} -- External features

	create_text (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

	c_set_do_it (flag: BOOLEAN) is
		external
			"C"
		alias
			"c_set_do_it"
		end;

	get_text_buffer (scr_obj: POINTER): STRING is
		external
			"C"
		alias
			"get_text_buffer"
		end;

end 
