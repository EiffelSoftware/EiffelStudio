indexing

	description:
		"Stacks with a bounded physical size, implemented by arrays";

	status: "See notice at end of class";
	names: dispenser, array;
	representation: array;
	access: fixed, lifo, membership;
	size: fixed;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class BOUNDED_STACK [G] inherit

	STACK [G]
		redefine
			replace, item,
			linear_representation
		end;

	BOUNDED [G]
		undefine
			consistent, copy, setup, is_equal
		end;

creation

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create a stack for at most `n' items.
		require
			non_negative_argument: n >= 0
		do
			!! fl.make (0,n);
		ensure
			stack_allocated: capacity = n;
			empty_stack: count = 0
		end;

feature -- Access

	item: G is
			-- Last item pushed (i.e. top)
		require else
			not_empty: count > 0;
		do
			Result := fl.item (count)
		end;

feature -- Measurement

	count: INTEGER;

	capacity: INTEGER is
		do
			Result := fl.count - 1
		end;

	occurrences (v: G): INTEGER is
		do
			if object_comparison then
				fl.compare_objects
			else
				fl.compare_references
			end
			Result := fl.occurrences (v)
		end;

feature -- Element change

	extend, force, put (v: like item) is
			-- Push `v' on top.
		do
			count := count + 1;
			fl.put (v, count)
		end;

	replace (v: like item) is
			-- Replace top item by `v'.
		do
			fl.put (v, count)
		end;
feature -- Access

	has (v: G): BOOLEAN is
			-- Does `v' appear in stack?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			if object_comparison then
				fl.compare_objects
			else
				fl.compare_references
			end
			Result := fl.has (v)
		end;

feature -- Removal

	remove is
			-- Remove top item.
		require else
			not_empty: count /= 0
		local
			default_value: like item
		do
			fl.put (default_value, count);
			count := count - 1
		end;

	wipe_out is
			-- Remove all items.
		do
			fl.clear_all;
			count := 0
		end;

feature -- Status report

	extendible: BOOLEAN is
		do
			Result := not full
		ensure then
			Result = not full
		end;

	resizable: BOOLEAN is true;

	prunable: BOOLEAN is true;

feature -- Conversion

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure
			-- (in the reverse order of original insertion)
		local
			i: INTEGER
		do
			from
				!! Result.make (count);
				i := count
			until
				i < 0
			loop
				Result.extend (fl.item (i));
				i := i - 1
			end
		end;

feature {STACK} -- Implementation

	start is
			-- Move to first position.
			-- (No effect if empty)
		do
			if not empty then
				index := count
			end
		end;

	finish is
			-- Move to last position.
			-- (No effect if empty)
		do
			if not empty then
				index := 1
			end
		end;

	forth is
			-- Move to next position.
		do
			index := index - 1;
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := (index < 1) or else (index > count)
		end;

	fl: ARRAY [G]
			-- Storage

	index: INTEGER
			-- Current place in stack.

feature {NONE} -- Inapplicable

	prune (v: G) is
		do
		end;

invariant

	count_small_enough: count <= capacity;
	extendible_definition: extendible = not full

end -- class BOUNDED_STACK


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
