indexing

	description:
		"Sequential lists whose items are sorted in ascending order %
		%according to the relational operators of PART_COMPARABLE";

	status: "See notice at end of class";
	names: sorted_list, sorted_struct, sequence;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class PART_SORTED_LIST [G -> PART_COMPARABLE] inherit

	LIST [G]
		redefine
			has, extend
		end;

feature -- Access

	has (v: G): BOOLEAN is
			-- Does structure include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			pos: CURSOR
		do
			if not empty then
				pos := cursor;
				start;
				search (v);
				Result := not after;
				go_to (pos)
			end
		end;

	search_after (v: like item) is
			-- Go to first position with item greater
			-- than or equal to `v'.
		do
			from
				start
			until
				after or else v <= item
			loop
				forth
			end
		ensure
			argument_less_than_item: (not after) implies (v <= item)
		end;

	search_before (v: like item) is
			-- Go to last position with item less
			-- than or equal to `v'.
		do
			from
				finish
			until
				before or else v >= item
			loop
				back
			end
		ensure
			(not off) implies (item <= v)
		end;

feature -- Element change

	extend (v: like item) is
			-- Put `v' at proper position in list.
			-- The cursor ends up on the newly inserted
			-- item.
		deferred
		ensure then
	 		remains_sorted: (old sorted) implies sorted;
			item_inserted: item = v
		end;

	merge (other: LINEAR [G]) is
			-- Add all items from `other' at their proper positions.
		do
			from
				other.start
			until
				other.off
			loop
				extend (other.item);
				other.forth
			end
		ensure then
	 		remains_sorted: (old sorted) implies sorted
		end;

feature -- Status report


	sorted: BOOLEAN is
		deferred
		end;
end -- class PART_SORTED_LIST


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

