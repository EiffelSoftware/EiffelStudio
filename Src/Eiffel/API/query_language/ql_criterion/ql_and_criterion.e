indexing
	description: "Object that represents a binary AND criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_AND_CRITERION

inherit
	QL_BINARY_CRITERION
		undefine
			process
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR) is
			-- Process Current using `a_criterion_visitor'.
		do
			a_criterion_visitor.process_and_criterion (Current)
		end

end
