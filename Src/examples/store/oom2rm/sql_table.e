indexing

	description:
		"An abstract representation of a SQL table with %
		%a set of fields.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SQL_TABLE inherit

	LINKED_LIST [SQL_COLUMN]
		rename 
			make as linked_list_make
		end;

create

	make, make_prefix

feature

	name: STRING;
			-- Table name.

	make (a_name: STRING) is
			-- Make a table named `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			linked_list_make;
			name := a_name
		ensure
			name = a_name
		end;

	make_prefix (a_name: STRING; a_prefix: STRING) is
			-- Make a table named `a_name' with `a_prefix'.
		require
			a_name_not_void: a_name /= Void;
			a_prefix_not_void: a_prefix /= Void
		do
			make (a_name);
			a_name.insert ("_", 1);
			a_name.insert (a_prefix, 1)
		end;

	print_result (output: FILE) is
			-- Print result on `output'.
		require
			output_not_void: output /= Void
		do
			from
	 			output.putstring ("create table ");
				output.putstring (name);
				output.putstring (" (");
				start
			until
				after
			loop
				item.print_result (output);
				forth;
				if not after then
					output.putstring (", ")
				end;
			end;
			output.putchar (')')
		ensure
			is_after: after
		end;

invariant

	name_not_void: name /= Void

end -- class SQL_TABLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
