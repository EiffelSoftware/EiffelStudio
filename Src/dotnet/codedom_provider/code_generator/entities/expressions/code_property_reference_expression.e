indexing 
	description: "Source code generator for property reference expressions"
	date: "$$"
	revision: "$$"

class
	CODE_PROPERTY_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION
	
	CODE_SHARED_CODE_GENERATOR_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `property_name'.
			-- Initialize `is_set_reference' to true
		do
			create arguments.make
			create property_name.make_empty
			is_set_reference := false
		ensure
			non_void_property_name: property_name /= Void
		end
		
feature -- Access

	property_name: STRING
			-- Name of property to reference
			
	target_object: CODE_EXPRESSION
			-- Target object
	
	is_set_reference: BOOLEAN
			-- get or set reference?
			
	current_namespace: STRING
			-- Current namespace
			
	current_class: STRING
			-- Current classe

	code: STRING is
			-- | Result := "[`target_object'.]set_`property_name'"	 if `is_set_reference' else
			-- | OR		:= "[`target_object'.]`property_name'"
			-- | OR		:= "feature {`target_object'}.set/get_`property_name'" if typeof `target_object' is CODE_TYPE_REFERENCE_EXPRESSION
			-- Eiffel code of property reference expression
		local
			target_name: STRING
			type_ref_exp: CODE_TYPE_REFERENCE_EXPRESSION
		do
			check
				not_empty_property_name: not property_name.is_empty
				non_void_target: target_object /= Void
			end

			create Result.make (120)
			
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
				if 	not target_name.is_equal (current_namespace + Dictionary.Dot_keyword + current_class)
				and not target_name.is_equal (Dictionary.Current_keyword) then
					Result.append (target_name)
					Result.append (Dictionary.Dot_keyword)
				end
			end
			
			if is_set_reference then
				Result.append (Dictionary.Set_keyword)
				Result.append ("_")
			end
			Result.append (Resolver.eiffel_entity_name (property_name))
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is property reference expression ready to be generated?
		do
			Result := property_name /= Void and not property_name.is_empty
		end

	type: TYPE is
			-- Type
		local
			l_dotnet_type_name: STRING
		do
			if is_set_reference then
				Result := Void
			else
				l_dotnet_type_name := Resolver.feature_result_type (target_object.type, property_name, arguments)
				if l_dotnet_type_name /= Void then
					Result := Dotnet_types.dotnet_type (l_dotnet_type_name)
				end
			end
		end

feature -- Status Setting

	set_property_name (a_name: like property_name) is
			-- Set `property_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			property_name := a_name
		ensure
			property_name_set: property_name = a_name
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
		
	set_is_set_reference (a_bool: like is_set_reference) is
			-- Set `is_set_reference' with `a_bool'.
		require
			non_void_expression: a_bool /= Void
		do
			is_set_reference := a_bool
		ensure
			is_set_reference_set: is_set_reference = a_bool
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

invariant
	non_void_property_name: property_name /= Void
	
end -- class CODE_PROPERTY_REFERENCE_EXPRESSION

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