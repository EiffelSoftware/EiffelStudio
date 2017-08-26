note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EW_COMPILE_RESULT_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;

feature

	inst_initialize (args: STRING)
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
			mod_args.left_adjust
			mod_args.right_adjust
			if mod_args.is_empty then
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
				elseif type.same_string_general (command_line_option_error_result) then
					if phrases.count > 0 then
						failure_explanation := "no arguments allowed for command_line_option_error result"
						init_ok := False
					else
						cr.set_has_command_line_option_error
						init_ok := True
					end
				elseif equal (type, Syntax_error_result) or equal (type, Syntax_warning_result) then
					if phrases.is_empty then
						init_ok := False
						failure_explanation := "no class/line_no pairs specified for syntax error or syntax warning"
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
					if phrases.is_empty then
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
				-- No need to sort expected compile result
				-- since all key fields are known for each
				-- syntax or validity error when it is added.
				-- But sort it anyway, just to be safe
				cr.sort
				expected_compile_result := cr;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST)
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
				-- Make sure syntax and validity errors/warnings
				-- are sorted.  They might not be sorted even
				-- though they are sorted lists because items
				-- may be added before all key fields are set
				cr.sort
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

	process_syntax_phrase (phrase: STRING; cr: EW_EIFFEL_COMPILATION_RESULT)
			-- Modify `cr' to reflect presence of syntax phrase `phrase'.
		require
			phrase_not_void: phrase /= Void
			compile_result_not_void: cr /= Void
		local
			words: LIST [STRING]
			line_no: STRING
			syn: EW_EIFFEL_SYNTAX_ERROR
		do
			words := broken_into_words (phrase)
			if words.count = 2 then
				line_no := words [2]
				if is_integer (line_no) then
					create syn.make (real_class_name (words [1]))
					syn.set_line_number (line_no.to_integer)
					cr.add_syntax_error (syn)
				else
					init_ok := False
					failure_explanation := "syntax error has non-integer line number: "
					failure_explanation.append (line_no)
				end
			else
				init_ok := False
				failure_explanation := "wrong number of arguments for syntax error phrase: "
				failure_explanation.append (phrase)
			end
		end

	process_validity_phrase (phrase: STRING; cr: EW_EIFFEL_COMPILATION_RESULT)
			-- Modify `cr' to reflect presence of validity phrase
			-- `phrase'
		require
			phrase_not_void: phrase /= Void;
			compile_result_not_void: cr /= Void;
		local
			words: LIST [STRING]
			count: INTEGER
			cname: STRING
			val: EW_EIFFEL_VALIDITY_ERROR
			code: STRING
			line: STRING
			line_no: INTEGER
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
					code := words.item
					if code.has (':') then
						line := code.substring (code.index_of (':', 1) + 1, code.count)
						if line.is_integer then
							code := code.substring (1, code.index_of (':', 1) - 1)
							line_no := line.to_integer
							if line_no <= 0 and then init_ok then
								init_ok := False
								failure_explanation := "validity error specifies non-positive line number "
								failure_explanation.append_integer (line_no)
							end
						else
							init_ok := False
							failure_explanation := "validity error specifies line number that is not an integer: "
							failure_explanation.append_string (line)
						end
					else
							-- Reset (previously set) line number to 0.
						line_no := 0
					end
					create val.make (cname, code)
					if line_no > 0 then
						val.set_line_number (line_no)
					end
					cr.add_validity_error (val)
					words.forth
				end
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

feature {EW_COMPILE_RESULT_INST, EW_CODE_ANALYSIS_RESULT_INST} -- Result strings

	Ok_result: STRING = "ok"

	Syntax_error_result: STRING = "syntax_error"

	Syntax_warning_result: STRING = "syntax_warning"

	Validity_error_result: STRING = "validity_error"

	Validity_warning_result: STRING = "validity_warning";

	command_line_option_error_result: STRING = "command_line_option_error"

note
	copyright: "[
			Copyright (c) 1984-2017, University of Southern California, Eiffel Software and contributors.
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
