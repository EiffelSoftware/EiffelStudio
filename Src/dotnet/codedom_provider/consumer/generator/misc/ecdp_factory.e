indexing
	description: "Generic code generator, common ancestor of all code generators"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECDP_FACTORY

inherit
	ECDP_SHARED_CONSUMER_CONTEXT
		export
			{NONE} all
		end

feature -- Code generation history

	current_namespace: ECDP_NAMESPACE is
			-- Namespace currently examined.
		do
			Result := internal_current_namespace.item
		ensure
			non_void_namespace: Result /= Void
		end

	current_type: ECDP_GENERATED_TYPE is
			-- Type currently examined.
		do
			Result := internal_current_type.item
		ensure
			non_void_type: Result /= Void
		end

	current_routine: ECDP_ROUTINE is
			-- Routine currently examined.
		do
			Result := internal_current_routine.item
		ensure
			non_void_routine: Result /= Void
		end

	last_compile_unit: ECDP_COMPILE_UNIT is
			-- Compile unit lastly examined.
		do
			Result := internal_last_compile_unit.item
		ensure
			non_void_compile_unit: Result /= Void
		end

	last_namespace: ECDP_NAMESPACE is
			-- Namespace lastly examined.
		do
			Result := internal_last_namespace.item
		ensure
			non_void_namespace: Result /= Void
		end		

	last_type: ECDP_GENERATED_TYPE is
			-- Type lastly examined.
		do
			Result := internal_last_type.item
		ensure
			non_void_type: Result /= Void
		end

	last_feature: ECDP_FEATURE is
			-- Routine lastly examined.
		do
			Result := internal_last_feature.item
		ensure
			non_void_feature: Result /= Void
		end

	last_statement: ECDP_STATEMENT is
			-- Statement lastly examined.
		do
			Result := internal_last_statement.item
		ensure
			non_void_statement: Result /= Void
		end

	last_expression: ECDP_EXPRESSION is
			-- Expression lastly examined.
		do
			Result := internal_last_expression.item
		ensure
			non_void_expression: Result /= Void
		end

	last_catch_clause: ECDP_CATCH_CLAUSE is
			-- Catch clause lastly examined.
		do
			Result := internal_last_catch_clause.item
		ensure
			non_void_catch_clause: Result /= Void
		end
		
	last_return_type: ECDP_TYPE is
			-- Reuturn type lastly examined.
		do
			Result := internal_last_return_type.item
		ensure
			non_void_return_type: Result /= Void
		end

	last_custom_attribute_declaration: ECDP_ATTRIBUTE_DECLARATION is
			-- Return last_custom_attribute_declaration.
		do
			Result := internal_last_custom_attribute_declaration.item
		ensure
			non_void_last_custom_attribute_declaration: Result /= Void
		end

	last_custom_attribute_argument: ECDP_ATTRIBUTE_ARGUMENT is
			-- Return last_custom_attribute_argument.
		do
			Result := internal_last_custom_attribute_argument.item
		ensure
			non_void_last_custom_attribute_argument: Result /= Void
		end

feature -- Status Setting

	set_current_namespace (a_namespace: like current_namespace) is
			-- Set `current_namespace' with `a_namespace'.
		require
		do
			internal_current_namespace.put (a_namespace)
		ensure
			current_namespace_set: current_namespace = a_namespace
		end		

	set_current_type (a_type: like current_type) is
			-- Set `current_type' with `a_type'.
		require
		do
			internal_current_type.put (a_type)
		ensure
			current_type_set: current_type = a_type
		end		

	set_current_routine (a_routine: like current_routine) is
			-- Set `current_routine' with `a_routine'.
		require
		do
			internal_current_routine.put (a_routine)
		ensure
			current_routine_set: current_routine = a_routine
		end

	set_last_compile_unit (a_compile_unit: like last_compile_unit) is
			-- Set `last_compile_unit' with `a_compile_unit'.
		require
			non_void_compile_unit: a_compile_unit /= Void
		do
			internal_last_compile_unit.put (a_compile_unit)
		ensure
			last_compile_unit_set: last_compile_unit = a_compile_unit
		end
		
	set_last_namespace (a_namespace: like last_namespace) is
			-- Set `last_namespace' with `a_namespace'.
		require
			non_void_namespace: a_namespace /= Void
		do
			internal_last_namespace.put (a_namespace)
		ensure
			last_namespace_set: last_namespace = a_namespace
		end

	set_last_type (a_type: like last_type) is
			-- Set `last_type' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			internal_last_type.put (a_type)
		ensure
			last_type_set: last_type = a_type
		end		

	set_last_feature (a_feature: like last_feature) is
			-- Set `last_feature' with `a_feature'.
		require
			non_void_routine: a_feature /= Void
		do
			internal_last_feature.put (a_feature)
		ensure
			last_feature_set: last_feature = a_feature
		end

	set_last_statement (a_statement: like last_statement) is
			-- Set `last_statement' with `a_statement'.
		require
			non_void_statement: a_statement /= Void
		do
			internal_last_statement.put (a_statement)
		ensure
			last_statement_set: last_statement = a_statement
		end

	set_last_expression (an_expression: like last_expression) is
			-- Set `last_expression' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			internal_last_expression.put (an_expression)
		ensure
			last_expression_set: last_expression = an_expression
		end

	set_last_catch_clause (a_catch_clause: like last_catch_clause) is
			-- Set `last_catch_clause' with `a_catch_clause'.
		require
			non_void_catch_clause: a_catch_clause /= Void
		do
			internal_last_catch_clause.put (a_catch_clause)
		ensure
			last_catch_clause_set: last_catch_clause = a_catch_clause
		end
	
	set_last_return_type (a_return_type: like last_return_type) is
			-- Set `last_return_type' with `a_return_type'.
		require
			non_void_return_type: a_return_type /= Void
		do
			internal_last_return_type.put (a_return_type)
		ensure
			last_return_type_set: last_return_type = a_return_type
		end

	set_last_custom_attribute_declaration (a_custom_attribute_declaration: like last_custom_attribute_declaration) is
			-- Set `custom_attribute_declaration' with `a_custom_attribute_declaration'.
		require
			non_void_a_custom_attribute_declaration: a_custom_attribute_declaration /= Void
		do
			internal_last_custom_attribute_declaration.put (a_custom_attribute_declaration)
		ensure
			custom_attribute_declaration_set: last_custom_attribute_declaration = a_custom_attribute_declaration
		end
		
	set_last_custom_attribute_argument (a_custom_attribute_argument: like last_custom_attribute_argument) is
			-- Set `custom_attribute_argument' with `a_custom_attribute'.
		require
			non_void_a_custom_attribute_argument: a_custom_attribute_argument /= Void
		do
			internal_last_custom_attribute_argument.put (a_custom_attribute_argument)
		ensure
			custom_attribute_argument_set: last_custom_attribute_argument = a_custom_attribute_argument
		end

feature {NONE} -- Implementation

	internal_current_namespace: CELL [ECDP_NAMESPACE] is
			-- Internal representation of `current_namespace'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_current_type: CELL [ECDP_GENERATED_TYPE] is
			-- Internal representation of `current_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_current_routine: CELL [ECDP_ROUTINE] is
			-- Internal representation of `current_routine'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_compile_unit: CELL [ECDP_COMPILE_UNIT] is
			-- Internal representation of `last_compile_unit'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_namespace: CELL [ECDP_NAMESPACE] is
			-- Internal representation of `last_namespace'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end	

	internal_last_type: CELL [ECDP_GENERATED_TYPE] is
			-- Internal representation of `last_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_feature: CELL [ECDP_FEATURE] is
			-- Internal representation of `last_feature'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_statement: CELL [ECDP_STATEMENT] is
			-- Internal representation of `last_statement'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_expression: CELL [ECDP_EXPRESSION] is
			-- Internal representation of `last_expression'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_catch_clause: CELL [ECDP_CATCH_CLAUSE] is
			-- Internal representation of `last_catch_clause'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_return_type: CELL [ECDP_TYPE] is
			-- Internal representation of `last_return_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_custom_attribute_declaration: CELL [ECDP_ATTRIBUTE_DECLARATION] is
			-- Internal representation of `last_custom_attribute_declaration'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_custom_attribute_argument: CELL [ECDP_ATTRIBUTE_ARGUMENT] is
			-- Internal representation of `last_custom_attribute_argument'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

feature {NONE} -- Implementation

	code_dom_generator: ECDP_CONSUMER_FACTORY is
			-- Instance of a ECDP_CONSUMER_FACTORY.
		once
			create Result.make
		ensure
			code_dom_source_created: Result /= Void
		end
		
end -- class ECDP_FACTORY

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