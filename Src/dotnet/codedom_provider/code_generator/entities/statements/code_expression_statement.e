indexing
	description: "Eiffel representation of a CodeDom expression statement"
	date: "$$"
	revision: "$$"	
	
class
	CODE_EXPRESSION_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_expression: CODE_EXPRESSION) is
			-- Initialize `expression'.
		require
			non_void_expression: a_expression /= Void
		do
			expression := a_expression
		ensure
			expression_set: expression = a_expression
		end
		
feature -- Access

	expression: CODE_EXPRESSION
			-- Expression

	code: STRING is
			-- | Result := "`expression'"
			-- | OR		:= "res := `expression'" if typeof `expression' is CODE_ROUTINE_INVOKE_EXPRESSION
			-- Eiffel code of expression statement
		local
			routine_invoke_exp: CODE_ROUTINE_INVOKE_EXPRESSION
			l_dummy_variable: BOOLEAN
			l_code: STRING
		do
			create Result.make (80)
			Result.append (indent_string)
			l_dummy_variable := dummy_variable
			set_dummy_variable (False)
			l_code := expression.code
			if dummy_variable then
				routine_invoke_exp ?= expression
				if routine_invoke_exp /= Void then
					Result.append ("res := ")
					set_dummy_variable (True)
				end
			end
			if l_dummy_variable then
				set_dummy_variable (True)
			end
			Result.append (l_code)
			Result.append_character ('%N')
		end
		
invariant
	non_void_expression: expression /= Void
	
end -- class CODE_EXPRESSION_STATEMENT

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