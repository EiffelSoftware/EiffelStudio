indexing
	description: "[
					Structures for which there exists a traversal policy
					that will visit every element exactly once.
			  ]"
	class_type: Interface
	external_name: "ISE.Base.Traversable"

deferred class
	TRAVERSABLE [G]

inherit
	CONTAINER [G]

feature -- Access

	item: G is
		indexing
			description: "Item at current position"
		require
			not_off: not off
		deferred
		end

feature -- Status report

	off: BOOLEAN is
		indexing
			description: "Is there no current item?"
		deferred
		end

feature -- Cursor movement

	start is
		indexing
			description: "Move to first position if any."
		deferred
		end
		
feature -- Iteration
		
--	do_all (action: PROCEDURE [ANY, TUPLE [G]]) is
--		indexing
--			description: "[
--						Apply `action' to every item.
--						Semantics not guaranteed if `action' changes the structure;
--						in such a case, apply iterator to clone of structure instead. 
--					  ]"
--		require
--			action_exists: action /= Void
--		deferred
--		end

--	do_if (action: PROCEDURE [ANY, TUPLE [G]];
--	       test: FUNCTION [ANY, TUPLE [G], BOOLEAN]) is
--		indexing
--			description: "[
--						Apply `action' to every item that satisfies `test'.
--						Semantics not guaranteed if `action' or `test' changes the structure;
--						in such a case, apply iterator to clone of structure instead. 
--					  ]"
--		require
--			action_exists: action /= Void
--			test_exits: test /= Void
			-- test.is_pure
--		deferred
--		end

--	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
--		indexing
--			description: "Is `test' true for at least one item?"
--		require
--			test_exits: test /= Void
--		deferred
--		end

--	for_all (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
--		indexing
--			description: "Is `test' true for all items?"
--		require
--			test_exits: test /= Void
			-- test.is_pure
--		deferred
--		end

--invariant
--	empty_constraint: is_empty implies off

end -- class TRAVERSABLE



