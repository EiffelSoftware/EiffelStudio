note
	description: "[
		Operating system failure
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	OPERATING_SYSTEM_FAILURE

inherit
	OPERATING_SYSTEM_EXCEPTION
		rename
			get_base_exception as local_get_base_exception,
			set_source as local_set_source,
			source as local_source,
			stack_trace as local_stack_trace
		redefine
			internal_meaning
		end

	DOTNET_EXCEPTION_WRAPPER
		undefine
			default_create,
			out
		end

create
	default_create

create
	{EXCEPTION_MANAGER}make_dotnet_exception

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.operating_system_exception
		end

	error_code: INTEGER
			-- Error code, not implemeted.

feature {EXCEPTION_MANAGER} -- Status setting

	set_Error_code (a_code: like Error_code)
			-- Set `Error_code' with `a_code'
		do
			Error_code := a_code
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "Operating system error.";

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
