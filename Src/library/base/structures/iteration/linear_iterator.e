indexing

	description:
		"Objects that are able to iterate over linear structures";

	status: "See notice at end of class";
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
				exhausted
			loop
				action ;
				forth
			end
		ensure then
			exhausted
		end;

	do_while is
			-- Apply `action' to every item of `target' up to
			-- and including first one not satisfying `test'.
			-- (from the `start' of `target')
		do
			start;
			continue_while
		ensure then
			finished: not exhausted implies not test
		end;

	continue_while is
			-- Apply `action' to every item of `target' up to
			-- and including first one not satisfying `test'
			-- (from the current position of `target').
		require else
			traversable_exists: target /= Void;
			invariant_satisfied: invariant_value
		do
			from
				if not exhausted then action end
			invariant
				invariant_value
			until
				exhausted or else not test
			loop
				forth
				if not exhausted then action end
			end
		ensure then
			finished: not exhausted implies not test
		end;

	while_do is
			-- Apply `action' to every item of `target' up to
			-- but excluding first one not satisfying `test'.
			-- (Apply to full list if all items satisfy `test'.)
		do
			start
			while_continue
		ensure then
			finished: not exhausted implies not test
		end

	while_continue is
			-- Apply `action' to every item of `target' up to
			-- but excluding first one not satisfying `test'.
		do
			from
			invariant
				invariant_value
			until
				exhausted or else not test
			loop
				action
				forth
			end
		ensure
			finished: not exhausted implies not test
		end

	until_do is
		-- Apply `action' to every item of `target' up to
		-- but excluding first one satisfying `test'.
			-- (Apply to full list if no item satisfies `test'.)
		do
			start;
			until_continue
		ensure then
			achieved: not exhausted implies test
		end;

	until_continue is
			-- Apply `action' to every item of `target' from current
			-- position, up to but excluding first one satisfying `test'.
		require
			traversable_exists: target /= Void;
			invariant_satisfied: invariant_value
		do
			from
			invariant
				invariant_value
			until
				exhausted or else test
			loop
				action;
				forth
			end
		ensure
			achieved: exhausted or else test;
			invariant_satisfied: invariant_value
		end;

	do_until is
			-- Apply `action' to every item of `target' up to
			-- and including first one satisfying `test'.
		do
			start ;
			continue_until;
		ensure then
			achieved: not exhausted implies test
		end;

	continue_until is
			-- Apply `action' to every item of `target' up to
			-- and including first one satisfying `test'.
			-- (from the current position of `target').
		require
			traversable_exists: target /= Void;
			invariant_satisfied: invariant_value
		local
			finished: BOOLEAN
		do
			from
				if not exhausted then action end
			invariant
				invariant_value
			until
				exhausted or else test
			loop
				forth ;
				if not exhausted then action end
			end
		ensure then
			achieved: not exhausted implies test
		end;

	search (b: BOOLEAN) is
			-- Search the first item of `target' for which `test'
			-- has the same value as `b' (both true or both false).
		require
			traversable_exists: target /= Void
		do
			start ;
			continue_search (b)
		end;

	continue_search (b: BOOLEAN) is
			-- Search the first item of `target'
			-- satisfying: `test' equals to `b'
			-- (from the current position of `target').
		require
			traversable_exists: target /= Void
		do
			from
			invariant
				invariant_value
			until
				exhausted or else (b = test )
			loop
				forth
			end
		ensure then
			found: not exhausted = (b = test )
		end;

	do_if is
			-- Apply `action' to every item of `target'
			-- satisfying `test'.
		do
			from
				start
			invariant
				invariant_value
			until
				exhausted
			loop
				if test then action end;
				forth
			end
		end;

	do_for (i, n, k: INTEGER) is
			-- Apply `action' to every `k'-th item,
			-- `n' times if possible, starting from `i'-th.
		require
			traversable_exists: target /= Void
			valid_start : i >= 1
			valid_repetition: n >= 0
			valid_skip: k >= 1
		local
			j: INTEGER
		do
			from
				start ;
				j := 1
			invariant
				j >= 1 and j <= i
			variant
				i - j
			until
				exhausted or else j = i
			loop
				forth ;
				j := j + 1
			end;
			continue_for (n, k)
		end;

	continue_for (n, k: INTEGER) is
			-- Apply `action' to every `k'-th item,
			-- `n' times if possible.
		require
			traversable_exists: target /= Void
			valid_repetition: n >= 0
			valid_skip: k >= 1
		local
			i, j: INTEGER
		do
			from
			invariant
				i >= 0 and i <= n
			variant
				n - i
			until
				exhausted or else i = n
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
					exhausted or else j = k
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
			Result := exhausted
		end;

	exists: BOOLEAN is
			-- Does `test' return true for
			-- at least one item of `target'?
		do
			search (True);
			Result := not exhausted
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
			target.forth
		end;

	off: BOOLEAN is
			-- Is position of `target' off?
		require
			traversable_exists: target /= Void
		do
			Result := target.off
		end;

	exhausted: BOOLEAN is
			-- Is `target' exhausted?
		require
			traversable_exists: target /= Void
		do
			Result := target.exhausted
		end;

end


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

