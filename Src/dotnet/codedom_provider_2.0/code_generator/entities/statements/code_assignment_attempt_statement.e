indexing
	description: "Source code generator for assignment attempt"
	date: "$$"
	revision: "$$"

class
	CODE_ASSIGNMENT_ATTEMPT_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_target: like target; a_expression: like expression) is
			-- Initialize `expression' and `target_object'.
		require
			non_void_target: a_target /= Void
			non_void_expression: a_expression /= Void
		do
			expression := a_expression
			target := a_target
		ensure
			target_set: target = a_target
			expression_set: expression = a_expression
		end

feature -- Access

	expression: CODE_EXPRESSION
			-- Expression to cast

	target: STRING
			-- Recipient of assignment attempt

	code: STRING is
			-- | Result := " `target_object' ?= `expression_to_cast'"
			-- Eiffel code of cast expression
		do
			create Result.make (80)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (indent_string)
			Result.append (target)
			Result.append (" ?= ")
			Result.append (expression.code)
			Result.append (Line_return)
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

invariant
	non_void_target: target /= Void
	non_void_expression: expression /= Void

end -- class CODE_ASSIGNMENT_ATTEMPT_STATEMENT

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
