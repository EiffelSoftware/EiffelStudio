
-- A text editor for one line of text.
-- The position in the text are not the characters but the space between
-- the characters: the first position is null and located before the text,
-- the position `i' is located after the `i'-th character of text.
-- When the text is empty, the only valid position is null.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TEXT_FIELD 

inherit

	FONTABLE
		rename
			implementation as font_implementation
		end;

	PRIMITIVE
		redefine
			implementation, is_fontable
		end

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a text field with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			Valid_name: a_name /= Void;
			Valid_parent: a_parent /= Void
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.text_field (Current);
			set_default
		ensure
			Parent_set: parent = a_parent;
			Identifier_set: identifier.is_equal (a_name)
		end;

feature -- Text size

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed when 
			-- an activate event occurs. 
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			Valid_command: a_command /= Void
		do
			implementation.add_activate_action (a_command, argument)
		end; -- add_modify_action

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to be executed 
			-- when an activate event occurs.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_activate_action (a_command, argument)
		end; -- remove_modify_action

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		do
			Result := implementation.maximum_size
		end; 

	count: INTEGER is
			-- Number of character in current text field
		do
			Result := implementation.count
		ensure
			Result >= 0
		end;

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require
			not_negative_maximum: a_max >= 0
		do
			implementation.set_maximum_size (a_max)
		end; 

feature -- Text manipulation

	text: STRING is
			-- Value of current text field
		do
			Result := implementation.text
		ensure
			Result.count = count
		end;

	append (a_text: STRING) is
			-- Append `a_text' at the end of current text.
		require
			not_a_text_void: not (a_text = Void)
		do
			implementation.append (a_text)
		end;

	clear is
			-- Clear current text field.
		do
			implementation.clear
		end;

	insert (a_text: STRING; a_position: INTEGER) is
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
		require
			not_a_text_void: not (a_text = Void);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		do
			implementation.insert (a_text, a_position)
		ensure
--			count = (old count) + a_text.count;
			a_text.count > 0 implies a_text.is_equal (text.substring
					(a_position + 1, a_position + a_text.count))
		end;


	replace (from_position, to_position: INTEGER; a_text: STRING) is
			-- Replace text from `from_position' to `to_position' by `a_text'.
		require
			not_text_void: not (a_text = Void);
			from_position_smaller_th_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		do
			implementation.replace (from_position, to_position, a_text)
		ensure
--			count = (old count) + a_text.count + to_position - from_position;
			a_text.count > 0 implies a_text.is_equal (text.substring
					(from_position + 1, from_position + a_text.count))
		end;

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			not_a_text_void: not (a_text = Void)
		do
			implementation.set_text (a_text)
		end; 

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TEXT_FIELD_I;
			-- Implementation of current text field

feature {G_ANY, G_ANY_I, WIDGET_I}

	is_fontable: BOOLEAN is true;
			-- Is current widget an heir of FONTABLE ?

feature {NONE}

	set_default is
			-- Set default text to current text field.
		do
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
