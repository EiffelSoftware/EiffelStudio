indexing
	description: "Eiffel representation of a CodeDom method return statement"
	date: "$$"
	revision: "$$"

class
	CODE_METHOD_RETURN_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_expression: like expression) is
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
			-- Expression to return

	code: STRING is
			-- | 	Result := "Result := `expression'"
			-- | OR Result := "Result := `expression'" if expression is `CODE_CAST_EXPRESSION'.
			-- | OR Result := "expression" if expression is `CODE_OBJECT_CREATE_EXPRESSION'
			-- Eiffel code of routine return statement
		local
			l_cast_exp: CODE_CAST_EXPRESSION
			l_object_creation_exp: CODE_OBJECT_CREATE_EXPRESSION
		do
			check
				non_void_expression: expression /= Void
			end
			create Result.make (120)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (Indent_string)
			set_new_line (False)
			l_cast_exp ?= expression
			if l_cast_exp /= Void then
				Result.append ("Result := ")
				Result.append (expression.code)
			else
				l_object_creation_exp ?= expression
				if l_object_creation_exp /= Void then
					l_object_creation_exp.set_target ("Result")
					Result.append (l_object_creation_exp.code)
				else
					Result.append ("Result := ")
					Result.append (expression.code)
				end
			end
			Result.append (Line_return)
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

invariant
	non_void_expression: expression /= Void

end -- class CODE_METHOD_RETURN_STATEMENT

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
