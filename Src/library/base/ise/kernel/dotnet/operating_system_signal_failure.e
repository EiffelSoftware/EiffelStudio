indexing
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
	OPERATING_SYSTEM_SIGNAL_FAILURE

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

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.signal_exception
		end

	signal_code: INTEGER
			-- Signal code, not implemented.

feature {EXCEPTION_MANAGER} -- Status setting

	set_signal_code (a_code: like signal_code) is
			-- Set `signal_code' with `a_code'
		do
			signal_code := a_code
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Operating system signal.";

indexing
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
