note
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	MATH_SAMPLE

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			l_stop: BOOLEAN
			l_formula: SYSTEM_STRING
			l_p: PARSER
		do
			create l_p.make
			from until l_stop loop
				{SYSTEM_CONSOLE}.write_line ("Enter a simple formual. Ex: 4+4: (or q to quit)")

				l_formula := {SYSTEM_CONSOLE}.read_line

				l_stop := l_formula.equals_string ("q") or l_formula.equals_string ("q")
				if not l_stop then
						-- parse the formula and get the arguments
					evaluate_formula (l_p, l_formula)
				end
			end
		end

feature {NONE} -- Basic operations

	evaluate_formula (a_parser: PARSER; a_formula: SYSTEM_STRING)
			-- Evaluates a supplied formula
		require
			a_parser_attached: a_parser /= Void
			not_a_formula_is_empty: not {SYSTEM_STRING}.is_null_or_empty (a_formula)
		local
			l_args: PARSER_ARGUMENTS
			retried: BOOLEAN
		do
			if not retried then
				l_args := a_parser.parse (a_formula)
				{SYSTEM_CONSOLE}.write_line (get_result (
					{SYSTEM_CONVERT}.to_int_32 (l_args.arg_1, {CULTURE_INFO}.invariant_culture),
					l_args.operator,
					{SYSTEM_CONVERT}.to_int_32 (l_args.arg_2, {CULTURE_INFO}.invariant_culture)))
			else
				{SYSTEM_CONSOLE}.write_line ({ISE_RUNTIME}.last_exception.message)
			end
		rescue
			retried := True
			retry
		end

feature -- Query

	get_result (a_arg1: INTEGER; a_op: CHARACTER; a_arg2: INTEGER): SYSTEM_STRING
			-- Evaluate the result of a given binary expression
		do
			inspect a_op
			when '+' then
				Result := {SYSTEM_STRING}.format ("Result: {0:G}", a_arg1 + a_arg2)
			when '-' then
				Result := {SYSTEM_STRING}.format ("Result: {0:G}", a_arg1 - a_arg2)
			when '*' then
				Result := {SYSTEM_STRING}.format ("Result: {0:G}", a_arg1 * a_arg2)
			when '/' then
				Result := {SYSTEM_STRING}.format ("Result: {0:G}", a_arg1 / a_arg2)
			else
				Result := "Invalid operation: " + a_op.out
			end
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
