indexing
	description: "Error object used in Eiffel Query Language."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_ERROR

feature -- Access

	code: STRING is
			-- Code error
		deferred
		ensure
			code_not_void: Result /= Void
		end
		
end
