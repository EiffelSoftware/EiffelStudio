indexing

	description: "Nested queries example."
	product: "EiffelStore"
	database: "Ingres"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class ACTION_2_I inherit

	ACTION_2
		redefine
			execute
		end

create
        
	make

feature

        execute is
		local
			tuple: DB_TUPLE
			column_name: STRING
		do
			create tuple.copy (selection.cursor)
			column_name ?= tuple.item (1)
			if column_name /= Void then
				io.putstring (column_name)
				io.new_line
			end
		end

end -- class ACTION_2_I


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
