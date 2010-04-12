note

	description: "Nested queries example."
	legal: "See notice at end of class."
	product: "EiffelStore"
	database: "Oracle"
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class TEST_I inherit

	TEST

create

	make

feature

	select_string: STRING
		once
			--| this lives inside the information_schema for MySQL
			Result := "select TABLE_NAME from TABLES"
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


end -- class TEST_I


