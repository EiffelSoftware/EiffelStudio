indexing
	description: "Eiffel representation of a CodeDom method return statement"
	date: "$$"
	revision: "$$"		
	
class
	ECDP_ROUTINE_RETURN_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `expression'.
		do
		end
		
feature -- Access
			
	expression: ECDP_EXPRESSION
			-- Expression to return
			
	code: STRING is
			-- | 	Result := "Result := `expression'"
			-- | OR Result := "Result := `expression'" if expression is `EG_CAST_EXPRESSION'.
			-- | OR Result := "expression" if expression is `EG_OBJECT_CREATE_EXPRESSION'
			-- Eiffel code of routine return statement
		local
			l_cast_exp: ECDP_CAST_EXPRESSION
			l_object_creation_exp: ECDP_OBJECT_CREATE_EXPRESSION
		do
			check
				non_void_expression: expression /= Void
			end
			create Result.make (120)
			Result.append (Indent_string)
			Result.append (Dictionary.Result_keyword)
			set_new_line (False)
			l_cast_exp ?= expression
			if l_cast_exp /= Void then
				Result.append (" := ")
				Result.append (expression.code)
			else
				l_object_creation_exp ?= expression
				if l_object_creation_exp /= Void then
					l_object_creation_exp.set_object_created ("Result")
					Result.append (l_object_creation_exp.code)	
				else
					Result.append (Dictionary.space)
					Result.append (Dictionary.Colon)
					Result.append (Dictionary.equal_keyword)
					Result.append (Dictionary.space)
					Result.append (expression.code)
				end
			end
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is routine return statement ready to be generated?
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
	
end -- class ECDP_ROUTINE_RETURN_STATEMENT

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