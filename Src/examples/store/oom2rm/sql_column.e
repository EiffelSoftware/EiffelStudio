indexing

	description:
		"An abstract representation of a SQL column.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SQL_COLUMN

create

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
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
