indexing
	description: "Eiffel representation of a CodeDom method return statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
