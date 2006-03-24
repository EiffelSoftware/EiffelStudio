indexing
	description: "Object that represents a software single scope"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_SOFTWARE_SINGLE_SCOPE

inherit
	EQL_SINGLE_SCOPE
		undefine
			is_equal
		end

	EQL_SOFTWARE_ITEM

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		deferred
		end

end
