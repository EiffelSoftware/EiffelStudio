indexing

	description:
		"Two-way lists, kept sorted.";

	status: "See notice at end of class";
	names: sorted_two_way_list, sorted_struct, sequence;
	representation: linked;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class SORTED_TWO_WAY_LIST [G -> COMPARABLE] inherit

	TWO_WAY_LIST [G]
		undefine
			has, search
		redefine
			prune_all, extend, new_chain
		end;

	SORTED_LIST [G]
		undefine
			move, remove, before, go_i_th,
			isfirst, start, finish, readable,
			islast, first, prune, after,
			last, off, prune_all
		end

creation

	make

feature -- Element change

	extend (v: like item) is
			-- Put `v' at proper position in list.
			-- Move cursor to newly inserted item.
		do
			search_after (v);
			put_left (v);
			back
		end;

feature -- Removal

	prune_all (v: like item) is
			-- Remove all items identical to `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave cursor `off'.
		do
			from
				start;
				search (v)
			until
				off or else v < item
			loop
				remove
			end;
			if not off then finish; forth end
		end;


feature -- Transformation

	sort is
			-- Sort all items.
			-- Has O(`count' * log (`count')) complexity.
			--| Uses comb-sort (BYTE February '91)
		local
			no_change: BOOLEAN;
			gap: INTEGER;
			left_cell, cell: like first_element;
			left_cell_item, cell_item: like item
		do
			if not empty then
				from
					gap := count * 10 // 13
				until
					gap = 0
				loop
					from
						no_change := false;
						go_i_th (1 + gap)
					until
						no_change
					loop
						no_change := true;
						from
							left_cell := first_element;
							cell := active;	-- position of first_element + gap
						until
							cell = Void
						loop
							left_cell_item := left_cell.item;
							cell_item := cell.item;
							if cell_item < left_cell_item then
									-- Swap `left_cell_item' with `cell_item'
								no_change := false;
								cell.put (left_cell_item);
								left_cell.put (cell_item)
							end;
							left_cell := left_cell.right;
							cell := cell.right
						end
					end;
					gap := gap * 10 // 13
				end
			end
		end;

feature -- Status report

	sorted: BOOLEAN is
			-- Is the structure sorted?
		local
			c: CURSOR;
			prev: like item
		do
			Result := true;
			if count > 1 then
				from
					c := cursor;
					start;
						check not off end;
					prev := item;
					forth
				until
					after or not Result
				loop
					Result := (prev <= item);
					prev := item;
					forth
				end;
				go_to (c)
			end
		end;

feature {SORTED_TWO_WAY_LIST} -- Implementation

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make
		end;

end -- class SORTED_TWO_WAY_LIST


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
