note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_ASSIGNMENT

inherit

	IV_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_target: IV_EXPRESSION; a_source: IV_EXPRESSION)
			-- Assign expression `a_source' to `a_target'.
		require
			a_target_attached: attached a_target
			a_target_valid: attached {IV_ENTITY} a_target or attached {IV_MAP_ACCESS} a_target
			a_source_attached: attached a_source
		do
			target := a_target
			source := a_source
		ensure
			target_set: target = a_target
			source_set: source = a_source
		end

feature -- Access

	target: IV_EXPRESSION
			-- Target of assignment.

	source: IV_EXPRESSION
			-- Source of assignment.

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_assignment (Current)
		end

invariant
	target_attached: attached target
	target_valid: attached {IV_ENTITY} target or attached {IV_MAP_ACCESS} target
	source_attached: attached source

end
