indexing 
	description: "Eiffel representation of a CodeDom variable declaration statement"
	date: "$$"
	revision: "$$"		
	
class
	CODE_VARIABLE_DECLARATION_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_variable: CODE_VARIABLE_REFERENCE; a_init_expression: CODE_EXPRESSION) is
			-- Initialize `variable'.
		require
			non_void_variable: a_variable /= Void
		do
			variable := a_variable
			init_expression := a_init_expression
		ensure
			variable_set: variable = a_variable
			init_expression_set: init_expression = a_init_expression
		end
		
feature -- Access

	variable: CODE_VARIABLE_REFERENCE
			-- Variable
	
	init_expression: CODE_EXPRESSION
			-- Initialization expression

feature -- Code generation

	declaration_statement: STRING is
			-- | Result := "`name': TYPE"
			-- Eiffel code of variable declaration statement
		do
			create Result.make (120)
			Result.append (indent_string) 
			Result.append (variable.eiffel_name)
			Result.append (": ")
			Result.append (variable.type.eiffel_name)
			Result.append_character ('%N')
		ensure
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end

	code: STRING is
			-- Result := "`name' := `init_expression'"
			-- OR Result := "Result := `init_expression'" if expression is `CODE_CAST_EXPRESSION'.
			-- OR Result := "" if no `init_expression' = Void
			-- Eiffel code of variable declaration statement
		local
			l_dummy_variable: BOOLEAN
		do
			l_dummy_variable := dummy_variable

			if init_expression /= Void then
				create Result.make (160)
				Result.append (indent_string)
				Result.append (variable.eiffel_name)
				Result.append (" := ")
				set_new_line (False)
				Result.append (init_expression.code)
				Result.append_character ('%N')
			else
				create Result.make_empty
			end

			set_dummy_variable (l_dummy_variable)
		end

invariant
	non_void_variable: variable /= Void
	
end -- class CODE_VARIABLE_DECLARATION_STATEMENT

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