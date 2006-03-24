indexing
	description: "Object that represents a NOT logic operation upon an EQL criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_NOT_CRITERION

inherit
	EQL_CRITERION

create
	make

feature{NONE} -- Implementation

	make (a_cri: like criterion) is
			--
		require
			a_cri_not_void: a_cri /= Void
		do
			criterion := a_cri
		ensure
			criterion_set: criterion = a_cri
		end

feature -- Evaluation

	evaluate (a_ctxt: EQL_CONTEXT): BOOLEAN is
			-- Evaluate current criterium in `a_ctxt'.
		do
			Result := not criterion.evaluate (a_ctxt)
		end

feature -- Internal criterion

	criterion: EQL_CRITERION


end
