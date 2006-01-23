indexing

	description: "Nested queries example."
	legal: "See notice at end of class."
	product: "EiffelStore"
	database: "Sybase"
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


end -- class ACTION_2_I


