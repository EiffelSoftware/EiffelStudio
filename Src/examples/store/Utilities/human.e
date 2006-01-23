indexing

        date: "$Date$";
        revision: "$Revision$";
	author: "Patrice Khawam"

class HUMAN

create

	make

feature

	h_no: INTEGER;

	h_name: STRING;

	h_gender: BOOLEAN;

	h_initial: CHARACTER;

	h_age: INTEGER;

	h_weight: REAL

	h_height: DOUBLE

	h_birthday: DATE_TIME;

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


end -- class HUMAN


