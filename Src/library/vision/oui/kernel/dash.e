indexing

	description: "Description of a dash pattern";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DASH 

inherit

	LINKED_LIST [INTEGER]

creation

	make

feature -- Access

	offset: INTEGER;
			-- How many pixels into the patterns the line should actually begin

feature -- Measurement

	max_offset: INTEGER is
			-- Sum of integers in the list
			-- `offset' must be less than `max_offset'
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				Result := Result+item;
				forth
			end;
			go_to (keep_cursor)
		end;

feature -- Element change

	set_offset (new_offset: INTEGER) is
			-- Set `offset' to `new_offset'.
		require
			offset_large_enough: offset >= 0;
			offset_small_enough: (not empty) implies (offset < max_offset)
		do
			offset := new_offset
		ensure
			offset = new_offset
		end

invariant

	non_negative_offset: offset >= 0;
	not_empty_offset_in_bound: (not empty) implies (offset <= max_offset)

end -- class DASH

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

