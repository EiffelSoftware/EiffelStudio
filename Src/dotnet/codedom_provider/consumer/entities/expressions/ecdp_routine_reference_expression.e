indexing 
	description: "Source code generator for method reference expressions"
	date: "$$"
	revision: "$$"
	
class
	ECDP_ROUTINE_REFERENCE_EXPRESSION

inherit
	ECDP_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `routine_name' and `target_object'.
		do
			create arguments.make
			create routine_name.make_empty
			create current_namespace.make_empty
			create current_class.make_empty
		ensure
			non_void_routine_name: routine_name /= Void
			non_void_current_namespace: current_namespace /= Void
			non_void_current_class: current_class /= Void
		end
		
feature -- Access

	routine_name: STRING
			-- Routine name
			
	target_object: ECDP_EXPRESSION
			-- Target object
			
	current_namespace: STRING
			-- Current namespace
			
	current_class: STRING
			-- Current classe
			
	code: STRING is
			-- | Result := "`target_object'.`routine_name'"
			-- | OR		:= "`routine_name'" if `target_object.name' is_equal "Current" or "current_namespace.current_class"
			-- | OR		:= "feature {`target_object'}.`routine_name'" if typeof `target_object' is ECDP_TYPE_REFERENCE_EXPRESSION.
			
			-- | Set `dummy_variable' to true if `returned_type_routine' /= Void
			-- Eiffel code of routine reference expression
		local
			target_name: STRING
			type_ref_exp: ECDP_TYPE_REFERENCE_EXPRESSION
			l_returned_type_name: STRING
		do
			check
				not_empty_routine_name: not routine_name.is_empty
				routine_arguments_set: arguments /= Void
			end

			create Result.make (120)
			if target_object /= Void then
				type_ref_exp ?= target_object
				if type_ref_exp /= Void then
					Result.append (Dictionary.Feature_keyword)
					Result.append (Dictionary.Space)
					Result.append (Dictionary.Opening_brace_bracket)
					Result.append (target_object.code)
					Result.append (Dictionary.Closing_brace_bracket)
					Result.append (Dictionary.Dot_keyword)
				else
					target_name := target_object.code
					if 
						not target_name.is_equal (current_namespace + Dictionary.Dot_keyword + current_class)
						and not target_name.is_equal (Dictionary.Current_keyword)
					then
						Result.append (target_name)
						Result.append (Dictionary.Dot_keyword)
					end
					if caller_type /= Void then
						l_returned_type_name := Eiffel_types.returned_type_feature (caller_type, routine_name, arguments)
						if l_returned_type_name /= Void and then not l_returned_type_name.is_equal ("System.Void") then
							set_dummy_variable (True) 
						end
					end
				end
			end

			Result.append (generated_routine_name)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is routine reference expression ready to be generated?
		do
			Result := routine_name /= Void and then not routine_name.is_empty --and target_object.ready
		end
		
	type: TYPE is
			-- Type
		local
			l_dotnet_type_name: STRING
		do
			l_dotnet_type_name := Eiffel_types.returned_type_feature (caller_type, routine_name, arguments)
			if l_dotnet_type_name /= Void then
				Result := Eiffel_types.dotnet_type (l_dotnet_type_name)
			else
					-- just to not return Void. But it is incorrect!!!
				Result := target_object.type
			end
		end

feature -- Status Setting

	set_routine_name (a_name: like routine_name) is
			-- Set `routine_name' with `a_name'.
			-- `target_object' must have been set before!
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			routine_name := a_name
		ensure
			routine_name_set: routine_name = a_name
		end		

	set_target_object (an_expression: like target_object) is
			-- Set `target_object' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			target_object := an_expression
		ensure
			target_object_set: target_object = an_expression
		end

	set_current_namespace (a_current_namespace: like current_namespace) is
			-- Set `current_namespace' with `a_current_namespace'.
		require
			non_void_current_namespace: a_current_namespace /= Void
		do
			current_namespace := a_current_namespace
		ensure
			current_namespace_set: current_namespace.is_equal (a_current_namespace)
		end

	set_current_class (a_current_class: like current_class) is
			-- Set `current_class' with `a_current_class'.
		require
			non_void_current_class: a_current_class /= Void
		do
			current_class := a_current_class
		ensure
			current_class_set: current_class.is_equal (a_current_class)
		end		

feature {NONE} -- Implementation

	generated_routine_name: STRING is
			-- call `Eiffel_types.routine_name'
		require
			routine_name_set: not routine_name.is_empty
		local
			this_target_object: ECDP_THIS_REFERENCE_EXPRESSION
		do
			if target_object /= Void then
				this_target_object ?= target_object
	
				if caller_type /= Void and this_target_object = Void then
					Result := Eiffel_types.eiffel_feature_name_from_dynamic_args (caller_type, routine_name, arguments)
				else
					Result := Eiffel_types.find_variable_name (routine_name)
				end
			else
				Result := Eiffel_types.find_variable_name (routine_name)
			end
		ensure
			non_void_result: Result /= Void
		end

	internal_caller_type: TYPE
	
	caller_type: TYPE is
			-- dotnet name of the caller's type.
		require
			routine_name_set: not routine_name.is_empty
			target_object_set: target_object /= Void
		local
			this_target_object: ECDP_THIS_REFERENCE_EXPRESSION
			argument_target_object: ECDP_ARGUMENT_REFERENCE_EXPRESSION
			variable_target_object: ECDP_VARIABLE_REFERENCE_EXPRESSION
			type_target_object: ECDP_TYPE_REFERENCE_EXPRESSION
			parent_name: STRING
		do
			if internal_caller_type /= Void then
				Result := internal_caller_type
			else
				this_target_object ?= target_object
				if this_target_object /= Void then
					parent_name := Eiffel_types.where_is_implemented_feature (current_class, routine_name, arguments)
					if parent_name /= Void and then parent_name.is_equal (current_class) then
						Result := this_target_object.type
					else
						Result := Eiffel_types.dotnet_type (parent_name)
					end
				else
					argument_target_object ?= target_object
					if argument_target_object /= Void then
						Result := argument_target_object.type
					else
						type_target_object ?= target_object
						if type_target_object /= Void then
							Result := type_target_object.type
						else
							variable_target_object ?= target_object
							if variable_target_object /= Void then
								Result := variable_target_object.type
							else
								Result := Void
							end
						end
					end
				end
				internal_caller_type := Result
			end
		end

invariant
	non_void_routine_name: routine_name /= Void
	non_void_current_namespace: current_namespace /= Void
	non_void_current_class: current_class /= Void
	
end -- class ECDP_ROUTINE_REFERENCE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------