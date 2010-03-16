note
	description: "[
						Execute the workbench version of the system named by the last
						`system' instruction (or `test' if no previous system
						instruction).  The system will get its input from `a_input_file'
						in the source directory $SOURCE and will place its output in
						`a_output-file' in the output directory $OUTPUT.  If present,
						the optional `a_args' will be passed to the system as command
						line arguments.  To specify no input file or no output file,
						use the name NONE.
																								]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_EXECUTE_WORK_INST

inherit
	EQA_EW_EXECUTE_INST

create
	make

feature {NONE} -- Implementation

	execution_dir_name: STRING
			-- Name of directory where executable resides
		once
			Result := {EQA_EW_PREDEFINED_VARIABLES}.Work_execution_dir_name
		end

note
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
