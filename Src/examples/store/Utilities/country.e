indexing

        date: "$Date$";
        revision: "$Revision$";
	author: "Patrice Khawam"

class COUNTRY

creation

	make

feature

	c_no: INTEGER;

	c_name: STRING

	make (no: like c_no; name: like c_name) is
		require
			name_not_void: name /= Void
		do
			c_no := no;
			c_name := name
		ensure
			c_no = no;
			c_name = name
		end

end -- class COUNTRY


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
