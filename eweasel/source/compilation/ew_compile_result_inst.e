indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_COMPILE_RESULT_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;

feature

	inst_initialize (args: STRING) is
			-- Initialize instruction from `args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			phrases: LIST [STRING];
			pos: INTEGER;
			mod_args, type: STRING;
			cr: EW_EIFFEL_COMPILATION_RESULT;
		do
			mod_args := args.twin
			mod_args.left_adjust;
			mod_args.right_adjust;
			if mod_args.count = 0 then
				init_ok := False;
				failure_explanation := "no arguments present";
			else
				pos := first_white_position (mod_args);
				if pos = 0 then
					type := mod_args;
					create mod_args.make (0);
				else
					type := mod_args.substring (1, pos - 1);
					mod_args.keep_tail (mod_args.count - pos);
				end
				type.to_lower;
				create cr;
				phrases := broken_at (mod_args, Phrase_separator);
				trim_white_space (phrases);
				phrases := empty_strings_removed (phrases);
				if equal (type, Ok_result) then
					if phrases.count > 0 then
						failure_explanation := "no arguments allowed for OK result";
						init_ok := False;
					else
						cr.set_compilation_finished;
						init_ok := True;
					end
				elseif equal (type, Syntax_error_result) or equal (type, Syntax_warning_result) then
					if phrases.count = 0 then
						init_ok := False;
						failure_explanation := "no class/line_no pairs specified for syntax error or syntax warning";
					else
						from
							init_ok := True;
							phrases.start;
						until
							phrases.after or not init_ok
						loop
							process_syntax_phrase (phrases.item, cr);
							phrases.forth;
						end
					end
				elseif equal (type, Validity_error_result) or equal (type, Validity_warning_result) then
					if phrases.count = 0 then
						init_ok := False;
						failure_explanation := "no class/constraint lists specified for validity error or validity warning";
					else
						from
							init_ok := True;
							phrases.start;
						until
							phrases.after or not init_ok
						loop
							process_validity_phrase (phrases.item, cr);
							phrases.forth;
						end
					end
				else
					init_ok := False;
					create failure_explanation.make (0);
					failure_explanation.append ("unknown keyword: ");
					failure_explanation.append (type);
				end;
				if cr.syntax_errors /= Void then
					if equal (type, Syntax_error_result) then
						cr.set_compilation_paused;
					else
						cr.set_compilation_finished;
					end
				elseif cr.validity_errors /= Void then
					if equal (type, Validity_error_result) then
						cr.set_compilation_paused;
					else
						cr.set_compilation_finished;
					end
				end;
				expected_compile_result := cr;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			cr: EW_EIFFEL_COMPILATION_RESULT;
		do
			cr := test.e_compilation_result;
			if cr = Void then
				execute_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("no pending Eiffel compilation result to check");

			else
				execute_ok := cr.matches (expected_compile_result);
				if not execute_ok then
					create failure_explanation.make (0);
					failure_explanation.append ("actual compilation result does not match expected result%N");
					failure_explanation.append ("Actual result:%N");
					failure_explanation.append (cr.summary);
					failure_explanation.append ("%NExpected result:%N");
					failure_explanation.append (expected_compile_result.summary);
				end;
				test.set_e_compilation_result (Void);
			end
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_compile_result: EW_EIFFEL_COMPILATION_RESULT;
			-- Result expected from compilation

	process_syntax_phrase (phrase: STRING; cr: EW_EIFFEL_COMPILATION_RESULT) is
			-- Modify `cr' to reflect presence of syntax phrase
			-- `phrase'
		require
			phrase_not_void: phrase /= Void;
			compile_result_not_void: cr /= Void;
		local
			words: LIST [STRING];
			count: INTEGER;
			cname, line_no: STRING;
			syn: EW_EIFFEL_SYNTAX_ERROR;
		do
			words := broken_into_words (phrase);
			count := words.count;
			if count = 2 then
				cname := words.i_th (1);
				line_no := words.i_th (2);
			end
			if count /= 2 then
				init_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("wrong number of arguments for syntax error phrase: ");
				failure_explanation.append (phrase);
			elseif not is_integer (line_no) then
				init_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("syntax error has non-integer line number: ");
				failure_explanation.append (line_no);
			else
				cname := real_class_name (cname);
				create syn.make (cname)
				syn.set_line_number (line_no.to_integer);
				cr.add_syntax_error (syn);
			end

		end;

	process_validity_phrase (phrase: STRING; cr: EW_EIFFEL_COMPILATION_RESULT) is
			-- Modify `cr' to reflect presence of validity phrase
			-- `phrase'
		require
			phrase_not_void: phrase /= Void;
			compile_result_not_void: cr /= Void;
		local
			words: LIST [STRING];
			count: INTEGER;
			cname: STRING;
			val: EW_EIFFEL_VALIDITY_ERROR;
		do
			words := broken_into_words (phrase);
			count := words.count;
			if count < 2 then
				init_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("validity error phrase has less than 2 arguments: ");
				failure_explanation.append (phrase);
			else
				from
					words.start;
					cname := real_class_name (words.item);
					words.forth;
				until
					words.after
				loop
					create val.make (cname, words.item)
					cr.add_validity_error (val);
					words.forth;
				end;
			end
		end

	real_class_name (cname: STRING): STRING is
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

	No_class_name: STRING is "NONE";

	Phrase_separator: CHARACTER is ';';

	Ok_result: STRING is "ok"

	Syntax_error_result: STRING is "syntax_error"

	Syntax_warning_result: STRING is "syntax_warning"

	Validity_error_result: STRING is "validity_error"

	Validity_warning_result: STRING is "validity_warning";

indexing
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
