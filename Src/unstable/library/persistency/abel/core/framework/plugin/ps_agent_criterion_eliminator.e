note
	description: "A visitor to remove agent criteria from a composite criterion."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_AGENT_CRITERION_ELIMINATOR

inherit

	PS_CRITERION_VISITOR [PS_CRITERION]

	PS_ABEL_EXPORT

feature {PS_CRITERION} -- Visitor functions

	visit_and (and_crit: PS_AND_CRITERION): PS_CRITERION
			-- <Precursor>
		local
			left, right: PS_CRITERION
		do
			left := visit (and_crit.left)
			right := visit (and_crit.right)

				-- Eliminate child with an empty criterion by
				-- forwarding the non-empty child.
			if left.is_empty_criterion then
				Result := right
			elseif right.is_empty_criterion then
				Result := left
			else
				Result := left and right
			end
		end

	visit_or (or_crit: PS_OR_CRITERION): PS_CRITERION
			-- <Precursor>
		local
			left, right: PS_CRITERION
		do
			left := visit (or_crit.left)
			right := visit (or_crit.right)

				-- Return an empty criterion in case any child node is empty.
			if left.is_empty_criterion or right.is_empty_criterion then
				Result := new_empty
			else
				Result := left or right
			end
		end

	visit_not (not_crit: PS_NOT_CRITERION): PS_CRITERION
			-- <Precursor>
		local
			child: PS_CRITERION
		do
			child := visit (not_crit.child)

				-- Eliminate the NOT node if the child node is empty!
			if child.is_empty_criterion then
				Result := child
			else
				Result := not child
			end
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): PS_CRITERION
			-- <Precursor>
		do
			Result := predef_crit
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): PS_CRITERION
			-- <Precursor>
		do
				-- Transform agent criteria leaves to empty criteria,
				-- so we only have to deal with one type to eliminate.
			Result := new_empty
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): PS_CRITERION
			-- <Precursor>
		do
			Result := empty_crit
		end

feature {NONE}

	new_empty: PS_EMPTY_CRITERION
			-- Create a new empty criterion
		do
			create Result
		end

end
