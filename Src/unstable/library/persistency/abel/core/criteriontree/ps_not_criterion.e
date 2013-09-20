note
	description: "A criterion that will negate the result of its child criterion."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_NOT_CRITERION

inherit

	PS_CRITERION

create
	make

feature {NONE} -- Initialization

	make (arg_child: PS_CRITERION)
			-- Initialization for `Current'.
		require
			arg_not_empty_criterion: not arg_child.is_empty_criterion
		do
			child := arg_child
		ensure
			child_set: child = arg_child
		end

feature -- Access

	child: PS_CRITERION
			-- The criterion on which `Current' will negate the result

feature -- Check

	is_satisfied_by (retrieved_obj: ANY): BOOLEAN
			-- Does `retrieved_obj' satisfy the criteria in Current?
		do
			Result := not child.is_satisfied_by (retrieved_obj)
		end

	can_handle_object (an_object: ANY): BOOLEAN
			-- Can `Current' handle `an_object' in the is_satisfied_by check?
		do
			Result := child.can_handle_object (an_object)
		end

feature -- Miscellaneous

	has_agent_criterion: BOOLEAN
			-- Is there an agent criterion in the criterion tree?
		do
			Result := child.has_agent_criterion
		end

	accept (a_visitor: PS_CRITERION_VISITOR [ANY]): ANY
			-- call visit_not on `a_visitor'
		do
			Result := a_visitor.visit_not (Current)
		end

end
