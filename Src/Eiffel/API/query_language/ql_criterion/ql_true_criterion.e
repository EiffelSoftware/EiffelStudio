indexing
	description: "Object that represent a True criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_TRUE_CRITERION

inherit
	QL_CRITERION
		undefine
			process
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR) is
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_true_criterion (Current)
		end

end
