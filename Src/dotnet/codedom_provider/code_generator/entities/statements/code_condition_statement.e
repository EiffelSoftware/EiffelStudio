indexing
	description: "Eiffel representation of a CodeDom condition statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"	
	
class
	CODE_CONDITION_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_condition: like condition; a_true_statements: like true_statements; a_false_statements: like false_statements) is
			-- Initialize `condition', `true_statements' and `false_statements'.
		require
			non_void_condition: a_condition /= Void
		do
			condition := a_condition
			true_statements := a_true_statements
			false_statements := a_false_statements
		ensure
			condition_set: condition = a_condition
			true_statements_set: true_statements = a_true_statements
			false_statements_set: false_statements = a_false_statements
		end
		
feature -- Access

	condition: CODE_EXPRESSION
			-- Condition
			
	true_statements: LIST [CODE_STATEMENT]
			-- True statements
			
	false_statements: LIST [CODE_STATEMENT]
			-- False statements
			
	code: STRING is
			-- | Result := "if `condition' then 
			-- |				`true_statements'
			-- |		  [	else
			-- |				`false_statements' ]
			-- |			end"
			-- Eiffel code of condition statement
		do
			create Result.make (2000)
			Result.append (Indent_string)
			Result.append ("if ")
			set_new_line (False)
			Result.append (condition.code)
			Result.append (" then%N")
			increase_tabulation
			if true_statements /= Void then
				from
					true_statements.start
				until
					true_statements.after
				loop
					Result.append (true_statements.item.code)
					true_statements.forth
				end
			end
			
			if false_statements /= Void and then false_statements.count > 0 then
				decrease_tabulation
				Result.append (indent_string)
				Result.append ("else%N")
				increase_tabulation
				from
					false_statements.start
				until
					false_statements.after
				loop
					Result.append (false_statements.item.code)
					false_statements.forth
				end
			end
			decrease_tabulation
			Result.append (indent_string)
			Result.append ("end%N")
		end
		
	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			if true_statements /= Void then
				from
					true_statements.start				
				until
					Result or true_statements.after
				loop
					Result := true_statements.item.need_dummy
					true_statements.forth
				end
			end
			if false_statements /= Void then
				from
					false_statements.start				
				until
					Result or false_statements.after
				loop
					Result := false_statements.item.need_dummy
					false_statements.forth
				end
			end
		end
		
invariant
	non_void_condition: condition /= Void
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_CONDITION_STATEMENT

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