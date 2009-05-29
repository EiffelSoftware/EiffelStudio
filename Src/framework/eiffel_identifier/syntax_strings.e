note
	description: "Strings used in the Eiffel syntax"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_STRINGS

feature -- Sets

	keywords: SEARCH_TABLE [STRING]
			-- List of Eiffel keywords in lowercase.
		once
			create Result.make (55)
			Result.force ("agent")
			Result.force ("alias")
			Result.force ("all")
			Result.force ("and")
			Result.force ("as")
			Result.force ("assign")
			Result.force ("attribute")
			Result.force ("check")
			Result.force ("class")
			Result.force ("convert")
			Result.force ("create")
			Result.force ("current")
			Result.force ("debug")
			Result.force ("deferred")
			Result.force ("do")
			Result.force ("else")
			Result.force ("elseif")
			Result.force ("end")
			Result.force ("ensure")
			Result.force ("expanded")
			Result.force ("export")
			Result.force ("external")
			Result.force ("false")
			Result.force ("feature")
			Result.force ("from")
			Result.force ("frozen")
			Result.force ("if")
			Result.force ("implies")
			Result.force ("inherit")
			Result.force ("inspect")
			Result.force ("invariant")
			Result.force ("like")
			Result.force ("local")
			Result.force ("loop")
			Result.force ("not")
			Result.force ("redefine")
			Result.force ("rename")
			Result.force ("require")
			Result.force ("rescue")
			Result.force ("result")
			Result.force ("retry")
			Result.force ("select")
			Result.force ("separate")
			Result.force ("then")
			Result.force ("true")
			Result.force ("undefine")
			Result.force ("until")
			Result.force ("variant")
			Result.force ("void")
			Result.force ("when")
			Result.force ("xor")
		ensure
			Result_not_void: Result /= Void
		end

	basic_operators: SEARCH_TABLE [STRING]
			-- List of basic Eiffel operators (lower-case).
		once
			create Result.make (20)
			Result.force ("not")
			Result.force ("+")
			Result.force ("-")
			Result.force ("*")
			Result.force ("/")
			Result.force ("<")
			Result.force (">")
			Result.force ("<=")
			Result.force (">=")
			Result.force ("//")
			Result.force ("\\")
			Result.force ("^")
			Result.force ("and")
			Result.force ("or")
			Result.force ("xor")
			Result.force ("and then")
			Result.force ("or else")
			Result.force ("implies")
		end

	binary_operators: SEARCH_TABLE [STRING]
			-- List of basic binary Eiffel operators (lower-case).
		once
			create Result.make (18)
			Result.force ("+")
			Result.force ("-")
			Result.force ("*")
			Result.force ("/")
			Result.force ("//")
			Result.force ("\\")
			Result.force ("^")
			Result.force ("..")
			Result.force ("<")
			Result.force (">")
			Result.force ("<=")
			Result.force (">=")
			Result.force ("and")
			Result.force ("or")
			Result.force ("xor")
			Result.force ("and then")
			Result.force ("or else")
			Result.force ("implies")
		end

	unary_operators: SEARCH_TABLE [STRING]
			-- List of basic unary Eiffel operators (lower-case)
		once
			create Result.make (3)
			Result.force ("not")
			Result.force ("+")
			Result.force ("-")
		end

	free_operators_start: SEARCH_TABLE [CHARACTER]
			-- List of characters that can start a free operator name.
		once
			create Result.make (4)
			Result.force ('@')
			Result.force ('#')
			Result.force ('|')
			Result.force ('&')
		end

	free_operators_characters: SEARCH_TABLE [CHARACTER]
			-- List of characters that can start a free operator name.
		once
			create Result.make (30)
			Result.force ('@')
			Result.force ('#')
			Result.force ('|')
			Result.force ('&')
			Result.force ('*')
			Result.force ('/')
			Result.force ('-')
			Result.force ('\')
			Result.force ('$')
			Result.force ('_')
			Result.force ('!')
			Result.force ('%'')
			Result.force ('(')
			Result.force (')')
			Result.force ('+')
			Result.force (',')
			Result.force ('.')
			Result.force (':')
			Result.force (';')
			Result.force ('<')
			Result.force ('>')
			Result.force ('=')
			Result.force ('?')
			Result.force ('[')
			Result.force (']')
			Result.force ('^')
			Result.force ('`')
			Result.force ('{')
			Result.force ('}')
			Result.force ('~')
		end

feature -- Constants

	Prefix_str: STRING = "prefix %""
	Infix_str: STRING = "infix %""
	Quote_str: STRING = "%""
	Frozen_str: STRING = "frozen "
	bracket_str: STRING = "[]";

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SYNTAX_STRINGS
