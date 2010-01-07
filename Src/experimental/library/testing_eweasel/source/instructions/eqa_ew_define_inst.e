note
	description: "[
					Define the substitution variable <name> to have the value			
					<value>.  If <value> contains white space characters, it must
					be enclosed in double quotes.  Substitution of variable values
					for names is triggered by the '$' character, when substitution
					is being done.  For example, $ABC will be replaced by the last
					value defined for variable ABC.  Case is significant and by
					convention substitution variables are normally given names
					which are all uppercase.  The name starts with the first
					character after the '$' and ends with the first non-identifier
					character (alphanumeric or underline) or end of line.
					Parentheses may be used to set a substitution variable off
					from the surrouding text (e.g., the substitution variable name
					in "$(ABC)D" is ABC, not ABCD).  If the named variable has not
					been defined, it is left as is during substitution (in the
					example above it would remain $(ABC)).  To get a $ character,
					use $$.  Substitution is always done when reading the lines of
					a test suite control file, test control file or test catalog.
					Substitution is done on the lines of a copied file when
					`copy_sub' is used, but not when `copy_raw' is used.
					 See
				 	"http://svn.origo.ethz.ch/viewvc/eiffelstudio/trunk/eweasel/doc/eweasel.doc?annotate=HEAD"
				 	for more information
																											]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_DEFINE_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Initialization

	make (a_arguments: STRING)
			-- Creation method
		require
			not_void: attached a_arguments and then not a_arguments.is_empty
		do
			inst_initialize (a_arguments)
		end

	inst_initialize (a_line: STRING)
			-- Initialize instruction from `a_line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING]
			count, pos: INTEGER
			l_failure_explanation: like failure_explanation
			l_val: like value
		do
			args := string_util.broken_into_words (a_line)
			count := args.count
			if count < 2 then
				failure_explanation := "argument count must be at least 2"
				init_ok := False
			elseif args.first.item (1) = {EQA_EW_SUBSTITUTION_CONST}.Substitute_char then
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("variable being defined cannot start with ")
				l_failure_explanation.extend ({EQA_EW_SUBSTITUTION_CONST}.Substitute_char)
				init_ok := False
			elseif count = 2 then
				variable := args.i_th (1)
				value := args.i_th (2)
				init_ok := True
			else
				pos :=  string_util.first_white_position (a_line)
				variable := a_line.substring (1, pos - 1)
				l_val := a_line.substring (pos, a_line.count)
				value := l_val
				l_val.left_adjust
				l_val.right_adjust
				init_ok := True
			end
			if init_ok then
				l_val := value
				check attached l_val end -- Implied by `init_ok'
				if l_val.item (1) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char and
				   l_val.item (l_val.count) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char then
					l_val.remove (l_val.count)
					l_val.remove (1)
				elseif l_val.item (1) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char or
				   l_val.item (l_val.count) = {EQA_EW_SUBSTITUTION_CONST}.Quote_char then
					failure_explanation := "value must be quoted on both ends or on neither end"
					init_ok := False
				end
			end
			if init_ok then
--				init_environment.define (variable, value)
			end

			if not init_ok then
				l_failure_explanation := failure_explanation
				check attached l_failure_explanation end -- Implied by previous if clause
				assert.assert (l_failure_explanation, False)
			end
		end

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `a_test'.  Always successful.
		local
			l_var, l_val: like value
		do
			l_var := variable
			check attached l_var end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'

			l_val := value
			check attached l_val end -- Implied by `init_ok' is True, otherwise assertion would be violated in `inst_initialize'

			a_test.environment.put (l_val, l_var)
		end

feature -- Query

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN = True
			-- Calls to `execute' are always successful.

feature {NONE}

	variable: detachable STRING
			-- Name of environment value

	value: detachable STRING
			-- Value to be given to environment value

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
