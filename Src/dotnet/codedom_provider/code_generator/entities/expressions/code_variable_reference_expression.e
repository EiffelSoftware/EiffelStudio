indexing 
	description: "Source code generator for variable reference expressions"
	date: "$$"
	revision: "$$"	
	
class
	CODE_VARIABLE_REFERENCE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_variable: like variable) is
			-- Initialize `variable_name' with empty string.
		require
			non_void_variable: a_variable /= Void
		do
			variable := a_variable
		ensure
			variable_set: variable = a_variable
		end
		
feature -- Access

	variable: CODE_VARIABLE_REFERENCE
			-- Name of variable to reference

	code: STRING is
			-- | Result := "`variable_name'"
			-- Eiffel code of variable reference expression
		do
			Result := variable.eiffel_name
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := variable.type
		end

invariant
	non_void_variable: variable /= Void
	
end -- class CODE_VARIABLE_REFERENCE_EXPRESSION

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