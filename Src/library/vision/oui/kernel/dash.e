indexing

	description: "Description of a dash pattern";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DASH 

inherit

	LINKED_LIST [INTEGER]

create

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
			offset_small_enough: (not is_empty) implies (offset < max_offset)
		do
			offset := new_offset
		ensure
			offset = new_offset
		end

invariant

	non_negative_offset: offset >= 0;
	not_empty_offset_in_bound: (not is_empty) implies (offset <= max_offset)

end -- class DASH

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

