note
	description: "An Eiffel compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_EIFFEL_COMPILER_CONSTANTS

feature {NONE} -- Input prompts

	Resume_prompt: STRING = "Press <Return> to resume compilation or <Q> to quit";

	Missing_precompile_prompt: STRING = "The project needs to use a precompile library, which has not been compiled.";


feature {NONE} -- Output constants

	Pass_prefix: STRING = "[";

	Pass_string: STRING = "Degree";

	Syntax_error_prefix: STRING = "Syntax error";

	Syntax_warning_prefix: STRING = "Obsolete syntax";

	Validity_error_prefix: STRING = "Error code:";

	Validity_warning_prefix: STRING = "Warning code:";

	Class_name_prefix: STRING = "Class:";

	Aborted_prefix: STRING = "ISE Eiffel: Session aborted";

	Exception_prefix: STRING = "Exception tag: ";

	Exception_occurred_prefix: STRING = "Exception occurred";

	Failure_prefix: STRING = "ec: system execution failed.";

	Illegal_inst_prefix: STRING = "Illegal instruction";

	Finished_prefix: STRING = "System Recompiled";

	Panic_string: STRING = " panic";

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
