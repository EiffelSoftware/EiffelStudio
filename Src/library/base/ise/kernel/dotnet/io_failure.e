note
	description: "[
		IO exception
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	IO_FAILURE

inherit
	DATA_EXCEPTION
		rename
			get_base_exception as local_get_base_exception,
			set_source as local_set_source,
			source as local_source,
			stack_trace as local_stack_trace
		end

	DOTNET_EXCEPTION_WRAPPER
		undefine
			default_create,
			out
		end

create
	default_create

create
	{EXCEPTION_MANAGER} make_dotnet_exception

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			if internal_code = {EXCEP_CONST}.Io_exception then
				Result := internal_code
			else
					-- Default to `Runtime_io_exception'.
				Result := {EXCEP_CONST}.Runtime_io_exception
			end
		end

	error_code: INTEGER
			-- Error code, not implemented.

	tag: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_8 ("I/O error.")
		end

feature {EXCEPTION_MANAGER} -- Status setting

	set_error_code (a_code: like error_code)
			-- Set `error_code' with `a_code'
		do
			error_code := a_code
		end

	set_code (a_code: like code)
			-- Set `code' with `a_code'.
		do
			internal_code := code
		end

	internal_code: like code;
			-- Internal code

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
