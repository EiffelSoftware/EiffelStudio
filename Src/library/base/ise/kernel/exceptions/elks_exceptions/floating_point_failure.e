indexing
	description: "[
		Floating point failure
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	FLOATING_POINT_FAILURE

inherit
	HARDWARE_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.floating_point_exception
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Floating point exception."

end
