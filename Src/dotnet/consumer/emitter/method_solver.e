indexing
	description: "Method to be consumed in Eiffel, intermediate structure used to solve overloading"
	date: "$Date$"
	revision: "$Revision$"

class
	METHOD_SOLVER

inherit
	COMPARABLE
	
	NAME_FORMATTER
		undefine
			is_equal
		end

	ARGUMENT_SOLVER
		rename
			arguments as solved_arguments
		undefine
			is_equal
		end

	SHARED_ASSEMBLY_MAPPING
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (meth: METHOD_INFO; get_property: BOOLEAN) is
			-- Set `internal_method' with `meth'.
		require
			non_void_method: meth /= Void
		do
			internal_method := meth
			is_get_property := get_property
			arguments := solved_arguments (meth)
		ensure
			method_set: internal_method = meth
			arguments_set: arguments /= Void
		end

		
feature -- Access

	dotnet_name: STRING is
			-- .NET name
		do
			create Result.make_from_cil (internal_method.get_name)
		end
	
	eiffel_name: STRING
			-- Eiffel name

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Method arguments

	is_get_property: BOOLEAN
			-- Is getter method of a property?
		
feature -- Element Settings

	set_eiffel_name (name: like eiffel_name) is
			-- Set `eiffel_name' with `name'.
		require
			non_void_name: name /= Void
		do
			eiffel_name := name
		ensure
			name_set: eiffel_name = name
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := arguments.count < other.arguments.count
		end
		
feature {METHOD_SOLVER, OVERLOAD_SOLVER} -- Implementation

	internal_method: METHOD_INFO
			-- Method to be consumed


end -- class METHOD_SOLVER
