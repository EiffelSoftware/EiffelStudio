indexing

	description:
		"Unbounded queues implemented as linked lists";

	status: "See notice at end of class";
	names: linked_queue, dispenser, linked_list;
	representation: linked;
	access: fixed, fifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_QUEUE [G] inherit

	QUEUE [G]
		undefine
			empty
		redefine
			linear_representation, prune_all, extend
		select
			item, put
		end;

	LINKED_LIST [G]
		rename
			item as ll_item,
			remove as ll_remove,
			make as ll_make,
			remove_left as remove,
			put as ll_put
		export
			{NONE}
				all;
			{ANY}
				writable, extendible, wipe_out,
				readable
		undefine
			fill, append, prune,
			readable, writable, prune_all, extend,
			force
		redefine
			duplicate, linear_representation
		select
			remove
		end;

creation

	make

feature -- Initialization

	make is
		do
			after := true
		end;

feature -- Access

	item: G is
			-- Oldest item
		require else
			not empty
		do
				check
					after and not empty implies (active = last_element)
				end;
			Result := active.item
		end;

feature -- Element change

	put, extend, force (v: G) is
			-- Add `v' as newest item.
		do
			put_front (v)
			before := false
			after := true
		ensure then
			(old empty) implies (item = v);
		end;

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (order is same as original order of insertion)
		local
			i: INTEGER;
		do
			!!Result.make_filled (count);
			from
				start;
				Result.finish;
			until
				after
			loop
				Result.replace (item);
				forth;
				Result.back
			end;
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- New queue containing the `n' oldest items in current queue.
			-- If `n' is greater than `count', identical to current queue.
		require else
			positive_argument: n > 0
		do
			start;
			from
				!! Result.make;
				start
			until
				after or Result.count = n
			loop
				Result.extend (ll_item);
				forth;
			end;
			finish
		end;

feature {NONE} -- Not applicable

	prune (v: like item) is
			-- Remove one occurrence of `v'.
			-- Not available.
		do
			-- Do nothing
		end;

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
			-- Not available
		do
			-- Do nothing
		end;

invariant

	is_always_after: not empty implies after

end -- class LINKED_QUEUE


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

