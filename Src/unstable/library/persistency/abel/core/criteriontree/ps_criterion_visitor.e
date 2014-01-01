note
	description: "Deferred class for the visitor pattern on criteria. Supports a return value."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_CRITERION_VISITOR [RETURN_VALUE -> ANY]

feature

	visit (criterion: PS_CRITERION): RETURN_VALUE
			-- Visit `criterion'.
		do
			check attached {RETURN_VALUE} criterion.accept (Current) as ret then
				Result := ret
			end
		end

feature {PS_CRITERION} -- Visitor functions

	visit_and (and_crit: PS_AND_CRITERION): RETURN_VALUE
			-- Visit an AND criterion.
		deferred
		end

	visit_or (or_crit: PS_OR_CRITERION): RETURN_VALUE
			-- Visit an OR criterion.
		deferred
		end

	visit_not (not_crit: PS_NOT_CRITERION): RETURN_VALUE
			-- Visit a NOT criterion.
		deferred
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): RETURN_VALUE
			-- Visit a predefined criterion.
		deferred
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): RETURN_VALUE
			-- Visit an agent criterion.
		deferred
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): RETURN_VALUE
			-- Visit an empty criterion.
		deferred
		end

end
