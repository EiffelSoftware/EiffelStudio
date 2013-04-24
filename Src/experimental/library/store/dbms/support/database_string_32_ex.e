note
	description: "String_32 tools"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STRING_32_EX [G -> DATABASE create default_create end]

inherit

	STRING_32

	HANDLE_SPEC [G]
		undefine
			is_equal, out, copy
		end

create -- Creation procedure

	make

feature -- Status setting

	get_value (no_descriptor: INTEGER; index: INTEGER)
			-- Put in `Current' value of index-th column of selection.
		do
			set_count (db_spec.put_data_32 (no_descriptor, index, Current, capacity))
		ensure
			capacity_unchanged: capacity >= old capacity
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_STRING_EX


