indexing
	description: ".NET method argument"

class
	CONSUMED_ARGUMENT

inherit
	NAME_FORMATTER

create
	make

feature {NONE} -- Initialization

	make (p: PARAMETER_INFO) is
			-- Initialize from `p'.
		require
			non_void_parameter: p /= Void
		do
			create dotnet_name.make_from_cil (p.get_name)
			eiffel_name := format_variable_name (dotnet_name)
			create type.make (p.get_parameter_type)
			is_out := p.get_is_out
		end
		
feature -- Access

	dotnet_name: STRING
			-- .NET name
	
	eiffel_name: STRING
			-- Eiffel name
	
	type: CONSUMED_REFERENCED_TYPE
			-- Variable type

	is_out: BOOLEAN
			-- Out argument?

end -- class CONSUMED_ARGUMENT
