indexing
	description: "Eiffel representation of a CodeDom snippet statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_SNIPPET_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_value: like value) is
		require
			non_void_value: a_value /= Void
		local
			l_analyzer: CODE_SNIPPET_ANALYZER
		do
			-- Analyze snippet to detect specified precompilation ace file if any
			create l_analyzer
			l_analyzer.parse (a_value)
			if l_analyzer.is_indexing_clause then
				value := ""
			else
				value := a_value
			end
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: STRING
			-- Literal code block of the snippet

	code: STRING is
			-- | Result := "`value'"
			-- Eiffel code of snippet statement
		do
			create Result.make (indent_string.count + value.count + 1)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (indent_string)
			Result.append (value)
			Result.append (Line_return)
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

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
end -- class CODE_SNIPPET_STATEMENT

