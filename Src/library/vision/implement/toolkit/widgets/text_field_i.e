indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	TEXT_FIELD_I 

inherit

	PRIMITIVE_I;

	FONTABLE_I

feature -- Access

	text: STRING is
			-- Value of current text field
		deferred
		ensure
			valid_count: Result.count = count
		end

feature -- Measurement

	count: INTEGER is
			-- Number of character in current text field
		deferred
		ensure
			positive_result: Result >= 0
		end;

	maximum_size: INTEGER is
			-- Maximum number of characters in current
			-- text field
		deferred
		end;

feature -- Status setting

	clear is
			-- Clear current text field.
		deferred
		end;

feature -- Element change

	add_activate_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	append (a_text: STRING) is
			-- Append `a_text' at the end of current text.
		require
			not_a_text_void: a_text /= Void
		deferred
		end;

	insert (a_text: STRING; a_position: INTEGER) is
			-- Insert `a_text' in current text field at `a_position'.
			-- Same as `replace (a_position, a_position, a_text)'.
		require
			not_a_text_void: a_text /= Void
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= count
		deferred
		ensure
			valid: a_text.count > 0 implies a_text.is_equal (text.substring (a_position						+ 1, a_position + a_text.count))
		end;

	replace (from_position, to_position: INTEGER; a_text: STRING) is
			-- Replace text from `from_position' to `to_position' by `a_text'.
		require
			not_text_void: a_text /= Void
			from_position_smaller_than_to_position: from_position <= to_position;
			from_position_large_enough: from_position >= 0;
			to_position_small_enough: to_position <= count
		deferred
		ensure
			valid: a_text.count > 0 implies a_text.is_equal (text.substring (from_position+1, from_position+a_text.count))
		end;

	set_maximum_size (a_max: INTEGER) is
			-- Set maximum_size to `a_max'.
		require
			not_negative_maximum: a_max >= 0
		deferred
		end;

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			not_a_text_void: a_text /= Void
		deferred
		end;

feature -- Removal

	remove_activate_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' to the list of action to be executed
			-- when an acitvate event occurs
		require
			not_a_command_void: a_command /= Void
		deferred
		end; 

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TEXT_FIELD_I

