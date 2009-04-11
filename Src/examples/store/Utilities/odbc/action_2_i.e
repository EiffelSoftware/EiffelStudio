note

	description: "Nested queries example."
	legal: "See notice at end of class."
	product: "EiffelStore"
	database: "ODBC"
	status: "See notice at end of class.";
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

        execute
		local
			tuple: DB_TUPLE
			l_cursor: detachable DB_RESULT
		do
			l_cursor := selection.cursor
			check l_cursor /= Void end -- FIXME: implied by ...?
			create tuple.copy (l_cursor)
			if attached {STRING} tuple.item (4) as column_name then
				io.putstring (column_name)
				io.new_line
			end
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


end -- class ACTION_2_I


