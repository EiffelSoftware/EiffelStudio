indexing
	description: "Support for CodeDOM Visitor."

class
	CODE_AST_HISTORIC

feature -- Access

	Type_attributes: HASH_TABLE [STRING, STRING] is
			-- Retrieve all attributes of current type.
		once
			create Result.make (100)
		ensure
			non_void_type_attributes: Result /= Void
		end

	Variables: HASH_TABLE [STRING, STRING] is
			-- Retrieve all parameters and local variable of current feature.
			-- Plus Result and Current.
		once
			create Result.make (5)
		ensure
			non_void_variables: Result /= Void
		end

	cast_expressions: HASHTABLE is
			-- cast expressions
			-- key: local variable name
			-- contains: SYSTEM_CODE_CAST_EXPRESSION
		once
			create Result.make
		ensure
			non_void_cast_expression: Result /= Void
		end

feature -- Status Repport

	is_attribute (a_name: STRING): BOOLEAN is
			-- Is `a_name' attribute of current type?
		require
			valid_a_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Type_attributes.has (a_name.as_lower)
		end

	is_variable (a_name: STRING): BOOLEAN is
			-- Is `a_name' variable of current feature?
		require
			valid_a_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Variables.has (a_name.as_lower)
		end

	is_cast_expression (a_name: STRING): BOOLEAN is
			-- Is `a_name' contained in `cast_expression'.
		require
			valid_a_name: a_name /= Void and then not a_name.is_empty
		do
			Result := Cast_expressions.contains (a_name.as_lower.to_cil)
		end

feature -- Attributes - parameters - local variables

	add_attribute (an_attribute, attribute_dotnet_type: STRING) is
			-- add `an_attribute' to `type_attributes'.
		require
			non_void_an_attribute: an_attribute /= Void
			not_empty_an_attribute: not an_attribute.is_empty
			non_void_attribute_dotnet_type: attribute_dotnet_type /= Void
			not_empty_attribute_dotnet_type: not attribute_dotnet_type.is_empty
		do
			type_attributes.put (attribute_dotnet_type, an_attribute.as_lower)
		ensure
			an_attribute_added: type_attributes.has (an_attribute)
		end

	add_variable (a_variable, variable_eiffel_type: STRING) is
			-- add `an_variable' to `type_variables'.
		require
			non_void_a_variable: a_variable /= Void
			not_empty_a_variable: not a_variable.is_empty
			non_void_variable_eiffel_type: variable_eiffel_type /= Void
			not_empty_variable_eiffel_type: not variable_eiffel_type.is_empty
		do
			variables.put (variable_eiffel_type, a_variable.as_lower)
		ensure
			a_variable_added: Variables.has (a_variable)
		end

	clear_variables is
			-- Clear all variables except Current.
		local
			l_current_type: STRING
		do
			l_current_type := Variables.item ("Current")
			Variables.clear_all
			add_variable ("Current", l_current_type)
		end

	clear_cast_expressions is
			-- Clear all cast expressions.
		do
			Cast_expressions.clear
		end
		
	clear_type_attributes is
			-- Clear all type attributes.
		do
			Type_attributes.clear_all
		end	

end -- Class CODE_AST_HISTORIC
