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

	make (meth: METHOD_INFO) is
			-- Set `internal_method' with `meth'.
		require
			non_void_method: meth /= Void
		do
			internal_method := meth
			arguments := solved_arguments (meth)
		ensure
			method_set: internal_method = meth
			arguments_set: arguments /= Void
		end

feature -- Status Report

	is_infix: BOOLEAN is
			-- Is function an infix function?
		require
			is_function: is_function
		do
			if not internal_is_infix_set then
				internal_is_infix := internal_method.get_name.get_length > 3 and then
						internal_method.get_is_special_name and then
						internal_method.get_name.starts_with (Operator_name_prefix.to_cil) and then
						internal_method.get_parameters.item (0).get_parameter_type.equals (internal_method.get_reflected_type)
				internal_is_infix_set := True
			end
			Result := internal_is_infix
		end

	is_prefix: BOOLEAN is
			-- Is function a prefix function?
		require
			is_function: is_function
		do
			if not internal_is_prefix_set then
				internal_is_prefix := internal_method.get_name.get_length > 3 and then
						internal_method.get_is_special_name and then
						internal_method.get_name.starts_with (Operator_name_prefix.to_cil) and then
						internal_method.get_parameters.get_length = 1
				internal_is_prefix_set := True
			end
			Result := internal_is_prefix
		end
		
	is_function: BOOLEAN is
			-- Is method a function?
		do
			if not internal_is_function_set then
				internal_is_function := not internal_method.get_return_type.equals (Void_type)
				internal_is_function_set := True
			end
			Result := internal_is_function
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

	consumed_procedure: CONSUMED_PROCEDURE is
			-- Consumed procedure
		require
			is_procedure: not is_function
			name_set: eiffel_name /= Void
		do
			create Result.make (
								eiffel_name,
								create {STRING}.make_from_cil (internal_method.get_name),
								arguments,
								internal_method.get_is_final,
								internal_method.get_is_static,
								internal_method.get_is_abstract)		
		end
	
	consumed_function: CONSUMED_FUNCTION is
			-- Consumed function
		require
			is_function: is_function
			name_set: eiffel_name /= Void
		do
			create Result.make (
								eiffel_name,
								create {STRING}.make_from_cil (internal_method.get_name),
								arguments,
								referenced_type_from_type (internal_method.get_return_type),
								internal_method.get_is_final,
								internal_method.get_is_static,
								internal_method.get_is_abstract,
								is_infix,
								is_prefix)			
		end
		
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
			Result := internal_method.get_parameters.count < other.internal_method.get_parameters.count
		end
		
feature {METHOD_SOLVER} -- Implementation

	internal_method: METHOD_INFO
			-- Method to be consumed

feature {NONE} -- Implementation

	Void_type: TYPE is
			-- Void .NET type
		once
			Result := feature {TYPE}.get_type_string (("System.Void").to_cil)
		end

	Operator_name_prefix: STRING is "op_"
			-- Special prefix for .NET operators

	internal_is_prefix_set: BOOLEAN
			-- Was `internal_is_prefix' calculated?
	
	internal_is_prefix: BOOLEAN
			-- Cached value for `is_prefix'
	
	internal_is_infix_set: BOOLEAN
			-- Was `internal_is_infix' calculated?
		
	internal_is_infix: BOOLEAN
			-- Cached value for `is_infix'
	
	internal_is_function_set: BOOLEAN
			-- Was `internal_is_function' calculated?
	
	internal_is_function: BOOLEAN
			-- Cached value for `is_function'

end -- class METHOD_SOLVER
