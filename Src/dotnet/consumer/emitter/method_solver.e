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
			if
				internal_method.is_special_name and
				(internal_method.name.equals (op_explicit) or
					internal_method.name.equals (op_implicit))
			then
				if
					internal_method.get_parameters.count = 1 and
					not internal_method.return_type.equals_type (Void_type)
				then
					is_conversion_operator := True
				end
			end
			arguments := solved_arguments (meth)
		ensure
			method_set: internal_method = meth
			arguments_set: arguments /= Void
		end

		
feature -- Access

	dotnet_name: STRING is
			-- .NET name
		do
			create Result.make_from_cil (internal_method.name)
		end
		
	starting_resolution_name: STRING is
			-- .NET Name used to perform overloading resolution
		do
			Result := dotnet_name
			if is_get_property and then Result.substring_index ("get_", 1) = 1 then
				Result.remove_head (4)
			elseif is_conversion_operator then
				if internal_method.get_parameters.item (0).parameter_type.equals_type (internal_method.reflected_type) then
					Result := clone (to_conversion_name)
					Result.append (
						formatted_variable_type_name (referenced_type_from_type (
							internal_method.return_type).name))
				else
					Result := clone (from_conversion_name)
					Result.append (
						formatted_variable_type_name (referenced_type_from_type (
							internal_method.get_parameters.item (0).parameter_type).name))
				end
			end
		end

	eiffel_name: STRING
			-- Eiffel name

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Method arguments

	is_get_property: BOOLEAN
			-- Is getter method of a property?
		
	is_conversion_operator: BOOLEAN
			-- Is Current a conversion operator?

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

feature {NONE} -- Constants

	Void_type: TYPE is
			-- Void .NET type
		once
			Result := feature {TYPE}.get_type_string (("System.Void").to_cil)
		end

	op_implicit: SYSTEM_STRING is "op_Explicit"
	op_explicit: SYSTEM_STRING is "op_Implicit"
			-- Special routine for conversion.

	from_conversion_name: STRING is "from_"
	to_conversion_name: STRING is "to_"
			-- Generated name corresponding to `op_xx'.

end -- class METHOD_SOLVER
