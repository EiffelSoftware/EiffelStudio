--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sequential lists where the cells are sorted in ascending order
-- according to the relational operators of PART_COMPARABLE

indexing

	names: sorted_list, sorted_struct, sequence;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class SORTED_LIST [G -> PART_COMPARABLE] inherit

	LIST [G]
		redefine
			has, search, add, search_equal
		end;

	SORTED_STRUCT [G]
		undefine
			index_of, exhausted, empty,
			sequential_representation, off
		redefine
			min, max, has, search, search_equal
		end

feature -- Access

	min: like item is
			-- Minimum in `Current'
		do
			Result := first
		end;
			
	max: like item is
			-- Maximum in `Current'
		do
			Result := last
		end;

	median: like item is
			-- Median in `Current'
		do
			Result := i_th ((count + 1) // 2)
		end;
	
	has (v: G): BOOLEAN is
			-- Does `Current' include `v'?
			-- (According to the = discrimination rule).
			-- Cursor doesn't move.
		local
			pos: CURSOR
		do
			pos := cursor;
			if not empty then
				start;
				search (v);
			end;
			Result := not exhausted;
			go_to (pos)
		end;

	search (v: like item) is
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item and `v' are identical.
			-- (according to the `=' rule)
			-- Move cursor after if
			-- `Current' doesn't include `v'
			-- `exhausted' becomes true if `Current'
			-- does not include `v'.
		do
			from
				if before then forth end;
			until
				exhausted
				or else item = v
			loop
				forth;
			end
		end;

	search_after (v: like item) is
			-- Go to first position with item greater
			-- than or equal to `v'.
		do
			from
				if before then
					forth;
				elseif after then
					if not empty then start end
				elseif v < item then
					start
				end;
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
			search_after (v);
			if after or else (v < item) then
				back
			end
		ensure
			(not off) implies (item <= v)
		end;

    search_equal (v: like item) is
            -- Move cursor to first position
            -- (at or after current cursor position)
            -- where item and `v' are identical.
            -- (according to the `equal' rule)
            -- Move cursor after if
            -- `Current' doesn't include `v'
            -- `exhausted' becomes true if `Current'
            -- does not include `v'.
        do
            from
                if before then forth end;
            until
                exhausted
                or else equal (item, v)
            loop
                forth;
            end
        end;

feature -- Insertion

	add (v: like item) is
			-- Put `v' at proper position in list.
			-- The cursor ends up on the newly inserted
			-- item.
		deferred
		ensure then
	--		remains_sorted: old sorted implies sorted;
			item_inserted: item = v
		end;

	merge (other: SEQUENTIAL [G]) is
			-- Merge `Current' with `other', preserving order.
		do
			from
				other.start
			until
				other.off
			loop
				add (other.item);
				other.forth
			end
		ensure then
	--		remains_sorted: old sorted implies sorted
		end;

end
