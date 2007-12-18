indexing
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

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.operating_system_exception
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Operating system error."

end
