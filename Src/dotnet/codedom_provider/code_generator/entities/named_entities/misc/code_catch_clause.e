indexing
	description: "Eiffel representation of a catch clause"
	date: "$Date$"
	revision: "$Revision$"
	
class
	CODE_CATCH_CLAUSE

inherit
	CODE_NAMED_ENTITY

create
	make
	
feature {NONE} -- Initialization

	make (a_variable: CODE_VARIABLE_REFERENCE; a_statements: like statements) is
			-- Initialize instance.
		require
			non_void_variable: a_variable /= Void
			non_void_statements: a_statements /= Void
		do
			create variable.make (a_variable)
			statements := a_statements
		ensure
			variable_set: variable /= Void
			statements_set: statements = a_statements
		end

feature -- Access

	variable: CODE_VARIABLE
			-- exception type.
	
	statements: LIST [CODE_STATEMENT]
			-- Catch statements
			
	code: STRING is
			-- Eiffel code of catch clause
		do
			create Result.make (120)
			Result.append (indent_string)
			Result.append (variable.variable.eiffel_name)
			Result.append (" ?= {ISE_RUNTIME}.last_exception%N")
			Result.append (indent_string)
			Result.append ("if ")
			Result.append (variable.variable.eiffel_name)
			Result.append (" /= Void then%N")
			increase_tabulation
			from
				statements.start
			until
				statements.after
			loop
				Result.append (statements.item.code)
				statements.forth
			end
			Result.append (indent_string)
			Result.append ("retry%N")
			decrease_tabulation
			Result.append (indent_string)
			Result.append ("end%N")
		end

invariant
	non_void_variable: variable /= Void
	non_void_statements: statements /= Void

end -- class CODE_CATCH_CLAUSE

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