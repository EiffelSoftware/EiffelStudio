indexing

	description:
		"Sets whose items may be compared according to a partial order relation; %
		%implemented as sorted two-way lists.";

	copyright: "See notice at end of class";
	names: sorted_set, set, two_way_list;
	representation: linked;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class PART_SORTED_SET [G -> PART_COMPARABLE] inherit

	SUBSET [G]
		undefine
			prune_all,
			changeable_comparison_criterion
		redefine
			disjoint, symdif
		end;

	PART_SORTED_TWO_WAY_LIST [G]
		export
			{ANY}
				put, merge
		undefine
			put
		redefine
			merge, duplicate, extend
		end;

creation

	make

feature -- Comparison

	is_subset (other: like Current): BOOLEAN is
			-- Is current set a subset of `other'?
		do
			if count <= other.count then
				Result := true;
				from
					start
				until
					after or not Result
				loop
					Result := other.has (item);
					forth
				end
			elseif empty then
				Result := true
			end
		end;

feature -- Element change

	extend, put (v: G) is
			-- Ensure that structure includes `v'.
		local
			not_empty: BOOLEAN
		do
			if not empty then
				search_after (v)
			end;
			if after or else not item.is_equal (v) then
				add_left (v);
			end;
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		do
			from
				start;
				other.start
			until
				other.after or else after
			loop
				if item < other.item then
					forth
				elseif item.is_equal (other.item) then
					forth;
					other.forth
				else -- item > other.item
					add_left (other.item);
					other.forth
				end
			end;
			if after then
				from
				until
					other.after
				loop
					add_left (other.item);
					other.forth
				end
			end
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of sub-set beginning at cursor position
			-- and having min (`n', `count' - `index' + 1) items
		local
			pos: CURSOR;
			counter: INTEGER
		do
			pos := cursor;
			Result := new_chain;
			Result.finish;
			from
			until
				(counter = n) or else after
			loop
				Result.add_left (item);
				forth;
				counter := counter + 1
			end;
			go_to (pos)
		end;

feature -- Basic operations

	intersect (other: like Current) is
			-- Remove all items not in `other'.
		do
			from
				start
			until
				after
			loop
				if other.has (item) then
					forth
				else
					remove
				end
			end
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		do
			from
				start;
			until
				after
			loop
				if other.has (item) then
					remove
				else
					forth
				end
			end
		end;

	disjoint (other: like Current): BOOLEAN is
			-- are `Current' and `other' distinct ?
		do
			from
				start
			until
				after or Result
			loop
				Result := other.has (item);
				forth
			end
		end;

	symdif (other: like Current) is
			-- Remove items also in `other'
			-- add items of `other' not in Current
		do
			from
				other.start
			until
				other.after
			loop
				search (other.item);
				if after then
					extend (other.item)
				else
					remove
				end;
				other.forth
			end
		end;
		
end -- class PART_SORTED_SET


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
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
