indexing
	description: "Object that represents a distinct iterator for EQL_SCOPE_RESULT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_DISTINCT_SCOPE_RESULT_ITERATOR [G -> EQL_SOFTWARE_SINGLE_SCOPE]

inherit
	EQL_DISTINCT_RESULT_ITERATOR [G]

	EQL_DISTINCT_SCOPE_ITERATOR [G]

create
	make

end
