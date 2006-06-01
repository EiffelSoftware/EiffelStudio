indexing
	description: "Error object used in Eiffel Query Language."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_ERROR

inherit
	ANY
		redefine
			out
		end

feature -- Access

	code: STRING is
			-- Code error
		deferred
		ensure
			code_not_void: Result /= Void
		end

feature -- Access

	text: STRING is
			-- The error message.
		deferred
		end

	out: STRING is
			-- Output
		do
			Result := text
		end

end
