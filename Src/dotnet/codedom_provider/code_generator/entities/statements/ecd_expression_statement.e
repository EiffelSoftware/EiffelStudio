indexing
	description: "Eiffel representation of a CodeDom expression statement"
	date: "$$"
	revision: "$$"	
	
class
	ECD_EXPRESSION_STATEMENT

inherit
	ECD_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `expression'.
		do
		end
		
feature -- Access

	expression: ECD_EXPRESSION
			-- Expression
						
	code: STRING is
			-- | Result := "`expression'"
			-- | OR		:= "[dummy := ]expression" if typeof `expression' is ECD_ROUTINE_INVOKE_EXPRESSION
			-- Eiffel code of expression statement
		local
			routine_invoke_exp: ECD_ROUTINE_INVOKE_EXPRESSION
			l_dummy_variable: BOOLEAN
		do
			l_dummy_variable := dummy_variable
			set_dummy_variable (False)
			
			create Result.make (80)
			Result.append (expression.code)
			Result.append (Dictionary.New_line)

			if dummy_variable then
				routine_invoke_exp ?= expression
				if routine_invoke_exp /= Void then
					Result.prepend ("dummy := ")
					set_dummy_variable (True)
				end
			end
			if l_dummy_variable then
				set_dummy_variable (True)
			end
			
			Result.prepend (indent_string)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is expression statement ready to be generated?
		do
			Result := expression /= Void and then expression.ready 
		end

feature -- Status Setting

	set_expression (an_expression: like expression) is
			-- Set `expression' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			expression := an_expression
		ensure
			expression_set: expression = an_expression
		end		
		
invariant
	
end -- class ECD_EXPRESSION_STATEMENT

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