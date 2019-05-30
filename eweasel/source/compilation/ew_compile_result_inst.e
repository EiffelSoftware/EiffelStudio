note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_COMPILE_RESULT_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;

feature

	inst_initialize (args: READABLE_STRING_32)
			-- Initialize instruction from `args'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			phrases: LIST [STRING_32]
			pos: INTEGER
			mod_args: STRING_32
			type: STRING_32
			cr: EW_EIFFEL_COMPILATION_RESULT
		do
			create mod_args.make_from_string (args)
			mod_args.adjust
			if mod_args.is_empty then
				init_ok := False
				failure_explanation := {STRING_32} "no arguments present"
			else
				pos := first_white_position (mod_args)
				if pos = 0 then
					type := mod_args
					create mod_args.make (0)
				else
					type := mod_args.substring (1, pos - 1)
					mod_args.keep_tail (mod_args.count - pos)
				end
				type.to_lower
				create cr
				phrases := broken_at (mod_args, Phrase_separator)
				trim_white_space (phrases)
				phrases := empty_strings_removed (phrases)
				if type.same_string (Ok_result) then
					if phrases.count > 0 then
						failure_explanation := {STRING_32} "no arguments allowed for OK result"
						init_ok := False
					else
						cr.set_compilation_finished
						init_ok := True
					end
				elseif type.same_string (command_line_option_error_result) then
					if phrases.count > 0 then
						failure_explanation := {STRING_32} "no arguments allowed for command_line_option_error result"
						init_ok := False
					else
						cr.set_has_command_line_option_error
						init_ok := True
					end
				elseif type.same_string (Syntax_error_result) or type.same_string (Syntax_warning_result) then
					if phrases.is_empty then
						init_ok := False
						failure_explanation := {STRING_32} "no class/line_no pairs specified for syntax error or syntax warning"
					else
						from
							init_ok := True
							phrases.start
						until
							phrases.after or not init_ok
						loop
							process_syntax_phrase (phrases.item, cr)
							phrases.forth
						end
					end
				elseif type.same_string (Validity_error_result) or type.same_string (Validity_warning_result) then
					if phrases.is_empty then
						init_ok := False
						failure_explanation := {STRING_32} "no class/constraint lists specified for validity error or validity warning"
					else
						from
							init_ok := True
							phrases.start
						until
							phrases.after or not init_ok
						loop
							process_validity_phrase (phrases.item, cr)
							phrases.forth
						end
					end
				else
					init_ok := False
					failure_explanation := {STRING_32} "unknown keyword: " + type
				end;
				if cr.syntax_errors /= Void then
					if type.same_string (Syntax_error_result) then
						cr.set_compilation_paused
					else
						cr.set_compilation_finished
					end
				elseif cr.validity_errors /= Void then
					if type.same_string (Validity_error_result) then
						cr.set_compilation_paused
					else
						cr.set_compilation_finished
					end
				end;
				-- No need to sort expected compile result
				-- since all key fields are known for each
				-- syntax or validity error when it is added.
				-- But sort it anyway, just to be safe
				cr.sort
				expected_compile_result := cr
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			cr: EW_EIFFEL_COMPILATION_RESULT;
		do
			cr := test.e_compilation_result
			if cr = Void then
				execute_ok := False
				failure_explanation := {STRING_32} "no pending Eiffel compilation result to check"

			else
				-- Make sure syntax and validity errors/warnings
				-- are sorted.  They might not be sorted even
				-- though they are sorted lists because items
				-- may be added before all key fields are set
				cr.sort
				execute_ok := cr.matches (expected_compile_result)
				if not execute_ok then
					failure_explanation := {STRING_32}
						"actual compilation result does not match expected result%N" +
						"Actual result:%N" +
						cr.summary +
						"%NExpected result:%N" +
						expected_compile_result.summary
				end
				test.set_e_compilation_result (Void)
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_compile_result: EW_EIFFEL_COMPILATION_RESULT
			-- Result expected from compilation

	process_syntax_phrase (phrase: READABLE_STRING_32; cr: EW_EIFFEL_COMPILATION_RESULT)
			-- Modify `cr' to reflect presence of syntax phrase `phrase'.
		require
			phrase_not_void: phrase /= Void
			compile_result_not_void: cr /= Void
		local
			words: LIST [READABLE_STRING_32]
			line_no: READABLE_STRING_32
			syn: EW_EIFFEL_SYNTAX_ERROR
		do
			words := broken_into_words (phrase)
			if words.count = 2 then
				line_no := words [2]
				if line_no.is_integer then
					create syn.make (real_class_name (words [1]))
					syn.set_line_number (line_no.to_integer)
					cr.add_syntax_error (syn)
				else
					init_ok := False
					failure_explanation := {STRING_32} "syntax error has non-integer line number: " + line_no
				end
			else
				init_ok := False
				failure_explanation := {STRING_32} "wrong number of arguments for syntax error phrase: " + phrase
			end
		end

	process_validity_phrase (phrase: READABLE_STRING_32; cr: EW_EIFFEL_COMPILATION_RESULT)
			-- Modify `cr' to reflect presence of validity phrase
			-- `phrase'
		require
			phrase_not_void: phrase /= Void;
			compile_result_not_void: cr /= Void;
		local
			words: LIST [READABLE_STRING_32]
			count: INTEGER
			cname: READABLE_STRING_32
			val: EW_EIFFEL_VALIDITY_ERROR
			code: READABLE_STRING_32
			line: READABLE_STRING_32
			line_no: INTEGER
		do
			words := broken_into_arguments (phrase)
			count := words.count
			if count < 2 then
				init_ok := False
				failure_explanation := {STRING_32} "validity error phrase has less than 2 arguments: " + phrase
			else
				across
					words as w
				from
					cname := real_class_name (w.item)
					w.forth
				loop
					code := w.item
					if code.has (':') then
						line := code.substring (code.index_of (':', 1) + 1, code.count)
						if line.is_integer then
							code := code.substring (1, code.index_of (':', 1) - 1)
							line_no := line.to_integer
							if line_no <= 0 and then init_ok then
								init_ok := False
								failure_explanation := {STRING_32} "validity error specifies non-positive line number "
								failure_explanation.append_integer (line_no)
							end
						else
							init_ok := False
							failure_explanation := {STRING_32} "validity error specifies line number that is not an integer: " + line
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
				end
			end
		end

	real_class_name (cname: READABLE_STRING_32): READABLE_STRING_32
			-- Actual class name to be used in expected
			-- compile result
		do
			Result  :=
				if cname.same_string (No_class_name) then
						-- Use empty string for real class name
					{STRING_32} ""
				else
					cname
				end
		end

	No_class_name: STRING_32 = "NONE"

	Phrase_separator: CHARACTER = ';'

feature {EW_COMPILE_RESULT_INST, EW_CODE_ANALYSIS_RESULT_INST} -- Result strings

	Ok_result: STRING_32 = "ok"

	Syntax_error_result: STRING_32 = "syntax_error"

	Syntax_warning_result: STRING_32 = "syntax_warning"

	Validity_error_result: STRING_32 = "validity_error"

	Validity_warning_result: STRING_32 = "validity_warning"

	command_line_option_error_result: STRING_32 = "command_line_option_error"

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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
