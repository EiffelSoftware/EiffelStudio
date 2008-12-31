note
	status: "See notice at end of class."
	legal: "See notice at end of class."
	
	dotnet_constructor:
		default_create

	metadata:
		create {EIFFEL_CONSUMABLE_ATTRIBUTE}.make (True) end

class
	PARSER

inherit
	SYSTEM_OBJECT

feature -- Basic operations

	parse (a_formula: SYSTEM_STRING): PARSER_ARGUMENTS
			-- Parses a supplied formula and returns the result
		require
			not_a_formula_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_formula)
		local
			l_ops_and_space: NATIVE_ARRAY [CHARACTER]
			l_pos: INTEGER
		do
			create Result

				-- Get the first arg
			l_ops_and_space := <<' ', '+', '-', '*', '/'>>

			l_pos := a_formula.index_of_any (l_ops_and_space)
			Result.arg1 := a_formula.substring (0, l_pos)
			Result.arg2 := Result.arg1

				-- Skip whitespace to get to operator
			from until a_formula.chars (l_pos) /= ' ' loop
				l_pos := l_pos + 1
			end

				-- Get the operator
			Result.operator := {SYSTEM_CONVERT}.to_char (a_formula.substring (l_pos, 1), {CULTURE_INFO}.invariant_culture)
			l_pos := l_pos + 1

				-- Skip whitespace to get to the second arg
			from until a_formula.chars (l_pos) /= ' ' loop
				l_pos := l_pos + 1
			end

				-- Get second arg
			Result.arg2 := a_formula.substring (l_pos)
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
