indexing
	description: "A C compilation result"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_C_COMPILATION_RESULT

feature -- Properties

	failure: BOOLEAN;
			-- Did an error occur while doing C compilations
			-- and or links?
	
	compilations_completed: BOOLEAN;
			-- Did all compilations/links finish successfully?
	
	summary: STRING is
			-- Summary of `Current'
		do
			create Result.make (0);
			if failure then
				Result.append ("failure ");
			else
				Result.append ("no_failure ");
			end;
			if compilations_completed then
				Result.append ("C_compilation_completed");
			else
				Result.append ("C_compilation_not_completed");
			end;
		end;

feature -- Update

	set_compilations_completed (b: BOOLEAN) is
		do
			compilations_completed := b;
		end;

	update (line: STRING) is
			-- Update `Current' to reflect the presence of
			-- `line' as next line in C compilation process output.
		local
			s: SEQ_STRING;
		do
			create s.make (line.count);
			s.append (line);
			s.to_lower;
			s.start;
			s.search_string_after (Failure_string1, 0);
			if not s.after then
				failure := True;
			end;
			s.start;
			s.search_string_after (Failure_string2, 0);
			if not s.after then
				failure := True;
			end;
			s.start;
			s.search_string_after (Failure_string3, 0);
			if not s.after then
				failure := True;
			end;
			s.start;
			s.search_string_after (Failure_string4, 0);
			if not s.after then
				failure := True;
			end;
			s.start;
			s.search_string_after (Completed_string, 0);
			if not s.after then
				compilations_completed := True;
			end;
		end;

feature -- Comparison

	matches (other: EW_C_COMPILATION_RESULT): BOOLEAN is
			-- Do `Current' and `other' represent the
			-- same compilation result?
		require
			other_not_void: other /= Void;
		do
			Result := equal (Current, other);
		end;


feature {NONE} -- String constants

	Failure_string1: STRING is "fatal error";

	Failure_string2: STRING is "fatal:";

	Failure_string3: STRING is " error ";

	Failure_string4: STRING is "waiting for unfinished jobs";

	Completed_string: STRING is "c compilation completed";

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
