indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_EXECUTE_RESULT_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_STRING_UTILITIES;

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			words: LIST [STRING];
			count: INTEGER;
			er: EW_EXECUTION_RESULT;
			type: STRING;
		do
			words := broken_into_words (line);
			count := words.count;
			if count /= 1 then
				init_ok := False;
				failure_explanation := "exactly one argument required";
			else
				create er;
				type := words.first;
				type.to_lower;
				if equal (type, "ok") then
					er.set_execution_finished (True);
					er.set_execution_failure (False);
					init_ok := True;
				elseif equal (type, "failed") then
					er.set_execution_finished (False);
					er.set_execution_failure (True);
					init_ok := True;
				elseif equal (type, "failed_silently") then
					er.set_execution_finished (False);
					er.set_execution_failure (False);
					init_ok := True;
				elseif equal (type, "completed_but_failed") then
					er.set_execution_finished (True);
					er.set_execution_failure (True);
					init_ok := True;
				else
					init_ok := False;
					create failure_explanation.make (0);
					failure_explanation.append ("unknown keyword: ");
					failure_explanation.append (type);
				end;
				expected_execution_result := er;
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			er: EW_EXECUTION_RESULT
		do
			er := test.execution_result;
			if er = Void then
				execute_ok := False;
				create failure_explanation.make (0);
				failure_explanation.append ("no pending execution result to check");
				
			else
				execute_ok := er.matches (expected_execution_result);
				if not execute_ok then
					create failure_explanation.make (0);
					failure_explanation.append ("actual execution result does not match expected result%N");
					failure_explanation.append ("Actual result:%N");
					failure_explanation.append (test.execution_result.summary);
					failure_explanation.append ("%NExpected result:%N");
					failure_explanation.append (expected_execution_result.summary);
				end
				test.set_execution_result (Void);
			end
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature {NONE} -- Implementation

	expected_execution_result: EW_EXECUTION_RESULT;
			-- Result expected from system compilation

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
