indexing

	description: "Nested queries example."
	product: "EiffelStore"
	database: "Oracle"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class TEST_I inherit

	TEST

create

	make

feature

	select_string: STRING is
		once
			Result := 
			"select TABLE_NAME from USER_TABLES"
		end

end -- class TEST_I


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

