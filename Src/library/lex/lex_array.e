indexing

	description:
		"One-dimensional arrays for lexical analysis";

	status: "See notice at end of class";
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

create

	make

feature -- Initialization

	make (lower_index, upper_index: INTEGER) is
		do
			array_make (lower_index, upper_index)
		end;

end -- class LEX_ARRAY [T]


--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

