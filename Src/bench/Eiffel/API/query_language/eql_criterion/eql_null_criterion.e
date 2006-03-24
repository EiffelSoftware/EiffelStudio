indexing
	description: "Object that represents an EQL criterion which is always satisfied"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_NULL_CRITERION

inherit
	EQL_CRITERION

feature -- Evaluation

	evaluable (a_ctxt: EQL_CONTEXT): BOOLEAN is
			-- Is current criterium evaluable on context `a_ctxt'?
		do
			Result := True
		end

	evaluate (a_ctxt: EQL_CONTEXT): BOOLEAN is
			-- Evaluate current criterium in `a_ctxt'.
		do
			Result := True
		end

end
