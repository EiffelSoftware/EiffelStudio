indexing

	description:
		"One-dimensional arrays for lexical analysis";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LEX_ARRAY [T] inherit

	ARRAY [T]
		rename
			make as array_make
		export
			{ANY} lower, upper, item, put, resize;
			{TEXT_FILLER} area, to_c
		end

creation

	make

feature -- Initialization

	make (lower_index, upper_index: INTEGER) is
		do
			array_make (lower_index, upper_index)
		end;

end -- class LEX_ARRAY [T]
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
