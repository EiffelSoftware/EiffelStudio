indexing

	description:
		"Sets whose items may be compared according to a partial order relation; %
		%implemented as sorted two-way lists.";

	status: "See notice at end of class";
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
		select
			extend, prune, put
		end;

	PART_SORTED_TWO_WAY_LIST [G]
		rename
			extend as pstwl_extend,
			prune as pstwl_prune,
			put as pstwl_put
		export
			{ANY}
				merge, duplicate,
				forth, item, after, start,
				put_left, finish
			{NONE} all
		redefine
			merge, duplicate
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
		do
			search_after (v)
			if after or else not item.is_equal (v) then
				put_left (v);
			end
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
					put_left (other.item);
					other.forth
				end
			end;
			if after then
				from
				until
					other.after
				loop
					put_left (other.item);
					other.forth
				end
			end
		end;

feature -- Removal

	prune (v : like item) is
		-- Remove `v' if present.
		do
			start
			pstwl_prune (v)
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
			-- Do current set and `other' have no
			-- items in common?
		do
			from
				start
			until
				after or Result
			loop
				Result := other.has (item);
				forth
			end
			Result := not Result
		end;

	symdif (other: like Current) is
			-- Remove all items also in `other', and add all
			-- items of other not already present.
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

