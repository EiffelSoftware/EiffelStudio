indexing
	description: "[
		Exception for feature applied to void reference.
		This type replace .NET NullReferenceException, and works as an adapter.
		]"
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

	DOTNET_EXCEPTION_WAPPER
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

	frozen internal_meaning: STRING is "Feature call on void target."

end
