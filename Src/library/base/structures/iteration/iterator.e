indexing

	description:
		"Objects that are able to iterate over traversable structures, %
		%on which they can perform repeated actions and tests according %
		%to a number of predefined control structures such as ``if'', %
		%``until'' and others.";

	status: "See notice at end of class";
	names: iterators, iteration;
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ITERATOR [G]

feature -- Status report

	target: TRAVERSABLE [G];
			-- The structure to which iteration features will apply

	test: BOOLEAN is
			-- Test to be applied to item at current position in `target'
			-- (default: value of `item_test' on item)
		require
			traversable_exists: target /= Void;
			not_off: not target.off
		do
			Result := item_test (target.item)
		ensure
			not_off: not target.off
		end;

	item_test (v: G): BOOLEAN is
			-- Test to be applied to item `v'
			-- (default: false)
		do
		end;

	invariant_value: BOOLEAN is
			-- Is the invariant satisfied?
			-- (Redefinitions of this feature will usually involve
			-- `target'; if so, make sure that the result is defined
			-- when `target = Void'.)
		require
			traversable_exists: target /= Void
		do
			Result := True
		end;

feature -- Status setting

	set (s: like target) is
			-- Make `s' the new target of iterations.
		require
			s /= Void
		do
			target := s
		ensure
			target = s;
			target /= Void
		end

feature -- Cursor movement

	do_all is
			-- Apply `action' to every item of `target'.
		require
			traversable_exists: target /= Void
		deferred
		end;

	do_if is
			-- Apply `action' to every item of `target' satisfying `test'.
		require
			traversable_exists: target /= Void
		deferred
		end;

	do_until is
			-- Apply `action' to every item of `target' up to
			-- and including first one satisfying `test'.
			-- (Apply to full list if no item satisfies `test').
		require
			traversable_exists: target /= Void
		deferred
		end;

	do_while is
			-- Apply `action' to every item of `target' up to
			-- and including first one not satisfying `test'.
			-- (Apply to full list if all items satisfy `test').
		deferred
		end;

	until_do is
			-- Apply `action' to every item of `target' up to
			-- but excluding first one satisfying `test'.
			-- (Apply to full list if no items satisfy `test'.)
		require
			traversable_exists: target /= Void
		deferred
		end;

	while_do is
			-- Apply `action' to every item of `target' up to
			-- but excluding first one satisfying not `test'.
			-- (Apply to full list if all items satisfy `test'.)
		require
			traversable_exists: target /= Void
		deferred
		end;

	forall: BOOLEAN is
			-- Is `test' true for all items of `target'?
		require
			traversable_exists: target /= Void
		deferred
		end;

	exists: BOOLEAN is
			-- Is `test' true for at least one item of `target'?
		require
			traversable_exists: target /= Void
		deferred
		end;

feature -- Element change

	action is
			-- Action to be applied to item at current position
			-- in `target' (default: `item_action' on that item).
			-- For iterators to work properly, redefined versions of
			-- this feature should not change the traversable's
			-- structure.
		require
			traversable_exists: target /= Void;
			not_off: not target.off;
			invariant_satisfied: invariant_value
		do
			item_action (target.item)
		ensure
			not_off: not target.off;
			invariant_satisfied: invariant_value
		end;

	item_action (v: G) is
			-- Action to be applied to item `v'
			-- (Default: do nothing.)
		do
		end;

end -- class ITERATOR


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

