indexing
	description: "[
		Exception raised in rescue clause
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	RESCUE_FAILURE

inherit
	OBSOLETE_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.rescue_exception
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Exception in rescue clause."

end
