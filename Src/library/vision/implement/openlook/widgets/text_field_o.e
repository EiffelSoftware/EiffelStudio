--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TEXT_FIELD_O 

inherit

	TEXT_FIELD_I;

	TEXT_FIELD_R_O
		export
			{NONE} all
		end;

	PRIMITIVE_O
		export
			{NONE} all
		end;

	FONTABLE_O
		rename
			resource_name as OfontList
		
		export
			{NONE} all
		end

creation

	make

feature 

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			if (activate_actions = Void) then
				!!activate_actions.make (action_target, Overification, widget_oui)
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
			set_text("")
		end;

	count: INTEGER is
			-- Number of character in current text field
		do
			Result := text.count
		ensure then
			Result >= 0
		end;

	make (a_text_field: TEXT_FIELD) is
			-- Create a openlook text_field.
		
		local
			ext_name: ANY;
		do
			ext_name := a_text_field.identifier.to_c;		
			screen_object := create_text_field ($ext_name, a_text_field.parent.implementation.screen_object);
			a_text_field.set_font_imp (Current)
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

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		
		do
			Result := xt_int (screen_object, OmaxLength)
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

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require else
			not_negative_maximum: not (a_max < 0)
		
		local
			ext_name: ANY;
		do
			ext_name := OmaxLength.to_c;		
			set_int (screen_object, a_max, $ext_name)
		end;

	set_text (a_text: STRING) is
			-- Set text text to `a_text'.
		require else
			not_a_text_void: not (a_text = Void)
		
		local
			ext_name, ext_text: ANY;
		do
			ext_name := Ostring.to_c;
			ext_text := a_text.to_c;
			set_string (screen_object, $ext_text, $ext_name)
		end;

	text: STRING is
			-- Value of current text field
		
		local
			ext_name: ANY;
		do
			ext_name := Ostring.to_c;		
			Result := get_string (screen_object, $ext_name)
		ensure then
			Result.count = count
		end

feature {NONE} -- External features

	create_text_field (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 

