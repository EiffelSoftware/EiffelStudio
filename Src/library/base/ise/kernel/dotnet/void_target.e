indexing
	description: "[
		Exception for feature applied to void reference.
		This type replace .NET NullReferenceException, and works as an adapter.
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_TARGET

inherit
	LANGUAGE_EXCEPTION
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
			default_create
		end

create
	default_create

create
	{EXCEPTION_MANAGER}make_dotnet_exception

feature -- Access

	code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.void_call_target
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Feature call on void target.";

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
