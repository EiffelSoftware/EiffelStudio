note

	description: "Nested queries example."
	legal: "See notice at end of class."
	product: "EiffelStore"
	database: "ODBC"
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
			l_cursor: detachable DB_RESULT
		do
			l_cursor := selection.cursor
			check l_cursor /= Void end -- FIXME: implied by ...?
			create tuple.copy (l_cursor)
			if attached {STRING} tuple.item (3) as table_name then
				io.putstring ("-- Column(s) for table ")
				io.putstring (table_name)
				io.new_line
				create new_selection.make
				create my_action.make (new_selection)
				new_selection.set_action (my_action)
				new_selection.set_map_name (table_name, "table_name")
				new_selection.query (select_string)
				if new_selection.is_ok then
					new_selection.load_result
				end
				new_selection.unset_map_name ("table_name")
				new_selection.terminate
			end
		end

	select_string: STRING
		once
			Result :=
			"sqlcolumns(:table_name)"
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


