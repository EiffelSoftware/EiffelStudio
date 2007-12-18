indexing
	description: "[
		.NET exception
		]"
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
			internal_meaning
		end

	DOTNET_EXCEPTION_WAPPER
		undefine
			default_create
		end


create {EXCEPTION_MANAGER}
	make_dotnet_exception

feature

	code: INTEGER_32
			-- Exception code.
			-- Default to developer exception code.
		once
			Result := {EXCEP_CONST}.developer_exception
		end

feature {NONE}

	internal_meaning: STRING_8 is ".NET exception."

end
