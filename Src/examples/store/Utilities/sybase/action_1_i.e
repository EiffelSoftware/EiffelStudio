indexing

	description: "Nested queries example."
	legal: "See notice at end of class."
	product: "EiffelStore"
	database: "Sybase"
	status: "See notice at end of class.";
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
			table_id: INTEGER_REF
		do      
			create tuple.copy (selection.cursor)
			create table_id
			table_name ?= tuple.item (1)
			table_id ?= tuple.item (2)
			if table_name /= Void and table_id /= Void then
				io.putstring ("-- Column(s) for table ") 
				io.putstring (table_name)
				io.new_line
				create new_selection.make
				create my_action.make (new_selection)
				new_selection.set_action (my_action)
				new_selection.set_map_name (table_id, "table_id")
				new_selection.query (select_string)
				new_selection.load_result
				new_selection.unset_map_name ("table_id")
				new_selection.terminate
			end
		end

	select_string: STRING is
		once
			Result := 
			"select name from syscolumns where id = :table_id"
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


end -- class ACTION_1_I


