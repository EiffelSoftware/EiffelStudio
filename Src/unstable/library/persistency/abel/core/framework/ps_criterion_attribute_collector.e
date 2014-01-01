note
	description: "Visitor for object trees to collect the required attributes for criterion evaluation."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRITERION_ATTRIBUTE_COLLECTOR

inherit
	PS_CRITERION_VISITOR [INTEGER]

create
	make

feature {PS_ABEL_EXPORT} -- Access

	attributes: ARRAYED_LIST [STRING]
			-- The collected attributes.

feature {PS_CRITERION} -- Visitor functions

	visit_and (and_crit: PS_AND_CRITERION): INTEGER
			-- <Precursor>
		do
			Result:= visit (and_crit.left)
			Result:=visit (and_crit.right)
		end

	visit_or (or_crit: PS_OR_CRITERION): INTEGER
			-- <Precursor>
		do
			Result:=visit (or_crit.left)
			Result:=visit (or_crit.right)
		end
	visit_not (not_crit: PS_NOT_CRITERION): INTEGER
			-- <Precursor>
		do
			Result:=visit (not_crit.child)
		end

	visit_predefined (predef_crit: PS_PREDEFINED_CRITERION): INTEGER
			-- <Precursor>
		do
			attributes.extend (predef_crit.attribute_name)
		end

	visit_agent (agent_crit: PS_AGENT_CRITERION): INTEGER
			-- <Precursor>
		local
			error: PS_INTERNAL_ERROR
		do
			create error
			error.raise
		end

	visit_empty (empty_crit: PS_EMPTY_CRITERION): INTEGER
			-- <Precursor>
		do
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create attributes.make (5)
		end

end
