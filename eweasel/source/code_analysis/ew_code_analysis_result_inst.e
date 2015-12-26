note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "$Date$"

class
	EW_CODE_ANALYSIS_RESULT_INST

inherit

	EW_TEST_INSTRUCTION;

	EW_STRING_UTILITIES;

feature -- Instruction

	inst_initialize (a_args_line: STRING)
			-- Initialize instruction from `args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [STRING]
			l_phrases: LIST [STRING];
			l_analysis_result: EW_CODE_ANALYSIS_RESULT;
			l_have_violations: BOOLEAN
			l_compilation_finished: BOOLEAN
		do
			init_ok := True
			create l_analysis_result
				-- There are no constructs for indicating a failed compilation.
				-- compile_result should be used instead. Here we always assume that
				-- the compilation succeeded (otherwise the analysis cannot run).
			l_compilation_finished := True
			l_args := broken_into_arguments (a_args_line)
			if l_args.is_empty then
				init_ok := False;
				failure_explanation := "no arguments present";
			end
			from
				l_args.start
			until
				l_args.after or not init_ok
			loop
				if equal (l_args.item, Ok_result) then
						-- Do nothing, the analysis clean flag will be set at the end in any case.

					if l_args.count /= 1 then -- if this is not the only argument
						init_ok := False;
						create failure_explanation.make (0);
						failure_explanation.append ("The " + Ok_result + " argument is only allowed alone.");
						failure_explanation.append (l_args.item);
					end
				elseif equal (l_args.item, Violation_result) or equal (l_args.item, Violations_result) then
					l_have_violations := True
					l_args.forth
					if l_args.after then
						init_ok := False;
						failure_explanation := "no class/constraint lists specified for code analysis violation";
					else
						l_phrases := l_args.item.split (Phrase_separator)
						from
							l_phrases.start
						until
							l_phrases.after or not init_ok
						loop
							process_violation_phrase (l_phrases.item, l_analysis_result);
							l_phrases.forth
						end
					end
				elseif l_args.item.same_string_general ({EW_COMPILE_RESULT_INST}.command_line_option_error_result) then
						-- Check if there are any additional arguments.
					l_args.forth
					if l_args.after then
						l_analysis_result.set_has_command_line_option_error
						l_have_violations := True
						l_compilation_finished := False
					else
						failure_explanation := "no arguments allowed for command_line_option_error result"
						init_ok := False
					end
				elseif equal (l_args.item, Argument_warning_result) then
					l_analysis_result.set_argument_warning
				elseif equal (l_args.item, Class_warning_result) then
					l_analysis_result.set_class_warning
				elseif equal (l_args.item, Rule_warning_result) then
					l_analysis_result.set_rule_warning
				elseif equal (l_args.item, Preference_warning_result) then
					l_analysis_result.set_preference_warning
				else
					init_ok := False;
					create failure_explanation.make (0);
					failure_explanation.append ("unknown keyword: ");
					failure_explanation.append (l_args.item);
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
			expected_analysis_result := l_analysis_result;
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
				execute_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("no pending code analysis to check");
			else
					-- Make sure violations are sorted.
					-- They might not be sorted even
					-- though they are sorted lists because items
					-- may be added before all key fields are set
				l_analysis_result.sort
				execute_ok := l_analysis_result.matches (expected_analysis_result);
				if not execute_ok then
					create failure_explanation.make (0);
					failure_explanation.append ("actual code analysis result does not match expected result%N");
					failure_explanation.append ("Actual result:%N");
					failure_explanation.append (l_analysis_result.summary);
					failure_explanation.append ("%NExpected result:%N");
					failure_explanation.append (expected_analysis_result.summary);
				end;
				test.set_e_compilation_result (Void);
			end
		end;

	init_ok: BOOLEAN;
		-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN;
	-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_analysis_result: EW_CODE_ANALYSIS_RESULT;
		-- Result expected from code analysis

	process_violation_phrase (a_phrase: STRING; a_analysis_result: EW_CODE_ANALYSIS_RESULT)
			-- Modify `a_analsis_result' to reflect presence of validity a_phrase `a_phrase'
		require
			phrase_not_void: a_phrase /= Void;
			analysis_result_not_void: a_analysis_result /= Void;
		local
			l_words: LIST [STRING];
			l_count: INTEGER;
			l_cname: STRING;
			l_rule_id: STRING
			l_line_number: INTEGER
			l_split_strings: LIST [STRING]
			l_viol: EW_CODE_ANALYSIS_VIOLATION;
		do
			l_words := broken_into_words (a_phrase);
			l_count := l_words.count;
			if l_count < 2 then
				init_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("validity error a_phrase has less than 2 arguments: ");
				failure_explanation.append (a_phrase);
			else

				from
					l_words.start;
					l_cname := real_class_name (l_words.item);
					l_words.forth;
				until
					l_words.after
				loop
					l_split_strings := l_words.item.split (':')
					if l_split_strings.count = 1 then
						l_rule_id := l_split_strings.at (1)
						l_line_number := 0 -- Undefined
					elseif l_split_strings.count = 2 then
						l_rule_id := l_split_strings.at (1)
						l_line_number := l_split_strings.at (2).to_integer
					else
						init_ok := False;
						create failure_explanation.make (0);
						failure_explanation.append ("more than one colon in a rule violation specification: ");
						failure_explanation.append (l_words.item);
					end
					create l_viol.make_empty
					l_viol.set_class_name (l_cname)
					l_viol.set_line_number (l_line_number)
					l_viol.set_rule_id (l_rule_id)
					a_analysis_result.add_violation (l_viol)
					l_words.forth;
				end;
			end
		end

	real_class_name (cname: STRING): STRING
			-- Actual class name to be used in expected
			-- compile result
		do
			if equal (cname, No_class_name) then
				create Result.make (0);
				-- Use empty string for real class name
			else
				Result := cname;
			end;
		end;

	No_class_name: STRING = "NONE";

	Phrase_separator: CHARACTER = ';';

	Ok_result: STRING = "ok"

	Rule_warning_result: STRING = "rule_warning"

	Preference_warning_result: STRING = "preference_warning"

	Class_warning_result: STRING = "class_warning"

	Argument_warning_result: STRING = "argument_warning"

	Violation_result: STRING = "violation"

	Violations_result: STRING = "violations"

note
	copyright: "[
		Copyright (c) 1984-2015, University of Southern California and contributors.
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
