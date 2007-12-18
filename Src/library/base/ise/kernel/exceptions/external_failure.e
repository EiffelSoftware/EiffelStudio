indexing
	description: "[
			Exception for operating system error
			which does not set the `errno' variable (Unix-specific)
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_FAILURE

inherit
	EIFFEL_RUNTIME_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.external_exception
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "External event."

end
