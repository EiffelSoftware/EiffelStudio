indexing

	description:
		"Print SQL requests to create the relationnal model.";
	Status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_REQUEST

create

	make

feature

	make (tables: LINKED_LIST [SQL_TABLE]; output: FILE) is
			-- Print `tables' on `output'.
		require
			tables_not_void: tables /= Void;
			output_not_void: output /= Void
		do
			from
				tables.start
			until
				tables.after
			loop
				tables.item.print_result (output);
				output.new_line;
				tables.forth
			end;
		ensure
			tables_is_after: tables.after
		end;

end -- class PRINT_REQUEST


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
