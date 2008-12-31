note
	description: "Eiffel representation of a CodeDom variable declaration statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_VARIABLE_DECLARATION_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_variable: CODE_VARIABLE_REFERENCE; a_init_expression: CODE_EXPRESSION)
			-- Initialize `variable'.
		require
			non_void_variable: a_variable /= Void
		do
			variable := a_variable
			init_expression := a_init_expression
		ensure
			variable_set: variable = a_variable
			init_expression_set: init_expression = a_init_expression
		end

feature -- Access

	variable: CODE_VARIABLE_REFERENCE
			-- Variable

	init_expression: CODE_EXPRESSION
			-- Initialization expression

	need_dummy: BOOLEAN
			-- Does statement require dummy local variable?
		do
			Result := False
		end

feature -- Code generation

	code: STRING
			-- Result := "`name' := `init_expression'"
			-- OR Result := "Result := `init_expression'" if expression is `CODE_CAST_EXPRESSION'.
			-- OR Result := "" if no `init_expression' = Void
			-- Eiffel code of variable declaration statement
		do
			if init_expression /= Void then
				create Result.make (160)
				if line_pragma /= Void then
					Result.append (line_pragma.code)
				end
				Result.append (indent_string)
				Result.append (variable.eiffel_name)
				Result.append (" := ")
				set_new_line (False)
				Result.append (init_expression.code)
				Result.append (Line_return)
			else
				create Result.make_empty
				if line_pragma /= Void then
					Result.append (line_pragma.code)
				end
			end
		end

invariant
	non_void_variable: variable /= Void

note
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
end -- class CODE_VARIABLE_DECLARATION_STATEMENT

