indexing
	description: "[
		Eiffel runtime panic
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_RUNTIME_PANIC

inherit
	SYS_EXCEPTION

feature -- Access

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.eiffel_runtime_panic
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Eiffel run-time panic."

end
