indexing
	description: "An Eiffel system execution result"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_EXECUTION_RESULT

feature -- Properties

	execution_failure: BOOLEAN;
			-- Did an explicit system execution failure
			-- occur during execution?
	
	had_panic: BOOLEAN;
			-- Did a panic occur during execution?
	
	illegal_instruction: BOOLEAN;
			-- Was an illegal instruction executed
			-- during execution?
	
	execution_finished: BOOLEAN;
			-- Did execution finish normally (zero exit status)?

	summary: STRING is
			-- Summary of `Current'
		local
			status: STRING;
		do
			create Result.make (0);
			create status.make (0);
			if execution_finished and execution_failure then
				status.append ("completed_but_failed ");
			elseif execution_finished and not execution_failure then
				status.append ("completed ");
			elseif not execution_finished and execution_failure then
				status.append ("system_failed ");
			elseif not execution_finished and not execution_failure then
				status.append ("silent_failure ");
			end;
			if had_panic then
				status.append ("had_panic ");
			end;
			if illegal_instruction then
				status.append ("illegal_instruction ");
			end;
			if status.count = 0 then
				status.append ("unknown	");
			end;
			status.prepend ("%TFinal status:  ");
			Result.append (status);
		end;

feature -- Modification

	set_execution_finished (b: BOOLEAN) is
		do
			execution_finished := b;
		end;

	set_execution_failure (b: BOOLEAN) is
		do
			execution_failure := b;
		end;


feature -- Update

	update (line: STRING) is
			-- Update `Current' to reflect the presence of
			-- `line' as next line in execution output.
		local
			s: SEQ_STRING;
			completed, failed: BOOLEAN
		do
			create s.make (line.count);
			s.append (line);
			s.to_lower;
			s.start;
			s.search_string_after (Panic_string, 0);
			if not s.after then
				had_panic := True;
			end;
			s.start;
			s.search_string_after (System_failed_string, 0);
			if not s.after then
				execution_failure := True;
			end;
			s.start;
			s.search_string_after (Illegal_inst_string, 0);
			if not s.after then
				illegal_instruction := True;
			end;
			s.start;
			s.search_string_after (Completed_string, 0);
			completed := not s.after
			s.start;
			s.search_string_after (Failed_string, 0);
			failed := not s.after
			if completed and not failed then
				execution_finished := True;
			end;
		end;

feature -- Comparison

	matches (other: EW_EXECUTION_RESULT): BOOLEAN is
			-- Do `Current' and `other' represent the
			-- same execution result?
		require
			other_not_void: other /= Void;
		do
			Result := had_panic = other.had_panic and
				execution_failure = other.execution_failure and
				illegal_instruction = other.illegal_instruction
				and execution_finished = other.execution_finished
		end;


feature {NONE} -- String constants

	Completed_string: STRING is "execution completed";

	Failed_string: STRING is "execution failed";

	System_failed_string: STRING is "system execution failed.";

	Panic_string: STRING is "panic";
	
	Illegal_inst_string: STRING is "illegal instruction";

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
