indexing
	description: "Object that represents a binary OR criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_OR_CRITERION

inherit
	QL_BINARY_CRITERION
		undefine
			process
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR) is
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_or_criterion (Current)
		end

end
