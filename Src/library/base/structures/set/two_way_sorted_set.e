indexing

	description:
		"Sets whose elements may be compared according to a total order relation; %
		%implemented as sorted two-way lists."; 

	copyright: "See notice at end of class";
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
			{TWO_WAY_SORTED_SET} all
			{ANY}
				min, max, 
				merge, after, before,
				forth, finish, start,
				item, empty, back
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
			-- elements in common?
		do
			from
				start;
				other.start;
				Result := true
			until
				after or other.after or not Result
			loop
				if item < other.item then
					search_after (other.item);
				end;
				if
					not after
					and then other.item.is_equal (item)
				then
					Result := false
				else
					forth;
					other.forth
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
		do
			search_after (v);
			if after or else not item.is_equal (v) then
				put_left (v);
				back
			end;
		end;

	merge (other: like Current) is
			-- Add all items of `other'.
		do
			from
				start;
				other.start
			until
				after or other.after
			loop
				if item < other.item then
					search_after (other.item)
				end;
				if not after and then item = other.item then
					forth;
					other.forth
				elseif not after then
					from
					until
						other.after or else other.item >= item
					loop
						put_left (other.item);
						other.forth
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
		do
			from
				start;
				other.start
			until
				after or other.after	
			loop
				if item < other.item then
					search_after (other.item)
				end;
				if
					not after
					and then other.item.is_equal (item)
				then
					remove
				else
					forth
				end;
				other.forth
			end
		end;
			
	symdif (other: like Current) is
			-- Remove all elements also in `other', and add all elements
			-- of `other' not already present.
		do
			from
				start;
				other.start
			until
				after or other.after
			loop
				if item < other.item then
					forth
				elseif item > other.item then
					put_left (other.item);
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
