indexing

	description:
		"Two-way lists, kept sorted";

	status: "See notice at end of class";
	names: sorted_two_way_list, sorted_struct, sequence;
	representation: linked;
	access: index, cursor, membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class PART_SORTED_TWO_WAY_LIST [G -> PART_COMPARABLE] inherit

	TWO_WAY_LIST [G]
		undefine
			has, search
		redefine
			prune_all, extend, new_chain
		end;

	PART_SORTED_LIST [G]
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
			-- The cursor ends up on the newly inserted
			-- item.
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


feature -- Status report

	sorted: BOOLEAN is
			-- is the structures topologically sorted
			-- i.e i < j implies not i_th (i) > i_th (j)
		do
			Result := true -- FIX ME: not implemented
		end;	
	
		
feature -- Transformation

	sort is
			-- sort the list
			-- | Dumb implementation: copy in other structure and insert again
		local
			seq: LINEAR [G]		
		do
			seq := linear_representation;
			wipe_out;
			from
				seq.start
			until
				seq.off
			loop
				extend (seq.item)
			end;
		end;

feature {PART_SORTED_TWO_WAY_LIST} -- Implementation

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
		do
			!! Result.make
		end;

end -- class PART_SORTED_TWO_WAY_LIST


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
