indexing

        date: "$Date$";
        revision: "$Revision$";
	author: "Patrice Khawam"

class COUNTRY

create

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
