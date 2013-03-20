note
	description: "[
		Operating system signal failure
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	OPERATING_SYSTEM_SIGNAL_FAILURE

inherit
	OPERATING_SYSTEM_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.signal_exception
		end

	signal_code: INTEGER
			-- Signal code

feature {EXCEPTION_MANAGER} -- Status setting

	set_signal_code (a_code: like signal_code)
			-- Set `signal_code' with `a_code'
		do
			signal_code := a_code
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "Operating system signal."

end
