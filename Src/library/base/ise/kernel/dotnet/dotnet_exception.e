note
	description: ".NET exception."
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_EXCEPTION

inherit
	EXCEPTION
		rename
			get_base_exception as local_get_base_exception,
			set_source as local_set_source,
			source as local_source,
			stack_trace as local_stack_trace
		redefine
			code,
			tag
		end

	DOTNET_EXCEPTION_WRAPPER
		undefine
			default_create,
			out
		end


create {EXCEPTION_MANAGER}
	make_dotnet_exception

feature -- Access

	code: INTEGER_32
			-- Exception code.
			-- Default to developer exception code.
		once
			Result := {EXCEP_CONST}.developer_exception
		end

	tag: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_8 (".NET exception.")
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
