note
	description: "Strings used in the Eiffel syntax"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_STRINGS

feature -- Sets

	keywords: STRING_TABLE [BOOLEAN]
			-- List of Eiffel keywords in lowercase.
		once
			create Result.make_caseless (55)
			Result.put (True, "across")
			Result.put (True, "agent")
			Result.put (True, "alias")
			Result.put (True, "all")
			Result.put (True, "and")
			Result.put (True, "as")
			Result.put (True, "assign")
			Result.put (True, "attached")
			Result.put (True, "attribute")
			Result.put (True, "check")
			Result.put (True, "class")
			Result.put (True, "convert")
			Result.put (True, "create")
			Result.put (True, "current")
			Result.put (True, "debug")
			Result.put (True, "deferred")
			Result.put (True, "detachable")
			Result.put (True, "do")
			Result.put (True, "else")
			Result.put (True, "elseif")
			Result.put (True, "end")
			Result.put (True, "ensure")
			Result.put (True, "expanded")
			Result.put (True, "export")
			Result.put (True, "external")
			Result.put (True, "false")
			Result.put (True, "feature")
			Result.put (True, "from")
			Result.put (True, "frozen")
			Result.put (True, "if")
			Result.put (True, "implies")
			Result.put (True, "indexing")
			Result.put (True, "inherit")
			Result.put (True, "inspect")
			Result.put (True, "invariant")
			Result.put (True, "like")
			Result.put (True, "local")
			Result.put (True, "loop")
			Result.put (True, "not")
			Result.put (True, "note")
			Result.put (True, "precursor")
			Result.put (True, "redefine")
			Result.put (True, "rename")
			Result.put (True, "require")
			Result.put (True, "rescue")
			Result.put (True, "result")
			Result.put (True, "retry")
			Result.put (True, "select")
			Result.put (True, "separate")
			Result.put (True, "some")
			Result.put (True, "then")
			Result.put (True, "true")
			Result.put (True, "undefine")
			Result.put (True, "until")
			Result.put (True, "variant")
			Result.put (True, "void")
			Result.put (True, "when")
			Result.put (True, "xor")
		ensure
			class
			Result_not_void: Result /= Void
			Result.is_case_insensitive
		end

	basic_operators: STRING_TABLE [BOOLEAN]
			-- List of basic Eiffel operators (lower-case).
		obsolete
			"Remove use of this function in favor of using Eiffel scanner/parser. [2021-11-30]"
		once
			create Result.make_caseless (20)
			Result.put (True, "not")
			Result.put (True, "+")
			Result.put (True, "-")
			Result.put (True, "*")
			Result.put (True, "/")
			Result.put (True, "<")
			Result.put (True, ">")
			Result.put (True, "<=")
			Result.put (True, ">=")
			Result.put (True, "//")
			Result.put (True, "\\")
			Result.put (True, "^")
			Result.put (True, "and")
			Result.put (True, "or")
			Result.put (True, "xor")
			Result.put (True, "and then")
			Result.put (True, "or else")
			Result.put (True, "implies")
		ensure
			class
			Result.is_case_insensitive
		end

	binary_operators: STRING_TABLE [BOOLEAN]
			-- List of basic binary Eiffel operators (lower-case).
		obsolete
			"Remove use of this function in favor of using Eiffel scanner/parser. [2021-11-30]"
		once
			create Result.make_caseless (18)
			Result.put (True, "+")
			Result.put (True, "-")
			Result.put (True, "*")
			Result.put (True, "/")
			Result.put (True, "//")
			Result.put (True, "\\")
			Result.put (True, "^")
			Result.put (True, "..")
			Result.put (True, "<")
			Result.put (True, ">")
			Result.put (True, "<=")
			Result.put (True, ">=")
			Result.put (True, "and")
			Result.put (True, "or")
			Result.put (True, "xor")
			Result.put (True, "and then")
			Result.put (True, "or else")
			Result.put (True, "implies")
		ensure
			class
			Result.is_case_insensitive
		end

	unary_operators: STRING_TABLE [BOOLEAN]
			-- List of basic unary Eiffel operators (lower-case)
		obsolete
			"Remove use of this function in favor of using Eiffel scanner/parser. [2021-11-30]"
		once
			create Result.make_caseless (3)
			Result.put (True, "not")
			Result.put (True, "+")
			Result.put (True, "-")
		ensure
			class
			Result.is_case_insensitive
		end

	free_operators_start: SEARCH_TABLE [CHARACTER_32]
			-- List of characters that can start a free operator name.
		obsolete
			"Remove use of this function in favor of using Eiffel scanner/parser. [2021-11-30]"
		once
			create Result.make (4)
			Result.force ('@')
			Result.force ('#')
			Result.force ('|')
			Result.force ('&')
		ensure
			class
		end

	free_operators_characters: SEARCH_TABLE [CHARACTER_32]
			-- List of characters that can start a free operator name.
		obsolete
			"Remove use of this function in favor of using Eiffel scanner/parser. [2021-11-30]"
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
		ensure
			class
		end

feature -- Constants

	Prefix_str: STRING = "prefix %""
	Infix_str: STRING = "infix %""
	Quote_str: STRING = "%""
	Frozen_str: STRING = "frozen "
	bracket_str: STRING = "[]"
	parentheses_str: STRING = "()"

;note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end
