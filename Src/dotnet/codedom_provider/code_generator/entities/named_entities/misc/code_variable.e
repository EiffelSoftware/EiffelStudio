indexing
	description: "Variable used in code, could be argument or local variable."
	date: "$$"
	revision: "$$"	

class
	CODE_VARIABLE
	
inherit
	CODE_ENTITY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_variable: CODE_VARIABLE_REFERENCE) is
			-- Initialize instance with arguments.
		require
			non_void_variable: a_variable /= Void
		do
			variable := a_variable
		ensure
			variable_set: variable = a_variable
		end
		
feature -- Access

	variable: CODE_VARIABLE_REFERENCE
			-- Corresponding variable reference
		
	code: STRING is
			-- Type source code
		do
			Result := variable.eiffel_name
		end

feature -- Comparison

	is_equal (other: CODE_VARIABLE): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := other.variable.is_equal (variable)
		end

invariant
	non_void_variable: variable /= Void

end -- class CODE_VARIABLE

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