indexing
	description: "Objects that represents an expression to evaluate..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	DBG_EXPRESSION

inherit
	DEBUG_OUTPUT
		redefine
			debug_output
		end

--create
--	make_with_expression

feature {NONE} -- Initialization

	make_with_expression (new_expr: STRING_32) is
		do
			syntax_error := False
			error_message := Void
			expression := new_expr
			parse_expression
		end

feature {EB_EXPRESSION} -- Parsing

	set_expression (new_expr: STRING_32) is
		require
			valid_expression: valid_expression (expression)
		do
			syntax_error := False
			error_message := Void
			expression := new_expr
			parse_expression
--		ensure
--			expression_set: expression = new_expr
		end

	parse_expression is
		require
			valid_expression: valid_expression (expression)
		deferred
		end

feature -- Properties

	expression: STRING_32
			-- String representation of the like Current.

feature -- Debug output

	debug_output: STRING is
		do
			if expression /= Void then
				Result := expression.as_string_8
			else
				create Result.make_empty
			end
		end

feature -- Status

	valid_expression (expr: STRING_32): BOOLEAN is
			-- Is `expr' a valid expression?
		do
			Result := expr /= Void
			if Result then
				Result := not expr.has ('%R') and not expr.has ('%N')
			end
		end

	has_unicode_character: BOOLEAN is
		do
			Result := expression /= Void and then not expression.is_equal (expression.as_string_8.as_string_32)
		end

feature -- Access

	syntax_error: BOOLEAN
			-- Is the provided expression syntactically valid?

	error_message: STRING
			-- If `Current' or one of its descendants couldn't be evaluated,
			-- return an explanatory message.

feature {NONE} -- Implementation data

invariant
	valid_expression: valid_expression (expression)

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

end
