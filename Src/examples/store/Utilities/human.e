indexing

        date: "$Date$";
        revision: "$Revision$";
	author: "Patrice Khawam"

class HUMAN

creation

	make

feature

	h_no: INTEGER;

	h_name: STRING;

	h_birthday: ABSOLUTE_DATE;

	h_country: ARRAY [COUNTRY]

	make (no: like h_no; name: like h_name;
		birthday: like h_birthday; country: like h_country) is
		require
			name_not_void: name /= Void;
			birthday_not_void: birthday /= Void;
			country: country /= Void
		do
			h_no := no;
			h_name := name;
			h_birthday := birthday;
			h_country := country
		ensure
			h_no = no;
			h_name = name;
			h_birthday = birthday;
			h_country = country
		end

end -- class HUMAN


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

