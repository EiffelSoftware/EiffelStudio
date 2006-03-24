indexing
	description: "Object that represents a criterion used in EQL querys"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_CRITERION


feature -- Evaluation

	evaluate (a_ctxt: EQL_CONTEXT): BOOLEAN is
			-- Evaluate current criterium in `a_ctxt'.
		require
			a_context_not_void: a_ctxt /= Void
		deferred
		end

feature -- Logic operations

	infix "and" (other: like Current): EQL_CRITERION is
			-- Boolean conjunction with `other'
		require
			other_exists: other /= Void
		do
			create {EQL_AND_CRITERION}Result.make (Current, other)
		ensure
			Result_not_void: Result /= Void
		end

	prefix "not": EQL_CRITERION is
			-- Negation
		do
			create {EQL_NOT_CRITERION}Result.make (Current)
		ensure
			Result_not_void: Result /= Void
		end

	infix "or" (other: like Current): EQL_CRITERION is
			-- Boolean disjunction with `other'
		require
			other_exists: other /= Void
		do
			create {EQL_OR_CRITERION}Result.make (Current, other)
		ensure
			Result_not_void: Result /= Void
		end

end
