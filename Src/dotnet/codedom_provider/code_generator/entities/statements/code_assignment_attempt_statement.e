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

	make (a_target: CODE_VARIABLE; a_expression: CODE_EXPRESSION) is
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
			
	target: CODE_VARIABLE
			-- Recipient of assignment attempt
			
	code: STRING is
			-- | Result := " `target_object' ?= `expression_to_cast'"
			-- Eiffel code of cast expression
		do
			create Result.make (80)
			Result.append (indent_string)
			Result.append (target.variable.eiffel_name)
			Result.append (" ?= ")
			Result.append (expression.code)
			Result.append_character ('%N')
		end
		
feature -- Status Report
		
	ready: BOOLEAN is
			-- Is cast expression ready to be generated?
		do
			Result := True
		end
		
invariant
	non_void_target: target /= Void
	non_void_expression: expression /= Void

end -- class CODE_ASSIGNMENT_ATTEMPT_STATEMENT

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