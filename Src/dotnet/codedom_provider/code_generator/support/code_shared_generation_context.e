indexing
	description: "Contextual generation information, include currently generated namespace, type, method etc..."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_GENERATION_CONTEXT

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	current_context: STRING is
			-- Current context, includes routine and type names if any
		local
			l_string1, l_string2, l_string3, l_string4: STRING
		do
			if current_type = Void then
				if current_namespace /= Void then
					l_string1 := current_namespace.name
					create Result.make (l_string1.count + 10)
					Result.append ("namespace ")
					Result.append (l_string1)
				else
					Result := ""
				end
			else
				l_string1 := current_type.eiffel_name
				l_string2 := current_type.full_name
				if internal_current_feature = Void then
					create Result.make (8 + l_string1.count + l_string2.count)
					Result.append ("type ")
					Result.append (l_string1)
					Result.append (" (")
					Result.append (l_string2)
					Result.append_character (')')
				else
					l_string3 := current_feature.eiffel_name
					l_string4 := current_feature.name
					create Result.make (20 + l_string1.count + l_string2.count + l_string3.count + l_string4.count)
					Result.append ("routine ")
					Result.append (l_string3)
					Result.append (" (")
					Result.append (l_string4)
					Result.append (") from ")
					Result.append (l_string1)
					Result.append (" (")
					Result.append (l_string2)
					Result.append_character (')')
				end
			end
		ensure
			non_void_context: Result /= Void
		end
		
	current_namespace: CODE_NAMESPACE is
			-- Namespace currently examined.
		do
			Result := internal_current_namespace.item
		ensure
			non_void_namespace: Result /= Void
		end

	current_type: CODE_GENERATED_TYPE is
			-- Type currently examined.
		do
			Result := internal_current_type.item
		ensure
			non_void_type: Result /= Void
		end

	current_feature: CODE_FEATURE is
			-- Feature currently examined.
		do
			Result := internal_current_feature.item
		ensure
			non_void_feature: Result /= Void
		end

	current_routine: CODE_ROUTINE is
			-- Routine currently examined.
		do
			if internal_current_feature /= Void then
				Result ?= internal_current_feature
				if Result = Void then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Failed_assignment_attempt, ["CODE_FEATURE", "CODE_ROUTINE", "access to current routine"])
				end
			end
			if Result = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_current_routine, [current_context])
			end
		ensure
			non_void_routine: Result /= Void
		end

	last_compile_unit: CODE_COMPILE_UNIT is
			-- Compile unit lastly examined.
		do
			Result := internal_last_compile_unit.item
		ensure
			non_void_compile_unit: Result /= Void
		end

	last_namespace: CODE_NAMESPACE is
			-- Namespace lastly examined.
		do
			Result := internal_last_namespace.item
		ensure
			non_void_namespace: Result /= Void
		end

	last_type: CODE_GENERATED_TYPE is
			-- Type lastly examined.
		do
			Result := internal_last_type.item
		ensure
			non_void_type: Result /= Void
		end

	last_feature: CODE_FEATURE is
			-- Routine lastly examined.
		do
			Result := internal_last_feature.item
		ensure
			non_void_feature: Result /= Void
		end

	last_statement: CODE_STATEMENT is
			-- Statement lastly examined.
		do
			Result := internal_last_statement.item
		ensure
			non_void_statement: Result /= Void
		end

	last_expression: CODE_EXPRESSION is
			-- Expression lastly examined.
		do
			Result := internal_last_expression.item
		ensure
			non_void_expression: Result /= Void
		end

	last_catch_clause: CODE_CATCH_CLAUSE is
			-- Catch clause lastly examined.
		do
			Result := internal_last_catch_clause.item
		ensure
			non_void_catch_clause: Result /= Void
		end

	last_custom_attribute_declaration: CODE_ATTRIBUTE_DECLARATION is
			-- Return last_custom_attribute_declaration.
		do
			Result := internal_last_custom_attribute_declaration.item
		ensure
			non_void_last_custom_attribute_declaration: Result /= Void
		end

	last_custom_attribute_argument: CODE_ATTRIBUTE_ARGUMENT is
			-- Return last_custom_attribute_argument.
		do
			Result := internal_last_custom_attribute_argument.item
		ensure
			non_void_last_custom_attribute_argument: Result /= Void
		end
	
	dummy_variable: BOOLEAN is
			-- Do we need a dummy variable?
		do
			Result := Dummy_variable_cell.item
		end

	new_line: BOOLEAN is
			-- is it a new line?
		do 
			Result := New_line_cell.item
		end

	tabulation_string: STRING is
			-- String used for indentation
		do 
			Result := Tabulation_string_cell.item
		ensure
			non_void_tabulation_string: Result /= Void
		end

	blank_lines_between_members: BOOLEAN is
			-- Should features be separated with blank lines?
		do
			Result := Blank_lines_between_members_cell.item			
		end
		
	else_on_closing: BOOLEAN is
			-- Should all if's be followed by a 'else' instruction?
		do
			Result := Else_on_closing_cell.item			
		end
	
	indent_string: STRING is
			-- Indentation string
		do
			Result := Indent_string_cell.item
		end

feature {NONE} -- Status Setting

	set_current_namespace (a_namespace: like current_namespace) is
			-- Set `current_namespace' with `a_namespace'.
		do
			internal_current_namespace.put (a_namespace)
		ensure
			current_namespace_set: current_namespace = a_namespace
		end

	set_current_type (a_type: like current_type) is
			-- Set `current_type' with `a_type'.
		do
			internal_current_type.put (a_type)
		ensure
			current_type_set: current_type = a_type
		end

	set_current_feature (a_feature: like current_feature) is
			-- Set `current_feature' with `a_feature'.
		do
			internal_current_feature.put (a_feature)
		ensure
			current_feature_set: current_feature = a_feature
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

	set_blank_lines_between_members (a_value: like blank_lines_between_members) is
			-- Set `blank_lines_between_members' with `a_value'.
		do
			Blank_lines_between_members_cell.set_item (a_value)
		ensure
			blank_lines_between_members_set: blank_lines_between_members.is_equal (a_value)
		end
		
	set_else_on_closing (a_value: like else_on_closing) is
			-- Set `else_on_closing' with `a_value'.
		do
			Else_on_closing_cell.set_item (a_value)
		ensure
			else_on_closing_set: else_on_closing.is_equal (a_value)
		end
		
	set_indent_string (a_value: like indent_string) is
			-- Set `indent_string' with `a_value'.
		require
			non_void_indent_string: a_value /= Void
		do
			Indent_string_cell.put (a_value)
		ensure
			indent_string_set: indent_string.is_equal (a_value)
		end

	set_new_line (a_bool: like new_line) is
			-- Set `new_line' with `a_bool'.
		do
			New_line_cell.set_item (a_bool)
		ensure
			new_line_set: new_line = a_bool
		end

	set_dummy_variable (a_bool: like new_line) is
			-- Set `new_line' with `a_bool'.
		do
			Dummy_variable_cell.set_item (a_bool)
		ensure
			dummy_variable_set: dummy_variable = a_bool
		end

	increase_tabulation is
			-- add a tabulation to `indent_string'.
		local
			l_indent: STRING
		do
			create l_indent.make (Indent_string.count + Tabulation_string.count)
			l_indent.append (Indent_string)
			l_indent.append (Tabulation_string)
			Indent_string_cell.put (l_indent)
		ensure
			indent_set: indent_string.is_equal (old indent_string + Tabulation_string)
		end

	decrease_tabulation is
			-- Substract last character (a tabulation) from `indent_string'.
		require
			at_least_one_indent: indent_string.count > 0
		do
			Indent_string_cell.item.remove_tail (Tabulation_string.count)
		ensure
			indent_set: indent_string.is_equal ((old indent_string).substring (1, (old indent_string.count) - Tabulation_string.count))
		end
		
feature {NONE} -- Private Access

	code_dom_generator: CODE_CONSUMER_FACTORY is
			-- Instance of a CODE_CONSUMER_FACTORY.
		once
			create Result
		ensure
			code_dom_source_created: Result /= Void
		end

feature {NONE} -- Implementation

	internal_current_namespace: CELL [CODE_NAMESPACE] is
			-- Internal representation of `current_namespace'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_current_type: CELL [CODE_GENERATED_TYPE] is
			-- Internal representation of `current_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_current_feature: CELL [CODE_FEATURE] is
			-- Internal representation of `current_feature'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_compile_unit: CELL [CODE_COMPILE_UNIT] is
			-- Internal representation of `last_compile_unit'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_namespace: CELL [CODE_NAMESPACE] is
			-- Internal representation of `last_namespace'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_type: CELL [CODE_GENERATED_TYPE] is
			-- Internal representation of `last_type'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_feature: CELL [CODE_FEATURE] is
			-- Internal representation of `last_feature'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_statement: CELL [CODE_STATEMENT] is
			-- Internal representation of `last_statement'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_expression: CELL [CODE_EXPRESSION] is
			-- Internal representation of `last_expression'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_catch_clause: CELL [CODE_CATCH_CLAUSE] is
			-- Internal representation of `last_catch_clause'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_custom_attribute_declaration: CELL [CODE_ATTRIBUTE_DECLARATION] is
			-- Internal representation of `last_custom_attribute_declaration'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	internal_last_custom_attribute_argument: CELL [CODE_ATTRIBUTE_ARGUMENT] is
			-- Internal representation of `last_custom_attribute_argument'.
		once
			create Result.put (Void)
		ensure
			cell_created: Result /= Void
		end

	Blank_lines_between_members_cell: BOOLEAN_REF is
			-- Shell for `blank_lines_between_members'
		once
			create Result
			Result.set_item (True)
		ensure
			cell_created: Result /= Void
		end
		
	Else_on_closing_cell: BOOLEAN_REF is
			-- Shell for `else_on_closing'
		once
			create Result
		ensure
			cell_created: Result /= Void
		end
		
	Tabulation_string_cell: CELL [STRING] is
			-- Shell for `tabulation_string'
		once
			create Result.put ("%T")
		ensure
			cell_created: Result /= Void
		end
		
	New_line_cell: BOOLEAN_REF is
			-- Shell for `new_line'
		once
			create Result
		ensure
			cell_created: Result /= Void
		end

	Dummy_variable_cell: BOOLEAN_REF is
			-- Shell for `dummy_variable'
		once
			create Result
		ensure
			cell_created: Result /= Void
		end

	Indent_string_cell: CELL [STRING] is
		-- Shell for `indent_string'
		once
			create Result.put ("")
		ensure
			cell_created: Result /= Void
		end

end -- class CODE_SHARED_GENERATION_CONTEXT

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