note
	description: "A criterion that will return a logical AND of its two child criteria."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_AND_CRITERION

inherit

	PS_CRITERION

create
	make

feature {NONE} -- Initialization

	make (arg_left: PS_CRITERION; arg_right: PS_CRITERION)
			-- Initialization for `Current'.
		require
			left_not_empty_criterion: not arg_left.is_empty_criterion
			right_not_empty_criterion: not arg_right.is_empty_criterion
		do
			left := arg_left
			right := arg_right
		ensure
			left_set: arg_left = left
			right_set: arg_right = right
		end

feature -- Access

	left: PS_CRITERION
			-- Left child criterion

	right: PS_CRITERION
			-- Right child criterion

feature -- Check

	is_satisfied_by (retrieved_obj: ANY): BOOLEAN
			-- Does `retrieved_obj' satisfy the criteria in Current?
		do
			Result := left.is_satisfied_by (retrieved_obj) and right.is_satisfied_by (retrieved_obj)
		end

	can_handle_object (an_object: ANY): BOOLEAN
			-- Can `Current' handle `an_object' in the is_satisfied_by check?
		do
			Result := left.can_handle_object (an_object) and right.can_handle_object (an_object)
		end

feature -- Miscellaneous

	has_agent_criterion: BOOLEAN
			-- Is there an agent criterion in the criterion tree?
		do
			Result := left.has_agent_criterion and right.has_agent_criterion
		end

	accept (a_visitor: PS_CRITERION_VISITOR [ANY]): ANY
			-- Call visit_and on `a_visitor'
		do
			Result := a_visitor.visit_and (Current)
		end

end
