indexing
	description: "To use with Gobo comparison facilities but implemented using agents instead."
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_BASED_EQUALITY_TESTER [G]
	
inherit
	KL_EQUALITY_TESTER [G]
		redefine
			test
		end

	KL_PART_COMPARATOR [G]
		
create
	make
	
feature {NONE} -- Initialization

	make (an_action: like action) is
			-- Use `an_action' to compare two elements of type G.
		require
			an_action_not_void: an_action /= Void
		do
			action := an_action
			create evaluation_tuple
		ensure
			action_set: action = an_action
		end
		
feature -- Access

	action: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]
			-- Action performed to compare two non-void items.

feature -- Status report

	test (v, u: G): BOOLEAN is
			-- Are `v' and `u' considered equal?
			-- (Use `equal' by default.)
		do
			if v = Void then
				Result := (u = Void)
			elseif u = Void then
				Result := False
			else
				evaluation_tuple.put (v, 1)
				evaluation_tuple.put (u, 2)
				Result := action.item (evaluation_tuple)
			end
		end
	
	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			evaluation_tuple.put (u, 1)
			evaluation_tuple.put (v, 2)
			Result := action.item (evaluation_tuple)	
		end

feature {NONE} -- Implementation

	evaluation_tuple: TUPLE [G, G]
			-- To avoid useless creation of TUPLE objects.
	
invariant
	action_not_void: action /= Void
	evaluation_tuple_not_void: evaluation_tuple /= Void
	
end -- class AGENT_BASED_EQUALITY_TESTER

