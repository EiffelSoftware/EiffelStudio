note
	description: "Deferred class for the visitor pattern on criteria. Supports a return value."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_CRITERION_VISITOR [RETURN_VALUE -> ANY]

feature

	visit (a_criterion: PS_CRITERION): RETURN_VALUE
		do
			check attached {RETURN_VALUE} a_criterion.accept (Current) as ret then
				Result := ret
			end
		end

	visit_and (and_crit: PS_AND_CRITERION): RETURN_VALUE
		deferred
		end

	visit_or (or_crit: PS_OR_CRITERION): RETURN_VALUE
		deferred
		end

	visit_not (not_crit: PS_NOT_CRITERION): RETURN_VALUE
		deferred
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): RETURN_VALUE
		deferred
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): RETURN_VALUE
		deferred
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): RETURN_VALUE
		deferred
		end

end
