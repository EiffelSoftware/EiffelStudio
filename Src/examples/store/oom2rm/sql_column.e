indexing

	description:
		"An abstract representation of a SQL column.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SQL_COLUMN

creation

	make

feature

	name: STRING;
			-- Column name.

	type: STRING;
			-- Column type.

	make (a_name, a_type: STRING) is
			-- Make a new column named `a_name' of type `a_type'.
		require
			a_name_not_void: a_name /= Void;
			a_type_not_void: a_type /= Void
		do
			name := a_name;
			type := a_type
		ensure
			name = a_name;
			type = a_type
		end;

	print_result (output: FILE) is
			-- Print result on `output'.
		require
			output_not_void: output /= Void
		do
			output.putstring (name);
			output.putchar (' ');
			output.putstring (type)
		end;

invariant
	
	name_not_void: name /= Void;
	type_not_void: type /= Void

end -- class SQL_COLUMN


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
