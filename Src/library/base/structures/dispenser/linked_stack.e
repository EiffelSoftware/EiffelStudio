indexing
		"Unbounded stacks implemented as linked lists";

	copyright: "See notice at end of class";
	names: linked_stack, dispenser, linked_list;
	representation: linked;
	access: fixed, lifo, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class LINKED_STACK [G] inherit

	STACK [G]
		undefine
			replace
		select
			item
		end;

	LINKED_LIST [G]
		rename
			item as ll_item,
			remove as ll_remove,
			remove_right as remove
		export
			{NONE} all;
			{ANY}
				count, readable, writable, extendible,
				make, wipe_out
		undefine
			readable, writable, fill,
			append, sequential_representation, put,
			prune_all
		redefine
			extend, force, duplicate
		select
			remove
		end

creation

	make

feature -- Access

	item: G is
			-- Item at the first position
		require else
			Not_empty: not empty
		do
			Result := first_element.item
		end;

feature -- Element change

	put, extend, force (v: like item) is
			-- Push `v' onto top.
		do
			add_front (v)
		end;

feature -- Conversion

	sequential_representation: ARRAYED_LIST [G] is
			-- Representation as a sequential structure
			-- (order is reverse of original order of insertion)
		do
			from
				!!Result.make (count);
				start
			until
				after
			loop
				Result.extend (ll_item);
			forth;
			end;
			start;
			back
		end;

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- New stack containing the `n' latest items inserted
			-- in current stack.
			-- If `n' is greater than `count', identical to current stack.
		require else
			positive_argument: n > 0
		local
			counter: INTEGER;
			temp: like Current;
		do
			if not empty then
				from
					!!temp.make;
					start
				until
					after or temp.count = n
				loop
					temp.put (ll_item);
					forth
				end;
				from
					!!Result.make
				until
					temp.empty
				loop
					Result.put (temp.item);
					temp.remove
				end;
				start;
				back
			end	
		end;

invariant

	always_before: before

end -- class LINKED_STACK


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
