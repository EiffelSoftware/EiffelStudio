note
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

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.eiffel_runtime_panic
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "Eiffel run-time panic."

end
