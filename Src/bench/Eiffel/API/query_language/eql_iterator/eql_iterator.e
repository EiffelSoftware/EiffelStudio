indexing
	description: "Object that represents an iterator for an EQL result"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_ITERATOR [G -> EQL_ITERABLE_ITEM]

inherit
	LINEAR [G]

feature -- Distinct option

	distinct_list: LIST [G] is
			-- List containing only distinct EQL_RESULT_ITEMs
		deferred
		end

feature -- Fail fast status

	valid_status: BOOLEAN is
			-- Is the structure to be iterated in a valid status?
			-- e.g. structure has not been changed after current iterator `start'.
		deferred
		end

end
