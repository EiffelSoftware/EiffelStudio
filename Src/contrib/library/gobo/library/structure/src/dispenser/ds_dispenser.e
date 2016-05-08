note

	description:

		"Dispenser containers"

	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 1999-2010, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class DS_DISPENSER [G]

inherit

	DS_EXTENDIBLE [G]
		redefine
			put,
			force,
			extend,
			append,
			do_all,
			do_if,
			do_until,
			do_if_until
		end

feature -- Access

	item: G
			-- Item accessible from dispenser
		require
			not_empty: not is_empty
		deferred
		end

feature -- Element change

	put (v: G)
			-- Add `v' to dispenser.
		deferred
		ensure then
			one_more: count = old count + 1
		end

	force (v: G)
			-- Add `v' to dispenser.
		deferred
		ensure then
			one_more: count = old count + 1
		end

	extend (other: DS_LINEAR [G])
			-- Add items of `other' to dispenser.
			-- Add `other.first' first, etc.
		deferred
		ensure then
			new_count: count = old count + other.count
		end

	append (other: DS_LINEAR [G])
			-- Add items of `other' to dispenser.
			-- Add `other.first' first, etc.
		deferred
		ensure then
			new_count: count = old count + other.count
		end

feature -- Removal

	remove
			-- Remove item from dispenser.
		require
			not_empty: not is_empty
		deferred
		ensure
			one_less: count = old count - 1
		end

	prune (n: INTEGER)
			-- Remove `n' items from dispenser.
		require
			valid_n: 0 <= n and n <= count
		deferred
		ensure
			new_count: count = old count - n
		end

	keep (n: INTEGER)
			-- Keep `n' items in dispenser.
		require
			valid_n: 0 <= n and n <= count
		deferred
		ensure
			new_count: count = n
		end

feature -- Iteration

	do_all (an_action: PROCEDURE [ANY, TUPLE [G]])
			-- Apply `an_action' to every item, from first to last item accessible.
			-- (Semantics not guaranteed if `an_action' changes the structure.)
		deferred
		end

	do_if (an_action: PROCEDURE [ANY, TUPLE [G]]; a_test: FUNCTION [ANY, TUPLE [G], BOOLEAN])
			-- Apply `an_action' to every item that satisfies `a_test', from first to last item accessible.
			-- (Semantics not guaranteed if `an_action' or `a_test' change the structure.)
		deferred
		end

	do_until (an_action: PROCEDURE [ANY, TUPLE [G]]; a_condition: FUNCTION [ANY, TUPLE [G], BOOLEAN])
			-- Apply `an_action' to every item, from first to last item accessible.
			-- (Semantics not guaranteed if `an_action' changes the structure.)
			--
			-- The iteration will be interrupted if `a_condition' starts returning True.
		deferred
		end

	do_if_until (an_action: PROCEDURE [ANY, TUPLE [G]]; a_test: FUNCTION [ANY, TUPLE [G], BOOLEAN]; a_condition: FUNCTION [ANY, TUPLE [G], BOOLEAN])
			-- Apply `an_action' to every item that satisfies `a_test', from first to last item accessible.
			-- (Semantics not guaranteed if `an_action' or `a_test' change the structure.)
			--
			-- The iteration will be interrupted if `a_condition' starts returning True.
		deferred
		end

end
