indexing

	description:
		"Print SQL requests to create the relationnal model."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PRINT_REQUEST

create

	make

feature

	make (tables: LINKED_LIST [SQL_TABLE]; output: FILE) is
			-- Print `tables' on `output'.
		require
			tables_not_void: tables /= Void;
			output_not_void: output /= Void
		do
			from
				tables.start
			until
				tables.after
			loop
				tables.item.print_result (output);
				output.new_line;
				tables.forth
			end;
		ensure
			tables_is_after: tables.after
		end;

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


end -- class PRINT_REQUEST


