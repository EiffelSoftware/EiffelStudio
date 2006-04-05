indexing
	description: "Source code generator for assignment attempt"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
