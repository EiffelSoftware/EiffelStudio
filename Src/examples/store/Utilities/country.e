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


end -- class COUNTRY


