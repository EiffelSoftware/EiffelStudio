note

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

	process_row
		local
			my_action: ACTION_2_I
			new_selection: DB_SELECTION
			tuple: DB_TUPLE
			table_id: INTEGER_REF
			l_cursor: detachable DB_RESULT
		do
			l_cursor := selection.cursor
			check l_cursor /= Void end -- FIXME: implied by ...?
			create tuple.copy (l_cursor)
			create table_id
			if (attached {STRING} tuple.item (1) as table_name) and (attached {INTEGER_REF} tuple.item (2) as l_table_id) then
				table_id := l_table_id
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

	select_string: STRING
		once
			Result :=
			"select name from syscolumns where id = :table_id"
		end

note
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


