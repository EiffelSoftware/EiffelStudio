indexing

	description:
		"Sets whose items may be compared according to a total order relation; %
		%implemented as sorted two-way lists.";

	status: "See notice at end of class";
	names: sorted_set, set, two_way_list;
	representation: linked;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_SORTED_SET [G -> COMPARABLE] inherit

	COMPARABLE_SET [G]
		undefine
			search, has, index, off,
			min, max, index_of,
			prune_all, occurrences
		redefine
			symdif, disjoint
		select
			 extend, put, prune
		end;

	SORTED_TWO_WAY_LIST [G]
		rename
			extend as stwl_extend,
			put as stwl_put,
			prune as stwl_prune
		export
			{NONE} stwl_extend, stwl_put, stwl_prune
			{ANY}
				min, max, index,
				merge, after, before,
				forth, finish, start,
				item, empty, back,
				remove, search, off, go_i_th
		undefine
			changeable_comparison_criterion
		redefine
			merge, duplicate
		end;

creation

	make

feature -- Comparison

	disjoint (other: like Current): BOOLEAN is
			-- Do current set and `other' have no
			-- items in common?
		local
			other_item: like item
		do
			from
				start;
				other.start;
				Result := true
			until
				after or other.after or not Result
			loop
				other_item := other.item;
				if item < other_item then
					search_after (other_item);
				end;
				if not after then
					if other_item.is_equal (item) then
						Result := false
					else
						other.forth
					end
				end
			end;
		end;

	is_subset (other: like Current): BOOLEAN is
			-- Is current set a subset of `other'?
		do
			if count <= other.count then
				from
					start;
					other.start;
					Result := true
				until
					after or not Result
				loop
					other.search (item);
					if other.after then
						Result := false
					else
						forth
					end
				end
			else
				Result := empty
			end
		end;

feature -- Element change

	extend, put (v: G) is
			-- Ensure that structure includes `v'.
		local
			found: BOOLEAN
		do
			search_after (v);
            if after or else not item.is_equal (v) then
                put_left (v);
                back
            end;
			if object_comparison then
				if after or else not equal (item, v) then
					put_left (v);
					back
				end
			else
				from
				until
					found or after or else not equal (item, v)
				loop
					found := item = v;
					forth
				end;
				if not found then
					put_left (v)
				end;
				back
			end;
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		local
			mode: BOOLEAN;
			other_item: like item;
		do
			from
				mode := object_comparison
				start;
				other.start
			until
				after or other.after
			loop
				other_item := other.item;
				if item < other_item then
					search_after (other_item)
				end;
				if not after then
					if
						(not mode and then item = other_item)
					or else
						(mode and then item.is_equal (other_item))
					then
						forth;
						other.forth
					else
						from
						until
							other.after or else other.item >= item
						loop
							put_left (other.item);
							other.forth;
						end
					end
				end
			end;
			from
			until
				other.after
			loop
				put_left (other.item);
				other.forth
			end
		end;

feature -- Removal

	prune (v : like item) is
		-- Remove `v' if present.
		do
			start
			stwl_prune (v)
		end

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
			Result.forth;
			from
			until
				(counter = n) or else after
			loop
				Result.put_left (item);
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
				start;
				other.start
			until
				after or other.after
			loop
				from
				until
					after or item >= other.item
				loop
					remove
				end;
				if not after then
					from
					until
						other.after
						or else other.item >= item
					loop
						other.forth
					end;
					if
						not other.after
						and then other.item.is_equal (item)
					then
						forth;
						other.forth
					end
				end
			end;
			if other.after then
				from
				until
					after
				loop
					remove
				end
			end
		end;

	subtract (other: like Current) is
			-- Remove all items also in `other'.
		local
			other_item: like item
		do
			from
				start;
				other.start
			until
				after or other.after
			loop
				other_item := other.item;
				if item < other_item then
					search_after (other_item)
				end;
				if not after and then other_item.is_equal (item) then
					remove
				end;
				other.forth
			end
		end;

	symdif (other: like Current) is
			-- Remove all items also in `other', and add all items
			-- of `other' not already present.
		local
			other_item: like item
		do
			from
				start;
				other.start
			until
				after or other.after
			loop
				other_item := other.item;
				if item < other_item then
					forth
				elseif item > other_item then
					put_left (other_item);
					other.forth
				else
					remove;
					other.forth
				end
			end;
			from
			until
				other.after
			loop
				put_left (other.item);
				other.forth
			end
		end;

end -- class TWO_WAY_SORTED_SET


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

