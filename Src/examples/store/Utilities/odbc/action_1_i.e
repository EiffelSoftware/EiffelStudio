indexing

	description: "Nested queries example."
	product: "EiffelStore"
	database: "ODBC"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class ACTION_1_I inherit

	ACTION_1

create
        
	make

feature

	process_row is
		local
			my_action: ACTION_2_I
			new_selection: DB_SELECTION
			tuple: DB_TUPLE
			table_name: STRING
--			table_owner:STRING
		do      
			create tuple.copy (selection.cursor)
			table_name ?= tuple.item (3)
--			table_owner ?= tuple.item (2)
			if table_name /= Void  then
				io.putstring ("-- Column(s) for table ") 
				io.putstring (table_name)
--				io.putstring (" Owner: ")
--				io.putstring (table_owner)
				io.new_line
				create new_selection.make
				create my_action.make (new_selection)
				new_selection.set_action (my_action)
				new_selection.set_map_name (table_name, "table_name")
--				new_selection.set_map_name (table_owner, "table_owner")
				new_selection.query (select_string)
				new_selection.load_result
				new_selection.unset_map_name ("table_name")
--				new_selection.unset_map_name ("table_owner")
				new_selection.terminate
			end
		end

	select_string: STRING is
		once
			Result := 
			"sqlcolumns(:table_name)"
		end

end -- class ACTION_1_I


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

