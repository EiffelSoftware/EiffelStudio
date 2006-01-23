indexing
	description: "String tools"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_STRING_EX [G -> DATABASE create default_create end]

inherit 

	STRING

	HANDLE_SPEC [G]
		undefine
			is_equal, out, copy
		end

create -- Creation procedure

	make

feature -- Status setting

	get_select_name (no_descriptor: INTEGER; index: INTEGER) is
			-- Put in `Current' name of the index-th column of selection.
		do
			set_count (db_spec.put_col_name (no_descriptor, index, Current, capacity))
		ensure
			capacity_unchanged: capacity = old capacity
		end

	get_value (no_descriptor: INTEGER; index: INTEGER) is
			-- Put in `Current' value of index-th column of selection.
		do
			set_count (db_spec.put_data (no_descriptor, index, Current, capacity))
		ensure
			capacity_unchanged: capacity = old capacity
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




end -- class DATABASE_STRING_EX


