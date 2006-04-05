indexing
	description: "Eiffel representation of a catch clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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