indexing

	description:
		"Objects that are able to iterate over linear structures";

	copyright: "See notice at end of class";
	names: iterators, iteration, linear_iterators, 
			linear_iteration;
	date: "$Date$";
	revision: "$Revision$"

class LINEAR_ITERATOR [G] inherit

	ITERATOR [G]
		redefine
			target
		end;

feature -- Cursor movement

	target: LINEAR [G];
		-- The structure to which iteration features will apply.

	do_all is
			-- Apply `action' to every item of `target'.
			-- (from the `start' of `target')
		do
			from
				start 
			invariant
				invariant_value 
			until 
				off 
			loop
				action ;
				forth 
			end
		ensure then
			off 
		end;

	do_while is
			-- Apply `action' to every item of `target' up to 
			-- but excluding the first one not satisfying `test'.
			-- (from the `start' of `target')
		do
			start;
			continue_while 
		ensure then
			not off implies not test 
		end;

	continue_while is
			-- Apply `action' to every item of `target' up to
			-- but excluding the first one not satisfying `test'.
			-- (from the current position of `target')
		require else
			traversable_exists: target /= Void;
			invariant_satisfied: invariant_value
		do
			from
			invariant
				invariant_value 
			until
				off or else not test 
			loop
				action ;
				forth 
			end
		ensure then
			not off implies not test 
		end;

	until_do is
		   -- Apply `action' to every item of `target' up to
			-- but excluding the first one satisfying `test'.
			-- (Apply to full list if no item satisfies `test'.)
		do
			start;
			until_continue
		end;

	until_continue is
			-- Apply `action' to every item of `target' from current position
			-- up to but excluding the first one satisfying `test'.
		require
			traversable_exists: target /= Void;
			invariant_satisfied: invariant_value
		do  
			from
			invariant
				invariant_value
			until
				target.off or else test
			loop
				action;
				target.forth
			end 
		ensure
			achieved: target.off or else test;
			invariant_satisfied: invariant_value
		end;

	do_until is
			-- Apply `action' to every item of `target' up to 
			-- and including the first one satisfying `test'.
			-- (from the `start' of `target')
		do
			start ;
			continue_until;
		ensure then
			not off implies test 
		end;

	 continue_until is
			-- Apply `action' to every item of `target' up to
			-- and including the first one satisfying `test'.
			-- (from the current position of `target')
		require
			traversable_exists: target /= Void;
			invariant_satisfied: invariant_value 
		local
			finished: BOOLEAN
		do
			from
				if not off then action end
			invariant
				invariant_value 
			until
				off or else test 
			loop
				forth ;
				if not off then action end
			end
		ensure then
			not off implies test 
		end;

	search (b: BOOLEAN) is
			-- Search the first item of `target' 
			-- satisfying: `test' equals to `b'.
			-- (from the `start' of `target')
		require
			traversable_exists: target /= Void
		do
			start ;
			continue_search (b)
		end;

	continue_search (b: BOOLEAN) is
			-- Search the first item of `target'
			-- satisfying: `test' equals to `b'.
			-- (from the current position of `target')
		require
			traversable_exists: target /= Void
		do
			from
			invariant
				invariant_value 
			until 
				off or else (b = test )
			loop
				forth 
			end
		ensure then
			not off = (b = test )
		end;

	do_if is
			-- Apply `action' to every item of `target' 
			-- satisfying `test'.
			-- (from the `start' of `target')
		do
			from
				start 
			invariant
				invariant_value 
			until
				off 
			loop
				if test then action end;
				forth 
			end
		end;

	do_for (i, n, k: INTEGER) is
			-- Apply `action' to every `k'-th item,
			-- `n' times if possible, starting from `i'th.
		require
			traversable_exists: target /= Void
		local
			j: INTEGER
		do
			from
				start ;
				j := 1
			invariant
				j >= 1 and  j <= i
			variant
				i - j
			until
				off or else j = i 
			loop
				forth ;
				j := j + 1
			end;
			continue_for (n, k)
		end;

	continue_for (n, k: INTEGER) is
			-- Every `k'th item, apply `action',
			-- `n' times if possible.
		require
			traversable_exists: target /= Void
		local
			i, j: INTEGER
		do
			from
			invariant
				i >= 0 and i <= n
			variant
				n - i
			until
				off or else i = n
			loop
				action ;
				i := i + 1;
				from
					j := 0
				invariant
					j >= 0 and j <= k
				variant
					k - j
				until 
					off  or else j = k 
				loop
					forth ;
					j := j + 1
				end
			end
		end;

	forall: BOOLEAN is
			-- Does `test' return true for
			-- all items of `target'?
		do
			search (False);
			Result := off 
		end;

	exists: BOOLEAN is
			-- Does `test' return true for
			-- at least one item of `target'?
		do
			search (True);
			Result := not off 
		end;

	start is
			-- Move to first position of `target'.
		require
			traversable_exists: target /= Void
		do
			target.start
		end;

	forth is
			-- Move to next position of `target'.
		require
			traversable_exists: target /= Void
		do
			target.start
		end;

	off: BOOLEAN is
			 -- Is position of `target' off?
		require
			traversable_exists: target /= Void
		do
			Result := target.off
		end;

end


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
