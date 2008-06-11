indexing
	description: "[
		Exception raised when retry did not succeed
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	RESUMPTION_FAILURE

inherit
	OBSOLETE_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		do
			Result := {EXCEP_CONST}.resumption_failed
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Resumption attempt failed."

end
