indexing 
	description: "Source code generator for attribute reference"
	date: "$$"
	revision: "$$"

class
	ECD_ATTRIBUTE_REFERENCE_EXPRESSION

inherit
	ECD_REFERENCE_EXPRESSION

	ECD_SHARED_CODE_GENERATOR_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `attribute_name'.
		do
			create arguments.make
			create attribute_name.make_empty
			create current_namespace.make_empty
			create current_class.make_empty
		ensure
			non_void_attribute_name: attribute_name /= Void
			non_void_current_namespace: current_namespace /= Void
			non_void_current_class: current_class /= Void
		end

feature -- Access

	attribute_name: STRING
			-- Attribute name

	target_object: ECD_EXPRESSION
			-- Target object

	current_namespace: STRING
			-- Current namespace

	current_class: STRING
			-- Current classe

	code: STRING is
			-- | Result := "feature {`target_object'}.`attribut_name'"
			-- | OR		:= "`attribut_name'" if `target_object.name' is_equal "Current" or "current_namespace.current_class"
			-- Eiffel code of attribute reference expression
		local
			reference_expression: ECD_TYPE_REFERENCE_EXPRESSION
			this_expression: ECD_THIS_REFERENCE_EXPRESSION
			index_last_point: INTEGER
			l_full_referenced_type, l_namespace, l_referenced_type: STRING
			formatter: NAME_FORMATTER
		do
			Check
				not_empty_name: not attribute_name.is_empty
				non_void_target: target_object /= Void
			end

			create Result.make (80)

			reference_expression ?= target_object
			this_expression ?= target_object
			if this_expression = Void then
				if reference_expression /= Void then
					l_full_referenced_type := reference_expression.referred_type
					index_last_point := l_full_referenced_type.last_index_of ('.', l_full_referenced_type.count)
					if index_last_point = 0 then
						create l_namespace.make_empty
					else
						l_namespace := l_full_referenced_type.substring (1, index_last_point - 1)
						l_referenced_type := l_full_referenced_type.substring (index_last_point + 1, l_full_referenced_type.count)
					end
					create formatter
					l_referenced_type := formatter.full_formatted_type_name (l_referenced_type)
					l_full_referenced_type := l_namespace + Dictionary.Dot_keyword + l_referenced_type
					if not l_full_referenced_type.is_equal (current_namespace + Dictionary.Dot_keyword + current_class) then
						Result.append (Dictionary.Feature_keyword)
						Result.append (Dictionary.Space)
						Result.append (Dictionary.Opening_brace_bracket)
						Result.append (target_object.code)
						Result.append (Dictionary.Closing_brace_bracket)
						Result.append (Dictionary.Dot_keyword)
					end
				end
			end

			Result.append (Resolver.eiffel_entity_name (attribute_name))
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is attribute reference expression ready to be generated?
		do
			Result := attribute_name /= Void and not attribute_name.is_empty and target_object.ready
		end

	type: TYPE is
			-- Type
		local
			l_dotnet_type_name: STRING
		do
			l_dotnet_type_name := Resolver.feature_result_type (target_object.type, attribute_name, arguments)
			Result := Dotnet_types.dotnet_type (l_dotnet_type_name)
		end

feature -- Status Setting

	set_attribute_name (a_name: like attribute_name) is
			-- Set `attribute_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			attribute_name := a_name
		ensure
			attribute_name_set: attribute_name.is_equal (a_name)
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
		
invariant
	non_void_attribute_name: attribute_name /= Void
	non_void_current_namespace: current_namespace /= Void
	non_void_current_class: current_class /= Void
	
end -- class ECD_ATTRIBUTE_REFERENCE_EXPRESSION

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