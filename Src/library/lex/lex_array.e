indexing

	description:
		"One-dimensional arrays for lexical analysis"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class LEX_ARRAY [T] inherit

	ARRAY [T]
		rename
			make as array_make
		export
			{ANY} lower, upper, item, put, resize;
		end

create

	make

feature -- Initialization

	make (lower_index, upper_index: INTEGER) is
		do
			array_make (lower_index, upper_index)
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




end -- class LEX_ARRAY [T]

