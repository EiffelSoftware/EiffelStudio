--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class TEXT_FIELD_I 

inherit

	PRIMITIVE_I;

	FONTABLE_I

feature 
    add_activate_action (a_command: COMMAND; argument: ANY) is
            -- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
        require
            not_a_command_void: not (a_command = Void)
        deferred
		end;

    remove_activate_action (a_command: COMMAND; argument: ANY) is
            -- Remove `a_command' to the list of action to be executed
			-- when an acitvate event occurs
        require
            not_a_command_void: not (a_command = Void)
        deferred
        end; 

	append (a_text: STRING) is
			-- Append `a_text' at the end of current text.
		require
			not_a_text_void: not (a_text = Void)
		deferred
		end; -- append

	clear is
			-- Clear current text field.
		deferred
		end; -- clear

	count: INTEGER is
			-- Number of character in current text field
		deferred
		ensure
			Result >= 0
		end; -- count

	insert (a_text: STRING; a_position: INTEGER) is
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
		require
			not_a_text_void: not (a_text = Void);
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		deferred
		ensure
--			count = (old count) + a_text.count;
			a_text.count > 0 implies a_text.is_equal (text.substring (a_position						+ 1, a_position + a_text.count))
		end; -- insert

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		deferred
		end; -- maximum_size

	replace (from_position, to_position: INTEGER; a_text: STRING) is
			-- Replace text from `from_position' to `to_position' by `a_text'.
		require
			not_text_void: not (a_text = Void);
			from_position_smaller_than_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		deferred
		ensure
--			count = (old count) + a_text.count + to_position - from_position;
			a_text.count > 0 implies a_text.is_equal (text.substring (from_position+1, from_position+a_text.count))
		end; -- replace

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require
			not_negative_maximum: not (a_max < 0)
		deferred
		end; -- set_maximum_size

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			not_a_text_void: not (a_text = Void)
		deferred
		end; -- set_text

	text: STRING is
			-- Value of current text field
		deferred
		ensure
			Result.count = count
		end -- text

end -- class TEXT_FIELD_I
