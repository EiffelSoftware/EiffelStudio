indexing
	description: "Objects that represents a NOT criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_NOT_CRITERION

inherit
	QL_UNARY_CRITERION
		undefine
			process
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR) is
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_not_criterion (Current)
		end

end
