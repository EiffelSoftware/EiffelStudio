
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TEXT_FIELD_M 

inherit

	TEXT_FIELD_I;

	PRIMITIVE_M
		rename
			clean_up as primitive_clean_up
		export
			{NONE} all
		end;

	PRIMITIVE_M
		export
			{NONE} all
		redefine
			clean_up
		select
			clean_up
		end;

	TEXT_FIELD_R_M
		export
			{NONE} all
		end;

	FONTABLE_M
		rename
			resource_name as MfontList
		export
			{NONE} all
		end

creation

	make

feature {NONE} -- Creation

	make (a_text_field: TEXT_FIELD; man: BOOLEAN) is
			-- Create a motif text_field.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_text_field.identifier.to_c;
			screen_object := create_text_field ($ext_name,
					parent_screen_object (a_text_field, widget_index),
					man);
			a_text_field.set_font_imp (Current)
		end;

feature -- Callbacks

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			if (activate_actions = Void) then
				!!activate_actions.make (screen_object, Mactivate, widget_oui)
			end;
			activate_actions.add (a_command, argument)
		end;
 
	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		do
			activate_actions.remove (a_command, argument)
		end;

feature {NONE}

	activate_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when
			-- an activate event occurs

	clean_up is
		do
			primitive_clean_up;
			if activate_actions /= Void then
				activate_actions.free_cdfd
			end;
		end

feature 

	append (a_text: STRING) is
			-- Append `a_text' at the end of current text.
		require else
			not_a_text_void: not (a_text = Void)
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_field_append (screen_object, $ext_name)
		end;

	clear is
			-- Clear current text field.
		local
			a_null_string: STRING;
			ext_name: ANY
		do
			a_null_string := "";
			ext_name := a_null_string.to_c;
			xm_text_field_set_string (screen_object, $ext_name)
		end;

	count: INTEGER is
			-- Number of character in current text field
		do
			Result := xm_text_field_count (screen_object)
		ensure then
			Result >= 0
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
			xm_text_field_insert (screen_object, a_position,
						$ext_name)
		ensure then
--			count = (old count) + a_text.count;
			a_text.count > 0 implies a_text.is_equal (text.substring
					(a_position+1, a_position+a_text.count))
		end;

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		do
			Result := xm_text_field_get_max_length (screen_object)
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
			xm_text_field_replace (screen_object, from_position, to_position, $ext_name)
		ensure then
--			count = (old count) + a_text.count + to_position - from_position;
			a_text.count > 0 implies a_text.is_equal
				(text.substring (from_position+1, from_position+a_text.count))
		end;

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require else
			not_negative_maximum: not (a_max < 0)
		do
			xm_text_field_set_max_length (screen_object, a_max)
		end;

	set_text (a_text: STRING) is
			-- Set text text to `a_text'.
		require else
			not_a_text_void: not (a_text = Void)
		local
			ext_name: ANY
		do
			ext_name := a_text.to_c;
			xm_text_field_set_string (screen_object, $ext_name)
		end;

	text: STRING is
			-- Value of current text field
		do
			Result := xm_text_field_value (screen_object)
		ensure then
			Result.count = count
		end

feature {NONE} -- External features

	xm_text_field_append (scr_obj: POINTER; name: ANY) is
		external
			"C"
		end;

	xm_text_field_value (scr_obj: POINTER): STRING is
		external
			"C"
		end;

	xm_text_field_set_max_length (scr_obj: POINTER; value: INTEGER) is
		external
			"C"
		end;

	xm_text_field_replace (scr_obj: POINTER; from_pos, to_pos: INTEGER; t_name: ANY) is
		external
			"C"
		end;

	xm_text_field_get_max_length (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_field_insert (scr_obj: POINTER; position: INTEGER; name: ANY) is
		external
			"C"
		end;

	create_text_field (t_name: ANY; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
		external
			"C"
		end;

	xm_text_field_count (scr_obj: POINTER): INTEGER is
		external
			"C"
		end;

	xm_text_field_set_string (scr_obj: POINTER; t_name: ANY) is
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
