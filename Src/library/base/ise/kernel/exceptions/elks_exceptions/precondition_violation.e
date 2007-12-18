indexing
	description: "[
		Exception representing an precondition violation.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	PRECONDITION_VIOLATION

inherit
	ASSERTION_VIOLATION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.precondition
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Precondition violated."

end
