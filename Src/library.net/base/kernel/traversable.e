indexing
	external_name: "ISE.Base.Traversable"

deferred class
	TRAVERSABLE [G]

inherit
	CONTAINER [G]

feature -- Access

	item: G is
			-- Item at current position
		require
			not_off: not off
		deferred
		end

feature -- Status report

	off: BOOLEAN is
			-- Is there no current item?
		deferred
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		deferred
		end
		
feature -- Iteration
		
--	do_all (action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead. 
--		require
--			action_exists: action /= Void
--		deferred
--		end

--	do_if (action: PROCEDURE [ANY, TUPLE [G]];
--	       test: FUNCTION [ANY, TUPLE [G], BOOLEAN]) is
			-- Apply `action' to every item that satisfies `test'.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead. 
--		require
--			action_exists: action /= Void
--			test_exits: test /= Void
			-- test.is_pure
--		deferred
--		end

--	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
--		require
--			test_exits: test /= Void
--		deferred
--		end

--	for_all (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for all items?
--		require
--			test_exits: test /= Void
			-- test.is_pure
--		deferred
--		end

--invariant
--	empty_constraint: is_empty implies off

end -- class TRAVERSABLE



