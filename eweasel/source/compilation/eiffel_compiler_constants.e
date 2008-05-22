indexing
	description: "An Eiffel compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "93/08/30"

class EIFFEL_COMPILER_CONSTANTS

feature {NONE} -- Input prompts

	Resume_prompt: STRING is "Press <Return> to resume compilation or <Q> to quit";

	Missing_precompile_prompt: STRING is "The project needs to use a precompile library, which has not been compiled.";

	Overwrite_prompt: STRING is "Do you wish to overwrite it (Y-yes or N-no)?";


	C_failure_prompt: STRING is "Press <c> to continue or <a> to abort: ";

feature {NONE} -- Output constants

	Pass_prefix: STRING is "[";

	Pass_string: STRING is "Degree";

	Syntax_error_prefix: STRING is "Syntax error";

	Syntax_warning_prefix: STRING is "Obsolete syntax";

	Validity_error_prefix: STRING is "Error code:";

	Validity_warning_prefix: STRING is "Warning code:";

	Class_name_prefix: STRING is "Class:";

	Updt_failure_prefix: STRING is "Error in writing .UPDT file";

	C_failure_prefix: STRING is "Cannot generate C code";

	Aborted_prefix: STRING is "ISE Eiffel: Session aborted";

	Exception_prefix: STRING is "Exception tag: ";

	Exception_occurred_prefix: STRING is "Exception occurred";

	Failure_prefix: STRING is "ec: system execution failed.";

	Illegal_inst_prefix: STRING is "Illegal instruction";

	Finished_prefix: STRING is "System Recompiled";

	Panic_string: STRING is " panic";

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
