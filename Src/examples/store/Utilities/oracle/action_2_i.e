indexing

	description: "Nested queries example."
	product: "EiffelStore"
	database: "Oracle"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class ACTION_2_I inherit

	ACTION_2
		redefine
			execute
		end

creation
        
	make

feature

        execute is
		local
			tuple: DB_TUPLE
			column_name: STRING
		do
			!! tuple.copy (selection.cursor)
			column_name ?= tuple.item (1)
			if column_name /= Void then
				io.putstring (column_name)
				io.new_line
			end
		end

end -- class ACTION_2_I


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
