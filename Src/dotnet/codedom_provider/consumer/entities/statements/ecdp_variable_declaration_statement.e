indexing 
	description: "Eiffel representation of a CodeDom variable declaration statement"
	date: "$$"
	revision: "$$"		
	
class
	ECDP_VARIABLE_DECLARATION_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `dotnet_type', `eiffel_type'.
		do
			create dotnet_type.make_empty
			create eiffel_type.make_empty
		end
		
feature -- Access

	name: STRING
			-- Variable name
	
	dotnet_type: STRING
			-- Dotnet type of variable

	eiffel_type: STRING
			-- Eiffel type of variable
	
	is_array_element: BOOLEAN
			-- Is declaration of an array?
			
	init_expression: ECDP_EXPRESSION
			-- Initialization expression
			
	declaration_statement: STRING is
			-- | Result := "`name': TYPE"
			-- Eiffel code of variable declaration statement
			-- Call `update_ace_file'
		local
			l_name: STRING
		do
			check
				dotnet_type_or_eiffel_type_set: not (dotnet_type.is_empty and eiffel_type.is_empty)
				name_set: not name.is_empty
			end
			
			create Result.make (120)
			Result.append (indent_string) 
			l_name := Resolver.unique_entity_name (name)
			if not dotnet_type.is_empty then
				Resolver.add_variable (dotnet_type, l_name)
			else
				Resolver.add_variable (eiffel_type, l_name)
			end
			Result.append (Resolver.eiffel_entity_name (l_name))
			Result.append (Dictionary.Colon)
			Result.append (Dictionary.Space)
			if is_array_element then
				Result.append ("NATIVE_ARRAY [")
			end
			if not eiffel_type.is_empty then
				Result.append (eiffel_type)
			else
				Result.append (Resolver.eiffel_type_name (dotnet_type))
			end
			if is_array_element then
				Result.append ("]")
			end
			Result.append (Dictionary.New_line)
		ensure
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end

	code: STRING is
			--    Result := "`name' := `init_expression'"
			-- OR Result := "Result := `init_expression'" if expression is `EG_CAST_EXPRESSION'.
			-- OR Result := "" if no `init_expression' = Void
			-- Eiffel code of variable declaration statement
		local
			l_dummy_variable: BOOLEAN
			l_cast_exp: ECDP_CAST_EXPRESSION
		do
			check
				dotnet_type_or_eiffel_type_set: not ( dotnet_type.is_empty and eiffel_type.is_empty )
				name_set: not name.is_empty
			end

			l_dummy_variable := dummy_variable

			if init_expression /= Void then
				create Result.make (160)
				Result.append (indent_string)
				Result.append (Resolver.eiffel_entity_name (name))
				set_new_line (False)
				l_cast_exp ?= init_expression
				if l_cast_exp /= Void then
					Result.append (" := ")
				else
					Result.append (" := ")
				end
				Result.append (init_expression.code)
				Result.append (Dictionary.New_line)
			else
				create Result.make_empty
				Result.append (Dictionary.Space)
			end

			set_dummy_variable (l_dummy_variable)
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is variable declaration statement ready to be generated?
		do
			Result := name /= Void and then not name.is_empty and not (eiffel_type.is_empty and dotnet_type.is_empty)
		end

feature -- Status Setting

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end	

	set_dotnet_type (a_type: like dotnet_type) is
			-- Set `dotnet_type' with `a_type'.
		require
			non_void_type: a_type /= Void
			positive_type: not a_type.is_empty
		do
			dotnet_type := a_type
		ensure
			dotnet_type_set: dotnet_type = a_type
		end	

	set_eiffel_type (a_type: like eiffel_type) is
			-- Set `eiffel_type' with `a_type'.
		require
			non_void_type: a_type /= Void
			positive_type: not a_type.is_empty
		do
			eiffel_type := a_type
		ensure
			eiffel_type_set: eiffel_type = a_type
		end	

	set_init_expression (an_expression: like init_expression) is
			-- Set `init_expression' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			init_expression := an_expression
		ensure
			init_expression_set: init_expression = an_expression
		end
		
	set_is_array_element (a_bool: BOOLEAN) is 
			-- Set `is_array_element' with `a_bool'.
		do
			is_array_element := a_bool
		ensure
			is_array_element_set: is_array_element = a_bool
		end

invariant
	non_void_dotnet_type: dotnet_type /= Void
	non_void_eiffel_type: eiffel_type /= Void
	
end -- class ECDP_VARIABLE_DECLARATION_STATEMENT_STATEMENT

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