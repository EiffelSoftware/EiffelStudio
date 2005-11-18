indexing
	description: "Collections of stateless BYTE_NODE visitors."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_BN_STATELESS_VISITOR

feature -- Visitors

	melted_generator: MELTED_GENERATOR is
			-- Generator for melted code.
		once
			create Result
		ensure
			melted_generator_not_void: Result /= Void
		end

	melted_assignment_generator: MELTED_ASSIGNMENT_GENERATOR is
			-- Generator assignments for melted code.
		once
			create Result
		ensure
			melted_assignment_generator_not_void: Result /= Void
		end

end
