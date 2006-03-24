indexing
	description: "Object that provide iterator in EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_ITERABLE [G -> EQL_ITERABLE_ITEM]

feature -- Iterator

	itr: EQL_ITERATOR [G] is
			-- Iterator
		deferred
		ensure
			Result_set: Result /= Void
		end

	distinct_itr: EQL_DISTINCT_ITERATOR [G] is
			-- Distinct iterator
		deferred
		ensure
			Result_set: Result /= Void
		end

end
