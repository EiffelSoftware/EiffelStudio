note
	description: "[
		Operating system failure
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	OPERATING_SYSTEM_FAILURE

inherit
	OPERATING_SYSTEM_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.operating_system_exception
		end

	error_code: INTEGER
			-- Error code

feature {EXCEPTION_MANAGER} -- Status setting

	set_Error_code (a_code: like Error_code)
			-- Set `Error_code' with `a_code'
		do
			Error_code := a_code
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "Operating system error."

end
