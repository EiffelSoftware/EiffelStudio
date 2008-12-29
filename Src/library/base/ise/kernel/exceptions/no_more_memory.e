note
	description: "[
		Exception raised when no more memory can be allocated.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	NO_MORE_MEMORY

inherit
	EIFFEL_RUNTIME_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.no_more_memory
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "No more memory."

end
