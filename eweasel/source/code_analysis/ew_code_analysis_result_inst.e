note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_CODE_ANALYSIS_RESULT_INST

inherit

	EW_CODE_ANALYSIS_CONSTANTS
	EW_STRING_UTILITIES
	EW_TEST_INSTRUCTION

feature -- Instruction

	inst_initialize (a_args_line: READABLE_STRING_32)
			-- Initialize instruction from `args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [READABLE_STRING_32]
			l_phrases: LIST [READABLE_STRING_32]
			l_analysis_result: EW_CODE_ANALYSIS_RESULT
			l_have_violations: BOOLEAN
			l_compilation_finished: BOOLEAN
			result_arg: READABLE_STRING_32
		do
			init_ok := True
			create l_analysis_result
				-- There are no constructs for indicating a failed compilation.
				-- compile_result should be used instead. Here we always assume that
				-- the compilation succeeded (otherwise the analysis cannot run).
			l_compilation_finished := True
			l_args := broken_into_arguments (a_args_line)
			if l_args.is_empty then
				init_ok := False
				failure_explanation := {STRING_32} "no arguments present"
			end
			from
				l_args.start
			until
				l_args.after or not init_ok
			loop
				result_arg := l_args.item
				if result_arg.same_string (Ok_result) then
						-- Do nothing, the analysis clean flag will be set at the end in any case.
					if l_args.count /= 1 then -- if this is not the only argument
						init_ok := False
						failure_explanation := {STRING_32} "The " + Ok_result + " argument is only allowed alone." + l_args.item
					end
				elseif result_arg.same_string (Violation_result) or result_arg.same_string (Violations_result) then
					l_have_violations := True
					l_args.forth
					if l_args.after then
						init_ok := False
						failure_explanation := {STRING_32} "no class/constraint lists specified for code analysis violation"
					else
						l_phrases := l_args.item.split (Phrase_separator)
						from
							l_phrases.start
						until
							l_phrases.after or not init_ok
						loop
							process_violation_phrase (l_phrases.item, l_analysis_result)
							l_phrases.forth
						end
					end
				elseif l_args.item.same_string ({EW_COMPILE_RESULT_INST}.command_line_option_error_result) then
						-- Check if there are any additional arguments.
					l_args.forth
					if l_args.after then
						l_analysis_result.set_has_command_line_option_error
						l_have_violations := True
						l_compilation_finished := False
					else
						failure_explanation := {STRING_32} "no arguments allowed for command_line_option_error result"
						init_ok := False
					end
				elseif result_arg.same_string (Argument_warning_result) then
					l_analysis_result.set_argument_warning
				elseif result_arg.same_string (Class_warning_result) then
					l_analysis_result.set_class_warning
				elseif result_arg.same_string (Rule_warning_result) then
					l_analysis_result.set_rule_warning
				elseif result_arg.same_string (Preference_warning_result) then
					l_analysis_result.set_preference_warning
				else
					init_ok := False
					failure_explanation := {STRING_32} "unknown keyword: " + l_args.item
				end
				if not l_args.after then
					l_args.forth
				end
			end
			if not l_have_violations then
				l_analysis_result.set_analysis_clean
			end
			if l_compilation_finished then
				l_analysis_result.set_compilation_finished
			end
				-- No need to sort expected analysis result
				-- since all key fields are known for each
				-- syntax or validity error when it is added.
				-- But sort it anyway, just to be safe
			l_analysis_result.sort
			expected_analysis_result := l_analysis_result
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_analysis_result: EW_CODE_ANALYSIS_RESULT
		do
			if attached {EW_CODE_ANALYSIS_RESULT} test.e_compilation_result as l_result then
				l_analysis_result := l_result
			end
			if l_analysis_result = Void then
				execute_ok := False
				failure_explanation := {STRING_32} "no pending code analysis to check"
			else
					-- Make sure violations are sorted.
					-- They might not be sorted even
					-- though they are sorted lists because items
					-- may be added before all key fields are set
				l_analysis_result.sort
				execute_ok := l_analysis_result.matches (expected_analysis_result)
				if not execute_ok then
					failure_explanation := {STRING_32}
						"actual code analysis result does not match expected result%N" +
						"Actual result:%N" +
						l_analysis_result.summary +
						"%NExpected result:%N" +
						expected_analysis_result.summary
				end
				test.set_e_compilation_result (Void)
			end
		end

	init_ok: BOOLEAN
		-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
	-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_analysis_result: EW_CODE_ANALYSIS_RESULT
		-- Result expected from code analysis.

	process_violation_phrase (a_phrase: READABLE_STRING_32; a_analysis_result: EW_CODE_ANALYSIS_RESULT)
			-- Modify `a_analsis_result' to reflect presence of validity a_phrase `a_phrase'.
		require
			phrase_not_void: a_phrase /= Void
			analysis_result_not_void: a_analysis_result /= Void
		local
			l_cname: READABLE_STRING_32
			l_line_number: INTEGER
			l_split_strings: LIST [READABLE_STRING_32]
			l_viol: EW_CODE_ANALYSIS_VIOLATION
			l_type: READABLE_STRING_32
		do
			across
				broken_into_words (a_phrase) as w
			from
				if not w.after then
					l_cname := real_class_name (w.item)
				end
				w.forth
				if w.after then
					init_ok := False
					failure_explanation := {STRING_32}
						"validity error a_phrase has less than 2 arguments: " + a_phrase
				end
			loop
				l_split_strings := w.item.split ('-')
				if l_split_strings.count = 2 then
						-- There is a violation type.
					l_type := l_split_strings [2]
					init_ok := is_valid_violation_type (l_type)
				else
						-- Violation type should not be specified.
					init_ok := l_split_strings.count = 1
				end
				l_split_strings := l_split_strings [1].split (':')
				if l_split_strings.count = 2 then
						-- There is a line number.
					if l_split_strings [2].is_natural_32 and then l_split_strings [2].is_integer then
						l_line_number := l_split_strings [2].to_integer
					else
						init_ok := False
					end
				else
						-- There should be no other parts separated by ':'.
					init_ok := l_split_strings.count = 1
				end
				if init_ok then
					create l_viol.make_empty
					l_viol.set_class_name (to_utf_8 (l_cname))
					l_viol.set_line_number (l_line_number)
					l_viol.set_type (l_type)
					l_viol.set_rule_id (l_split_strings [1])
					a_analysis_result.add_violation (l_viol)
				else
					failure_explanation := {STRING_32}
						"invalid rule violation specification (supported format: rule[:line][-type] where type is one of Error, Warning, Suggestion, Hint): " +
						w.item
				end
			end
		end

	real_class_name (cname: READABLE_STRING_32): READABLE_STRING_32
			-- Actual class name to be used in expected
			-- compile result.
		do
			if cname.same_string (No_class_name) then
					-- Use empty string for real class name
				create {STRING_32} Result.make_empty
			else
				Result := cname
			end
		end

	no_class_name: STRING_32 = "NONE"

	phrase_separator: CHARACTER = ';'

	ok_result: STRING_32 = "ok"

	rule_warning_result: STRING_32 = "rule_warning"

	preference_warning_result: STRING_32 = "preference_warning"

	class_warning_result: STRING_32 = "class_warning"

	argument_warning_result: STRING_32 = "argument_warning"

	violation_result: STRING_32 = "violation"

	violations_result: STRING_32 = "violations"

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
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

end
