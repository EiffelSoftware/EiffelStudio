--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Two way lists that are kept sorted

indexing

	names: sorted_two_way_list, sorted_struct, sequence;
	representation: linked;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class SORTED_TWO_WAY_LIST [G -> PART_COMPARABLE] inherit

	TWO_WAY_LIST [G]
		undefine
			has, search, search_equal
		redefine
			remove_all_occurrences, add, new_chain
		end;

	SORTED_LIST [G]
		undefine
			move, remove, before, go_i_th,
			isfirst, start, finish, readable,
			islast, first, remove_item, after,
			contractable, last, off
		end

creation

	make

feature -- Insertion

	add (v: like item) is
			-- Put `v' at proper position in list.
			-- The cursor ends up on the newly inserted
			-- item.
		do
			search_after (v);
			add_left (v);
			back
		end;

feature -- Deletion

	remove_all_occurrences (v: like item) is
			-- Remove all items identical to `v'.
			-- (According to the currently adopted
			-- discrimination rule in `search')
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
			-- Sort `Current'.
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
						go (1 + gap)
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

feature {SORTED_TWO_WAY_LIST} -- Creation

	new_chain: like Current is
			-- Instance of class `like Current'.
		do
			!! Result.make
		end;

end
