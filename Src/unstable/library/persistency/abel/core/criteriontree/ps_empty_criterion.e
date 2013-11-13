note
	description: "An empty criterion which will not filter any objects. Cannot be used in a criterion tree."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_EMPTY_CRITERION

inherit

	PS_CRITERION
		redefine
			is_empty_criterion
		end

create {PS_QUERY, PS_ABEL_EXPORT}
	default_create

feature -- Check

	is_satisfied_by (retrieved_obj: ANY): BOOLEAN
			-- Does `retrieved_obj' satisfy the criteria in Current?
		do
			Result := True
		end

	can_handle_object (an_object: ANY): BOOLEAN
			-- Can `Current' handle `an_object' in the is_satisfied_by check?
		do
			Result := True
		end

feature -- Miscellaneous

	has_agent_criterion: BOOLEAN = False
			-- Is there an agent criterion in the criterion tree?

	is_empty_criterion: BOOLEAN
			-- Is `Current' a PS_EMPTY_CRITERION?
		do
			Result := True
		end

	accept (a_visitor: PS_CRITERION_VISITOR [ANY]): ANY
			-- Call visit_empty on `a_visitor'
		do
			Result := a_visitor.visit_empty (Current)
		end

end
