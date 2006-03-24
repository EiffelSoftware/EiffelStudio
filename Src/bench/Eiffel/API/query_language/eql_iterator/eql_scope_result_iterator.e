indexing
	description: "Object that represents an iterator for EQL_SCOPE_RESULT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_SCOPE_RESULT_ITERATOR [G -> EQL_SOFTWARE_SINGLE_SCOPE]

inherit
	EQL_RESULT_ITERATOR [G]

	EQL_SCOPE_ITERATOR [G]

create
	make

end
