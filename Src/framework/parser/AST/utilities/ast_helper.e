indexing
	description: "[
		Functions supporting AST analysis.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	AST_HELPER

feature -- Query

	frozen is_valid_positional_node (a_ast: !AST_EIFFEL): BOOLEAN
			-- Determines if an AS node is valid for positional queries.
			--
			-- `a_ast': An AS node to determine position validity for.
			-- `Result': True if the node is valid for positional queries; False otherwise.
		local
			l_location: LOCATION_AS
		do
			l_location := a_ast.start_location
			Result := l_location /= Void and then not l_location.is_null
			if Result then
				l_location := a_ast.end_location
				Result := l_location /= Void and then not l_location.is_null
			end
		ensure
			has_valid_start_location: Result implies (a_ast.start_location /= Void and then not a_ast.start_location.is_null)
			has_valid_end_location: Result implies (a_ast.end_location /= Void and then not a_ast.end_location.is_null)
		end

	frozen is_before_line (a_ast: !AST_EIFFEL; a_line: INTEGER): BOOLEAN
			-- Determines if an AS node appears before a specified line number
		require
			a_ast_is_valid_positional_node: is_valid_positional_node (a_ast)
			a_line_positive: a_line >= 0
		do
			Result := a_ast.end_location.line < a_line
		end

	frozen is_after_line (a_ast: !AST_EIFFEL; a_line: INTEGER): BOOLEAN
			-- Determines if an AS node appears before a specified line number
		require
			a_ast_is_valid_positional_node: is_valid_positional_node (a_ast)
			a_line_positive: a_line >= 0
		do
			Result := a_line > a_ast.start_location.line
		end

	frozen is_line_in (a_ast: !AST_EIFFEL; a_line: INTEGER): BOOLEAN
			-- Determines if a line is within the start/end bounds of a AS node.
		require
			a_ast_is_valid_positional_node: is_valid_positional_node (a_ast)
			a_line_positive: a_line >= 0
		do
			Result := a_ast.start_location.line <= a_line and a_line <= a_ast.end_location.line
		end

	frozen is_before_position (a_ast: !AST_EIFFEL; a_line: INTEGER; a_column: INTEGER): BOOLEAN
			-- Determines if an AS node appears before a specified line number
		require
			a_ast_is_valid_positional_node: is_valid_positional_node (a_ast)
			a_line_positive: a_line > 0
			a_column_non_negative: a_column >= 0
		local
			l_location: LOCATION_AS
			l_line: INTEGER
		do
			l_location := a_ast.end_location
			l_line := l_location.line
			Result := l_line < a_line or (l_line = a_line and l_location.column < a_column)
		end

	frozen is_after_position (a_ast: !AST_EIFFEL; a_line: INTEGER; a_column: INTEGER): BOOLEAN
			-- Determines if an AS node appears before a specified line number
		require
			a_ast_is_valid_positional_node: is_valid_positional_node (a_ast)
			a_line_positive: a_line > 0
			a_column_non_negative: a_column >= 0
		local
			l_location: LOCATION_AS
			l_line: INTEGER
		do
			l_location := a_ast.start_location
			l_line := l_location.line
			Result := a_line < l_line or (a_line = l_line and a_column < l_location.column)
		end

	frozen is_position_in (a_ast: !AST_EIFFEL; a_line: INTEGER; a_column: INTEGER): BOOLEAN
			-- Determines if a line is within the start/end bounds of a AS node.
		require
			a_ast_is_valid_positional_node: is_valid_positional_node (a_ast)
			a_line_positive: a_line > 0
			a_column_non_negative: a_column >= 0
		local
			l_location: LOCATION_AS
			l_line: INTEGER
		do
			l_location := a_ast.start_location
			l_line := l_location.line
			Result := l_line <= a_line and l_location.column <= a_column
			if Result  then
				l_location := a_ast.end_location
				l_line := l_location.line
				Result := a_line <= l_line and a_column <= l_location.column
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
