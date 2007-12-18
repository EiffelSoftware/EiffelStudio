indexing
	description: "[
		Exception raised when an old expression evaluation failure was recorded and the expression access is attempted in postcondition.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	OLD_VIOLATION

inherit
	SYS_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.old_exception
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Old expression evaluation failed."

end
