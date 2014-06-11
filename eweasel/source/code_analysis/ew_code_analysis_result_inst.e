note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_CODE_ANALYSIS_RESULT_INST

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
		do
			init_ok := True

			create l_analysis_result
				-- There are no constructs for indicating a failed compilation.
				-- compile_result should be used instead. Here we always assume that
				-- the compilation succeeded (otherwise the analysis cannot run).
			l_analysis_result.set_compilation_finished

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
				if equal (l_args.item, Clean_result) then
					l_analysis_result.set_analysis_clean
				elseif equal (l_args.item, Violation_result) or equal (l_args.item, Violations_result) then
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
				elseif equal (l_args.item, Argument_warning_result) then
					l_analysis_result.set_argument_warning
				elseif equal (l_args.item, Class_warning_result) then
					l_analysis_result.set_class_warning
				elseif equal (l_args.item, Rule_warning_result) then
					l_analysis_result.set_rule_warning
				else
					init_ok := False;
					create failure_explanation.make (0);
					failure_explanation.append ("unknown keyword: ");
					failure_explanation.append (l_args.item);
				end

				l_args.forth
			end

				-- No need to sort expected analysis result
				-- since all key fields are known for each
				-- syntax or validity error when it is added.
				-- But sort it anyway, just to be safe
			l_analysis_result.sort
			expected_analysis_result := l_analysis_result;
		end

--	inst_initialize (args: STRING)
--			-- Initialize instruction from `args'.  Set
--			-- `init_ok' to indicate whether
--			-- initialization was successful.
--		local
--			l_phrases: LIST [STRING];
--			l_pos: INTEGER;
--			l_mod_args, l_type: STRING;
--			l_analysis_result: EW_CODE_ANALYSIS_RESULT;
--			l_init_ok: BOOLEAN
--		do
--			l_init_ok := True

--			l_mod_args := args.twin
--			l_mod_args.adjust;
--			if l_mod_args.is_empty = 0 then
--				l_init_ok := False;
--				failure_explanation := "no arguments present";
--			else
--				l_pos := first_white_position (l_mod_args);
--				if l_pos = 0 then
--					l_type := l_mod_args;
--					create l_mod_args.make (0);
--				else
--					l_type := l_mod_args.substring (1, l_pos - 1);
--					l_mod_args.keep_tail (l_mod_args.count - l_pos);
--				end
--				l_type.to_lower;

--				create l_analysis_result
--					-- There are no constructs for indicating a failed compilation.
--					-- compile_result should be used instead. Here we always assume that
--					-- the compilation succeeded (otherwise the analysis cannot run).
--				l_analysis_result.set_compilation_finished


--				l_phrases := broken_at (l_mod_args, Phrase_separator);
--				trim_white_space (l_phrases);
--				l_phrases := empty_strings_removed (l_phrases);
--				if equal (l_type, Clean_result) then
--					if l_phrases.count > 0 then
--						failure_explanation := "no arguments allowed for clean result";
--						l_init_ok := False;
--					else
--						l_analysis_result.set_analysis_clean
--					end
--				elseif equal (l_type, Violation_result) or equal (l_type, Violations_result) then
--					if l_phrases.is_empty = 0 then
--						l_init_ok := False;
--						failure_explanation := "no class/constraint lists specified for code analysis violation";
--					else
--						from
--							l_phrases.start;
--						until
--							l_phrases.after or not init_ok
--						loop
--							process_violation_phrase (l_phrases.item, l_analysis_result);
--							l_phrases.forth;
--						end
--					end
--				elseif equal (l_type, Argument_warning_result) then
--					if l_phrases.count > 0 then
--						failure_explanation := "no arguments allowed for argument warning";
--						l_init_ok := False;
--					else
--						l_analysis_result.set_argument_warning
--					end
--				elseif equal (l_type, Class_warning_result) then
--					if l_phrases.count > 0 then
--						failure_explanation := "no arguments allowed for class warning";
--						l_init_ok := False;
--					else
--						l_analysis_result.set_class_warning
--					end
--				elseif equal (l_type, Rule_warning_result) then
--					if l_phrases.count > 0 then
--						failure_explanation := "no arguments allowed for rule warning";
--						l_init_ok := False;
--					else
--						l_analysis_result.set_rule_warning
--					end
--				else
--					l_init_ok := False;
--					create failure_explanation.make (0);
--					failure_explanation.append ("unknown keyword: ");
--					failure_explanation.append (l_type);
--				end

--				-- No need to sort expected analysis result
--				-- since all key fields are known for each
--				-- syntax or validity error when it is added.
--				-- But sort it anyway, just to be safe
--				l_analysis_result.sort
--				expected_analysis_result := l_analysis_result;

--				init_ok := l_init_ok
--			end
--		end

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

					-- TODO: Incorrectly triggers CA024. Write test!
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

	Clean_result: STRING = "clean"

	Rule_warning_result: STRING = "rule_warning"
	Class_warning_result: STRING = "class_warning"
	Argument_warning_result: STRING = "argument_warning"

	Violation_result: STRING = "violation"
	Violations_result: STRING = "violations"

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
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
