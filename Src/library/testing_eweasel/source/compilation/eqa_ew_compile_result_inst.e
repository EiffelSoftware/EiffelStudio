note
	description: "[
					Check that the compilation result from the last
					compile_melted, compile_frozen, compile_final or
					resume_compile instruction matches <result>.  If it does not,
					then the test has failed.  If the result matches <result>,
					continue processing with the next test instruction.  To
					specify no class for <class> below, use NONE (which matches
					only if the compiler does not report the error in a particular
					class).  <result> can be:

					syntax_error  { <class> <line-number> ";" ... }+

						Matches if compiler reported a syntax error on each
						of the indicated classes at the given line numbers,
						in the order indicated.
						If <line-number> is omitted, then matches if
						compiler reported a syntax error on class
						<class>, regardless of position.  To specify
						no class (which means "syntax error on the Ecf
						file"), use NONE.

					validity_error { <class> <validity-code-list> ";" ...}+

						Matches if compiler reported the indicated
						validity errors in the named classes in the
						order listed.  This validity code list is a
						white space separated list of validity codes
						from "Eiffel: The Language".

					validity_warning { <class> <validity-code-list> ";" ...}+

						Matches if compiler reported the indicated
						validity errors in the named classes in the
						order listed.  This validity code list is a
						white space separated list of validity codes
						from "Eiffel: The Language".  This is
						identical to validity_error, except that
						the compilation is expected to complete
						for validity_warning whereas it is expected
						to be paused for validity_error.

					ok

						Matches if compiler did not report any syntax
						or validity errors and no system failure or
						run-time panic occurred and the system was
						successfully recompiled.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_COMPILE_RESULT_INST

inherit
	EQA_EW_TEST_INSTRUCTION

create
	make

feature {NONE} -- Intialization

	make (a_expected_result: STRING)
			-- Creation method
		do
			prepare_expected_compile_result (a_expected_result)
		end

feature -- Query

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

feature -- Command

	execute (a_test: EQA_EW_SYSTEM_TEST_SET)
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			l_cr: detachable EQA_EW_EIFFEL_COMPILATION_RESULT
			l_failure_explanation: like failure_explanation
		do
			l_cr := a_test.e_compilation_result
			if l_cr = Void then
				execute_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("no pending Eiffel compilation result to check")

			else
				-- Make sure syntax and validity errors/warnings
				-- are sorted.  They might not be sorted even
				-- though they are sorted lists because items
				-- may be added before all key fields are set
				l_cr.sort
				execute_ok := l_cr.matches (expected_compile_result)
				if not execute_ok then
					create l_failure_explanation.make (0)
					failure_explanation := l_failure_explanation
					l_failure_explanation.append ("actual compilation result does not match expected result%N")
					l_failure_explanation.append ("Actual result:%N")
					l_failure_explanation.append (l_cr.summary)
					l_failure_explanation.append ("%NExpected result:%N")
					l_failure_explanation.append (expected_compile_result.summary)
				end
				a_test.set_e_compilation_result (Void)
			end

			if not execute_ok then
				l_failure_explanation := failure_explanation
				check attached l_failure_explanation end -- Implied by previous if clauses
				assert.assert (l_failure_explanation, False)
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

feature {NONE} -- Implementation

	prepare_expected_compile_result (a_expected_result: STRING)
			-- Prepare `expected_compile_result' base on parsing `a_expected_result'
			-- Modified from {EW_COMPILE_RESULT_INST}.inst_initialize
		require
			not_void: attached a_expected_result
		local
			l_phrases: LIST [STRING]
			l_pos: INTEGER
			l_mod_args, l_type: STRING
			l_cr: EQA_EW_EIFFEL_COMPILATION_RESULT
			l_failure_explanation: like failure_explanation
		do
			l_mod_args := a_expected_result
			l_pos := string_util.first_white_position (l_mod_args)
			if l_pos = 0 then
				l_type := l_mod_args
				create l_mod_args.make (0)
			else
				l_type := l_mod_args.substring (1, l_pos - 1)
				l_mod_args.keep_tail (l_mod_args.count - l_pos)
			end
			l_type.to_lower
			create l_cr
			l_phrases := string_util.broken_at (l_mod_args, Phrase_separator)
			string_util.trim_white_space (l_phrases)
			l_phrases := string_util.empty_strings_removed (l_phrases)
			if equal (l_type, Ok_result) then
				if l_phrases.count > 0 then
					failure_explanation := "no arguments allowed for OK result"
					init_ok := False
				else
					l_cr.set_compilation_finished
					init_ok := True
				end
			elseif equal (l_type, Syntax_error_result) or equal (l_type, Syntax_warning_result) then
				if l_phrases.count = 0 then
					init_ok := False
					failure_explanation := "no class/line_no pairs specified for syntax error or syntax warning"
				else
					from
						init_ok := True
						l_phrases.start
					until
						l_phrases.after or not init_ok
					loop
						process_syntax_phrase (l_phrases.item, l_cr)
						l_phrases.forth
					end
				end
			elseif equal (l_type, Validity_error_result) or equal (l_type, Validity_warning_result) then
				if l_phrases.count = 0 then
					init_ok := False
					failure_explanation := "no class/constraint lists specified for validity error or validity warning"
				else
					from
						init_ok := True
						l_phrases.start
					until
						l_phrases.after or not init_ok
					loop
						process_validity_phrase (l_phrases.item, l_cr)
						l_phrases.forth
					end
				end
			else
				init_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("unknown keyword: ")
				l_failure_explanation.append (l_type)
			end
			if l_cr.syntax_errors /= Void then
				if equal (l_type, Syntax_error_result) then
					l_cr.set_compilation_paused
				else
					l_cr.set_compilation_finished
				end
			elseif l_cr.validity_errors /= Void then
				if equal (l_type, Validity_error_result) then
					l_cr.set_compilation_paused
				else
					l_cr.set_compilation_finished
				end
			end
			-- No need to sort expected compile result
			-- since all key fields are known for each
			-- syntax or validity error when it is added.
			-- But sort it anyway, just to be safe
			l_cr.sort
			expected_compile_result := l_cr
		ensure
			created: attached expected_compile_result
		end

	expected_compile_result: EQA_EW_EIFFEL_COMPILATION_RESULT
			-- Result expected from compilation

	process_syntax_phrase (a_phrase: STRING; a_cr: EQA_EW_EIFFEL_COMPILATION_RESULT)
			-- Modify `cr' to reflect presence of syntax phrase
			-- `phrase'
		require
			phrase_not_void: a_phrase /= Void
			compile_result_not_void: a_cr /= Void
		local
			l_words: LIST [STRING]
			l_count: INTEGER
			l_cname, l_line_no: detachable STRING
			l_syn: EQA_EW_EIFFEL_SYNTAX_ERROR
			l_failure_explanation: like failure_explanation
		do
			l_words := string_util.broken_into_words (a_phrase)
			l_count := l_words.count
			if l_count = 2 then
				l_cname := l_words.i_th (1)
				l_line_no := l_words.i_th (2)
			end
			if l_count /= 2 then
				init_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("wrong number of arguments for syntax error phrase: ")
				l_failure_explanation.append (a_phrase)
			elseif attached l_line_no and then not string_util.is_integer (l_line_no) then
				init_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("syntax error has non-integer line number: ")
				l_failure_explanation.append (l_line_no)
			else
				check attached l_cname end -- Implied by previous if clause
				l_cname := real_class_name (l_cname)
				create l_syn.make (l_cname)
				check attached l_line_no end -- Implied by previous if clause
				l_syn.set_line_number (l_line_no.to_integer)
				a_cr.add_syntax_error (l_syn)
			end

		end

	process_validity_phrase (a_phrase: STRING; a_cr: EQA_EW_EIFFEL_COMPILATION_RESULT)
			-- Modify `a_cr' to reflect presence of validity phrase
			-- `phrase'
		require
			phrase_not_void: a_phrase /= Void
			compile_result_not_void: a_cr /= Void
		local
			l_words: LIST [STRING]
			l_count: INTEGER
			l_cname: STRING
			l_val: EQA_EW_EIFFEL_VALIDITY_ERROR
			l_failure_explanation: like failure_explanation
		do
			l_words := string_util.broken_into_words (a_phrase)
			l_count := l_words.count
			if l_count < 2 then
				init_ok := False
				create l_failure_explanation.make (0)
				failure_explanation := l_failure_explanation
				l_failure_explanation.append ("validity error phrase has less than 2 arguments: ")
				l_failure_explanation.append (a_phrase)
			else
				from
					l_words.start
					l_cname := real_class_name (l_words.item)
					l_words.forth
				until
					l_words.after
				loop
					create l_val.make (l_cname, l_words.item)
					a_cr.add_validity_error (l_val)
					l_words.forth
				end
			end
		end

	real_class_name (cname: STRING): STRING
			-- Actual class name to be used in expected
			-- compile result
		do
			if equal (cname, No_class_name) then
				create Result.make (0)
					-- Use empty string for real class name
			else
				Result := cname
			end
		end

feature {NONE} -- Constants

	No_class_name: STRING = "NONE"

	Phrase_separator: CHARACTER = ';'

	Ok_result: STRING = "ok"

	Syntax_error_result: STRING = "syntax_error"

	Syntax_warning_result: STRING = "syntax_warning"

	Validity_error_result: STRING = "validity_error"

	Validity_warning_result: STRING = "validity_warning"

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
