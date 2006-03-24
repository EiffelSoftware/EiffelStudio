indexing
	description: "Object that represents an OR logic operation upon two EQL criteria"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_OR_CRITERION

inherit
	EQL_BINARY_CRITERION

create
	make

feature -- Evaluation

	evaluate (a_ctxt: EQL_CONTEXT): BOOLEAN is
			-- Evaluate current criterium in `a_ctxt'.
		do
			Result := cri1.evaluate (a_ctxt) or cri2.evaluate (a_ctxt)
		end

end
