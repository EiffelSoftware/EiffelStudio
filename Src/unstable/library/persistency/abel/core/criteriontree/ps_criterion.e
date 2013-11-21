note
	description: "Descendant objects represent criteria for selection to be used in queries."
	author: "Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_CRITERION

feature -- Functions to build a criterion tree.

	criterion_and alias "and" (t: PS_CRITERION): PS_AND_CRITERION
			-- Create and return an "and"-node with `Current' and `t' as children.
		do
			create Result.make (Current, t)
		end

	criterion_or alias "or" (t: PS_CRITERION): PS_OR_CRITERION
			-- Create and return an "or"-node with `Current' and `t' as children.
		do
			create Result.make (Current, t)
		end

	criterion_not alias "not": PS_NOT_CRITERION
			-- Create and return a "not"-node with `Current' as child.
		do
			create Result.make (Current)
		end

feature -- Check

	is_satisfied_by (retrieved_obj: ANY): BOOLEAN
			-- Does `retrieved_obj' satisfy the criteria in Current?
		require
			object_matches: can_handle_object (retrieved_obj)
		deferred
		end

	can_handle_object (an_object: ANY): BOOLEAN
			-- Can `Current' handle `an_object' in the is_satisfied_by check?
		deferred
		end

	can_handle_type (type: TYPE [detachable ANY]): BOOLEAN
			-- Can `Current' handle objects of type `type'?
		local
			reflection: INTERNAL
		do
			create reflection
			Result := can_handle_object (reflection.new_instance_of (type.type_id))
		end

feature -- Miscellaneous

	has_agent_criterion: BOOLEAN
			-- Is there an agent criterion in the criterion tree?
		deferred
		end

	is_empty_criterion: BOOLEAN
			-- Is `Current' a PS_EMPTY_CRITERION?
		do
			Result := false
		end

	accept (a_visitor: PS_CRITERION_VISITOR [ANY]): ANY
			-- `accept' function of the Visitor pattern
		deferred
		end

end
