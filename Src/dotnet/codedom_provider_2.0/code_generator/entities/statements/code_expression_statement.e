indexing
	description: "Eiffel representation of a CodeDom expression statement"
	date: "$$"
	revision: "$$"	
	
class
	CODE_EXPRESSION_STATEMENT

inherit
	CODE_STATEMENT

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

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
		do
			create Result.make (80)
			Result.append (indent_string)
			if need_dummy then
				Result.append ("res := ")
			end
			Result.append (expression.code)
			Result.append_character ('%N')
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		local
			l_method_invoke_expression: CODE_ROUTINE_INVOKE_EXPRESSION
		do
			l_method_invoke_expression ?= expression
			if l_method_invoke_expression /= Void then
				Result := not l_method_invoke_expression.type.is_equal (None_type_reference)
			end
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